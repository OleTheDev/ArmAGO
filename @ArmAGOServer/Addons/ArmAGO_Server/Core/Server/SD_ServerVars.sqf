/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_ServerVars.sqf
*/
SD_TeamRed = [];
SD_TeamBlue = [];
SD_TeamRedCount = 0; //Amount of team red players
SD_TeamBlueCount = 0; //Amount of team blue players
SD_InQue = 0; //Amount of players in que
SD_Ready = 0; //Amount of players ready to start
SD_MaxQue = 5; //Max que for each side
SD_MatchQue = 10; //Amount of players needed on each side to start the match.
SD_Admins = [];
SD_MatchStarted = false;
SD_BomBTime_M = 2; //Bomb timer minutes
SD_BomBTime_S = 0; //Bomb timer seconds
SD_MatchTime_M = 5; //Match timer minutes
SD_MatchTime_S = 0; //Match timer Seconds
SD_ScoreRed = 0; //Score team red
SD_ScoreBlue = 0; //Score team Blue
SD_RoundBuy = false;
SD_BombPlanted = false;
SD_TeamRedPlant = false;
SD_TeamBluePlant = false;
SD_WinningBonus = 1500; //Winnings
SD_LosingBonus = 900; //losing
SD_TeamBlueAlive = 0; //Count the Team red for alive.
SD_TeamRedAlive = 0; //Count the Team red for alive.
SD_TeamWinningScore = 10;

publicVariable "SD_TeamRed";
publicVariable "SD_TeamBlue";
publicVariable "SD_TeamRedCount";
publicVariable "SD_TeamBlueCount";
publicVariable "SD_InQue";
publicVariable "SD_Ready";
publicVariable "SD_MaxQue";
publicVariable "SD_MatchQue";
publicVariable "SD_Admins";
publicVariable "SD_MatchStarted";
publicVariable "SD_BomBTime_M";
publicVariable "SD_BomBTime_S";
publicVariable "SD_MatchTime_M";
publicVariable "SD_MatchTime_S";
publicVariable "SD_ScoreRed";
publicVariable "SD_ScoreBlue";
publicVariable "SD_RoundBuy";
publicVariable "SD_BombPlanted";
publicVariable "SD_TeamRedPlant";
publicVariable "SD_TeamBluePlant";
publicVariable "SD_WinningBonus";
publicVariable "SD_LosingBonus";
publicVariable "SD_TeamBlueAlive";
publicVariable "SD_TeamRedAlive";
publicVariable "SD_TeamWinningScore";