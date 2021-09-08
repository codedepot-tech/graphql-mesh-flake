{
  description = "Use GraphQL query language to access data in remote APIs that don't run GraphQL";
 
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.graphql-src.url = "github:Urigo/graphql-mesh";
  inputs.graphql-src.flake = false;

  outputs = { self, nixpkgs, flake-utils, graphql-src }: 
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        gql = pkgs.mkYarnPackage {
            name = "graphql-mesh-monorepo";
            src = graphql-src;
            packageJSON = ./package.json;
            yarnLock = ./yarn.lock;
            yarnNix = ./yarn.nix;
          };
      in rec
        {
          packages.graphql-mesh-monorepo = gql;
          defaultPackage = gql;
          devShell = pkgs.mkShell {
            buildInputs = [
              gql
            ];
          };
        }
    ));
}
