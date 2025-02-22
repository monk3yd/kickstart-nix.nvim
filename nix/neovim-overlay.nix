# This overlay, when applied to nixpkgs, adds the final neovim derivation to nixpkgs.
{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Use this to create a plugin from a flake input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  # Make sure we use the pinned nixpkgs instance for wrapNeovimUnstable,
  # otherwise it could have an incompatible signature when applying this overlay.
  pkgs-wrapNeovim = inputs.nixpkgs.legacyPackages.${pkgs.system};

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix { inherit pkgs-wrapNeovim; };

  zellijnav = pkgs.vimUtils.buildVimPlugin {
    pname = "zellij-nav.nvim";
    version = "2024-09-03";
    src = pkgs.fetchFromGitHub {
      owner = "swaits";
      repo = "zellij-nav.nvim";
      rev = "511e9b7bb7165ef817dbfb40169cea9b4d3c3d44";
      sha256 = "0cvdxzbz45ac46s1i811l67g1hg5wgsb8hy7rrzbw52mq8qbkliw";
    };
    meta.homepage = "https://github.com/swaits/zellij-nav.nvim/";
  };

  # nvimufo = pkgs.vimUtils.buildVimPlugin {
  #   pname = "nvim-ufo";
  #   version = "2024-04-03";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "kevinhwang91";
  #     repo = "nvim-ufo";
  #     rev = "a52c92c3bbaa10f0c9b547a50adaa8c7d8b29f94";
  #     sha256 = "1fv3rhny1d8wgxd3h3fy4vv05nb0fz506sk2in8rkmwlzwixl2wn";
  #   };
  #   meta.homepage = "https://github.com/kevinhwang91/nvim-ufo/";
  # };

  git-worktree = pkgs.vimUtils.buildVimPlugin {
    pname = "git-worktree.nvim";
    version = "2.0.1";
    src = pkgs.fetchFromGitHub {
        owner = "polarmutex";
        repo = "git-worktree.nvim";
        rev = "bac72c240b6bf1662296c31546c6dad89b4b7a3c";
        sha256 = "1zlxycgnwb7gb85m5lxwlfdcsyyidikkph1aphngxyizfy325xsj";
    };
  };

  # A plugin can either be a package or an attrset, such as
  # { plugin = <plugin>; # the package, e.g. pkgs.vimPlugins.nvim-cmp
  #   config = <config>; # String; a config that will be loaded with the plugin
  #   # Boolean; Whether to automatically load the plugin as a 'start' plugin,
  #   # or as an 'opt' plugin, that can be loaded with `:packadd!`
  #   optional = <true|false>; # Default: false
  #   ...
  # }
  all-plugins = with pkgs.vimPlugins; [
    # plugins from nixpkgs go in here.
    # https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=vimPlugins

    nvim-treesitter.withAllGrammars
    luasnip # snippets | https://github.com/l3mon4d3/luasnip/
    # nvim-cmp (autocompletion) and extensions
    nvim-cmp # https://github.com/hrsh7th/nvim-cmp
    cmp_luasnip # snippets autocompletion extension for nvim-cmp | https://github.com/saadparwaiz1/cmp_luasnip/
    lspkind-nvim # vscode-like LSP pictograms | https://github.com/onsails/lspkind.nvim/
    cmp-nvim-lsp # LSP as completion source | https://github.com/hrsh7th/cmp-nvim-lsp/
    cmp-nvim-lsp-signature-help # https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/
    cmp-buffer # current buffer as completion source | https://github.com/hrsh7th/cmp-buffer/
    cmp-path # file paths as completion source | https://github.com/hrsh7th/cmp-path/
    cmp-nvim-lua # neovim lua API as completion source | https://github.com/hrsh7th/cmp-nvim-lua/
    cmp-cmdline # cmp command line suggestions
    cmp-cmdline-history # cmp command line history suggestions
    # ^ nvim-cmp extensions
    # git integration plugins
    diffview-nvim # https://github.com/sindrets/diffview.nvim/
    neogit # https://github.com/TimUntersberger/neogit/
    gitsigns-nvim # https://github.com/lewis6991/gitsigns.nvim/
    vim-fugitive # https://github.com/tpope/vim-fugitive/
    # ^ git integration plugins
    # telescope and extensions
    telescope-nvim # https://github.com/nvim-telescope/telescope.nvim/
    telescope-fzy-native-nvim # https://github.com/nvim-telescope/telescope-fzy-native.nvim
    # telescope-smart-history-nvim # https://github.com/nvim-telescope/telescope-smart-history.nvim
    # ^ telescope and extensions
    # UI
    lualine-nvim # Status line | https://github.com/nvim-lualine/lualine.nvim/
    nvim-navic # Add LSP location to lualine | https://github.com/SmiteshP/nvim-navic
    statuscol-nvim # Status column | https://github.com/luukvbaal/statuscol.nvim/
    nvim-treesitter-context # nvim-treesitter-context
    # ^ UI
    # language support
    # ^ language support
    # navigation/editing enhancement plugins
    vim-unimpaired # predefined ] and [ navigation keymaps | https://github.com/tpope/vim-unimpaired/
    eyeliner-nvim # Highlights unique characters for f/F and t/T motions | https://github.com/jinh0/eyeliner.nvim
    nvim-surround # https://github.com/kylechui/nvim-surround/
    nvim-treesitter-textobjects # https://github.com/nvim-treesitter/nvim-treesitter-textobjects/
    nvim-ts-context-commentstring # https://github.com/joosepalviste/nvim-ts-context-commentstring/
    # ^ navigation/editing enhancement plugins
    # Useful utilities
    nvim-unception # Prevent nested neovim sessions | nvim-unception
    # ^ Useful utilities
    # libraries that other plugins depend on
    sqlite-lua
    plenary-nvim
    nvim-web-devicons
    vim-repeat
    # ^ libraries that other plugins depend on
    # bleeding-edge plugins from flake inputs
    # (mkNvimPlugin inputs.wf-nvim "wf.nvim") # (example) keymap hints | https://github.com/Cassin01/wf.nvim
    # ^ bleeding-edge plugins from flake inputs
    which-key-nvim

    # ---- monk3yd ----
    gruvbox-material # https://github.com/sainnhe/gruvbox-material
    zellijnav # https://github.com/swaits/zellij-nav.nvim
    promise-async # https://github.com/kevinhwang91/promise-async/
    nvim-lspconfig
    toggleterm-nvim # https://github.com/akinsho/toggleterm.nvim/

    # TODO
    # git-worktree-nvim # https://github.com/ThePrimeagen/git-worktree.nvim/
    # git-worktree # https://github.com/polarmutex/git-worktree.nvim

    # DAP
    nvim-dap # https://github.com/mfussenegger/nvim-dap/
    nvim-dap-ui # https://github.com/rcarriga/nvim-dap-ui/
    nvim-nio # https://github.com/nvim-neotest/nvim-nio/
    # telescope-dap-nvim # https://github.com/nvim-telescope/telescope-dap.nvim/
    nvim-dap-go
    nvim-dap-python
    # nvim-dap-vscode-js # https://github.com/mxsdev/nvim-dap-vscode-js

    # Formatter
    # conform-nvim # https://github.com/stevearc/conform.nvim

    # jsonls lsp dependency
    SchemaStore-nvim # https://github.com/b0o/SchemaStore.nvim/

    # nvimufo # https://github.com/kevinhwang91/nvim-ufo/
    nvim-ufo

    # AI
    # copilot-vim # https://github.com/github/copilot.vim/
  ];

  extraPackages = with pkgs; [
    # language servers, etc.
    lua-language-server
    nil # nix lsp
    gopls # go lsp
    delve # go debugger
    templ
    htmx-lsp
    pyright # python lsp
    black # python formatter
    tailwindcss-language-server
    dockerfile-language-server-nodejs # dockerfile lsp
    vscode-langservers-extracted # html/css/eslint/json
    typescript
    typescript-language-server # js/ts lsp
  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # This can be symlinked in the devShell's shellHook
  nvim-luarc-json = final.mk-luarc-json {
    plugins = all-plugins;
  };

  # You can add as many derivations as you like.
  # Use `ignoreConfigRegexes` to filter out config
  # files you would not like to include.
  #
  # For example:
  #
  # nvim-pkg-no-telescope = mkNeovim {
  #   plugins = [];
  #   ignoreConfigRegexes = [
  #     "^plugin/telescope.lua"
  #     "^ftplugin/.*.lua"
  #   ];
  #   inherit extraPackages;
  # };
}
