{
  keymaps = [
    {
      action = "<cmd>bdelete<CR>";
      key = "<F4>";
      mode = [ "n" ];
    }
    {
      action = "<cmd>nohlsearch<CR>";
      key = "<esc>";
      mode = [ "n" ];
    }
    {
      action = "<Nop>";
      key = "<F1>";
      mode = [ "i" "c" "v" "s" "x" "t" ];
    }
    {
      action = "<cmd>LazyGit<CR>";
      key = "<F5>";
      mode = [ "n" ];
    }
    {
      action = ''<cmd>TermExec cmd="exec lazydocker" lazysql<CR>'';
      key = "<F6>";
      mode = [ "n" ];
    }
    {
      action = ''<cmd>TermExec cmd="exec lazysql" name=lazysql<CR>'';
      key = "<F7>";
      mode = [ "n" ];
    }
  ];
}
