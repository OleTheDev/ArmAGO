/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_Cfg.sqf
*/
SD_Variables = {
	SD_Rank = 1; //Defult rank
	SD_Elo = 0; //Elo for matching your rank
	SD_XPNeeded = 10;
	SD_XP = 0;
	SD_Cash = 800; //Cash you spawn with
	SD_DB_Load = false;
	SD_Action_Use = false;
	SD_CurrentGear = [];
	SD_Kills = 0;
	SD_Wins = 0;
	SD_Death = 0;
	
	player setVariable ["SD_PlayerReady",false,true];
	player setVariable ["SD_TeamRed",false,true];
	player setVariable ["SD_TeamBlue",false,true];
	player setVariable ["SD_InMatch",false,true];
	player setVariable ["SD_Dead",false,true];
};
publicVariable "SD_Variables";