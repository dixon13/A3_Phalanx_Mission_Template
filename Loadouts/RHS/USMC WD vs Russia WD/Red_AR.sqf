// Add clothing
call phx_fnc_loadout_handleClothing; // Add clothing variables above this line!

// Add gear
for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {player addItemToUniform "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};
player addItemToVest "rhs_100Rnd_762x54mmR";
for "_i" from 1 to 3 do {player addItemToBackpack "rhs_100Rnd_762x54mmR";};
player addWeapon "rhs_weap_pkm";
player addItemToVest "rhs_100Rnd_762x54mmR";

// Add items
call phx_fnc_loadout_handleItems;

missionNamespace setVariable ["phx_loadoutAssigned",true]; //Place this at the end of the loadout script so other scripts can tell when the player's loadout has been set.
