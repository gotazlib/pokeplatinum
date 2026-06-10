#include "macros/scrcmd.inc"
#include "res/text/bank/victory_road_1f.h"


    ScriptEntry VictoryRoad_OnTransition
    ScriptEntry VictoryRoad_Collector
    ScriptEntry Legend_Kyogre
    ScriptEntry Legend_Groudon
    ScriptEntry Legend_Rayquaza
    ScriptEntry Legend_Manaphy
    ScriptEntryEnd

VictoryRoad_OnTransition:
    SetFlag FLAG_FIRST_ARRIVAL_VICTORY_ROAD
    GoToIfUnset FLAG_GAME_COMPLETED, VictoryRoad_DontHideCollector
    GetNationalDexEnabled VAR_MAP_LOCAL_0
    GoToIfEq VAR_MAP_LOCAL_0, FALSE, VictoryRoad_DontHideCollector
    SetFlag FLAG_HIDE_VICTORY_ROAD_1F_COLLECTOR
VictoryRoad_DontHideCollector:
    End

VictoryRoad_Collector:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    GoToIfSet FLAG_GAME_COMPLETED, VictoryRoad1F_YoullMeetManyPokemon
    Message VictoryRoad1F_Text_AimForPokemonLeague
    GoTo VictoryRoad1F_CollectorEnd
    End

VictoryRoad1F_YoullMeetManyPokemon:
    Message VictoryRoad1F_Text_YoullMeetManyPokemon
    GoTo VictoryRoad1F_CollectorEnd
    End

VictoryRoad1F_CollectorEnd:
    WaitButton
    CloseMessage
    ReleaseAll
    End

    .balign 4, 0

// ROM hack: static legendary spawn (SPECIES_KYOGRE), re-battleable mysterious Poké Ball.
Legend_Kyogre:
    LockAll
    FacePlayer
    PlayCry SPECIES_KYOGRE
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_KYOGRE, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

// ROM hack: static legendary spawn (SPECIES_GROUDON), re-battleable mysterious Poké Ball.
Legend_Groudon:
    LockAll
    FacePlayer
    PlayCry SPECIES_GROUDON
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_GROUDON, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

// ROM hack: static legendary spawn (SPECIES_RAYQUAZA), re-battleable mysterious Poké Ball.
Legend_Rayquaza:
    LockAll
    FacePlayer
    PlayCry SPECIES_RAYQUAZA
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_RAYQUAZA, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

// ROM hack: static legendary spawn (SPECIES_MANAPHY), re-battleable mysterious Poké Ball.
Legend_Manaphy:
    LockAll
    FacePlayer
    PlayCry SPECIES_MANAPHY
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_MANAPHY, 50
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

    .balign 4, 0
