/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_Onkeypress.sqf

Description:
Key bindings
*/
["AGO_OnKeyPress",  {
	private ["_key","_shift","_handled"];
	_key     = _this select 1;
	_shift   = _this select 2;
	_handled = false;

	if (!alive player) exitWith {_handled;};
	if (AGO_Action_Use) exitWith {_handled};

	AGO_Action_Use = true;

	switch (_key) do {
		case 21: //Y - Signup menu
		{
			[]call AGO_Signup_DialogOpen;
		};

		case 48: //B - Buy menu
		{
			[] call AGO_Shop_DialogOpen;
		};

	};

	AGO_Action_Use = false;

	//systemChat format ["Debug: %1 | %2 | %3",_key,_shift,_handled];

	_handled;
}] call AGO_Function;

["AGO_KeyHandler", {
	[] spawn {
		waitUntil {!isNull findDisplay 46};
		(findDisplay 46) displayAddEventHandler ["KeyDown","_this call AGO_OnKeyPress;false;"];
	};
}] call AGO_Function;