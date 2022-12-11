{
  description = "A collection of handy scripts for TLS plumbing";

  inputs.flake-utils.url = "github:numtide/flake-utils";


  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        packages = flake-utils.lib.flattenTree {
          show-remote-cert = pkgs.writeShellScriptBin "show-remote-cert" ''
            if [ "$1" == "" -o "$1" == "-h" -o "$1" == "--help" ]; then
              echo "Usage: show-remote-cert HOSTNAME [PORT]"
              exit 2
            fi
            HOST="$1"
            PORT="''${2:-443}"

            CERTS=$(echo | ${pkgs.openssl.bin}/bin/openssl s_client -showcerts -servername "$1" -connect "$HOST:$PORT")

            if [ "$CERTS" == "" -o $? -ne 0 ]; then
              echo "could not connect to the remote at $HOST:$PORT or fetch the ceritifcate"
              exit 1
            fi

            echo "$CERTS" | ${pkgs.openssl.bin}/bin/openssl x509 -inform pem -noout -text
          '';
        };
        defaultPackage = packages.show-remote-cert;
        apps.show-remote-cert = flake-utils.lib.mkApp { drv = packages.show-remote-cert; };
        defaultApp = apps.show-remote-cert;
      }
    );
}
