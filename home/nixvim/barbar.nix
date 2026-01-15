{
  plugins.barbar = {
    enable = true;
    settings = {
    maximum_length = 20;
    maximum_padding = 2;
      icons = {
        modified = { button = "●"; };
        pinned = {
          button = "⚓";
          filename = true;
        };
      };
    };
    keymaps.goTo1.key = "<A-1>";
    keymaps.goTo2.key = "<A-2>";
    keymaps.goTo3.key = "<A-3>";
    keymaps.goTo4.key = "<A-4>";
    keymaps.goTo5.key = "<A-5>";
    keymaps.goTo6.key = "<A-6>";
    keymaps.goTo7.key = "<A-7>";
    keymaps.goTo8.key = "<A-8>";
    keymaps.goTo9.key = "<A-9>";
    keymaps.previous.key = "<A-a>";
    keymaps.next.key = "<A-s>";
    keymaps.moveNext.key = "<A-f>";
    keymaps.movePrevious.key = "<A-d>";
    keymaps.pin.key = "<A-'>";
  };
}
