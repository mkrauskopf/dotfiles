--------------------------------------------------------------------------
-- Maintainer : martin.krauskopf (@) gmail.com
--
-- xmonad config (inspired by many)
--------------------------------------------------------------------------

import Control.Monad((<=<))
import Data.Monoid(appEndo)
import Graphics.X11.ExtraTypes.XorgDefault
import System.IO(hPutStrLn)
import XMonad hiding ((|||))
import XMonad.Actions.CopyWindow(copyToAll)
import XMonad.Actions.GridSelect(defaultGSConfig, spawnSelected)
import XMonad.Actions.NoBorders(toggleBorder)
import XMonad.Actions.WindowBringer(gotoMenu)
import XMonad.Actions.WindowGo(runOrRaise)
import XMonad.Hooks.DynamicLog(xmobarPP, ppOutput, ppTitle, xmobarColor, shorten, dynamicLogWithPP)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.ManageDocks(manageDocks, avoidStruts, ToggleStruts(ToggleStruts))
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName(setWMName)
import XMonad.Layout.LayoutCombinators(JumpToLayout(JumpToLayout), (|||))
import XMonad.Layout.Maximize(maximize, maximizeRestore)
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run(spawnPipe)

import qualified Data.Map as M
import qualified XMonad.StackSet as W


-- Scratchpads
scratchpads :: [NamedScratchpad]
scratchpads =
  [ -- run in xterm, find it by title, use default floating window
    -- placement
    NS "rxvt-quick" "rxvt -sr -bg black -fg white -fn -*-fixed-medium-r-normal-*-12-*-*-*-*-*-iso8859-2 -fb -*-fixed-medium-r-normal-*-12-*-*-*-*-*-iso8859-2 --color11 orange -sl 2500 -title rxvt-quick" (title =? "rxvt-quick") rightBottomFloating
  , NS "top" "gnome-terminal -e top -t top" (title =? "top") leftBottomFloating
  , NS "iotop" "gnome-terminal -e iotop -t iotop" (title =? "iotop") rightTopFloating
  , NS "alarm-clock-applet" "alarm-clock-applet" (title =? "Alarms") leftTopFloating

    -- run stardict, find it by class name, place it in the floating window 1/6
    -- of screen width from the left, 1/6 of screen height from the top, 2/3 of
    -- screen width by 2/3 of screen height
  , NS "stardict" "stardict" (className =? "Stardict") rightBottomFloating
 ] where leftBottomFloating = customFloating $ W.RationalRect (1/25) (3/5) (1/3) (1/3)
         leftTopFloating = customFloating $ W.RationalRect (3/5) (1/25) (1/3) (1/3)
         rightBottomFloating = customFloating $ W.RationalRect (52/100) (52/100) (46/100) (46/100)
         rightTopFloating = customFloating $ W.RationalRect (3/5) (1/5) (1/3) (1/3)


-- Control-Alt-Shift-<key> mapping
casMap :: MonadIO m => String -> String -> (String, m ())
casMap key cmd' = ("C-M1-S-" ++ key, spawn cmd')

myManageHook = composeAll . concat $
  [ [ title       =? c --> doFloat     | c <- myFloatsTitles]
  , [ className   =? c --> doFloat     | c <- myFloats]
  , [ className   =? c --> unfloat     | c <- myNonFloats]
  , [ className   =? c --> doShift "7" | c <- ws7]
  , [ className   =? c --> doShift "6" | c <- ws6]
  , [ className   =? c --> doShift "8" | c <- ws8]
  , [ isFullscreen --> doFullFloat ]
  ]
  where
    unfloat = ask >>= doF . W.sink
    myNonFloats  = [ "Gimp" ]
    myFloats  = [ "Dialog", "Gcalctool", "VirtualBox", "Vncviewer"
                , "Gnome-sound-properties", "Gnome-display-properties"
                , "javax.swing.JDialog", "Downloads", "Gksudo"
                , "Alarm-clock-applet"
                ]
    myFloatsTitles  = [ "Java Tester", "Firefox Preferences" ]
    ws6       = ["Xchat"]
    ws7       = ["Shredder", "Skype.real", "Pidgin"]
    ws8       = ["RSSOwl"]

myLayout = maximize tiled
       ||| maximize (Mirror tiled)
       ||| maximize Full
       ||| maximize columns3
  where
     tiled    = Tall nmaster delta ratio
     nmaster  = 1
     ratio    = 1/2
     delta    = 3/100
     columns3 = ThreeColMid 1 (3/100) (2/3)

main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ ewmh (myConf xmproc)

