/*
Script File Another: Lifeman
Script File Mod: RP Project
Script File: InitPlayerLocal.sqf

Description:
Starting the client
*/

player allowDamage false;
player enableSimulation false;

systemChat "::Server INIT:: Loading Client INIT 20%...";

waitUntil {!(isNull (findDisplay 46))};

systemChat "::Server INIT:: Loading Client INIT 50%...";

waitUntil{!isNull player};

systemChat "::Server INIT:: Loading Client INIT 70%...";

waitUntil{player == player};

systemChat "::Server INIT:: Loading Client INIT 80%...";

waitUntil{time > 0.1};

systemChat "::Server INIT:: Loading Client INIT 90%...";

waitUntil {!(isNull player)};

[] call SD_Spawn_Client;

systemChat "::Server INIT:: Loading Client INIT 100%.";