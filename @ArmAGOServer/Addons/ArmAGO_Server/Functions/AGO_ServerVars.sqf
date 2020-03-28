/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_ServerVars.sqf

Description:
Server Variables
*/

AGO_BombSitePlanted = "";
publicVariable "AGO_BombSitePlanted";

AGO_BombPlanted = false;
publicVariable "AGO_BombPlanted";

AGO_BombTime = 1;
publicVariable "AGO_BombTime";

AGO_BombDefused = false;
publicVariable "AGO_BombDefused";

AGO_roundTime = 5;
publicVariable "AGO_roundTime";

AGO_roundLive = false;
publicVariable "AGO_roundLive";

AGO_maxRounds = 30;
publicVariable "AGO_maxScore";

AGO_warmupMode = false;
publicVariable "AGO_warmupMode";

AGO_halftimeRound = 15;
publicVariable "AGO_halftimeRound";

AGO_roundsPlayed = 0;
publicVariable "AGO_roundsPlayed";

AGO_score_T = 0;
publicVariable "AGO_score_T";

AGO_score_CT = 0;
publicVariable "AGO_score_CT";

AGO_matchLive = false;
publicVariable "AGO_matchLive";

AGO_startingoutfit = [
	["U_B_CombatUniform_mcam","CT","forceAddUniform"],
	["B_AssaultPack_rgr","CT","addBackpack"],
	["U_O_CombatUniform_ocamo","T","forceAddUniform"],
	["B_AssaultPack_blk","T","addBackpack"],
	["U_C_Poloshirt_burgundy","","forceAddUniform"]
];
publicVariable "AGO_startingoutfit";

AGO_nextmsgShow = true;

AGO_White = "#F0F0F0";
AGO_Red = "#bd0707";
AGO_Blue = "#0033CC";
AGO_Yellow = "#e0e72e";
AGO_Black = "#303030";
AGO_Green = "#009933";
publicVariable "AGO_White";
publicVariable "AGO_Red";
publicVariable "AGO_Blue";
publicVariable "AGO_Yellow";
publicVariable "AGO_Black";
publicVariable "AGO_Green";

