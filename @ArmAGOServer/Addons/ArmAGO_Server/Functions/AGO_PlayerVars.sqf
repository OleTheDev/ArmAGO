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
	player setVariable["AGO_isDead",false,true];

	player addEventHandler ["Respawn", {[_this select 0,_this select 1] spawn AGO_Respawn;}];
	player addEventHandler ["InventoryOpened", {_this call AGO_Inventory_Block}];

	AGO_nextmsgShow = true;
}] call AGO_Function;

["AGO_Inventory_Block",{
	private ["_container","_unit"];
	if (count _this isEqualTo 1) exitWith {false};
	params["_unit","_container"];

	_classname = typeOf _container;
	_backpack = getNumber (configFile >> "CfgVehicles" >> _classname >> "isBackpack");

	if (_unit getVariable["AGO_isDead",false]) exitWith {
		true;
	};
	if (_backpack isEqualTo 1) exitWith {
		true;
	};
}] call AGO_Function;
