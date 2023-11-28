local indent_blankline_ok, indent_blankline = pcall(require, "ibl")
if not indent_blankline_ok then
  return
end

indent_blankline.setup()
