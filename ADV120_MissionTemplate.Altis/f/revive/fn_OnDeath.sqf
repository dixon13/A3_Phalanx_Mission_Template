// F3 - Simple Wounding System -- Modified by robtherad
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================
// Happens when a unit dies. Determines wether or not to send them to spectator or to recreate them and set them as downed.
if (!hasInterface) exitWith {};

params [
    ["_newUnit", objNull, [objNull]],
    ["_oldUnit", objNull, [objNull]],
    ["_respawn", 0, [0]],
    ["_respawnDelay", 0, [0]]
];

if (phx_revive_respawnRevive) then {
    waitUntil {!isNull _newUnit};
    
    // Get player back the same gear he had when he died
    [_newUnit, [missionNamespace, "phx_revive_lastLoadout"], ["linkeditems"]] call BIS_fnc_loadInventory;
    private _loadout = missionNamespace getVariable ["phx_revive_loadout",[]];
    [_loadout] call phx_fnc_AddLinkedItems;

    // Put player into a downed state
    [_newUnit, true] remoteExecCall ["phx_fnc_SetDowned", 0];
    
    // Move player into position and then delete old body
    _newUnit setDir (getDir _oldUnit);
    _newUnit setPos (getPos _oldUnit);
    deleteVehicle _oldUnit;
    
    // Update variables on new unit
    _newUnit setVariable ["phx_revive_down",phx_revive_down, true];
    _newUnit setVariable ["phx_revive_bleeding",phx_revive_bleeding, true];
    _newUnit setVariable ["phx_revive_bleedFast",phx_revive_bleedFast, true];
    _newUnit setVariable ["phx_revive_respawnRevive",phx_revive_respawnRevive, true];
    
} else {
    // If unit is down, unset them as down
    if (phx_revive_down) then {
        [_oldUnit, false] remoteExecCall ["phx_fnc_SetDowned", 0];
    };
    
    _this call f_fnc_CamInit;
};
