{ config, ... }:
{
  nixpkgs.config.allowUnfreePackages = [
    "cuda_cudart"
    "cuda_nvcc"
    "cuda_cccl"
    "libcublas"
  ];
  flake.modules.nixos.ai = { pkgs, ... }:
  {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      loadModels = [
        "ministral-3:14b"
        "ministral-3:8b"
        "ministral-3:3b"
        "codestral"
      ];
    };
  };
}
