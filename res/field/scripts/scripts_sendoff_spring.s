#include "macros/scrcmd.inc"
#include "res/text/bank/sendoff_spring.h"
#include "res/field/events/events_sendoff_spring.h"


    ScriptEntry SendoffSpring_OnFrameCynthia
    ScriptEntry SendoffSpring_Cynthia
    ScriptEntry SendoffSpring_OnTransition
    ScriptEntry Legend_Mewtwo
    ScriptEntry Legend_Mew
    ScriptEntry Legend_Jirachi
    ScriptEntry Legend_Deoxys
    ScriptEntryEnd

SendoffSpring_OnTransition:
    CallIfSet FLAG_CAUGHT_GIRATINA, SendoffSpring_ShowTurnbackCaveItem
    End

SendoffSpring_ShowTurnbackCaveItem:
    ClearFlag FLAG_HIDE_TURNBACK_CAVE_GIRATINA_ROOM_ITEM
    Return

SendoffSpring_OnFrameCynthia:
    LockAll
    SetPartyGiratinaForm GIRATINA_FORM_ALTERED
    ScrCmd_2B5 MAP_HEADER_UNKNOWN_266, 762, 714
    Message SendoffSpring_Text_ThisPlace
    CloseMessage
    ApplyMovement LOCALID_CYNTHIA, SendoffSpring_Movement_CynthiaLookAround
    WaitMovement
    ApplyMovement LOCALID_PLAYER, SendoffSpring_Movement_PlayerWalkOnSpotWest
    WaitMovement
    Message SendoffSpring_Text_ItsTheSendoffSpring
    CloseMessage
    ApplyMovement LOCALID_CYNTHIA, SendoffSpring_Movement_CynthiaWalkOnSpotEast
    WaitMovement
    BufferPlayerName 0
    Message SendoffSpring_Text_YouShouldVisitProfRowan
    WaitButton
    CloseMessage
    SetVar VAR_EXITED_DISTORTION_WORLD_STATE, 2
    SetVar VAR_SANDGEM_TOWN_LAB_STATE, 2
    SetFlag FLAG_HIDE_SPEAR_PILLAR_DISTORTED_TEAM_GALACTIC
    ClearFlag FLAG_SPEAR_PILLAR_IS_DISTORTED
    SetFlag FLAG_HIDE_MT_CORONET_GALACTIC_GRUNTS
    SetFlag FLAG_HIDE_MT_CORONET_1F_NORTH_ROOM_1_GRUNT_F
    SetFlag FLAG_HIDE_MT_CORONET_2F_LOOKER
    SetFlag FLAG_ALT_MUSIC_GALACTIC_HQ_1F
    ClearFlag FLAG_HIDE_GALACTIC_HQ_1F_SATURN
    SetFlag FLAG_GALACTIC_LEFT_LAKE_VALOR
    SetFlag FLAG_HIDE_MT_CORONET_1F_NORTH_ROOM_1_GRUNT_F
    ReleaseAll
    End

    .balign 4, 0
SendoffSpring_Movement_PlayerWalkOnSpotWest:
    WalkOnSpotNormalWest
    EndMovement

    .balign 4, 0
SendoffSpring_Movement_CynthiaLookAround:
    WalkOnSpotFastWest
    Delay8
    WalkOnSpotFastEast
    Delay8 2
    WalkOnSpotFastNorth
    EndMovement

    .balign 4, 0
SendoffSpring_Movement_CynthiaWalkOnSpotEast:
    WalkOnSpotNormalEast
    EndMovement

SendoffSpring_Cynthia:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    GoToIfGe VAR_EXITED_DISTORTION_WORLD_STATE, 3, SendoffSpring_IWishIBattledGiratina
    Message SendoffSpring_Text_GoTellProfRowan
    GoTo SendoffSpring_CynthiaEnd
    End

SendoffSpring_IWishIBattledGiratina:
    Message SendoffSpring_Text_IWishIBattledGiratina
    GoTo SendoffSpring_CynthiaEnd
    End

SendoffSpring_CynthiaEnd:
    WaitButton
    CloseMessage
    ReleaseAll
    End

    .balign 4, 0

// ROM hack: static legendary spawn (SPECIES_MEWTWO). Gated behind beating the League
// (FLAG_DEFEATED_CYNTHIA); re-battleable mysterious Poké Ball.
Legend_Mewtwo:
    GoToIfUnset FLAG_DEFEATED_CYNTHIA, Legend_Mewtwo_Locked
    LockAll
    FacePlayer
    PlayCry SPECIES_MEWTWO
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_MEWTWO, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

Legend_Mewtwo_Locked:
    End

// ROM hack: static legendary spawn (SPECIES_MEW). Gated behind beating the League
// (FLAG_DEFEATED_CYNTHIA); re-battleable mysterious Poké Ball.
Legend_Mew:
    GoToIfUnset FLAG_DEFEATED_CYNTHIA, Legend_Mew_Locked
    LockAll
    FacePlayer
    PlayCry SPECIES_MEW
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_MEW, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

Legend_Mew_Locked:
    End

// ROM hack: static legendary spawn (SPECIES_JIRACHI). Gated behind beating the League
// (FLAG_DEFEATED_CYNTHIA); re-battleable mysterious Poké Ball.
Legend_Jirachi:
    GoToIfUnset FLAG_DEFEATED_CYNTHIA, Legend_Jirachi_Locked
    LockAll
    FacePlayer
    PlayCry SPECIES_JIRACHI
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_JIRACHI, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

Legend_Jirachi_Locked:
    End

// ROM hack: static legendary spawn (SPECIES_DEOXYS). Gated behind beating the League
// (FLAG_DEFEATED_CYNTHIA); re-battleable mysterious Poké Ball.
Legend_Deoxys:
    GoToIfUnset FLAG_DEFEATED_CYNTHIA, Legend_Deoxys_Locked
    LockAll
    FacePlayer
    PlayCry SPECIES_DEOXYS
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_DEOXYS, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

Legend_Deoxys_Locked:
    End

    .balign 4, 0
