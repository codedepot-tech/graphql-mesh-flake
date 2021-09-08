{
  description = "use GraphQL query language to access data in remote APIs that don't run GraphQL";
 
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: 
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; }; 
        gql = import ./default.nix { inherit pkgs; };
      in 
        {
          packages.graphql-mesh-monorepo = gql.package;
          defaultPackage = gql.package;
          devShell = gql.shell;
        }
    ));
}
