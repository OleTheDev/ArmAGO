/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_Shop_Config.sqf

Description:
Shop Config
*/

AGO_ShopConfig = 
[
	//classname,price,side,cfg type,shop type,command


	["hgun_P07_snds_F",100,"CT","CfgWeapons","Pistols","addWeapon"],
	["arifle_Katiba_F",2500,"CT","CfgWeapons","Rifles","addWeapon"],
	["arifle_MXC_F",3100,"CT","CfgWeapons","Rifles","addWeapon"],
	["V_PlateCarrier1_rgr",500,"CT","CfgWeapons","Armory","addVest"],
	["H_HelmetIA_camo",450,"CT","CfgWeapons","Armory","addHeadgear"],


	["hgun_ACPC2_F",100,"T","CfgWeapons","Pistols","addWeapon"],
	["arifle_Mk20C_plain_F",2100,"T","CfgWeapons","Rifles","addWeapon"],
	["arifle_SDAR_F",2700,"CfgWeapons","Rifles","addWeapon"],
	["V_PlateCarrierIA1_dgtl",500,"T","CfgWeapons","Armory","addVest"],
	["H_HelmetB_black",450,"T","CfgWeapons","Armory","addHeadgear"],


	["hgun_Pistol_heavy_02_F",700,"","CfgWeapons","Pistols","addWeapon"],
	["SMG_02_F",1600,"","CfgWeapons","SMGs","addWeapon"],
	["optic_Holosight",1000,"","CfgWeapons","Scopes","addItem"],
	["optic_Arco",1500,"","CfgWeapons","Scopes","addItem"],
	["HandGrenade",300,"","CfgMagazines","Nades","addMagazine"],
	["SmokeShell",300,"","CfgMagazines","Nades","addMagazine"]
];
publicVariable "AGO_ShopConfig";

AGO_ShopConfig_gunMag =
[
	["hgun_P07_snds_F","16Rnd_9x21_Mag"],
	["arifle_Katiba_F","30Rnd_65x39_caseless_green"],
	["arifle_MXC_F","30Rnd_65x39_caseless_mag"],
	["hgun_ACPC2_F","9Rnd_45ACP_Mag"],
	["arifle_Mk20C_plain_F","30Rnd_556x45_Stanag"],
	["arifle_SDAR_F","30Rnd_556x45_Stanag"],
	["hgun_Pistol_heavy_02_F","6Rnd_45ACP_Cylinder"],
	["SMG_02_F","30Rnd_9x21_Mag_SMG_02"]
];
publicVariable "AGO_ShopConfig_gunMag";

AGO_ShopConfig_Types =
[
	"Pistols",
	"Rifles",
	"Armory",
	"SMGs",
	"Nades",
	"Scopes"
];
publicVariable "AGO_ShopConfig_Types";