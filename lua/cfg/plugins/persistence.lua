return {
  'folke/persistence.nvim',
  event = 'VimEnter',
  -- event = 'BufReadPre',
  config = function()
    require('persistence').setup {
      dir = vim.fn.stdpath 'state' .. '/sessions/',
      need = 1,
      branch = true,
    }
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceSavePre',
      callback = function()
        -- Close neo-tree before saving the session
        vim.cmd 'Neotree close'
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceSavePost',
      callback = function()
        -- Optional: Notify the user after saving
        vim.notify('Session saved successfully!', vim.log.levels.INFO)
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceLoadPre',
      callback = function()
        -- Perform any cleanup before loading the session
        print 'Loading session...'
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceLoadPost',
      callback = function()
        -- Optional: Reopen neo-tree after loading a session
        vim.defer_fn(function()
          vim.cmd 'Neotree show'
        end, 50) -- Delay to ensure session is fully restored
      end,
    })

    -- Define key mappings
    vim.keymap.set('n', '<leader>qs', function()
      require('persistence').load()
    end, { desc = 'Load session for current directory' })

    vim.keymap.set('n', '<leader>qS', function()
      require('persistence').select()
    end, { desc = 'Select session to load' })

    vim.keymap.set('n', '<leader>ql', function()
      require('persistence').load { last = true }
    end, { desc = 'Load last session' })

    vim.keymap.set('n', '<leader>qd', function()
      require('persistence').stop()
    end, { desc = 'Stop Persistence (session will not be saved on exit)' })
  end,
}
