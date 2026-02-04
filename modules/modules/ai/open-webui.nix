{
  flake.modules.nixos.ai = {
    services.open-webui = {
      enable = true;
      environment = {
        CONTENT_EXTRACTION_ENGINE = "tika";
        ENABLE_OLLAMA_API = "True";
        OLLAMA_BASE_URL = "http://127.0.0.1:11434";
        OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
        PDF_EXTRACT_IMAGES = "True";
        TIKA_SERVER_URL = "http://tardis:9998";
        WEBUI_AUTH = "False";
        WEBUI_NAME = "LLM @ Home";
      };
    };
  };
}
