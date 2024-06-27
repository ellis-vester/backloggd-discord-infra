packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "nixos" {
  ami_name      = "backloggd-discord-nixos {{timestamp}}"
  instance_type = "t3a.large"
  region        = "ca-central-1"
  vpc_id = "vpc-0e07cd624fe19214f"
  subnet_id = "subnet-088fa3a3215bfeb4a"
  associate_public_ip_address = true

  launch_block_device_mappings {
    device_name = "/dev/xvda"
    volume_size = 30
  }

  source_ami_filter {
    filters = {
      name             = "nixos/24.05*"
      root-device-type = "ebs"
      architecture = "x86_64"
    }
    most_recent = true
    owners      = ["427812963091"]
  }
  ssh_username = "root"
}

build {
  name = "backloggd-discord-nixos"
    sources = [
    "source.amazon-ebs.nixos"
  ]

  provisioner "file" {
    source      = "../nixos/configuration.nix"
    destination = "/tmp/"
  }

  provisioner "file" {
    source = "../nixos/backloggd-discord.nix"
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "mv /tmp/backloggd-discord.nix /etc/nixos/backloggd-discord.nix",
      "mv /tmp/configuration.nix /etc/nixos/configuration.nix",
      "nixos-rebuild switch",
      "nix-collect-garbage -d",
      "rm -rf /etc/ec2-metadata /etc/ssh/ssh_host_* /root/.ssh"
    ]
  }
}
