class AGO_SignupDialog
{
    idd = 30045;
    movingenable = true;
    onLoad = "uiNamespace setVariable ['AGO_SignupDialog', (_this select 0)]";
	
	class Controls
	{
		class background: RscPicture
		{
			idc = 1800;
			text = "Images\Background.paa";
			x = 0.275 * safezoneW + safezoneX;
			y = 0.3 * safezoneH + safezoneY;
			w = 0.4375 * safezoneW;
			h = 0.38 * safezoneH;
		};
		class tSide: RscListbox
		{
			idc = 1500;
			x = 0.2875 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.1625 * safezoneW;
			h = 0.2 * safezoneH;
		};
		class ctSide: RscListbox
		{
			idc = 1501;
			x = 0.5375 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.1625 * safezoneW;
			h = 0.2 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Join Terrorist"; //--- ToDo: Localize;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.0875 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Join Counter-Terrorist"; //--- ToDo: Localize;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.0875 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			text = "Ready/UnReady"; //--- ToDo: Localize;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.0875 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class RscButton_1603: RscButton
		{
			idc = 1603;
			text = "Leave"; //--- ToDo: Localize;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.0875 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "Terrorists"; //--- ToDo: Localize;
			x = 0.35 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.06 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = "Counter-Terrorists"; //--- ToDo: Localize;
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.08 * safezoneH;
		};
	};
};
