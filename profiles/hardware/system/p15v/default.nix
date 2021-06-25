{ pkgs, hardware, ... }:
let
    inherit (lib.arnix) mkProfile;
in mkProfile {
    imports = [
        hardware.common-pc-laptop
        hardware.common-pc-laptop-ssd
        hardware.common-cpu-intel-kaby-lake
    ];

    requires.profiles = [
        "hardware/capabilities/fingerprint"
    ];

    # thunderbolt support
    services.hardware.bolt.enable = true;

    # use the newer DCAP SGX driver because we have FLC support
    security.sgx.packages.driver = pkgs.linuxPackages.intel-sgx-dcap;

    # hardware video offload
    environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
}