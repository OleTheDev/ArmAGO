/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_Respawn.sqf

Description:
Player Respawn
*/

["AGO_Respawn",{
	params["_unit","_corpse"];

	if (_unit getVariable ["AGO_playerSide",""] isEqualTo "") exitWith {
		deleteVehicle _corpse;
	};

	_unit setPos (getMarkerPos "dead");
	_unit enableSimulation false;
	_unit allowDamage false;

	private _box = createVehicle ["groundWeaponHolder", _corpse modelToWorld [0,0.8,0], [], 0.5, "CAN_COLLIDE"];
	_box setDir floor (random 360);

	_corpse setVariable["AGO_isDead",true,true];
	_unit setVariable["AGO_isDead",true,true];

	private _weapons = [];

	if (primaryWeapon _corpse != "") then {
		_weapons pushBack [primaryWeapon _corpse,"Weapon"];
	};
	if (handgunWeapon _corpse != "") then {
		_weapons pushBack [handgunWeapon _corpse,"Weapon"];
	};

	{
		_weapons pushBack [_x,"Item"];
	} foreach primaryWeaponItems _corpse;
	{
		_weapons pushBack [_x,"Item"];
	} foreach handgunItems _corpse;
	{
		_weapons pushBack [_x,"Mag"];
		_corpse removeMagazine _x;
	} foreach magazines _corpse;

	removeAllWeapons _corpse;
	removeAllItems _corpse;

	if (count _weapons <= 0) then {
		deleteVehicle _box;
	};

	{
		_classname = _x select 0;
		_type = _x select 1;
		switch (_type) do { 
			case "Weapon": {
				_box addWeaponCargoGlobal [_classname,1];
			}; 
			case "Mag": {
				_box addMagazineCargoGlobal [_classname,1];
			}; 
			default {
				_box addItemCargoGlobal [_classname,1];
			}; 
		};
	} foreach _weapons;

	systemChat "You have been killed!";

	[] call AGO_PlayerSetup_StartingGear;

	if (!AGO_matchLive) then {
		_time = 5;
		for "_i" from 1 to 5 do {
			_time = _time - 1;
			hintSilent format["Respawning in %1 second(s)...",_time];
			uiSleep 1;
		};
		[] call AGO_Match_setSpawnPoint;
		deleteVehicle _corpse;
	} else {
		[] call AGO_Respawn_CamView;
	};
}] call AGO_Function;

["AGO_Respawn_CamView",{
	AGO_TeamMatesCam = [];
	AGO_CamSpecPlayer = 1;

	{
		if (!(_x getVariable["AGO_isDead",false])) then {
			_side = _x getVariable["AGO_playerSide",""];
			_sidePlayer = player getVariable["AGO_playerSide",""];
			if (_side == _sidePlayer && _side != "" && _sidePlayer != "") then {
				AGO_TeamMatesCam pushBack _x;
			};
		};
	} foreach playableUnits;

	if (count AGO_TeamMatesCam <= 0) exitWith {};

	_specUnit = AGO_TeamMatesCam select 0;
	[_specUnit] call AGO_Respawn_CamCreate;
 
	findDisplay 46 displayAddEventHandler ["MouseButtonDown", { 
		if (_this select 1 == 0) then { 
			[] call AGO_Respawn_CamView_Switch;
		}; 
		false 
	}]; 
}] call AGO_Function;

["AGO_Respawn_CamCreate",{
	params["_specUnit"];

	if (!isNil "AGO_SpecCam") then {
		camDestroy AGO_SpecCam; 
		AGO_SpecCam cameraEffect ["TERMINATE","BACK"];
	};

	AGO_SpecCam = "camera" camCreate (ASLToAGL eyePos _specUnit);
	AGO_SpecCam cameraEffect ["Internal","back"];
	AGO_SpecCam attachTo [vehicle _specUnit, [0,0,0], "head"];
	AGO_UnitSpecing = _specUnit;
	showCinemaBorder false;

	addMissionEventHandler [ "EachFrame", format[ "
		['%1'] call AGO_Respawn_Cam_UpdatePos;
	", vehicle AGO_UnitSpecing call BIS_fnc_netId]];

	[_specUnit] call AGO_Respawn_CamView_Loop;
}] call AGO_Function;

["AGO_Respawn_Cam_UpdatePos",{
	params["_unitNetID"];
		
	_unit = _unitNetID call BIS_fnc_objectFromNetId;
		
	AGO_SpecCam camSetPos (( ASLToAGL eyePos _unit ) vectorAdd (( getCameraViewDirection vehicle _unit ) vectorMultiply 0.5 ));
	AGO_SpecCam camSetDir ( getCameraViewDirection _unit );
	AGO_SpecCam camCommit 0;
}] call AGO_Function;

["AGO_Respawn_CamView_Switch",{
	private _camPlayer = 1;
	private _found = false;

	{
		if (_found) exitWith {};

		_isDead = _x getVariable["AGO_isDead",false];

		if (_isDead) then {
			AGO_TeamMatesCam = AGO_TeamMatesCam - [_x];
		} else {
			_side = _x getVariable["AGO_playerSide",""];
			_sidePlayer = player getVariable["AGO_playerSide",""];
			if (_side == _sidePlayer && _side != "" && _sidePlayer != "") then {
				if (_camPlayer > AGO_CamSpecPlayer) then {
					_unitSpec = _x;
					_found = true;
				} else {
					_camPlayer = _camPlayer + 1;
				};
			};
		};
	} foreach AGO_TeamMatesCam;
}] call AGO_Function;

["AGO_Respawn_CamView_Loop",{
	params["_unit"];

	while {player getVariable ["AGO_isDead",false]} do {
		if (!alive _unit) then {
			[] call AGO_Respawn_CamView_Switch;
		};
		if (_unit != AGO_UnitSpecing) exitWith {};
		if (count AGO_TeamMatesCam <= 0) exitWith {};
		sleep 1;
	};

	if (!isNil "AGO_SpecCam" && _unit isEqualTo AGO_UnitSpecing) then {
		camDestroy AGO_SpecCam;
		AGO_SpecCam cameraEffect ["TERMINATE","BACK"];
		closeDialog 1;
	};
}] call AGO_Function;