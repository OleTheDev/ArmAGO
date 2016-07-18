/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_BuyMenu.sqf
*/

SD_BuyMenu_Dialog = {
	createDialog "SD_BuyMenu";

	{
		_text = getText (configFile >> 'CfgWeapons' >> _x >> 'displayName');
		lbAdd [1500, format ["%1",_text]];
	} foreach weapons player;
	{
		_text = getText (configFile >> 'CfgWeapons' >> _x >> 'displayName');
		lbAdd [1500, format ["%1",_text]];
	} foreach items player;

	buttonSetAction [1600, "['SMGs'] call SD_BuyMenu_Selected;"];
	buttonSetAction [1601, "['Heavy'] call SD_BuyMenu_Selected;"];
	buttonSetAction [1602, "['Pistols'] call SD_BuyMenu_Selected;"];
	buttonSetAction [1603, "['Grenades'] call SD_BuyMenu_Selected;"];
	buttonSetAction [1604, "['Gear'] call SD_BuyMenu_Selected;"];
	buttonSetAction [1605, "['Rifles'] call SD_BuyMenu_Selected;"];
	buttonSetAction [1606, "closeDialog 1;"];
	buttonSetAction [1607, "[] call SD_BuyMenu_Rebuy;"];
};
publicVariable "SD_BuyMenu_Dialog";

SD_BuyMenu_Buy = {
	private ["_data","_Array","_classname","_text","_price","_cmd"];

	_data = lbdata [1501,lbCurSel 1501];
	
	if (lbCurSel 1501 isEqualTo -1) exitWith {};
	if (_data isEqualTo "") exitWith {};

	switch (_data) do { 
		case "SMGs": {
			_Array = SD_SMGs select (lbCurSel 1501);
			_classname = _Array select 0;
			_text = _Array select 1;
			_price = _Array select 2;
			_cmd = _Array select 3;

			if (SD_Cash < _price) exitWith {
				hint "You don't have enought cash for this.";
			};

			SD_Cash = SD_Cash - _price;

			player addWeapon _classname;

			call compile format ["player addMagazines ['%1',5]",_cmd];

			SD_CurrentGear = SD_CurrentGear + [ ["SMGs",_classname,_cmd] ];

			hint format ["You bought a %1 for $%2",_text,_price];
		};

		case "Pistols": {
			_Array = SD_Pistols select (lbCurSel 1501);
			_classname = _Array select 0;
			_text = _Array select 1;
			_price = _Array select 2;
			_cmd = _Array select 3;

			if (SD_Cash < _price) exitWith {
				hint "You don't have enought cash for this.";
			};

			SD_Cash = SD_Cash - _price;

			player addWeapon _classname;

			call compile format ["player addMagazines ['%1',5]",_cmd];

			SD_CurrentGear = SD_CurrentGear + [ ["Pistols",_classname,_cmd] ];

			hint format ["You bought a %1 for $%2",_text,_price];
		};

		case "Rifles": {
			_Array = SD_Rifles select (lbCurSel 1501);
			_classname = _Array select 0;
			_text = _Array select 1;
			_price = _Array select 2;
			_cmd = _Array select 3;

			if (SD_Cash < _price) exitWith {
				hint "You don't have enought cash for this.";
			};

			SD_Cash = SD_Cash - _price;

			player addWeapon _classname;

			call compile format ["player addMagazines ['%1',5]",_cmd];

			SD_CurrentGear = SD_CurrentGear + [ ["Rifles",_classname,_cmd] ];

			hint format ["You bought a %1 for $%2",_text,_price];
		};

		case "Heavy": {
			_Array = SD_Heavy select (lbCurSel 1501);
			_classname = _Array select 0;
			_text = _Array select 1;
			_price = _Array select 2;
			_cmd = _Array select 3;

			if (SD_Cash < _price) exitWith {
				hint "You don't have enought cash for this.";
			};

			SD_Cash = SD_Cash - _price;

			player addWeapon _classname;

			call compile format ["player addMagazines ['%1',5]",_cmd];

			SD_CurrentGear = SD_CurrentGear + [ ["Heavy",_classname,_cmd] ];

			hint format ["You bought a %1 for $%2",_text,_price];
		};

		case "Gear": {
			_Array = SD_Gear select (lbCurSel 1501);
			_classname = _Array select 0;
			_text = _Array select 1;
			_price = _Array select 2;
			_cmd = _Array select 3;

			if (SD_Cash < _price) exitWith {
				hint "You don't have enought cash for this.";
			};

			SD_Cash = SD_Cash - _price;

			call compile format ["player %1 '%2'",_cmd,_classname];

			SD_CurrentGear = SD_CurrentGear + [ ["Gear",_classname,_cmd] ];

			hint format ["You bought a %1 for $%2",_text,_price];
		};

		case "Grenades": {
			_Array = SD_Grenades select (lbCurSel 1501);
			_classname = _Array select 0;
			_text = _Array select 1;
			_price = _Array select 2;

			if (SD_Cash < _price) exitWith {
				hint "You don't have enought cash for this.";
			};

			SD_Cash = SD_Cash - _price;

			call compile format ["player addMagazines ['%1',1]",_classname];

			SD_CurrentGear = SD_CurrentGear + [ ["Gear",_classname,"None"] ];

			hint format ["You bought a %1 for $%2",_text,_price];
		};
	};
};
publicVariable "SD_BuyMenu_Buy";

