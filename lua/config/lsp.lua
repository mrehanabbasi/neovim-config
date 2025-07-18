return {
  servers = {
    gopls = {
      settings = {
        gopls = {
          -- gofumpt = true,
          codelenses = {
            gc_details = false,
            generate = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          analyses = {
            -- fieldalignment = true,
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
          },
          usePlaceholders = true,
          completeUnimported = true,
          -- staticcheck = true,
          directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
          semanticTokens = true,
          deepCompletion = true,
        },
      },
    },

    jsonls = {
      -- lazy-load schemastore when needed
      on_new_config = function(new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
      end,
      settings = {
        json = {
          format = {
            enable = true,
          },
          validate = { enable = true },
        },
      },
    },

    yamlls = {
      -- Have to add this for yamlls to understand that we support line folding
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      -- lazy-load schemastore when needed
      on_new_config = function(new_config)
        local crd_schemas = {
          ["https://raw.githubusercontent.com/external-secrets/external-secrets/main/config/crds/bases/external-secrets.io_externalsecrets.yaml"] = {
            "**/externalsecret*.yaml",
          },
          ["https://raw.githubusercontent.com/external-secrets/external-secrets/main/config/crds/bases/external-secrets.io_secretstores.yaml"] = {
            "**/secretstore*.yaml",
          },
          ["https://raw.githubusercontent.com/istio/istio/master/manifests/charts/base/files/crd-all.gen.yaml"] = {
            "**/virtualservice*.yaml",
          },
        }

        -- Ensure schemas table exists before merging
        new_config.settings.yaml.schemas = vim.tbl_deep_extend(
          "force",
          new_config.settings.yaml.schemas or {},
          require("schemastore").yaml.schemas(),
          crd_schemas
        )
      end,
      settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
          keyOrdering = false,
          format = {
            enable = true,
          },
          validate = true,
          schemaStore = {
            -- Must disable built-in schemaStore support to use
            -- schemas from SchemaStore.nvim plugin
            enable = false,
            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
            -- url = "",
          },
        },
      },
    },

    dockerls = {},
    docker_compose_language_service = {},

    nixd = {},
  },

  setup = {
    gopls = function(_, opts)
      -- workaround for gopls not supporting semanticTokensProvider
      -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
      LazyVim.lsp.on_attach(function(client, _)
        if not client.server_capabilities.semanticTokensProvider then
          -- Ensure client.config.capabilities and textDocument are not nil
          local semantic = client.config.capabilities.textDocument
            and client.config.capabilities.textDocument.semanticTokens
          if semantic then
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              legend = {
                tokenTypes = semantic.tokenTypes,
                tokenModifiers = semantic.tokenModifiers,
              },
              range = true,
            }
          end
        end
      end, "gopls")
      -- end workaround
    end,
  },

  yamlls = function()
    -- Neovim < 0.10 does not have dynamic registration for formatting
    if vim.fn.has("nvim-0.10") == 0 then
      LazyVim.lsp.on_attach(function(client, _)
        client.server_capabilities.documentFormattingProvider = true
      end, "yamlls")
    end
  end,

  helm_ls = function(_, opts)
    opts.settings = {
      schemas = vim.tbl_deep_extend("force", opts.settings.schemas or {}, {
        ["https://raw.githubusercontent.com/external-secrets/external-secrets/main/config/crds/bases/external-secrets.io_externalsecrets.yaml"] = "**/externalsecret*.yaml",
        ["https://raw.githubusercontent.com/external-secrets/external-secrets/main/config/crds/bases/external-secrets.io_secretstores.yaml"] = "**/secretstore*.yaml",
        ["https://raw.githubusercontent.com/istio/istio/master/manifests/charts/base/files/crd-all.gen.yaml"] = "**/virtualservice*.yaml",
      }),
    }
  end,
}
