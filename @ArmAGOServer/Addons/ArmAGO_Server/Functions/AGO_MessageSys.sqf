/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_MessageSys.sqf

Description:
Message System
*/
["AGO_MessageSystem",{
	[_this select 0,_this select 1] spawn {
		params["_msg","_color"];

		waitUntil{AGO_nextmsgShow};
		AGO_nextmsgShow = false;

		[parseText format["<t font='PuristaBold' size='1.6'>NEW MESSAGE</t><br /><t color='%2'>%1</t>",_msg,_color], true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;

		sleep 3;
		AGO_nextmsgShow = true;
	};
}] call AGO_Function;