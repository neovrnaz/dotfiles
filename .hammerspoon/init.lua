hs.loadSpoon("SpoonInstall")

--------------------------------
-- START VIM CONFIG
--------------------------------
local VimMode = hs.loadSpoon("VimMode")
local vim = VimMode:new()

-- Configure apps you do *not* want Vim mode enabled in
-- For example, you don't want this plugin overriding your control of Terminal
-- vim
vim
 :disableForApp('Terminal')
 :disableForApp('PyCharm')
 :disableForApp('WebStorm')
 :disableForApp('IntelliJ IDEA')
 :disableForApp('MacVim')
 :disableForApp('Cascadea')
 :disableForApp('Notes')
 :disableForApp('System Preferences')
 :disableForApp('Finder')
 :disableForApp('Shortcuts')

vim:useFallbackMode('Google Chrome')

-- If you want the screen to dim (a la Flux) when you enter normal mode
-- flip this to true.
vim:shouldDimScreenInNormalMode(false)

-- If you want to show an on-screen alert when you enter normal mode, set
-- this to true
vim:shouldShowAlertInNormalMode(true)

-- You can configure your on-screen alert font
vim:setAlertFont("Courier New")

-- Enter normal mode by typing a key sequence
-- vim:enterWithSequence('')

-- if you want to bind a single key to entering vim, remove the
-- :enterWithSequence('ue') line above and uncomment the bindHotKeys line
-- below:
--
-- To customize the hot key you want, see the mods and key parameters at:
--   https://www.hammerspoon.org/docs/hs.hotkey.html#bind
--
vim:bindHotKeys({ enter = { {''}, 'escape' } })

vim:enableBetaFeature('block_cursor_overlay')

--------------------------------
-- END VIM CONFIG
--------------------------------
