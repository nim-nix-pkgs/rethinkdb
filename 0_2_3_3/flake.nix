{
  description = ''RethinkDB driver for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-rethinkdb-0_2_3_3.flake = false;
  inputs.src-rethinkdb-0_2_3_3.ref   = "refs/tags/0.2.3.3";
  inputs.src-rethinkdb-0_2_3_3.owner = "OpenSystemsLab";
  inputs.src-rethinkdb-0_2_3_3.repo  = "rethinkdb.nim";
  inputs.src-rethinkdb-0_2_3_3.type  = "github";
  
  inputs."struct".owner = "nim-nix-pkgs";
  inputs."struct".ref   = "master";
  inputs."struct".repo  = "struct";
  inputs."struct".dir   = "v0_2_3";
  inputs."struct".type  = "github";
  inputs."struct".inputs.nixpkgs.follows = "nixpkgs";
  inputs."struct".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."scram".owner = "nim-nix-pkgs";
  inputs."scram".ref   = "master";
  inputs."scram".repo  = "scram";
  inputs."scram".dir   = "0_2_0";
  inputs."scram".type  = "github";
  inputs."scram".inputs.nixpkgs.follows = "nixpkgs";
  inputs."scram".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-rethinkdb-0_2_3_3"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-rethinkdb-0_2_3_3";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}