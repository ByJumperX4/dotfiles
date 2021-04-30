import XMonad
import XMonad.Layout.Grid                   -- my favourite layout.
import XMonad.Config.Xfce                   -- for XFCE compatibility, as I use XFCE's panel with XMonad.
import XMonad.Util.Replace                  -- to replace a currently running window manager automatically.
import System.IO
import Control.Arrow((***), second)
import XMonad.Util.EZConfig                 -- for keybindigs support.
import qualified XMonad.StackSet as W       -- for window managing.

-- For panel support
import XMonad.Hooks.ManageDocks

-- Variables
myFocusFollowsMouse :: Bool  
myFocusFollowsMouse = False
myTerminal          = "alacritty"
myLayout            = avoidStruts $ GridRatio (4/3) ||| Full
mystartupHook       = do
                    -- Required autostarts: panels, network icons, various commands to execute, ...
                    spawn "numlockx"                                    -- enable numlock.
                    spawn "xsetroot -cursor_name left_ptr"              -- set left pointer cursor by default.
                    spawn "pkill dhcpcd-gtk"                            -- kill remaining network applets.
                    spawn "sleep 0.5 && dhcpcd-gtk"                     -- start a new network applet.
                    spawn "pkill xfce4-panel"                           -- kill remaining xfce panel.
                    spawn "sleep 0.5 && xfce4-panel"                    -- start xfce's panel.
                    spawn "nitrogen --restore"                          -- load wallpaper.
                    spawn "xset s off"
                    spawn "xset -dpms"
                    -- Apps to autostart
                    spawn "schildichat-desktop"                         -- a matrix client, my favourite chat client. 
-- Keybinds
myAdditionalKeys=   [ ("C-M1-t", spawn $ myTerminal)                    -- open a terminal.
                    , ("M-w", spawn "rofi -show run")                   -- open rofi.
                    , ("M-x", kill)                                     -- close current window.
                    , ("M-m", sendMessage NextLayout)                   -- toggle "maximized" mode.
                    , ("M-S-q", spawn "pkill X")       -- quit xmonad.
                    , ("M-<Space>", withFocused $ windows . W.sink)     -- Push window back into tiling.
                    ]
-- Main
main = do
  replace
  xmonad $ xfceConfig 
    { modMask               = mod4Mask 
    , terminal              = myTerminal
    , layoutHook            = myLayout 
    , manageHook            = manageHook def <+> manageDocks
    , focusFollowsMouse     = myFocusFollowsMouse
    , startupHook           = mystartupHook
    , normalBorderColor     = "#353528"
    , focusedBorderColor    = "#00FF00" 
    } `additionalKeysP` myAdditionalKeys
