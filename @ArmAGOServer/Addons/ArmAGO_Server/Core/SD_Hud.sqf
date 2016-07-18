/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_Hud.sqf
*/
SD_Hud_Start = {
	[] spawn {
		1 cutRsc ["SD_Hud", "PLAIN"];
	   	disableSerialization;
	   	_text = uiNameSpace getVariable ["SD_Hud",displayNull];
	   	while {true} do {
		   	_Rank = _text displayCtrl 1000;
		   	_Health = _text displayCtrl 1001;
		   	_FPS = _text displayCtrl 1002;
			_Cash = _text displayCtrl 1003;
			_GetHelth = getDammage player;

			_Rank ctrlSetText format["Rank: %1",SD_Rank];
			_Health ctrlSetText format["Health %1/100",(((1-_GetHelth)*100)-((1-_GetHelth)*100 mod 1))];
			_FPS ctrlSetText format["FPS: %1",round(diag_fps)];
			_Cash ctrlSetText format["Cash $%1",SD_Cash];
			sleep 0.3;
		};
	};
};
publicVariable "SD_Hud_Start";