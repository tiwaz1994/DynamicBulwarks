/**
*  createBase
*
*  Selects a base location and spawns required mission items
*
*  Domain: Server
**/

_bulwarkLocation = [BULWARK_LOCATIONS, BULWARK_RADIUS] call bulwark_fnc_bulwarkLocation;
bulwarkRoomPos = _bulwarkLocation select 0;
bulwarkCity = _bulwarkLocation select 1;

bullwarkBox = createVehicle ["B_supplyCrate_F", [0,0,0], [], 0, "CAN_COLLIDE"];
bullwarkBox setPosASL bulwarkRoomPos;
bullwarkBox allowDamage false;
clearItemCargoGlobal bullwarkBox;
clearWeaponCargoGlobal bullwarkBox;
clearMagazineCargoGlobal bullwarkBox;
clearBackpackCargoGlobal bullwarkBox;
bullwarkBox addWeaponCargoGlobal["hgun_P07_F",10];
bullwarkBox addMagazineCargoGlobal ["16Rnd_9x21_Mag",20];
[bullwarkBox, ["Pickup", "bulwark\moveBox.sqf"]] remoteExec ["addAction", 0];
[bullwarkBox, ["Shop", "[] spawn bulwark_fnc_purchaseGui; ShopCaller = _this select 1"]] remoteExec ["addAction", 0];

_marker1 = createMarker ["Mission Area", bulwarkCity];
"Mission Area" setMarkerShape "ELLIPSE";
"Mission Area" setMarkerSize [BULWARK_RADIUS, BULWARK_RADIUS];
"Mission Area" setMarkerColor "ColorWhite";

lootHouses = bulwarkCity nearObjects ["House", BULWARK_RADIUS];

/* Spinner Box */
/*
_lootBoxRoom = while {true} do {
	_lootBulding = selectRandom lootHouses;
	_lootRooms = _lootBulding buildingPos -1;
	_lootRoom = selectRandom _lootRooms;
	if(!isNil "_lootRoom") exitWith {_lootRoom};
};
lootBox = createVehicle ["Land_WoodenBox_F", _lootBoxRoom, [], 0, "CAN_COLLIDE"];
publicVariable "lootBox";
sleep 2;
lootBoxPos    = getPos lootBox; publicVariable "lootBoxPos";
lootBoxPosATL = getPosATL lootBox; publicVariable "lootBoxPosATL";
[lootBox, [
	    "<t color='#FF0000'>Spin the box!</t>", {
		//TODO: should use the return from spend call
		if(player getVariable "killPoints" >= SCORE_RANDOMBOX) then {
			[player, SCORE_RANDOMBOX] call killPoints_fnc_spend;
			// Call lootspin script on ALL clients
			[[lootBoxPos, lootBoxPosATL], "loot\spin\main.sqf"] remoteExec ["BIS_fnc_execVM", player];
		} else {
			[format ["<t size='0.6' color='#ff3300'>%1 points required to spin the box</t>", SCORE_RANDOMBOX], -0.6, -0.35] call BIS_fnc_dynamicText;
		};
    }
]] remoteExec ["addAction", 0, true];
lootBox enableSimulationGlobal false;
*/