/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_PlayerVars.sqf

Description:
Player Variables
*/

["AGO_PlayerVars_Setup",{
	AGO_Kills = 0;
	AGO_Deaths = 0;
	AGO_Cash = 800;
	AGO_Action_Use = false;

	player setVariable["AGO_isdead",false,true];
	player setVariable["AGO_isReady",false,true];
	player setVariable["AGO_playerSide","",true];

	AGO_nextmsgShow = true;
}] call AGO_Function;