Scriptname MEKCCPMenuConfig extends SKI_ConfigBase

GlobalVariable Property MEKCCPMaxSummonedCorpseSetting Auto
GlobalVariable Property MEKCCPCorpseCannonForce Auto
GlobalVariable Property MEKCCPCorpseFireDelay Auto
GlobalVariable Property MEKCCPCorpseKillDelay Auto

int maxCorpsesMenuOID
int corpseCannonForceMenuOID
int corpseFireDelayMenuOID
int corpseKillDelayMenuOID
string[] maxCorpsesOptions
int curMaxCorpsesOption = 5
float corpseCannonForce = 50.0
float corpseFireDelay = 0.1
float corpseKillDelay = 0.1

int function GetVersion()
    return 1
endFunction

event OnConfigInit()
    {Called when this config menu is initialized}

    int globalSetting = MEKCCPMaxSummonedCorpseSetting.GetValue() as int
    If (globalSetting > 5)
        globalSetting = 5
    EndIf
    If (globalSetting < 0)
        globalSetting = 0
    EndIf
    curMaxCorpsesOption = globalSetting

    corpseCannonForce = MEKCCPCorpseCannonForce.GetValue()
    corpseFireDelay = MEKCCPCorpseFireDelay.GetValue()
    corpseKillDelay = MEKCCPCorpseKillDelay.GetValue()

    maxCorpsesOptions = new String[6]
    maxCorpsesOptions[0] = "1"
    maxCorpsesOptions[1] = "5"
    maxCorpsesOptions[2] = "10"
    maxCorpsesOptions[3] = "15"
    maxCorpsesOptions[4] = "20"
    maxCorpsesOptions[5] = "25"
endEvent

event OnPageReset(string a_page)
    {Called when a new page is selected, including the initial empty page}

    If (a_page == "")
        SetCursorFillMode(TOP_TO_BOTTOM)
        maxCorpsesMenuOID = AddMenuOption("Max Corpse Ammo", maxCorpsesOptions[curMaxCorpsesOption])
        AddHeaderOption("Warning: Setting too high may crash game")
        corpseCannonForceMenuOID = AddSliderOption("Cannon Force", corpseCannonForce, "{0}")
        AddHeaderOption("Warning: Setting too low may crash game")
        corpseFireDelayMenuOID = AddSliderOption("Corpse Fire Delay", corpseFireDelay, "{2} seconds")
        corpseKillDelayMenuOID = AddSliderOption("Corpse Kill Delay", corpseKillDelay, "{2} seconds")
    EndIf
endEvent

event OnOptionHighlight(int a_option)
    {Called when highlighting an option}

    if (a_option == maxCorpsesMenuOID)
        SetInfoText("Sets the maximum corpses that will be fired and changes the scaling with the Conjuration skill.")
    EndIf
    If (a_option == corpseCannonForceMenuOID)
        SetInfoText("Sets the amount of force applied to corpses as the exit the cannon.")
    EndIf
    If (a_option == corpseFireDelayMenuOID)
        SetInfoText("Sets the delay in seconds between a corpse being spawned and when it is fired from the cannon. Increase if you experience CTDs")
    EndIf
    If (a_option == corpseKillDelayMenuOID)
        SetInfoText("Sets the delay in seconds between an NPC fired from the cannon when it is actually killed. Increase if you experience CTDs")
    EndIf
endEvent

event OnOptionMenuOpen(int a_option)
    {Called when a menu option has been selected}

    if (a_option == maxCorpsesMenuOID)
        SetMenuDialogStartIndex(curMaxCorpsesOption)
        SetMenuDialogDefaultIndex(5)
        SetMenuDialogOptions(maxCorpsesOptions)
    endIf
endEvent

event OnOptionMenuAccept(int a_option, int a_index)
    {Called when a menu entry has been accepted}

    if (a_option == maxCorpsesMenuOID)
        curMaxCorpsesOption = a_index
        MEKCCPMaxSummonedCorpseSetting.SetValue(a_index)
        SetMenuOptionValue(a_option, maxCorpsesOptions[curMaxCorpsesOption])
    EndIf
endEvent

event OnOptionSliderOpen(int a_option)
    {Called when a slider option has been selected}
    If (a_option == corpseCannonForceMenuOID)
        SetSliderDialogDefaultValue(50.0)
        SetSliderDialogInterval(1.0)
        SetSliderDialogRange(0.0,1000.0)
        SetSliderDialogStartValue(corpseCannonForce)
    EndIf
    If (a_option == corpseFireDelayMenuOID)
        SetSliderDialogDefaultValue(0.1)
        SetSliderDialogInterval(0.01)
        SetSliderDialogRange(0.0,10.0)
        SetSliderDialogStartValue(corpseFireDelay)
    EndIf
    If (a_option == corpseKillDelayMenuOID)
        SetSliderDialogDefaultValue(0.1)
        SetSliderDialogInterval(0.01)
        SetSliderDialogRange(0.0,10.0)
        SetSliderDialogStartValue(corpseKillDelay)
    EndIf
endEvent

event OnOptionSliderAccept(int a_option, float a_value)
    {Called when a new slider value has been accepted}
    If (a_option == corpseCannonForceMenuOID)
        corpseCannonForce = a_value
        MEKCCPCorpseCannonForce.SetValue(a_value)
        SetSliderOptionValue(a_option, a_value, "{0}")
    EndIf
    If (a_option == corpseFireDelayMenuOID)
        corpseFireDelay = a_value
        MEKCCPCorpseFireDelay.SetValue(a_value)
        SetSliderOptionValue(a_option, a_value, "{2} seconds")
    EndIf
    If (a_option == corpseKillDelayMenuOID)
        corpseKillDelay = a_value
        MEKCCPCorpseKillDelay.SetValue(a_value)
        SetSliderOptionValue(a_option, a_value, "{2} seconds")
    EndIf
endEvent

; Not Implimented:

event OnVersionUpdate(int a_version)
    {Called when a version update of this script has been detected}
endEvent

event OnOptionSelect(int a_option)
    {Called when a non-interactive option has been selected}
endEvent

event OnOptionDefault(int a_option)
    {Called when resetting an option to its default value}
endEvent

event OnOptionColorOpen(int a_option)
    {Called when a color option has been selected}
endEvent

event OnOptionColorAccept(int a_option, int a_color)
    {Called when a new color has been accepted}
endEvent

event OnOptionKeyMapChange(int a_option, int a_keyCode, string a_conflictControl, string a_conflictName)
    {Called when a key has been remapped}
endEvent

event OnOptionInputOpen(int a_option)
    {Called when a text input option has been selected}
endEvent

event OnOptionInputAccept(int a_option, string a_input)
    {Called when a new text input has been accepted}
endEvent
