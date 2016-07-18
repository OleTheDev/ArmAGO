class SD_Hud
{
	idd=-1;
	movingEnable=0;
	fadein=0;
	duration = 99999999999999999999999999999999999999999999;
	fadeout=0;
	name="RPP_HudDialog";
    onLoad = "uiNamespace setVariable ['SD_Hud', (_this select 0)]";
	
	class Controls
	{

		class rank: RscText
		{
			idc = 1000;
			text = "Rank: 10"; //--- ToDo: Localize;
			x = -2.45869e-008 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.1625 * safezoneW;
			h = 0.06 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = "Health: 100%"; //--- ToDo: Localize;
			x = -2.45869e-008 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.1625 * safezoneW;
			h = 0.06 * safezoneH;
		};
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "FPS: 35"; //--- ToDo: Localize;
			x = -2.45869e-008 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.1625 * safezoneW;
			h = 0.06 * safezoneH;
		};
		class RscText_1003: RscText
		{
			idc = 1003;
			text = "Play Time: 35 Seconds"; //--- ToDo: Localize;
			x = -2.45869e-008 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.1625 * safezoneW;
			h = 0.06 * safezoneH;
		};
	};
};
