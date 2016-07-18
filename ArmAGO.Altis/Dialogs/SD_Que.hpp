class RPP_QueMenu
{
    idd = 30045;
    movingenable = true;
    onLoad = "uiNamespace setVariable ['RPP_QueMenu', (_this select 0)]";
	
	class Controls
	{

		class background: RscPicture
		{
			idc = 1800;
			text = "#(argb,8,8,3)color(0,0,0,0.8)";
			x = 0.3 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.4 * safezoneH;
		};
		class Team_Blue: RscListbox
		{
			idc = 1500;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.24 * safezoneH;
		};
		class Team_Red: RscListbox
		{
			idc = 1501;
			x = 0.525 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.24 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Join Team Blue"; //--- ToDo: Localize;
			x = 0.35 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Join Team Red"; //--- ToDo: Localize;
			x = 0.55 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "Team Blue"; //--- ToDo: Localize;
			x = 0.375 * safezoneW + safezoneX;
			y = 0.34 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.06 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = "Team Red"; //--- ToDo: Localize;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.34 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.06 * safezoneH;
		};
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "0/10 In Que"; //--- ToDo: Localize;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			text = "Ready up"; //--- ToDo: Localize;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(1,0,0,1.0,CO)";
			x = 0.3 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.06 * safezoneH;
		};
		class RscText_1003: RscText
		{
			idc = 1003;
			text = "S&D Que Menu"; //--- ToDo: Localize;
			x = 0.3 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
		};
	};
};
