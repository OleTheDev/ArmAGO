class AGO_ShopDialog
{
    idd = 30045;
    movingenable = true;
    onLoad = "uiNamespace setVariable ['AGO_ShopDialog', (_this select 0)]";
	
	class Controls
	{

		class background: RscPicture
		{
			idc = 1800;
			text = "Images\Background.paa";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.46 * safezoneH;
		};
		class Types: RscCombo
		{
			idc = 2100;
			onLBSelChanged = "_this call AGO_Shop_ChangeType;";
			x = 0.375 * safezoneW + safezoneX;
			y = 0.3 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "Select Shop Type"; //--- ToDo: Localize;
			x = 0.4625 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.12 * safezoneH;
		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.375 * safezoneW + safezoneX;
			y = 0.34 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.28 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Buy"; //--- ToDo: Localize;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.02 * safezoneH;
		};
	};
};
