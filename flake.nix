{
  description = "use GraphQL query language to access data in remote APIs that don't run GraphQL";
 
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.graphql-src.url = "github:Urigo/graphql-mesh";
  inputs.graphql-src.flake = false;

  outputs = { self, nixpkgs, flake-utils, graphql-src }: 
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        name = "graphql-mesh-monorepo";
      in 
        {
          packages."${name}" = pkgs.mkYarnPackage {
            name = "graphql-mesh-monorepo";
            src = graphql-src;
            packageJSON = ./package.json;
            yarnLock = ./yarn.lock;
            yarnNix = ./yarn.nix;
          };
          defaultPackage = self.packages.graphql-mesh-monorepo;
          devShell = pkgs.mkShell {
            buildInputs = [
              self.defaultPackage
            ];
          };
        }
    ));
}
