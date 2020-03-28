/*
Script File Another: Nais
Script File Mod: ArmA GO
Script File: InitPlayerLocal.sqf

Description:
Starting the client
*/

systemChat "Loading client side 0%...";
player enableSimulation false;
waitUntil {!(isNull (findDisplay 46))};
systemChat "Loading client side 20%...";
waitUntil{!isNull player};
systemChat "Loading client side 40%...";
waitUntil{player == player};
systemChat "Loading client side 50%...";
waitUntil{time > 0.1};
systemChat "Loading client side 70%...";
waitUntil {!(isNull player)};
systemChat "Loading client side 90%...";

systemChat "Loading client side 100%";

[] call AGO_PlayerSetup_Start;

systemChat format ["Client %1 loaded.",name player];
