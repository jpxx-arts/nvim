-- ~/.config/nvim/lua/utils/java_file_creator.lua (Versão Corrigida)

local M = {}

local templates = {
  Class = "public class %s {\n\n\t// %s\n\n}",
  Interface = "public interface %s {\n\n\t// %s\n\n}",
  Enum = "public enum %s {\n\n\t// %s\n\n}",
  Record = "public record %s() {\n\n\t// %s\n\n}",
}

function M.create_java_file()
  local current_dir = vim.fn.expand("%:p:h")
  local file_types = { "Class", "Interface", "Enum", "Record" }

  vim.ui.select(file_types, { prompt = "Selecione o tipo de arquivo Java:" }, function(choice)
    if not choice then
      print("Criação de arquivo cancelada.")
      return
    end

    vim.ui.input({ prompt = "Nome da " .. choice .. ": " }, function(filename)
      if not filename or filename == "" then
        print("Criação de arquivo cancelada.")
        return
      end

      local new_file_path = current_dir .. "/" .. filename .. ".java"
      vim.g.java_template_info = {
        type = choice,
        filename = filename,
      }
      vim.cmd("edit " .. new_file_path)
    end)
  end)
end

local function insert_java_template()
  if not vim.g.java_template_info then
    return
  end

  local info = vim.g.java_template_info
  vim.g.java_template_info = nil

  local file_path = vim.fn.expand("%:p")
  local package_path = file_path:match("src/main/java/(.*)") or file_path:match("src/test/java/(.*)")
  local package_statement = ""

  if package_path then
    package_path = package_path:match("(.*/)")
    if package_path then
      package_statement = "package " .. package_path:gsub("/", "."):gsub("%.$", "") .. ";\n\n"
    end
  end

  local template_body = templates[info.type]
  if not template_body then
    return
  end

  local final_content = package_statement .. string.format(template_body, info.filename, "|")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(final_content, "\n"))

  local cursor_pos_line, cursor_pos_col = nil, nil
  for i, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    local col = line:find("|", 1, true)
    if col then
      cursor_pos_line = i
      cursor_pos_col = col - 1
      -- Linha corrigida para descartar o segundo valor de retorno do gsub
      vim.api.nvim_buf_set_lines(0, i - 1, i, false, { (line:gsub("|", "")) })
      break
    end
  end

  if cursor_pos_line then
    vim.api.nvim_win_set_cursor(0, { cursor_pos_line, cursor_pos_col })
  end
end

local augroup = vim.api.nvim_create_augroup("JavaTemplate", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
  group = augroup,
  pattern = "*.java",
  callback = insert_java_template,
})

return M
