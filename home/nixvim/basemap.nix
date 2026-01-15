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
  ];
}
