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
    theme = "robbyrussell";
  };
}