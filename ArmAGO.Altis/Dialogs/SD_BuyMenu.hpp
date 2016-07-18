class SD_BuyMenu
{
    idd = 30045;
    movingenable = true;
    onLoad = "uiNamespace setVariable ['SD_BuyMenu', (_this select 0)]";
	
	class Controls
	{
		class background: RscPicture
		{
			idc = 1200;
			text = "Image\S&D_Shop.paa";
			x = 0.075 * safezoneW + safezoneX;
			y = 0.06 * safezoneH + safezoneY;
			w = 0.825 * safezoneW;
			h = 0.94 * safezoneH;
		};
		class Inventory: RscListbox
		{
			idc = 1500;
			x = 0.729219 * safezoneW + safezoneX;
			y = 0.408 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.352 * safezoneH;
		};
		class Selected: RscListbox
		{
			idc = 1501;
			onLBSelChanged = "_this call SD_BuyMenu_Buy";
			x = 0.524999 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.451 * safezoneH;
		};
		class SMGS: RscButton_Hiden
		{
			idc = 1600;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class Heavy: RscButton_Hiden
		{
			idc = 1601;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class Pistols: RscButton_Hiden
		{
			idc = 1602;
			x = 0.257656 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class Nades: RscButton_Hiden
		{
			idc = 1603;
			x = 0.216406 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class Gear: RscButton_Hiden
		{
			idc = 1604;
			x = 0.257656 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class Rifles: RscButton_Hiden
		{
			idc = 1605;
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class Close: RscButton_Hiden
		{
			idc = 1606;
			x = 0.237031 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class AutoBuy: RscButton_Hiden
		{
			idc = 1607;
			x = 0.484531 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class reBuy: RscButton_Hiden
		{
			idc = 1608;
			x = 0.721719 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.055 * safezoneH;
		};
	};
};