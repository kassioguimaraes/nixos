;;; vue-lsp.el --- Vue 3 bridge for lsp-mode -*- lexical-binding: t; -*-

(require 'lsp-mode)
(require 'lsp-javascript)

(defvar my/vue-typescript-plugin nil
  "Nix path to the Vue TypeScript plugin, supplied by emacs.nix.")

(defun my/vue-language-server-directory ()
  "Locate the Nix Vue package containing node_modules/@vue/typescript-plugin."
  (let* ((executable (executable-find "vue-language-server"))
         (prefix (and executable
                      (file-name-directory
                       (directory-file-name
                        (file-name-directory (file-truename executable))))))
         (candidates
          (list (and my/vue-typescript-plugin
                     (expand-file-name "../language-server/" my/vue-typescript-plugin))
                (and prefix
                     (expand-file-name "lib/language-tools/packages/language-server/" prefix)))))
    (or (seq-find (lambda (directory)
                    (and directory
                         (file-exists-p
                          (expand-file-name "node_modules/@vue/typescript-plugin/package.json"
                                            directory))))
                  candidates)
        (user-error "Cannot locate the Nix Vue TypeScript plugin"))))

;; Set this before loading lsp-volar: its top-level code registers the plugin.
;; The plugin's own directory is not a valid tsserver probe location; its
;; parent language-server package contains the required node_modules link.
(setq lsp-volar-location-for-typescript-plugin (my/vue-language-server-directory)
      lsp-clients-typescript-prefer-use-project-ts-server t)
(require 'lsp-volar)

(defun my/vue-tsserver-request (vue-workspace params)
  "Forward Vue's PARAMS to the TypeScript workspace for the same project.
Vue 3.3 sends [ID COMMAND PAYLOAD]; older releases batch those triples.
Reply in the corresponding format, including when forwarding fails."
  (let* ((flat (numberp (elt params 0)))
         (requests (if flat (vector params) params))
         (ts-workspace
          (lsp-find-workspace
           lsp-volar-typescript-server-id
           (expand-file-name "package.json" (lsp--workspace-root vue-workspace)))))
    (seq-doseq (request requests)
      (let* ((id (elt request 0))
             (command (elt request 1))
             (payload (elt request 2))
             (reply (lambda (body)
                      (let ((response (vector id body)))
                        (lsp-volar--send-notify
                         vue-workspace "tsserver/response"
                         (if flat response (vector response)))))))
        (if (not ts-workspace)
            (progn
              (lsp--warn "Vue bridge: no TypeScript workspace for %s"
                         (lsp--workspace-root vue-workspace))
              (funcall reply nil))
          (with-lsp-workspace ts-workspace
            (lsp-request-async
             "workspace/executeCommand"
             (list :command "typescript.tsserverRequest"
                   :arguments (vector command payload))
             (lambda (response) (funcall reply (lsp-get response :body)))
             :error-handler (lambda (error)
                              (lsp--warn "Vue bridge: %S" error)
                              (funcall reply nil)))))))))

(let ((client (gethash 'vue-semantic-server lsp-clients)))
  (puthash "tsserver/request" #'my/vue-tsserver-request
           (lsp--client-notification-handlers client))
  ;; Use the same TypeScript SDK in both servers.  The Nix wrapper otherwise
  ;; loads its bundled TypeScript, which can differ from the project's SDK.
  (setf (lsp--client-new-connection client)
        (lsp-stdio-connection
         (lambda ()
           (list (lsp-package-path 'volar-language-server) "--stdio"
                 (concat "--tsdk=" (lsp-clients-typescript-server-path)))))))

(provide 'vue-lsp)
;;; vue-lsp.el ends here
