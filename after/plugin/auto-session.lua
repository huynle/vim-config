local ok, auto_session = pcall(require, "auto-session")
if not ok then
  return
end

local HOME = vim.fn.expand('$HOME')

auto_session.setup({
  log_level = 'error',
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath('data') .. '/sessions/',
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_suppress_dirs = { '/etc', '/tmp', HOME, HOME .. '/code', HOME .. '/projects', HOME .. '/git' }
})
