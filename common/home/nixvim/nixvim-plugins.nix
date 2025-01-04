 { ... }:
{ # Plugins for neovim
  programs.nixvim.plugins = {
    lazygit.enable = true;   # LazyGit integration
    
    nvim-tree = {  # Display a filetree in the left
      enable = true;
      openOnSetup = true;
      filters = {
         custom = [ ".git" ];
       };
    };
    web-devicons.enable = true;  # Required for nvim-tree

    chatgpt = {		#ChatGPT integration
      enable = true;
      settings = { 
        api_key_cmd = "echo $OPENAI_API_KEY"; # Fetches api key from environment variable. The variable needs to be set on every user. Set the variable with this command: echo "export OPENAI_API_KEY='yourkey'" >> ~/.bash_profile
          openai_params = {
            model = "gpt-4o-mini"; #gpt-4o-mini is the cheapest model at this time
            max_tokens = 300;	# Limit tokens in case the model starts blabbering on.
        };
        openai_edit_params = {
          model = "gpt-4o-mini";  # gpt-4o-mini is the cheapest model at this time
          max_tokens = 2000; 	# Allow for more tokens so it can return the entire edited code.
        };    
      };    
    };

    treesitter = {  # Treesitter integration (better syntax highlighting)
      enable = true;
      settings = {
        highlight = {
          enable = true;
        };
        indent = {
          enable = true;
        };
      };
    };
    lsp = {  # Autocompletion etc.
      enable = true;
      servers = {
        nixd.enable = true;
        pyright.enable = true;
        openscad_lsp.enable = true;
      };
    };

    cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
    };

    which-key = {		# Display keybindings
      enable = true;
    };

    nvim-autopairs = {  # Autocomplete brackets
      enable = true;
      settings.check_ts = true;	# Use treesitter for checking pairs
    };

    indent-blankline = {  # Display indentation lines
      enable = true;
    }; 
    lualine = { # A better looking status line
      enable = true;
    };
    dressing = {  # Better looking popups
      enable = true;
    };
    rainbow-delimiters = {  # Color bracket pairs
      enable = true;
    };
    guess-indent = {  # Smarter automatic indentations
      enable = true;
      settings = {
        override_editorconfig = true;
      };
    };
    comment = { # Shortcuts for commenting
       enable = true;
     };
  };
}
