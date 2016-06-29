// F3 - Simple Wounding System -- Modified by robtherad
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================
// Triggered by the HandleHeal EH. Stops a player's scripted bleeding when they get healed.
if (!hasInterface) exitWith {};

// Add wait until for animation starting
[{
    params ["_unit", "_healer"];
    (["medic",animationstate _healer] call bis_fnc_inString)
}, {
    params ["_unit", "_healer"];
    
    // Add wait until for animation ending
    [{
        params ["_unit", "_healer"];
        !(["medic",animationstate _healer] call bis_fnc_inString)
    }, {
        params ["_unit", "_healer"];
        
        if (_unit getVariable ["phx_revive_bleeding",false]) then {
            [_unit, false, true] remoteExecCall ["phx_fnc_SetBleeding", 0];
        };
    }, [_unit,_healer] call CBA_fnc_waitUntilAndExecute;
}, [_unit, _healer]] call CBA_fnc_waitUntilAndExecute;
    
true
