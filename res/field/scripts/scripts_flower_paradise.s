#include "macros/scrcmd.inc"
#include "generated/distribution_events.h"
#include "res/text/bank/flower_paradise.h"
#include "res/field/events/events_flower_paradise.h"


    ScriptEntry FlowerParadise_OnTransition
    ScriptEntry FlowerParadise_OnLoad
    ScriptEntry FlowerParadise_Shaymin
    ScriptEntry Legend_Celebi
    ScriptEntry Legend_Latias
    ScriptEntryEnd

FlowerParadise_OnTransition:
    SetFlag FLAG_FIRST_ARRIVAL_FLOWER_PARADISE
    GetNationalDexEnabled VAR_MAP_LOCAL_0
    GoToIfEq VAR_MAP_LOCAL_0, FALSE, FlowerParadise_HideShaymin
    CheckItem ITEM_OAKS_LETTER, 1, VAR_MAP_LOCAL_0
    GoToIfEq VAR_MAP_LOCAL_0, FALSE, FlowerParadise_HideShaymin
    CheckDistributionEvent DISTRIBUTION_EVENT_SHAYMIN, VAR_MAP_LOCAL_0
    GoToIfEq VAR_MAP_LOCAL_0, FALSE, FlowerParadise_HideShaymin
    GoToIfSet FLAG_CAUGHT_SHAYMIN, FlowerParadise_HideShaymin
    ClearFlag FLAG_HIDE_FLOWER_PARADISE_SHAYMIN
    End

FlowerParadise_HideShaymin:
    SetFlag FLAG_HIDE_FLOWER_PARADISE_SHAYMIN
    End

FlowerParadise_OnLoad:
    GoToIfSet FLAG_MAP_LOCAL, FlowerParadise_RemoveShaymin
    End

FlowerParadise_RemoveShaymin:
    SetFlag FLAG_HIDE_FLOWER_PARADISE_SHAYMIN
    RemoveObject LOCALID_SHAYMIN
    ClearFlag FLAG_MAP_LOCAL
    End

FlowerParadise_Shaymin:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    PlayCry SPECIES_SHAYMIN
    Message FlowerParadise_Text_KyuuUuhn
    CloseMessage
    SetFlag FLAG_MAP_LOCAL
    StartFatefulEncounter SPECIES_SHAYMIN, 30
    ClearFlag FLAG_MAP_LOCAL
    CheckWonBattle VAR_RESULT
    GoToIfEq VAR_RESULT, FALSE, FlowerParadise_BlackOut
    CheckDidNotCapture VAR_RESULT
    GoToIfEq VAR_RESULT, TRUE, FlowerParadise_ShayminDisappearedAmongTheFlowers
    SetFlag FLAG_CAUGHT_SHAYMIN
    ReleaseAll
    End

FlowerParadise_ShayminDisappearedAmongTheFlowers:
    Message FlowerParadise_Text_ShayminDisappearedAmongTheFlowers
    WaitButton
    CloseMessage
    ClearFlag FLAG_HIDE_FLOWER_PARADISE_SHAYMIN
    ReleaseAll
    End

FlowerParadise_BlackOut:
    BlackOutFromBattle
    ClearFlag FLAG_HIDE_FLOWER_PARADISE_SHAYMIN
    ReleaseAll
    End

    .balign 4, 0

// ROM hack: static legendary spawn (SPECIES_CELEBI). Gated behind beating the League
// (FLAG_DEFEATED_CYNTHIA); re-battleable mysterious Poké Ball.
Legend_Celebi:
    GoToIfUnset FLAG_DEFEATED_CYNTHIA, Legend_Celebi_Locked
    LockAll
    FacePlayer
    PlayCry SPECIES_CELEBI
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_CELEBI, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

Legend_Celebi_Locked:
    End

// ROM hack: static legendary spawn (SPECIES_LATIAS). Gated behind beating the League
// (FLAG_DEFEATED_CYNTHIA); re-battleable mysterious Poké Ball.
Legend_Latias:
    GoToIfUnset FLAG_DEFEATED_CYNTHIA, Legend_Latias_Locked
    LockAll
    FacePlayer
    PlayCry SPECIES_LATIAS
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_LATIAS, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

Legend_Latias_Locked:
    End

    .balign 4, 0
