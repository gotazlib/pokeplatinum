#include "macros/scrcmd.inc"
#include "res/text/bank/route_230.h"


    ScriptEntry Route230_ArrowSignpostFightArea
    ScriptEntry Route230_Fisherman
    ScriptEntry Route230_RichBoy
    ScriptEntry Legend_Kyogre
    ScriptEntry Legend_Lugia
    ScriptEntry Legend_Manaphy
    ScriptEntry Legend_Phione
    ScriptEntryEnd

Route230_ArrowSignpostFightArea:
    ShowArrowSign Route230_Text_SignRt230FightArea
    End

Route230_Fisherman:
    NPCMessage Route230_Text_VisitBattleFrontier
    End

Route230_RichBoy:
    NPCMessage Route230_Text_ChallengeOtherTrainers
    End

    .balign 4, 0

// ROM hack: static legendary spawn (SPECIES_KYOGRE). Gated behind beating the League
// (FLAG_DEFEATED_CYNTHIA); re-battleable mysterious Poké Ball.
Legend_Kyogre:
    GoToIfUnset FLAG_DEFEATED_CYNTHIA, Legend_Kyogre_Locked
    LockAll
    FacePlayer
    PlayCry SPECIES_KYOGRE
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_KYOGRE, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

Legend_Kyogre_Locked:
    End

// ROM hack: static legendary spawn (SPECIES_LUGIA). Gated behind beating the League
// (FLAG_DEFEATED_CYNTHIA); re-battleable mysterious Poké Ball.
Legend_Lugia:
    GoToIfUnset FLAG_DEFEATED_CYNTHIA, Legend_Lugia_Locked
    LockAll
    FacePlayer
    PlayCry SPECIES_LUGIA
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_LUGIA, 70
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

Legend_Lugia_Locked:
    End

// ROM hack: static legendary spawn (SPECIES_MANAPHY). Gated behind beating the League
// (FLAG_DEFEATED_CYNTHIA); re-battleable mysterious Poké Ball.
Legend_Manaphy:
    GoToIfUnset FLAG_DEFEATED_CYNTHIA, Legend_Manaphy_Locked
    LockAll
    FacePlayer
    PlayCry SPECIES_MANAPHY
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_MANAPHY, 50
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

Legend_Manaphy_Locked:
    End

// ROM hack: static legendary spawn (SPECIES_PHIONE). Gated behind beating the League
// (FLAG_DEFEATED_CYNTHIA); re-battleable mysterious Poké Ball.
Legend_Phione:
    GoToIfUnset FLAG_DEFEATED_CYNTHIA, Legend_Phione_Locked
    LockAll
    FacePlayer
    PlayCry SPECIES_PHIONE
    WaitCry
    SetFlag FLAG_MAP_LOCAL
    StartLegendaryBattle SPECIES_PHIONE, 50
    ClearFlag FLAG_MAP_LOCAL
    ReleaseAll
    End

Legend_Phione_Locked:
    End

    .balign 4, 0
