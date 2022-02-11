Scriptname MEKCCPCorpseCannonScript extends ObjectReference  

ActorBase Property MEKCCPSummonedCorpse Auto
ActorBase Property MEKCCPNazeem Auto
Static Property MEKCCPNordicCoffinStatic04Rotate Auto
EffectShader Property DA02ArmorShadow Auto
GlobalVariable Property MEKCCPMaxSummonedCorpseSetting Auto
GlobalVariable Property MEKCCPCorpseCannonForce Auto
GlobalVariable Property MEKCCPCorpseFireDelay Auto
GlobalVariable Property MEKCCPAmmoType Auto
Static Property XMarkerHeading Auto

float coffinOffset = 155.0
float coffinDespawnDelay = 1.0
float markerSpawnDistance = -300.0
float corpseSpawnDistance = 15.0

Event OnLoad()
    SummonCorpses(GetCorpseCount(), MEKCCPCorpseCannonForce.GetValue(), MEKCCPCorpseFireDelay.GetValue())
    RegisterForSingleUpdate(5.0)
EndEvent

Event OnUpdate()
    Disable()
    Delete()
endEvent

Event OnUnload()
EndEvent

Function SummonCorpses(int corpseCount, float cannonForce = 50.0, float corpseFireDelay = 0.01)
    float playerAngleZ = Game.GetPlayer().GetAngleZ()
    float pushX = Math.sin(playerAngleZ)
    float pushY = Math.cos(playerAngleZ)
    float markerOffsetX = markerSpawnDistance * pushX
    float markerOffsetY = markerSpawnDistance * pushY
    float corpseOffsetX = corpseSpawnDistance * pushX
    float corpseOffsetY = corpseSpawnDistance * pushY

    Debug.Trace("MEKCCP markerOffsetX " + markerOffsetX)
    Debug.Trace("MEKCCP markerOffsetY " + markerOffsetY)
    Debug.Trace("MEKCCP corpseOffsetX " + corpseOffsetX)
    Debug.Trace("MEKCCP corpseOffsetY " + corpseOffsetY)
    Debug.Trace("MEKCCP cannonForce " + cannonForce)
    Debug.Trace("MEKCCP corpseFireDelay " + corpseFireDelay)

    ObjectReference markerRef = self.PlaceAtMe(XMarkerHeading)
    markerRef.MoveTo(self, markerOffsetX, markerOffsetY, 1.0)
    markerRef.SetAngle(0.0, 0.0, playerAngleZ)

    ObjectReference coffinRef = self.PlaceAtMe(MEKCCPNordicCoffinStatic04Rotate)
    coffinRef.SetAngle(0.0, 0.0, playerAngleZ)

    Utility.Wait(coffinDespawnDelay)
    ;DA02ArmorShadow.Play(coffinRef, 1)

    ActorBase ammoType = GetAmmoType()
    ObjectReference currentCorpseRef = none
    int index = 0
    While (index < corpseCount)
        currentCorpseRef = self.PlaceAtMe(ammoType)
        currentCorpseRef.MoveTo(self, corpseOffsetX, corpseOffsetY, 1.0)
        currentCorpseRef.SetAngle(0.0, 0.0, playerAngleZ)
        While (!currentCorpseRef.Is3DLoaded())
            ;Utility.Wait(0.00)
        EndWhile
        Actor currentCorpseActor = currentCorpseRef as Actor
        markerRef.PushActorAway(currentCorpseActor, cannonForce)
        currentCorpseActor.KillSilent()
        Utility.Wait(corpseFireDelay)
        index += 1
    EndWhile
    DA02ArmorShadow.Play(coffinRef, 1)
    Utility.Wait(coffinDespawnDelay)
    DA02ArmorShadow.Stop(coffinRef)
    markerRef.Disable()
    markerRef.Delete()
    coffinRef.Disable()
    coffinRef.Delete()
EndFunction

int Function GetCorpseCount()
    int [] distribution = GetDistribution()

    float playerConjurationLevel = Game.GetPlayer().GetActorValue("Conjuration")

    If (playerConjurationLevel < 20)
        return distribution[0]
    EndIf
    If (playerConjurationLevel < 30)
        return distribution[1]
    EndIf
    If (playerConjurationLevel < 40)
        return distribution[2]
    EndIf
    If (playerConjurationLevel < 50)
        return distribution[3]
    EndIf
    If (playerConjurationLevel < 60)
        return distribution[4]
    EndIf
    return distribution[5]
EndFunction

int[] Function GetDistribution()
    int maxCorpsesSetting = MEKCCPMaxSummonedCorpseSetting.GetValue() as int
    If (maxCorpsesSetting > 5)
        maxCorpsesSetting = 5
    EndIf
    If (maxCorpsesSetting < 0)
        maxCorpsesSetting = 0
    EndIf

    int[] distribution = new int[6]
    If (maxCorpsesSetting == 0)
        distribution[0] = 1
        distribution[1] = 1
        distribution[2] = 1
        distribution[3] = 1
        distribution[4] = 1
        distribution[5] = 1
        return distribution
    EndIf
    If (maxCorpsesSetting == 1)
        distribution[0] = 1
        distribution[1] = 1
        distribution[2] = 2
        distribution[3] = 3
        distribution[4] = 4
        distribution[5] = 5
        return distribution
    EndIf
    If (maxCorpsesSetting == 2)
        distribution[0] = 1
        distribution[1] = 2
        distribution[2] = 4
        distribution[3] = 6
        distribution[4] = 8
        distribution[5] = 10
        return distribution
    EndIf
    If (maxCorpsesSetting == 3)
        distribution[0] = 1
        distribution[1] = 3
        distribution[2] = 5
        distribution[3] = 7
        distribution[4] = 10
        distribution[5] = 15
        return distribution
    EndIf
    If (maxCorpsesSetting == 4)
        distribution[0] = 1
        distribution[1] = 5
        distribution[2] = 8
        distribution[3] = 10
        distribution[4] = 15
        distribution[5] = 20
        return distribution
    EndIf
    If (maxCorpsesSetting == 5)
        distribution[0] = 1
        distribution[1] = 5
        distribution[2] = 10
        distribution[3] = 15
        distribution[4] = 10
        distribution[5] = 25
        return distribution
    EndIf
EndFunction

ActorBase Function GetAmmoType()
    int ammoType = MEKCCPAmmoType.GetValue() as int
    If (ammoType == 1)
        return MEKCCPNazeem
    EndIf
    return MEKCCPSummonedCorpse
EndFunction