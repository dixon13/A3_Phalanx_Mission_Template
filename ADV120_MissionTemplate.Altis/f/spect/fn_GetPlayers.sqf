// F3 - Spectator Script
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================
// gets all the player groups and filter out the AI.
private ["_arr"];
_players = [];
_ai = [];
{
    if (isNil "f_cam_side" || {side _x isEqualTo f_cam_side}) then {
        if ( { private _spectator = _x getVariable ["phx_isUnitSpecator",false]; (isPlayer _x) && {!_spectator} && {alive _x} } count (units _x) > 0 ) then {
            _players pushBack _x;
        } else {
            if ( { private _spectator = _x getVariable ["phx_isUnitSpecator",false]; !(isPlayer _x) && {!_spectator} && {alive _x}} count (units _x) > 0 ) then {
                _ai pushBack _x;
            };
        };
    };

} foreach allGroups;
[_players,_ai]
