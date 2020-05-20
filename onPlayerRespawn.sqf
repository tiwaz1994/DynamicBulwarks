// Executed LOCALLY when player respawns in a multiplayer mission. 
// This event script will also fire at the beginning of a mission if respawnOnStart is 0 or 1, oldUnit will be objNull in this instance. This script will not fire at mission start if respawnOnStart equals -1. 

waitUntil {sleep 0.2; !(isNil "bulwarkBox")};
["Terminate"] call BIS_fnc_EGSpectator;
player setVariable ["buildItemHeld", false];

"onPlayerRespawn invoked" call shared_fnc_log;

//delete empty continers
// REVIEW: Is this related to the weapons-going-missing bug?
[player, ['Take', {
  params ['_unit', '_container', '_item'];
  [_container] remoteExecCall ["loot_fnc_deleteIfEmpty", 2];
}]] remoteExec ['addEventHandler', 0, true];

_player = _this select 0;
removeHeadgear _player;
removeGoggles _player;
removeVest _player;
removeBackpack _player;
removeAllWeapons _player;
removeAllAssignedItems _player;
_player setPosASL ([bulwarkBox] call bulwark_fnc_findPlaceAround);

if(PLAYER_STARTWEAPON) then {
    _weap = selectRandom LOOT_WEAPON_HANDGUN_POOL;
		_ammo = selectRandom getArray (configFile >> "CfgWeapons" >> _weap >> "magazines");
		for "_i" from 1 to 3 do {_player addMagazine _ammo;};
		_player addWeapon _weap;
};

if(PLAYER_STARTMAP) then {
    _player addItem "ItemMap";
    _player assignItem "ItemMap";
    _player linkItem "ItemMap";
};

if(PLAYER_STARTNVG) then {
    _player addItem "Integrated_NVG_F";
    _player assignItem "Integrated_NVG_F";
    _player linkItem "Integrated_NVG_F";
};

if (isClass (configfile >> "CfgVehicles" >> "tf_anarc164")) then {
  _player addItem "tf_anprc152";
};

waituntil {alive _player};

[] remoteExec ["killPoints_fnc_updateHud", 0];