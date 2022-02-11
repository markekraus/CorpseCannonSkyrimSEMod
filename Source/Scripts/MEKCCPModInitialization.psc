Scriptname MEKCCPModInitialization extends ReferenceAlias  

GlobalVariable Property MEKCCPCorpseFireDelay  Auto
float Property Version = 1.0  Auto

string UpdateText = "Corpse Cannon Updated to "

Event OnInit()
    RegisterForSingleUpdate(1.0)
EndEvent

Event OnPlayerLoadGame()
    RegisterForSingleUpdate(1.0)
EndEvent

Event OnUpdate()
    If (Version < 1.1)
        Version = 1.1
        MEKCCPCorpseFireDelay.SetValue(0.01)
        Debug.Notification(UpdateText + "1.1")
    EndIf
EndEvent