## Description

- Suspends or resumes `SkyrimSE.exe` with `\`.
- Has a 1-second lockout for safety's sake.
- Shows a tooltip on pause/resume to make the lockout clear.

> [!IMPORTANT]
> This script has no config options and no GUI, but you can <a href="#how-to-edit-the-script-to-work-for-you">edit it to work for you</a>.

<br>

## Requirements
1. [PsSuspend](https://learn.microsoft.com/en-us/sysinternals/downloads/pssuspend)
2. [AutoHotkey 1.1](https://www.autohotkey.com/download/ahk-install.exe)

<br>

## Setup

1. If you've never run `pssuspend.exe` before, there's a license agreement. Run `pssuspend.exe` and agree.
2. Download `skyrimse.ahk` from this repo and put it wherever you want to keep it.
3. Edit the script to work for you. See ["How to edit the script to work for you"](#how-to-edit-the-script-to-work-for-you) below.
4. Run the script to enable the hotkey. As long as `SkyrimSE.exe` is running, tap `\` to suspend the process, and tap `\` again to resume it.

> [!NOTE]
> The hotkey will remain active [until you stop the script](https://www.autohotkey.com/docs/v1/Program.htm#tray-icon). If you shut down your computer, you'll need to run the script again when you boot up. If you want it to start automatically, add a shortcut to the script to your Startup folder (probably `%appdata%\Microsoft\Windows\Start Menu\Programs\Startup`).

<br>

## How to edit the script to work for you

### Update the `pssuspend.exe` path

> [!WARNING]
> The script won't do anything if your `pssuspend.exe` path is wrong.

Replace `D:\PSTools\pssuspend.exe` with your own path to `pssuspend.exe`:
  - [on line 18](/skyrimse.ahk#L18)
  - [on line 25](/skyrimse.ahk#L25)

### If you want to target an exe other than `SkyrimSE.exe`

Replace the following:
  - [SkyrimSE.exe on line 8](/skyrimse.ahk#L8)
  - [SkyrimSE on line 18](/skyrimse.ahk#L18)
  - [SkyrimSE on line 25](/skyrimse.ahk#L25)

### If you want to use a hotkey other than `\`

Replace [the \ on line 10](/skyrimse.ahk#L10).

If you're not sure what to replace it with, [see the AutoHotkey v1 "Hotkeys" documentation](https://www.autohotkey.com/docs/v1/Hotkeys.htm).

### If you don't want `\` to work while you're tabbed out

As written, `\` will still suspend `SkyrimSE.exe` *even while you're tabbed out*.

If you want `\` to only work when `SkyrimSE` is *active*, replace `IfWinExist` with `IfWinActive`:
  - [on line 8](/skyrimse.ahk#L8)
  - [on line 41](/skyrimse.ahk#L41)
    
### If you don't want the tooltip

[Comment out](https://www.autohotkey.com/docs/v1/Language.htm#comments) or remove the following:
  - [line 17](/skyrimse.ahk#L17)
  - [line 24](/skyrimse.ahk#L24)
  - [lines 31 through 33](/skyrimse.ahk#L31-L33)
  - [line 36](/skyrimse.ahk#L36)
  - [line 38](/skyrimse.ahk#L38)

### If you want to change the 1-second lockout

Replace `1000` with the lockout time you prefer, in milliseconds:
  - [on line 26](/skyrimse.ahk#L26), to change the lockout when `\` suspends the process
  - [on line 19](/skyrimse.ahk#L19), to change the lockout when `\` resumes the process

<br>

## Troubleshooting

### If the script doesn't work

1. Verify that your `pssuspend.exe` paths in the script are correct.
2. If you're using a relative path for `pssuspend.exe`, try an absolute path instead.
3. Try running `pssuspend.exe` from the command line *with the exact same path you're using in the script*, and make sure it works.
   - If it's "not recognized," return to step 1.
   - If you get a prompt for the license agreement, agree to it, then [restart your script and try the hotkey again](#if-you-need-to-restart-the-script).
4. Confirm that the name of your exe is correct. The name in the script must match whatever program you're trying to suspend.
5. Make sure there's only **one** instance of whatever program you're trying to suspend.
   - If you have more than one and *can* close the others, close them, then [restart your script and try the hotkey again](#if-you-need-to-restart-the-script).
   - If you have more than one and *cannot* close the others, you're in a situation this script was not designed to handle. If you still want to go down this road, here's a few notes to get you started:
     - To target the [currently active instance](https://www.autohotkey.com/docs/v1/misc/WinTitle.htm#ActiveWindow), you'll need [its process id](https://www.autohotkey.com/docs/v1/lib/WinGet.htm).
     - Strip out everything to do with `S_IsStopped` from the script; it's only safe to use in my case because `pssuspend.exe` always acts on the same process. When there are multiple processes, you'll need [a more reliable way to determine whether the active window is currently suspended](https://www.autohotkey.com/board/topic/113862-solved-check-if-process-is-suspended/).
     - Edit your `pssuspend.exe` calls to use the process id instead of exe name.
6. 🤷‍♀️

### If you need to restart the script

Run it again. You may see a dialog box asking whether you want to replace the script currently running with the new instance; click "Yes."

<br>

## Why do this at all?

We replaced my brother's loading screen text with hilarious alternatives, but his game loads too quick to read them. The ideal would've been some kind of "press any key to continue" loading screen mod, but I couldn't find one (and I doubt many people care about that sort of thing in the first place). Some posts suggested `fPostLoadUpdateTimeMS`, but it didn't work for us.

Went with the AHK + PsSuspend combo because it was quick to set up and I'd used it before (for GTA Online, back in the dark ages before private sessions existed).