SD_BuyMenu_RecreateGear = {
	private ["_type","_classname","_cmd"];
	
	{
		_type = _x select 0;
		_classname = _x select 1;
		_cmd = _x select 2;
		_c = false;
		switch (_type) do { 
			case "Grenades": {
				{
					player removeMagazines _x;
				} foreach magazines player;
				call compile format ["player addMagazines ['%1',5]",_classname];
			}; 
			case "Gear": {
				call compile format ["player %1 '%2'",_cmd,_classname];
			}; 
			default {
				removeAllWeapons player;
				{
					player removeMagazines _x;
				} foreach magazines player;

				player addWeapon _classname;
				call compile format ["player addMagazines ['%1',5]",_cmd];
			}; 
		};
	} foreach SD_CurrentGear;
};
publicVariable "SD_BuyMenu_RecreateGear";

SD_BuyMenu_Rebuy = {

};
publicVariable "SD_BuyMenu_Rebuy";

SD_BuyMenu_Selected = {
	private ["_type"];
	_type = _this select 0;
	lbClear 1501;

	switch (_type) do { 
		case "SMGs": {
			{
				_text = _x select 1;
				_price = _x select 2;
				_data1 = lbAdd [1501, format ["%1 ($%2)",_text,_price]];
				lbSetData [1501, _data1, "SMGs"];
			} foreach SD_SMGs;
		};

		case "Pistols": {
			{
				_text = _x select 1;
				_price = _x select 2;
				_data2 = lbAdd [1501, format ["%1 ($%2)",_text,_price]];
				lbSetData [1501, _data2, "Pistols"];
			} foreach SD_Pistols;
		};

		case "Rifles": {
			{
				_text = _x select 1;
				_price = _x select 2;
				_data3 = lbAdd [1501, format ["%1 ($%2)",_text,_price]];
				lbSetData [1501, _data3, "Rifles"];
			} foreach SD_Rifles;
		};

		case "Heavy": {
			{
				_text = _x select 1;
				_price = _x select 2;
				_data4 = lbAdd [1501, format ["%1 ($%2)",_text,_price]];
				lbSetData [1501, _data4, "Heavy"];
			} foreach SD_Heavy;
		};

		case "Gear": {
			{
				_text = _x select 1;
				_price = _x select 2;
				_data5 = lbAdd [1501, format ["%1 ($%2)",_text,_price]];
				lbSetData [1501, _data5, "Gear"];
			} foreach SD_Gear;
		};

		case "Grenades": {
			{
				_text = _x select 1;
				_price = _x select 2;
				_data6 = lbAdd [1501, format ["%1 ($%2)",_text,_price]];
				lbSetData [1501, _data6, "Grenades"];
			} foreach SD_Grenades;
		};

	};
};
publicVariable "SD_BuyMenu_Selected";