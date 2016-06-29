// F3 - Simple Wounding System -- Modified by robtherad
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================
// Called by the revive action. Runs only on the reviving unit. Waits for the animation to have played and then revives the downed unit if none of the conditions have changed.
if (!hasInterface) exitWith {};

params ["_downedUnit", "_reviverUnit"];

if !(_reviverUnit isEqualTo player) exitWith {};
if !("Medikit" in (items player)) exitWith {}; // Medkit is required to revive, double check that the reviver still has one
if (missionNamespace getVariable ["phx_revive_currentlyBusy",false]) exitWith {}; // Make sure it isn't run twice

missionNamespace setVariable ["phx_revive_currentlyBusy",true];

// Calculate time it will take to revive the unit

// Add revive PFH
[{
    params ["_downedUnit", "_reviverUnit", "_reviveTime"];

    if (_reviveTime > diag_tickTime) then {
        // Make sure animation is playing, if not, play it.
        if (!(["medic",animationstate _reviverUnit] call bis_fnc_inString)) then {
            if ((stance _reviverUnit) isEqualTo "PRONE") then {
                _reviverUnit playMove "AinvPpneMstpSlayWrflDnon_medicOther"; // Prone anim
            } else {
                _reviverUnit playMove "ainvpknlmstpslaywrfldnon_medicother"; // Crouch anim
            };
        };

        // Add cancel action to stop reviving
        if !(missionNamespace getVariable ["",false]) then {
            
        };
    } else {
        // Remove PFH
        [_handle] call CBA_fnc_removePerFrameHandler;

        // Stop animation, healing done
        if ((["medic",animationstate _reviverUnit] call bis_fnc_inString)) then {
            _reviverUnit playMove "";
        };

        // Make sure player didn't cancel the revive process
        if !(missionNamespace getVariable ["phx_revive_cancelledRevive",false]) then {
            missionNamespace setVariable ["phx_revive_currentlyBusy",false];

            // --------------------------------------------------
            // Display messages on why the action failed
            if !(_reviverUnit distance _downedUnit < 3) exitWith {titleText ["Revive Failed - Distance too far. Get closer and try again.", "PLAIN DOWN"];};
            if !("Medikit" in (items player)) exitWith {titleText ["Revive Failed - Medic doesn't have a medkit anymore!", "PLAIN DOWN"];};
            if !(isNull objectParent _reviverUnit) exitWith {titleText ["Revive Failed - Medic got into a vehicle!", "PLAIN DOWN"];};
            if !(isNull objectParent _downedUnit) exitWith {titleText ["Revive Failed - The patient got into a vehicle!", "PLAIN DOWN"];};
            if (_reviverUnit getVariable ["phx_revive_down",false] || !(alive _reviverUnit)) exitWith {titleText ["Revive Failed - The medic went down while reviving!", "PLAIN DOWN"];};
            if !(_downedUnit getVariable ["phx_revive_down",false]) exitWith {titleText ["Revive Failed - The patient was no longer down!", "PLAIN DOWN"];};
            if !(alive _downedUnit) exitWith {titleText ["Revive Failed - The patient is dead!", "PLAIN DOWN"];};
            // --------------------------------------------------
            // Stop bleeding
            if (_downedUnit getVariable ["phx_revive_bleeding",false]) then {
                [_downedUnit, false, true] remoteExecCall ["phx_fnc_SetBleeding", 0];
            };

            // Revive unit
            if (_downedUnit getVariable ["phx_revive_down",false]) then {
                [_downedUnit, false] remoteExecCall ["phx_fnc_SetDowned", 0];
            };

            titleText [format["You have revived %1.",name _downedUnit], "PLAIN DOWN"];
        } else {
            missionNamespace setVariable ["phx_revive_cancelledRevive",false];
            titleText [format["You have stopped reviving %1.",name _downedUnit], "PLAIN DOWN"];
        };
    };
}, 0, [_downedUnit,_reviverUnit, (diag_tickTime + _timeToRevive)]] call CBA_fnc_addPerFrameHandler;
