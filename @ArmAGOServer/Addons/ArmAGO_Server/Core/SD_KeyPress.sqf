/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_KeyPress.sqf
*/
SD_OnKeyPress = {
	private ["_key","_shift","_handled"];
	_key     = _this select 1;
	_shift   = _this select 2;
	_handled = false;

	if (!alive player) exitWith {_handled;};
	if (SD_Action_Use) exitWith {_handled};

	SD_Action_Use = true;

	switch (_key) do {
		case 2: //1 (Shop)
		{
			if (!(player getVariable "SD_InMatch")) exitWith {
				hint "You are not in a match.";
			};
			if (!(SD_RoundBuy)) exitWith {
				hint "The Round buy time is out.";
			};
			[] call SD_BuyMenu_Dialog;
		};

		case 21: //Y (Que Menu)
		{
			if (SD_MatchStarted) then {
				hint "You are not allowed to access this while there is a match on going.";
			} else {
				[] call SD_Que_Dialog;
			};
		};
	};

	SD_Action_Use = false;

	//systemChat format ["Debug: %1 | %2 | %3",_key,_shift,_handled];

	_handled;
};
publicVariable "SD_OnKeyPress";

SD_KeyDo = {
	[] spawn {
		waitUntil {!isNull findDisplay 46};
		(findDisplay 46) displayAddEventHandler ["KeyDown","_this call SD_OnKeyPress;false;"];
	};
};
publicVariable "SD_KeyDo";