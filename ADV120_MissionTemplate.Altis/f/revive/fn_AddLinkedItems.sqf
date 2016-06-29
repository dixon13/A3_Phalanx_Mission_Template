// F3 - Simple Wounding System -- Modified by robtherad
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================
// Add a player's linked items back to him. Without this, items will get desynced.
if (!hasInterface) exitWith {};

params ["_loadoutArray"];
private _assignedItemArray = _loadoutArray param [9,[],[[]]];

if (count _assignedItemArray > 0) then {
    // Remove any items not present in last loadout but present on new character
    {
        if !(_x in _assignedItemArray) then {
            player unlinkItem _x;
        };
    } forEach assignedItems player;

    // Add any items the player doesn't have but should have
    {
        if !(_x in (assignedItems player)) then {
            player linkItem _x;
        };
    } forEach _assignedItemArray;
};
