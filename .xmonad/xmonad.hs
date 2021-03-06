import XMonad
import qualified XMonad as X
import XMonad.Layout.Grid						-- my favourite layout.
import XMonad.Util.Replace						-- to replace a currently running window manager automatically.
import System.IO
import Control.Arrow((***), second)
import XMonad.Util.EZConfig						-- for keybindigs support.
import qualified XMonad.StackSet as W					-- for window managing.
import XMonad.Hooks.ManageDocks						-- for panel support
import XMonad.Hooks.DynamicLog						-- logs
import qualified XMonad.Hooks.DynamicBars as Bars
import qualified XMonad.Util.Run as Run

-- Variables
myFocusFollowsMouse = False
myTerminal          = "xterm"						-- yes, I really do use xterm as my main terminal, look at my ~/.Xresources
myLayout            = avoidStruts $ GridRatio (4/3) ||| Full		-- set layout to grid, full is used for maximized windows (toggle with mod + m)
myStartupHook       = do
                    -- Required autostarts: panels, network icons, various commands to execute, ...
                    spawn "numlockx"                                    -- enable numlock.
                    spawn "xsetroot -cursor_name left_ptr"              -- set left pointer cursor by default.
                    spawn "nitrogen --restore"                          -- load wallpaper.
                    spawn "xset s off"
                    spawn "xset -dpms"
		    spawn "pkill stalonetray ; stalonetray"					-- system tray
		    Bars.dynStatusBarStartup barCreator barDestroyer
                    -- Apps to autostart
                    spawn "matrixclient"                                -- open a script that will launch a matrix client. 
myWorkspaces        = ["1","2","3","4","5","6","7","8","9"]
-- Bars setup
myBar              = "xmobar -x 0 -t '%StdinReader% } <fc=#7fff7f>%date%</fc> { %cpu% : %memory% : %uname%                                '" -- the spaces are there to make space for stalonetray
myPP                = xmobarPP { ppCurrent = xmobarColor "#e6ffe6" "" . wrap "<" ">" }
barCreator :: Bars.DynamicStatusBar
barCreator (X.S sid) = Run.spawnPipe $ "xmobar --screen " ++ show sid

barDestroyer :: Bars.DynamicStatusBarCleanup
barDestroyer = return ()
-- Keybinds
myAdditionalKeys =  [ ("C-M1-t", spawn $ myTerminal)                    -- open a terminal.
                    , ("M-w", spawn "rofi -show run")                   -- open rofi run prompt.
		    , ("M-e", spawn "rofi -show window")		-- open rofi window prompt.
		    , ("M-d", spawn "autoclick")			-- launch an autoclicker
		    , ("M-v", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle") -- mute sound
		    , ("M-b", spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle") -- mute mic
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
		    , handleEventHook 	    = Bars.dynStatusBarEventHook barCreator barDestroyer
    		    , manageHook            = manageHook def <+> manageDocks
    		    , focusFollowsMouse     = myFocusFollowsMouse
    		    , startupHook           = myStartupHook
    		    , normalBorderColor     = "#0b250b"
    		    , focusedBorderColor    = "#7fff7f" 
    		    } `additionalKeysP` myAdditionalKeys

-- Main
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig		-- load everything