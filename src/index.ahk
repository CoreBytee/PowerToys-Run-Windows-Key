#Requires AutoHotkey v2.0
#SingleInstance Force

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
    Send("!{Space}")
}

killStartMenu() {
    ProcessClose("StartMenuExperienceHost.exe")
}

SetTimer(killStartMenu, 1)


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