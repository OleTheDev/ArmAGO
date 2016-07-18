/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_Actions.sqf
*/
SD_Action_Add = {
	SD_Action = player addAction ["<t color='#0000FF'>Plant Bomb",{[] call SD_Bomb_Plant},[false],1,false,true,"","(player distance (getpos Bomb)) < 5"];
	SD_Action = player addAction ["<t color='#0000FF'>Defuse Bomb",{[] call SD_Bomb_Defuse},[false],1,false,true,"","(player distance (getpos Bomb)) < 5"];
};
publicVariable "SD_Action_Add";
	