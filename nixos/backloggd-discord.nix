{ lib, buildGoModule, fetchFromGitHub, ...}:

buildGoModule rec {
  pname = "backlooggd-discord";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "ellis-vester";
    repo = "backloggd-discord";
    rev = "v${version}";
    hash = "sha256-gXE3+G0IJnpfHQdk3bfj3B/1dl2P2AeA+FsZ1M+aojY=";
  };

  vendorHash = "sha256-UKlzYCySXMfLKymqA/FARJ0OgK4cLJgqbNCQPFCib3g=";

  meta = {
    description = "Backloggd bot for Discord.";
    homepage = "https://github.com/ellis-vester/backloggd-discord";
    license = lib.licenses.mit;
  };
}