myConf xmproc = defaultConfig
        { borderWidth     = 3
        , terminal        = "gnome-terminal"
        , startupHook     = setWMName "LG3D"
        , manageHook      = namedScratchpadManageHook scratchpads <+> manageDocks <+> myManageHook <+> manageHook defaultConfig
        , handleEventHook = ewmhDesktopsEventHook
        , layoutHook      = smartBorders $ avoidStruts myLayout
        , logHook = do
            ewmhDesktopsLogHook
            setWMName "LG3D"
            takeTopFocus
            dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask   -- Rebind Mod to the Windows key
        } `additionalKeys`
        (-- whole-screen screenshot
         [ ((0, xK_Print ), spawn $ scrot "")
         -- one-windows or region screenshot (you have to choose the windows by
         -- mouse-clicking on it or region by dragging the mouse)
         , ((controlMask, xK_Print), spawn $ scrot "-s")
         -- XF86AudioPlay
         , ((0, 0x1008ff14), spawn "echo pause > $HOME/.mplayer/fifo")
         , ((0, 0x1008ff48), spawn "setxkbmap cz qwerty; control-reset; xmodmap ~/.xmodmap")
         , ((0, 0x1008ff49), spawn "setxkbmap us; control-reset; xmodmap ~/.xmodmap")
         ]
         ++
         [ ((modMask, key), windows (W.view [ws])) | (key,ws) <- zip czRow "123456789" ])
        `additionalKeysP`

        -- Ctrl-Alt-Shift-<key>
        [ casMap "b" "firefox -P martin"
        , casMap "c" runMC
        , casMap "d" "mydocssession-wmctrl"
        , casMap "n" "edit-now-wmctrl"
        , casMap "v" "gvim"
        , casMap "i" "rm -f /tmp/irssi-new-message"

        -- Alt-r <key>
        , ("M-d", spawn "mydocssession-wmctrl")
        , ("M-n", spawn "edit-now-wmctrl")
        , ("M-v", spawn "gvim")

        , ("M-S-w", windows copyToAll) -- stick and unstick the current window
        , ("M-r a", ns "alarm-clock-applet")
        , ("M-r c", spawn "gnome-calculator")
        , ("M-r e", runOrRaise "thunderbird" (className =? "Shredder"))
        , ("M-r k", runOrRaise "anki" (className =? "Anki"))
        , ("M-r m", ns "mydocssession")
        , ("M-r p", spawn "echo pause > $HOME/.mplayer/fifo")
        , ("M-r s", ns "stardict")
        , ("M-r t", ns "top")
        , ("M-r x", spawn "xmonad-restart")
        {-, ("M-S-w", killAllOtherCopies)-}
        {-, ("M-r t", do { ns "top"; ns "iotop" })-} -- iotop needs root access now

        -- Alt-Shift-<key>
        , ("M-S-b", withFocused toggleBorder)
        , ("M-S-f", withFocused (sendMessage . maximizeRestore)) -- full size
        , ("M-S-g", gotoMenu)
        , ("M-S-l", spawn "cinnamon-screensaver-command --lock")
        , ("M-S-r", spawnSelected defaultGSConfig spawners)
        , ("M-S-s", sendMessage ToggleStruts)
        , ("M-S-t", doCenteredFloat)

        -- Others
        , ("C-M-<Return>", ns "rxvt-quick")
        , ("C-M-<Space>", sendMessage (JumpToLayout "Maximize Full"))
        -- Keyboard stuff
        , ("<F12>", spawn "setxkbmap us; control-reset; xmodmap ~/.xmodmap")
        , ("S-<F12>", spawn "setxkbmap cz qwerty; control-reset; xmodmap ~/.xmodmap")
        , ("C-S-<F11>", spawn "control-reset")

        ]
    where
      modMask = mod4Mask   -- Rebind Mod to the Windows key
      czRow = [ xK_plus
              , xK_ecaron
              , xK_scaron
              , xK_ccaron
              , xK_rcaron
              , xK_zcaron
              , xK_yacute
              , xK_aacute
              , xK_iacute
              ]
      runMC = "gnome-terminal -e mc"
      scrot opts = "sleep 0.2; scrot ~/tmp/screenshot.png " ++ opts -- ++ " && ~/bin/open-image ~/tmp/screenshot.png"
      spawners =
        [ "gnome-panel", "caja"
        , "gksu synaptic"
        , "mintupdate", "cinnamon-control-center"
        , "mypaint-mk"
        ]
      ns = namedScratchpadAction scratchpads

-- | Makes focused windows floated, centered and vertically maximized.
doCenteredFloat :: X ()
doCenteredFloat = withFocused ((windows . appEndo <=<) . runQuery $ manHook)
  where manHook  = isFloat >>= \b -> if b then unfloatW else floatW
        floatW   = doRectFloat $ W.RationalRect (1/5) (2/100) (3/5) (97/100)
        unfloatW = ask   >>= \w -> liftX (reveal w) >> doF (W.sink w)

-- | Is the focused window a floating window?
isFloat :: Query Bool
isFloat = ask >>= (\w -> liftX $ withWindowSet (return . M.member w . W.floating))

