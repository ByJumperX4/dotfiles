import XMonad
import XMonad.Layout.Grid                   -- my favourite layout.
import XMonad.Config.Xfce                   -- for XFCE compatibility, as I use XFCE's panel with XMonad.
import XMonad.Util.Replace                  -- to replace a currently running window manager automatically.
import System.IO
import Control.Arrow((***), second)
import XMonad.Util.EZConfig                 -- for keybindigs support.
import qualified XMonad.StackSet as W       -- for window managing.
import XMonad.Hooks.ManageDocks     	    -- for panel support
import XMonad.Hooks.DynamicLog 		    -- logs

-- Variables
myFocusFollowsMouse :: Bool  
myFocusFollowsMouse = False
myTerminal          = "xterm" -- Yes, I really do use xterm as my main terminal, look at my ~/.Xresources
myLayout            = avoidStruts $ GridRatio (4/3) ||| Full
myStartupHook       = do
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
		    spawn "stalonetray"					-- system tray
                    -- Apps to autostart
                    spawn "matrixclient"                                -- open a script that will launch a matrix web client in firefox kiosk mode. 
myWorkspaces        = ["1","2","3","4","5","6","7","8","9"]
myBar               = "xmobar"
myPP                = xmobarPP { ppCurrent = xmobarColor "#e6ffe6" "" . wrap "<" ">" }
-- Keybinds
myAdditionalKeys =  [ ("C-M1-t", spawn $ myTerminal)                    -- open a terminal.
                    , ("M-w", spawn "rofi -show run")                   -- open rofi run prompt.
		    , ("M-e", spawn "rofi -show window")		-- open rofi window prompt.
                    , ("M-x", kill)                                     -- close current window.
                    , ("M-m", sendMessage NextLayout)                   -- toggle "maximized" mode.
                    , ("M-S-q", spawn "pkill X")       			-- quit xmonad.
                    , ("M-<Space>", withFocused $ windows . W.sink)     -- push window back into tiling.
                    ] ++ 
    		    [ (otherModMasks ++ "M-" ++ [key], action tag)
      		    | (tag, key)  <- zip myWorkspaces "123456789"
      		    , (otherModMasks, action) <- [ ("", windows . W.view)
                    , ("S-", windows . W.shift)]
    		    ]
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_t)    -- toggle bar with mod + t
-- Config
myConfig = def	    { modMask               = mod4Mask
     	    	    , workspaces = myWorkspaces
          	    , terminal              = myTerminal
    		    , layoutHook            = myLayout 
    		    , manageHook            = manageHook def <+> manageDocks
    		    , focusFollowsMouse     = myFocusFollowsMouse
    		    , startupHook           = myStartupHook
    		    , normalBorderColor     = "#0b250b"
    		    , focusedBorderColor    = "#7fff7f" 
    		    } `additionalKeysP` myAdditionalKeys

-- Main
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig