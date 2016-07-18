/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_Spawn.sqf
*/

SD_Spawn_Client = {
	[] spawn {
		titleText ["Waiting for extDb2...", "BLACK"];
		
		waitUntil{!isNil "SD_SRV_READY"};
		waitUntil{SD_SRV_READY};

		titleText ["extDB2 is Ready.", "BLACK"];

		sleep 0.4;

		SD_Client_StatsLoaded = false;
		titleText [ format ["%1 We are loading your Stats please wait...",name player], "BLACK"];

		sleep 0.2;

		[getPlayerUID player,player] remoteExec ["SD_DB_fetchData",2];
		waitUntil{SD_Client_StatsLoaded};

		titleText ["Stats loaded", "PLAIN"];

		player allowDamage true;
		player enableSimulation true;

		[] call SD_Variables;
		[] call SD_KeyDo;
		[] call SD_Action_Add;
		[] call SD_Hud_Start;
		[] call SD_Client_XPCheck;
		
		_title = "<t align = 'center' shadow = '1' size='1.3' font='PuristaBold'>ArmA GO by Lifeman</t>";
		_text = format
		[
			"
			<br /><br /><t align='center' color='#e0e72e'>%1 Welcome to ArmA GO Made by: Lifeman<br /><br />
			To open the Que menu press Y and when ingame while in buy time press 1 to use the Shop Menu<br /><br />
			Team Red is the team that will Plant the bomb while Team Blue will try to protect the bomb from being planted!<br /><br />
			First to get to %2 round will win!<br /><br />
			Have fun!</t>
			",name player,SD_TeamWinningScore
		];

		hint parseText (_title + _text);
	};
};
publicVariable "SD_Spawn_Client";