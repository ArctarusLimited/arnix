final: prev: {
  # applications
  cilium-cli = prev.callPackage ./applications/networking/cilium-cli { };
  hubble = prev.callPackage ./applications/networking/hubble { };
  clusterctl = prev.callPackage ./applications/networking/cluster/clusterctl { };
  talosctl = prev.callPackage ./applications/networking/cluster/talosctl { };
  vcluster = prev.callPackage ./applications/networking/cluster/vcluster { };
  kata-images = prev.callPackage ./applications/virtualization/kata-images { };
  kata-runtime = prev.callPackage ./applications/virtualization/kata-runtime { };

  # development
  codesafe = prev.callPackage ./development/libraries/codesafe { };
  qvtf = prev.callPackage ./development/libraries/qvtf { };
  secworld = prev.callPackage ./development/libraries/secworld { };
  vtflib = prev.callPackage ./development/libraries/vtflib { };
  #nodePackagesCustom = import ./development/node-packages { pkgs = final; };

  # misc
  canon-cups-cque = prev.callPackage ./misc/cups/drivers/canon-cque { };

  # os-specific
  linuxPackages = import ./os-specific/linux { inherit final prev; };

  # tools
  calico-node = prev.callPackage ./tools/networking/calico/calico-node.nix { };
  calicoctl = prev.callPackage ./tools/networking/calico/calicoctl.nix { };
  inix-helper = import ./tools/package-management/inix-helper { inherit final prev; };
  velero = prev.callPackage ./tools/backup/velero { };

  # python
  # python3 = prev.python3.override {
  #     packageOverrides = import ./development/python-modules;
  # };

  # python37 = prev.python37.override {
  #     packageOverrides = import ./development/python-modules;
  # };

  # python38 = prev.python38.override {
  #     packageOverrides = import ./development/python-modules;
  # };
}
