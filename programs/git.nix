{
  enable = true;
  userName = "akorchyn";
  userEmail = "artur.yurii.korchynskyi@gmail.com";
  signing = {
    key = "artur.yurii.korchynskyi@gmail.com";
    signByDefault = true;
  };
  extraConfig = {
    url = {
      "git@github.com:" = {
        insteadOf = "https://github.com/";
      };
    };
  };
  includes = [
    {
      condition = "gitdir:/mnt/work/boosty/**";
      contents = {
        user = {
          email = "artur.korchynskyi@boostylabs.com";
          signingKey = "3E5A592823DBAE21";
        };
      };
    }
    {
      condition = "gitdir:/mnt/work/ggx/**";
      contents = {
        user = {
          email = "artur.yurii.korchynskyi@ggxchain.io";
          signingKey = "93C0473D4D2C654E";
        };
      };
    }
  ];
}