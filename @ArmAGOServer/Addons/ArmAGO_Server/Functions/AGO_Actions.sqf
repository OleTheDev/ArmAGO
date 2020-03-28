/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_Actions.sqf

Description:
Actions
*/
["AGO_Actions_Setup",{
	removeAllActions bomb_a;
	removeAllActions bomb_b;

	if (player getVariable "AGO_playerSide" isEqualTo "T") then {
		bomb_a addAction["Plant Bomb",{["A"] call AGO_Bomb_Plant;}];
		bomb_b addAction["Plant Bomb",{["B"] call AGO_Bomb_Plant;}];
	} else {
		bomb_a addAction["Defuse Bomb",{hint "TEST DEFUSE A";}];
		bomb_b addAction["Defuse Bomb",{hint "TEST DEFUSE B";}];
	};
	
}] call AGO_Function;