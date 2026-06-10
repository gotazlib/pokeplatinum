#include "macros/scrcmd.inc"
#include "res/text/bank/stark_mountain_room_1.h"
#include "res/field/events/events_stark_mountain_room_1.h"


    ScriptEntry StarkMountainOutside_OnTransition
    ScriptEntry StarkMountainOutside_OnFrameTeamGalactic
    ScriptEntry StarkMountainRoom1_Mewtwo
    ScriptEntry Legend_Mew
    ScriptEntry Legend_Lugia
    ScriptEntry Legend_HoOh
    ScriptEntry Legend_Celebi
    ScriptEntry Legend_Jirachi
    ScriptEntry Legend_Latias
    ScriptEntry Legend_Latios
    ScriptEntry Legend_Deoxys
    ScriptEntryEnd

StarkMountainOutside_OnTransition:
    SetFlag FLAG_FIRST_ARRIVAL_STARK_MOUNTAIN_INTERIOR
    SetFlag FLAG_HIDE_ROUTE_227_BUCK
    End

// ROM hack: a "mysterious Poké Ball" that triggers a static legendary battle.
// Re-battleable by design (no caught flag), so the player can retry.
StarkMountainRoom1_Mewtwo:
    LockAll
    FacePlayer
    PlayCry SPECIES_MEWTWO
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_MEWTWO, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

StarkMountainOutside_OnFrameTeamGalactic:
    LockAll
    ApplyMovement LOCALID_MARS, StarkMountainRoom1_Movement_MarsWalkOnSpotSouth
    WaitMovement
    Message StarkMountainRoom1_Text_IllMakeYouTalk
    CloseMessage
    ApplyMovement LOCALID_MARS, StarkMountainRoom1_Movement_MarsWalkSouth
    WaitMovement
    StartTrainerBattle TRAINER_COMMANDER_MARS_STARK_MOUNTAIN
    CheckWonBattle VAR_RESULT
    GoToIfEq VAR_RESULT, FALSE, StarkMountainRoom1_LostBattle
    Message StarkMountainRoom1_Text_PokemonLetMeDown
    CloseMessage
    ApplyMovement LOCALID_MARS, StarkMountainRoom1_Movement_MarsWalkBack
    WaitMovement
    ApplyMovement LOCALID_JUPITER, StarkMountainRoom1_Movement_JupiterWalkOnSpotWestSouth
    WaitMovement
    Message StarkMountainRoom1_Text_IllGoUpNext
    CloseMessage
    ApplyMovement LOCALID_JUPITER, StarkMountainRoom1_Movement_JupiterWalkSouth
    WaitMovement
    StartTrainerBattle TRAINER_COMMANDER_JUPITER_STARK_MOUNTAIN
    CheckWonBattle VAR_RESULT
    GoToIfEq VAR_RESULT, FALSE, StarkMountainRoom1_LostBattle
    Message StarkMountainRoom1_Text_HowDareYou
    CloseMessage
    WaitTime 15, VAR_RESULT
    ApplyMovement LOCALID_MARS, StarkMountainRoom1_Movement_MarsExclamationMark
    ApplyMovement LOCALID_JUPITER, StarkMountainRoom1_Movement_JupiterFaceMars
    WaitMovement
    Message StarkMountainRoom1_Text_ThatsItForMe
    ApplyMovement LOCALID_JUPITER, StarkMountainRoom1_Movement_JupiterWalkOnSpotNorth
    WaitMovement
    Message StarkMountainRoom1_Text_ImQuittingToo
    CloseMessage
    ApplyMovement LOCALID_MARS, StarkMountainRoom1_Movement_MarsWalkOnSpotNorthSouth
    WaitMovement
    Message StarkMountainRoom1_Text_BackToOrdinaryGirls
    CloseMessage
    ApplyMovement LOCALID_MARS, StarkMountainRoom1_Movement_MarsLeave
    ApplyMovement LOCALID_PLAYER, StarkMountainRoom1_Movement_PlayerMoveAside
    WaitMovement
    PlaySE SEQ_SE_DP_KAIDAN2
    WaitSE SEQ_SE_DP_KAIDAN2
    ApplyMovement LOCALID_JUPITER, StarkMountainRoom1_Movement_JupiterWalkOnSpotEast
    WaitMovement
    Message StarkMountainRoom1_Text_NotOrdinaryGirl
    CloseMessage
    ApplyMovement LOCALID_JUPITER, StarkMountainRoom1_Movement_JupiterLeave
    WaitMovement
    PlaySE SEQ_SE_DP_KAIDAN2
    WaitSE SEQ_SE_DP_KAIDAN2
    ApplyMovement LOCALID_CHARON, StarkMountainRoom1_Movement_CharonWalkOnSpotSouth
    ApplyMovement LOCALID_PLAYER, StarkMountainRoom1_Movement_PlayerWalkOnSpotNorth
    WaitMovement
    Message StarkMountainRoom1_Text_ImpressionableAndImpetuous
    Message StarkMountainRoom1_Text_OffToCollectMagmaStone
    CloseMessage
    ApplyMovement LOCALID_CHARON, StarkMountainRoom1_Movement_CharonLeave
    ApplyMovement LOCALID_GRUNT_M_1, StarkMountainRoom1_Movement_GruntM1Leave
    ApplyMovement LOCALID_GRUNT_M_2, StarkMountainRoom1_Movement_GruntM2Leave
    WaitMovement
    RemoveObject LOCALID_CHARON
    RemoveObject LOCALID_MARS
    RemoveObject LOCALID_JUPITER
    RemoveObject LOCALID_GRUNT_M_1
    RemoveObject LOCALID_GRUNT_M_2
    SetVar VAR_STARK_MOUNTAIN_ROOM_1_STATE, 1
    ReleaseAll
    End

