removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

player forceAddUniform "CUP_U_B_USMC_MARPAT_WDL_Sleeves";
for "_i" from 1 to 8 do {player addItemToUniform "SmokeShell";};
player addVest "CUP_V_B_MTV_Patrol";
for "_i" from 1 to 8 do {player addItemToVest "CUP_30Rnd_556x45_Stanag";};
player addBackpack "CUP_B_USMC_MOLLE";
for "_i" from 1 to 1 do {player addItemToBackpack "Medikit";};
for "_i" from 1 to 10 do {player addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 4 do {player addItemToBackpack "30Rnd_556x45_Stanag_Tracer_Red";};
player addHeadgear "CUP_H_USMC_HelmetWDL";

player addWeapon "CUP_arifle_M16A4_Base";

if (phx_loadout_map == 0) then {
    player linkItem "ItemMap";
    if (phx_loadout_gps == 0) then {player linkItem "ItemGPS";};
};
player linkItem "ItemCompass";
player linkItem "ItemWatch";
if (phx_loadout_radio == 0) then {
    player linkItem "ItemRadio";
};
[player,"MedB"] call bis_fnc_setUnitInsignia;

missionNamespace setVariable ["phx_loadoutAssigned",true]; //Place this at the end of the loadout script so other scripts can tell when the player's loadout has been set.