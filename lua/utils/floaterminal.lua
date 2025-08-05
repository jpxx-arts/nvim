-- ~/.config/nvim/lua/utils/floaterminal.lua (Versão Corrigida)

local M = {}

local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }
  local win = vim.api.nvim_open_win(buf, true, win_config)
  return { buf = buf, win = win }
end

-- Função que abre e fecha o terminal
function M.toggle()
  -- Se a janela não existe, crie-a
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    
    -- Se o buffer ainda não for um terminal, o inicializamos
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      -- CORREÇÃO: Foca na janela flutuante e então executa o comando :terminal
      vim.api.nvim_set_current_win(state.floating.win)
      vim.cmd.terminal()
    end
  else
    -- Se a janela já existe, apenas a esconda
    vim.api.nvim_win_hide(state.floating.win)
  end
  vim.cmd('startinsert')
end

-- Cria o comando de usuário :Floaterminal
vim.api.nvim_create_user_command("Floaterminal", M.toggle, {})

-- Retorna o módulo para que ele possa ser usado em outros arquivos (keymaps)
return M
