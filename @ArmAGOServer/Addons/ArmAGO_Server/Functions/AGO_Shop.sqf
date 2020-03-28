/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_Shop.sqf

Description:
Shop
*/
["AGO_Shop_DialogOpen",{
	_exit = false;
	if (AGO_warmupMode isEqualTo false) then {
		if (!(AGO_matchLive)) exitWith {
			["You may only access this inside a match!",AGO_Red] call AGO_MessageSystem;
			_exit = true;
		};
		if (AGO_roundLive && AGO_warmupMode isEqualTo false) exitWith {
			["Buy time has expiered!",AGO_Red] call AGO_MessageSystem;
			_exit = true;
		};
	};
	if (_exit) exitWith {};
	if (player getVariable "AGO_playerSide" isEqualTo "") exitWith {
		["You must be in a team!",AGO_Red] call AGO_MessageSystem;
	};

	if (player getVariable "AGO_playerSide" isEqualTo "T" && player distance (getMarkerPos "tspawn") > 30) exitWith {
		["You must be closer to the spawn!",AGO_Red] call AGO_MessageSystem;
	};
	if (player getVariable "AGO_playerSide" isEqualTo "CT" && player distance (getMarkerPos "ctspawn") > 30) exitWith {
		["You must be closer to the spawn!",AGO_Red] call AGO_MessageSystem;
	};

	systemChat format ["Current Cash: $%1",AGO_Cash];

	createDialog "AGO_ShopDialog";

	{
		_data = lbAdd[2100,format["%1",_x]];
		lbSetData[2100,_data,_x];
	} foreach AGO_ShopConfig_Types;

	lbAdd[1500,"Please select shop type!"];

	buttonSetAction[1600,"[] call AGO_Shop_Buy;"];
}] call AGO_Function;

["AGO_Shop_ChangeType",{
	private["_shopType","_playerSide"];
	if (lbCurSel 2100 isEqualTo -1) exitWith {
		["Missing shop type selection!",AGO_Red] call AGO_MessageSystem;
	};
	_shopType = lbData[2100,(lbCurSel 2100)];
	if (_shopType isEqualTo "") exitWith {
		["Shop type returned empty!",AGO_Red] call AGO_MessageSystem;
	};

	_playerSide = player getVariable "AGO_playerSide";

	lbClear 1500;
	{
		_classname = _x select 0;
		_price = _x select 1;
		_side = _x select 2;
		_cfg = _x select 3;
		_type = _x select 4;

		if (_type == _shopType && _side == _playerSide || _type == _shopType && _side == "") then {
			_pic = getText (configFile >> _cfg >> _classname >> 'picture');
			_text = getText (configFile >> _cfg >> _classname >> 'displayName');

			_data1 = lbAdd[1500,format["%1 ($%2)",_text,_price]];

			lbSetData [1500,_data1,_classname];
			lbSetPicture[1500,_data1,_pic];
		};
	} forEach AGO_ShopConfig;
}] call AGO_Function;

["AGO_Shop_Buy",{
	private["_itemSel"];
	if (lbCurSel 1500 isEqualTo -1) exitWith {
		["Please select something to buy!",AGO_Red] call AGO_MessageSystem;
	};
	_classname = lbData[1500,(lbCurSel 1500)];
	if (_classname isEqualTo "") exitWith {
		["That item was not found in our config!",AGO_Red] call AGO_MessageSystem;
	};
	
	{
		if (_classname == _x select 0) exitWith {
			_price = _x select 1;
			_cfg = _x select 3;
			_text = getText (configFile >> _cfg >> _classname >> 'displayName');

			if (AGO_Cash < _price) exitWith {
				[format["You don't have enough cash for %1",_text],AGO_Red] call AGO_MessageSystem;
			};
			
			_cmd = _x select 5;
			switch (_cmd) do { 
				case "addWeapon": {
					player addWeapon _classname;

					{
						if (_classname == _x select 0) exitWith {
							_mag = _x select 1;
							player addMagazines[_mag,10];
						};
					} count AGO_ShopConfig_gunMag;
				}; 
				case "addVest": {
					player addVest _classname;
				};
				case "addHeadgear": {
					player addHeadgear _classname;
				};
				case "addItem": {
					player addPrimaryWeaponItem _classname;
				};
				case "addMagazine": {
					player addMagazine [_classname,1];
				};
			};

			AGO_Cash = AGO_Cash - _price;
		};
	} count AGO_ShopConfig;
}] call AGO_Function;