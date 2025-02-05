#Requires AutoHotkey v2.0
#SingleInstance Force
#WinActivateForce

global otherKeyPress := false

; LWin::!Space

print(Text) {
    FileAppend(Text, "*")
}

LWin:: {
    global otherKeyPress
    otherKeyPress := false
    Send("{LWin Down}")
}

LWin Up:: {
    Send("{LWin Up}")
    if (otherKeyPress) {
        return
    }
    killStartMenu()
    Send("!{Space}")
}

killStartMenu() {
    if (!ProcessExist("StartMenuExperienceHost.exe")) {
        return
    }
    ProcessClose("StartMenuExperienceHost.exe")
    ProcessWaitClose("StartMenuExperienceHost.exe")
}

focusPowertoysRun() {
    if (!WinExist("PowerToys.PowerLauncher")) {
        return
    }
    print("focus")
    WinActivate("PowerToys.PowerLauncher")
    if (!WinExist("a")) {
        return
    }
    print(
        WinGetTitle("A")
    )
}

SetTimer(killStartMenu, 1)
SetTimer(focusPowertoysRun, 1)


hook := InputHook()
hook.KeyOpt("{All}", "NV")
hook.OnKeyDown := onKeyDown
hook.OnKeyUp := onKeyUp
hook.BackspaceIsUndo := false
hook.Start()

onKeyDown(hook, keyCode, scanCode) {
    keyName := GetKeyName(Format("vk{:x}sc{:x}", keyCode, scanCode))
    if (keyName != "LWin") {
        global otherKeyPress := true
    }
    return
}

onKeyUp(hook, keyCode, scanCode) {
    keyName := GetKeyName(Format("vk{:x}sc{:x}", keyCode, scanCode))
    return
}