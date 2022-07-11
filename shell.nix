{ pkgs ? import <nixpkgs> { }, ... }:
let pythonCustom = pkgs.python39.overrideAttrs (old:
  {
    src = pkgs.fetchFromGitHub {
      owner = "colesbury";
      repo = "nogil";
      rev = "c3894a5ead20f5bc344993550d3f2a9aa0c9b341";
      sha256 = "1lh5j4gn5h9z95cij8bryymib20jjvxbpbygmvc59970qpm1951f";
    };
  }
);
in
pkgs.mkShell {

  # Package names can be found via https://search.nixos.org/packages
  nativeBuildInputs = with pkgs; [
    # baseline 
    direnv
    gitFull
    subversion
    nixfmt
    exa
    terraform
    terraform-ls
    python310
    rnix-lsp
    pythonCustom
  ];

  NIX_ENFORCE_PURITY = true;

  shellHook = ''
    alias tf=terraform
    alias lse='exa -lah'
    alias nixpkgs-fmt='nixfmt'
  '';
}
