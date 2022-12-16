{ config, lib, tools, ... }:

with lib;

let
  router = config.services.eidolon.router;
  cfg = router.nat64;

  versionOpts = v: {
    options = {
      address = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "The source IPv${toString v} address for the NAT64 server.";
      };

      pool = mkOption {
        type = with types; nullOr (submodule (addrOpts v));
        description = "The pool of IPv${toString v} addresses to use for translation.";
      };
    };
  };
in
{
  options = {
    services.eidolon.router.nat64 = {
      enable = mkEnableOption "Eidolon RIS NAT64";

      ipv4 = mkOption {
        type = types.submodule (versionOpts 4);
      };

      ipv6 = mkOption {
        type = types.submodule (versionOpts 6);
      };
    };
  };

  config = mkIf cfg.enable {
    # services.networking.tayga = with tools; {
    #   enable = true;

    #   ipv4 = {
    #     inherit (cfg.ipv4) address pool;
    #     router = { inherit (router.ipv4.addrs.primary) address; };
    #   };

    #   ipv6 = {
    #     inherit (cfg.ipv6) address pool;
    #     router = { inherit (router.ipv6.addrs.primary) address; };
    #   };
    # };

    # # advertise the v4 and v6 pools in IGP
    # services.eidolon.router = {
    #   ipv4.routes.igp = [ (cfg.ipv4.pool // { interface = "nat64"; }) ];
    #   ipv6.routes.igp = [ (cfg.ipv6.pool // { interface = "nat64"; }) ];
    # };
  };
}