StarkMountainRoom1_LostBattle:
    BlackOutFromBattle
    ReleaseAll
    End

    .balign 4, 0
StarkMountainRoom1_Movement_MarsWalkOnSpotSouth:
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_MarsWalkSouth:
    WalkNormalSouth
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_MarsWalkBack:
    WalkNormalNorth
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_MarsExclamationMark:
    EmoteExclamationMark
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_MarsWalkOnSpotNorthSouth:
    WalkOnSpotNormalNorth
    Delay8 2
    WalkOnSpotNormalSouth
    Delay8 2
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_MarsLeave:
    WalkNormalSouth 2
    Delay8
    WalkNormalSouth
    SetInvisible
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_PlayerMoveAside:
    Delay8 2
    WalkNormalWest
    WalkOnSpotNormalEast
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_PlayerWalkOnSpotNorth:
    WalkOnSpotNormalNorth
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_JupiterWalkOnSpotWestSouth:
    WalkOnSpotNormalWest
    Delay8 2
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_JupiterWalkSouth:
    WalkNormalSouth
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_JupiterWalkOnSpotNorth:
    WalkOnSpotNormalNorth
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_JupiterWalkOnSpotEast:
    WalkOnSpotNormalEast
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_JupiterLeave:
    WalkNormalWest
    WalkNormalSouth 2
    SetInvisible
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_JupiterFaceMars:
    Delay8
    WalkOnSpotNormalNorth
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_CharonWalkOnSpotSouth:
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_CharonLeave:
    WalkNormalNorth 7
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_GruntM1Leave:
    WalkNormalEast
    WalkNormalNorth 7
    EndMovement

    .balign 4, 0
StarkMountainRoom1_Movement_GruntM2Leave:
    Delay8
    WalkNormalWest
    WalkNormalNorth 7
    EndMovement

// ROM hack: static legendary spawn (SPECIES_MEW), re-battleable mysterious Poké Ball.
Legend_Mew:
    LockAll
    FacePlayer
    PlayCry SPECIES_MEW
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_MEW, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

// ROM hack: static legendary spawn (SPECIES_LUGIA), re-battleable mysterious Poké Ball.
Legend_Lugia:
    LockAll
    FacePlayer
    PlayCry SPECIES_LUGIA
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_LUGIA, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

// ROM hack: static legendary spawn (SPECIES_HO_OH), re-battleable mysterious Poké Ball.
Legend_HoOh:
    LockAll
    FacePlayer
    PlayCry SPECIES_HO_OH
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_HO_OH, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

// ROM hack: static legendary spawn (SPECIES_CELEBI), re-battleable mysterious Poké Ball.
Legend_Celebi:
    LockAll
    FacePlayer
    PlayCry SPECIES_CELEBI
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_CELEBI, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

// ROM hack: static legendary spawn (SPECIES_JIRACHI), re-battleable mysterious Poké Ball.
Legend_Jirachi:
    LockAll
    FacePlayer
    PlayCry SPECIES_JIRACHI
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_JIRACHI, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

// ROM hack: static legendary spawn (SPECIES_LATIAS), re-battleable mysterious Poké Ball.
Legend_Latias:
    LockAll
    FacePlayer
    PlayCry SPECIES_LATIAS
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_LATIAS, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

// ROM hack: static legendary spawn (SPECIES_LATIOS), re-battleable mysterious Poké Ball.
Legend_Latios:
    LockAll
    FacePlayer
    PlayCry SPECIES_LATIOS
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_LATIOS, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

// ROM hack: static legendary spawn (SPECIES_DEOXYS), re-battleable mysterious Poké Ball.
Legend_Deoxys:
    LockAll
    FacePlayer
    PlayCry SPECIES_DEOXYS
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_DEOXYS, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

    .balign 4, 0
