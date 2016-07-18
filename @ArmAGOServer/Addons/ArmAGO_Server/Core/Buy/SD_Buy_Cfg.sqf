/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_Buy_Cfg.sqf
*/
SD_Pistols =
[
	//Classname,text,price,mag
	["hgun_P07_snds_F","P07 9 mm",200,"30Rnd_9x21_Mag"],
	["hgun_Pistol_heavy_01_MRD_F","4-five .45",400,"11Rnd_45ACP_Mag"],
	["hgun_Pistol_heavy_02_F","Zubr .45",750,"6Rnd_45ACP_Cylinder"]
];
publicVariable "SD_Pistols";

SD_Rifles =
[
	//Classname,text,price,mag
	["arifle_Katiba_F","Katiba 6.5 mm",2300,"30Rnd_65x39_caseless_green"],
	["arifle_MXC_F","MXC 6.5 mm",3100,"30Rnd_65x39_caseless_mag"],
	["srifle_EBR_F","Mk18 ABR 7.62 mm",3200,"20Rnd_762x51_Mag"],
	["srifle_LRR_LRPS_F","M320 LRR .408",6100,"7Rnd_408_Mag"]
];
publicVariable "SD_Rifles";

SD_SMGs =
[
	//Classname,text,price,mag
	["hgun_PDW2000_F","PDW2000 9 mm",1500,"30Rnd_9x21_Mag"],
	["SMG_01_F","Vermin SMG .45 ACP",1800,"30Rnd_45ACP_Mag_SMG_01"],
	["SMG_02_ACO_F","Sting 9 mm",2000,"30Rnd_9x21_Mag"]
];
publicVariable "SD_SMGs";

SD_Heavy =
[
	//Classname,text,price,mag
	["LMG_Mk200_F","Mk200 6.5 mm",5500,"200Rnd_65x39_cased_Box"],
	["LMG_Zafir_F","Zafir 7.62 mm",5800,"150Rnd_762x54_Box"]
];
publicVariable "SD_Heavy";

SD_Gear =
[
	//Classname,text,price,cmd
	["V_TacVest_brn","Tactical Vest (Brown)",650,"addVest"],
	["H_HelmetSpecB","SF Helmet",350,"addHeadgear"]
];
publicVariable "SD_Gear";

SD_Grenades =
[
	//Classname,text,price,cmd
	["SmokeShell","Smoke (White)",300,"addMagazines"],
	["HandGrenade","Hand Grenade",300,"addMagazines"]
];
publicVariable "SD_Grenades";