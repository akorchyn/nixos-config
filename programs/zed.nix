{
  pkgs,
  ...
}:
{
  enable = true;
  extraPackages = [ pkgs.nixd ];
}
