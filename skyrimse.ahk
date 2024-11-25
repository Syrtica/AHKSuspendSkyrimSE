#NoEnv
#Warn
#Persistent

S_IsStopped := false
S_IsDisabled := false

#IfWinExist ahk_exe SkyrimSE.exe

\::

if( S_IsDisabled == true )
  return

if( S_IsStopped ) {
  S_IsStopped := false
  ToolTip, Resuming, 50, 50, 1
  Run, "D:\PSTools\pssuspend.exe" "SkyrimSE" "-r", , Hide
  SetTimer, S_Unblock, -1000
}

else {
  S_IsStopped := true
  ToolTip, Pausing, 50, 50, 1
  Run, "D:\PSTools\pssuspend.exe" "SkyrimSE", , Hide
  SetTimer, S_Unblock, -1000
}

return

S_RemoveToolTip:
ToolTip
return

S_Unblock:
ToolTip, Paused, 50, 50, 1
S_IsDisabled := false
SetTimer, S_RemoveToolTip, -1000
return

#IfWinExist