Scriptname MEKCCPMenuConfig extends SKI_ConfigBase

GlobalVariable Property MEKCCPMaxSummonedCorpseSetting Auto
GlobalVariable Property MEKCCPCorpseCannonForce Auto
GlobalVariable Property MEKCCPCorpseFireDelay Auto
GlobalVariable Property MEKCCPAmmoType Auto

int maxCorpsesMenuOID
int ammoTypeMenuOID
int corpseCannonForceMenuOID
int corpseFireDelayMenuOID
string[] maxCorpsesOptions
string[] ammoTypeOptions
int curMaxCorpsesOption = 5
int ammoType = 0

int function GetVersion()
    return 2
endFunction


event OnVersionUpdate(int a_version)
    {Called when a version update of this script has been detected}
    If (a_version > 1)
        OnConfigInit()
    EndIf
endEvent


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

    maxCorpsesOptions = new String[6]
    maxCorpsesOptions[0] = "1"
    maxCorpsesOptions[1] = "5"
    maxCorpsesOptions[2] = "10"
    maxCorpsesOptions[3] = "15"
    maxCorpsesOptions[4] = "20"
    maxCorpsesOptions[5] = "25"

    ammoType = MEKCCPAmmoType.GetValue() as int
    If (ammoType < 0 || ammoType > 1)
        ammoType = 0
    EndIf

    ammoTypeOptions = new String[2]
    ammoTypeOptions[0] = "Random NPC"
    ammoTypeOptions[1] = "Nazeem"
endEvent

event OnPageReset(string a_page)
    {Called when a new page is selected, including the initial empty page}

    If (a_page == "")
        SetCursorFillMode(TOP_TO_BOTTOM)
        maxCorpsesMenuOID = AddMenuOption("Max Corpse Ammo", maxCorpsesOptions[curMaxCorpsesOption])
        ammoTypeMenuOID = AddMenuOption("Coprse Ammo Type", ammoTypeOptions[ammoType])
        corpseCannonForceMenuOID = AddSliderOption("Cannon Force", MEKCCPCorpseCannonForce.GetValue(), "{0}")
        corpseFireDelayMenuOID = AddSliderOption("Corpse Fire Delay", MEKCCPCorpseFireDelay.GetValue(), "{2} seconds")
    EndIf
endEvent

event OnOptionHighlight(int a_option)
    {Called when highlighting an option}

    if (a_option == maxCorpsesMenuOID)
        SetInfoText("Sets the maximum corpses that will be fired and changes the scaling with the Conjuration skill.")
    EndIf
    if (a_option == maxCorpsesMenuOID)
        SetInfoText("Sets the corpses type that will be fired.")
    EndIf
    If (a_option == corpseCannonForceMenuOID)
        SetInfoText("Sets the amount of force applied to corpses as the exit the cannon.")
    EndIf
    If (a_option == corpseFireDelayMenuOID)
        SetInfoText("Sets the delay in seconds between a corpse being spawned and when it is fired from the cannon. Increase if you experience CTDs")
    EndIf
endEvent

event OnOptionMenuOpen(int a_option)
    {Called when a menu option has been selected}

    if (a_option == maxCorpsesMenuOID)
        SetMenuDialogStartIndex(curMaxCorpsesOption)
        SetMenuDialogDefaultIndex(5)
        SetMenuDialogOptions(maxCorpsesOptions)
    endIf
    if (a_option == ammoTypeMenuOID)
        SetMenuDialogStartIndex(ammoType)
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(ammoTypeOptions)
    endIf
endEvent

event OnOptionMenuAccept(int a_option, int a_index)
    {Called when a menu entry has been accepted}

    if (a_option == maxCorpsesMenuOID)
        curMaxCorpsesOption = a_index
        MEKCCPMaxSummonedCorpseSetting.SetValue(a_index)
        SetMenuOptionValue(a_option, maxCorpsesOptions[curMaxCorpsesOption])
    EndIf
    if (a_option == ammoTypeMenuOID)
        ammoType = a_index
        MEKCCPAmmoType.SetValue(ammoType)
        SetMenuOptionValue(a_option, ammoTypeOptions[ammoType])
    EndIf
endEvent

event OnOptionSliderOpen(int a_option)
    {Called when a slider option has been selected}
    If (a_option == corpseCannonForceMenuOID)
        SetSliderDialogDefaultValue(50.0)
        SetSliderDialogInterval(1.0)
        SetSliderDialogRange(0.0,1000.0)
        SetSliderDialogStartValue(MEKCCPCorpseCannonForce.GetValue())
    EndIf
    If (a_option == corpseFireDelayMenuOID)
        SetSliderDialogDefaultValue(0.1)
        SetSliderDialogInterval(0.01)
        SetSliderDialogRange(0.0,10.0)
        SetSliderDialogStartValue(MEKCCPCorpseFireDelay.GetValue())
    EndIf
endEvent

event OnOptionSliderAccept(int a_option, float a_value)
    {Called when a new slider value has been accepted}
    If (a_option == corpseCannonForceMenuOID)
        MEKCCPCorpseCannonForce.SetValue(a_value)
        SetSliderOptionValue(a_option, a_value, "{0}")
    EndIf
    If (a_option == corpseFireDelayMenuOID)
        MEKCCPCorpseFireDelay.SetValue(a_value)
        SetSliderOptionValue(a_option, a_value, "{2} seconds")
    EndIf
endEvent

; Not Implimented:

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
