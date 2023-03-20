let
  inherit (builtins) length head tail listToAttrs genList;
  lib = import <nixpkgs/lib>;
  recursiveUpdate = lib.attrsets.recursiveUpdate;
  range = a: b: if a < b then [a] ++ range (a+1) b else [];
  globalPath = "org/gnome/settings-daemon/plugins/media-keys";
  path = "${globalPath}/custom-keybindings";
  mkPath = id: "${globalPath}/custom${toString id}";
  isEmpty = list: length list == 0;
  mkSettings = settings:
    let
    checkSettings = { name, command, binding }@this: this;
    aux = i: list:
      if isEmpty list then [] else
      let
        hd = head list;
        tl = tail list;
        name = mkPath i;
      in
        aux (i+1) tl ++ [ {
        name = mkPath i;
        value = checkSettings hd;
        } ];
    settingsList = (aux 0 settings);
    in
    listToAttrs (settingsList ++ [
      {
      name = globalPath;
      value = {
        custom-keybindings = genList (i: "/${mkPath i}/") (length settingsList);
      };
      }
    ]);
in # Keybindings
  recursiveUpdate (mkSettings [
    {
      binding = "<Alt>Tab";
      command = "switch-windows";
      name = "Switch Windows";
    }
    {
      binding = "<Alt><Shift>Tab";
      command = "switch-windows-backward";
      name = "Switch Windows Backward";
    }
    {
      binding = [];
      command = "switch-applications";
      name = "Switch Applications";
    }
    {
      binding = [];
      command = "switch-applications-backward";
      name = "Switch Applications Backward";
    }
  ])
  {
    "org/gnome/shell/extensions/dash-to-dock" = {
      "click-action" = "launch";
      "dock-fixed" = false;
    };
    "org/gnome/desktop/input-sources" = {
      "sources" = [
        "('xkb', 'us')"
        "('xkb', 'ua')"
        "('xkb', 'ru')"
      ];
    };
  }