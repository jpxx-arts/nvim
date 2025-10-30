local M = {}
local popup_win = nil
local popup_buf = nil

function M.toggle_filepath()
  if popup_win and vim.api.nvim_win_is_valid(popup_win) then
    vim.api.nvim_win_close(popup_win, true)
    popup_win = nil
    popup_buf = nil
    return
  end

  local filepath = vim.fn.expand("%:.")
  if filepath == "" then
    vim.notify("No open file", vim.log.levels.WARN)
    return
  end

  popup_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(popup_buf, 0, -1, false, { filepath })

  local width = math.min(80, #filepath + 2)
  local height = 1
  local row = 2
  local col = math.floor((vim.o.columns - width) / 2)

  popup_win = vim.api.nvim_open_win(popup_buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })
end

return M

