{ pkgs, ... }:
{
  enable = true;
  history = {
    size = 10000;
    save = 100000;
    expireDuplicatesFirst = true;
    extended = true;
  };
  enableAutosuggestions = true;
  enableSyntaxHighlighting = true;
  oh-my-zsh = {
    enable = true;
    plugins = [
      "git"
      "sudo"
      "cp"
      "docker"
      "docker-compose"
      "rust"
    ];
  };
  plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
  ];
  initExtra = ''
    source $HOME/.p10k.zsh
    export PATH="$HOME/.npm-packages/bin:$PATH"
  '';
}