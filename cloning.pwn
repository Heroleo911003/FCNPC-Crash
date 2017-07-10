#include <a_samp>
#include <FCNPC>
#include <zcmd>
#include <sscanf2>
#define MAX_CLONES 10
#define Col_Power 0x006280AA
forward UpdateClones();
enum cinfo
{
  id,
  follow,
  aimat,
  shootat,
  attackmode
};
new Clone[MAX_PLAYERS][MAX_CLONES][cinfo];
new Clones[MAX_PLAYERS];
//new clonerid;

stock NameEx(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}
stock GetXYInFrontOfPlayer(playerid, &Float:x2, &Float:y2, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x2, y2, a);
	GetPlayerFacingAngle(playerid, a);
	if(GetPlayerVehicleID(playerid))
	{
		GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x2 += (distance * floatsin(-a, degrees));
	y2 += (distance * floatcos(-a, degrees));
}

stock GetXYInFrontOfPlayer2(playerid, &Float:x2, &Float:y2, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x2, y2, a);
	GetPlayerFacingAngle(playerid, a);
	x2 += (distance * floatsin(-a, degrees));
	y2 += (distance * floatcos(-a, degrees));
}

stock GetXYBackOfPlayer(const playerid, &Float:x, &Float:y, const Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	x -= (distance * floatsin(-a, degrees));
	y -= (distance * floatcos(-a, degrees));
}

stock GetXYLeftOfPlayer(playerid, &Float:X, &Float:Y, Float:distance)
{
    new Float:Angle;
    GetPlayerFacingAngle(playerid, Angle); Angle += 90.0;
    X += floatmul(floatsin(-Angle, degrees), distance);
    Y += floatmul(floatcos(-Angle, degrees), distance);
}

stock GetXYRightOfPlayer(playerid, &Float:X, &Float:Y, Float:distance)
{
    new Float:Angle;
    GetPlayerFacingAngle(playerid, Angle); Angle -= 90.0;
    X += floatmul(floatsin(-Angle, degrees), distance);
    Y += floatmul(floatcos(-Angle, degrees), distance);
}

/*public FCNPC_OnDeath(npcid, killerid, weaponid)
{
	new msg[128];
	format(msg, sizeof msg, "CLONES: Clone %s_%d was killed by %s with weaponid %d.", NameEx(playerid), npcid, NameEx(killerid), weaponid);
	SendClientMessage(clonerid, Col_Power, msg);
	return 1;
}

public FCNPC_OnCreate(npcid)
{
	new msg[128];
	format(msg, sizeof msg, "CLONES: You have created a new clone, Clone %d.", npcid);
	SendClientMessage(clonerid, Col_Power, msg);
	return 1;
}*/

public FCNPC_OnTakeDamage(npcid, damagerid, weaponid, bodypart, Float:health_loss)
{
 	return 1;
}

public UpdateClones()
{
	//Loop Through All players
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		// Validate the player
		if(!IsPlayerConnected(i) || !Clones[i]) continue;
		for(new j = 0; j < MAX_CLONES; j++) //Loop through all the player's clones
		{
			if(Clone[i][j][attackmode] == 1) //Process the duel
			{
			    //Get Creator Position
				new Float:x, Float:y, Float:z, Float:nx, Float:ny, Float:nz;
				GetPlayerPos(i, x, y, z);
				//Get clone position
				FCNPC_GetPosition(Clone[i][j][id], nx, ny, nz);
				//Check if he need to follow
				if(!IsPlayerInRangeOfPoint(i, 15.0, nx, ny, nz))
				{
					new rand; rand = random(15);
					switch(rand)
					{
						case 0:
						{
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
						case 1:
						{
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
						case 2:
						{
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
						case 3:
						{
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
						case 4:
						{
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
						case 5:
						{
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
						case 6:
						{
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
						case 7:
						{
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
						case 8:
						{
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
						case 9:
						{
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
						case 10:
						{
							FCNPC_AimAt(Clone[i][j][id], x, y, z, true, -1, true);
						}
						case 11:
						{
							GetXYRightOfPlayer(Clone[i][j][id], x, y, 20.0);
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
						case 12:
						{
							GetXYLeftOfPlayer(Clone[i][j][id], x, y, 20.0);
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
						case 13:
						{
							GetXYRightOfPlayer(Clone[i][j][id], x, y, 20.0);
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
						case 14:
						{
							GetXYLeftOfPlayer(Clone[i][j][id], x, y, 20.0);
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_SPRINT, 0.0, false);
						}
					}
				}
				else
				{
					new rand; rand = random(15);
					switch(rand)
					{
						case 0:
						{
							FCNPC_AimAt(Clone[i][j][id], x, y, z, true, -1, true);
						}
						case 1:
						{
							FCNPC_AimAt(Clone[i][j][id], x, y, z, true, -1, true);
						}
						case 2:
						{
							FCNPC_AimAt(Clone[i][j][id], x, y, z, true, -1, true);
						}
						case 3:
						{
							FCNPC_AimAt(Clone[i][j][id], x, y, z, true, -1, true);
						}
						case 4:
						{
							FCNPC_AimAt(Clone[i][j][id], x, y, z, true, -1, true);
						}
						case 5:
						{
							FCNPC_AimAt(Clone[i][j][id], x, y, z, true, -1, true);
						}
						case 6:
						{
							GetXYRightOfPlayer(Clone[i][j][id], x, y, 20.0);
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_RUN, 0.0, false);
						}
						case 7:
						{
							GetXYLeftOfPlayer(Clone[i][j][id], x, y, 20.0);
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_RUN, 0.0, false);
						}
						case 8:
						{
							GetXYRightOfPlayer(Clone[i][j][id], x, y, 20.0);
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_RUN, 0.0, false);
						}
						case 9:
						{
							GetXYLeftOfPlayer(Clone[i][j][id], x, y, 20.0);
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_RUN, 0.0, false);
						}
						case 10:
						{
							GetXYRightOfPlayer(Clone[i][j][id], x, y, 20.0);
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_RUN, 0.0, false);
						}
						case 11:
						{
							GetXYLeftOfPlayer(Clone[i][j][id], x, y, 20.0);
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_RUN, 0.0, false);
						}
						case 12:
						{
							GetXYRightOfPlayer(Clone[i][j][id], x, y, 20.0);
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_RUN, 0.0, false);
						}
						case 13:
						{
							GetXYLeftOfPlayer(Clone[i][j][id], x, y, 20.0);
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_RUN, 0.0, false);
						}
						case 14:
						{
							GetXYRightOfPlayer(Clone[i][j][id], x, y, 20.0);
							FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_RUN, 0.0, false);
						}
					}
				}
			}
			// Process Follow
			else if(Clone[i][j][follow] == 1)
			{
				//Get cloner position
				new Float:x, Float:y, Float:z, Float:nx, Float:ny, Float:nz;
				GetPlayerPos(i, x, y, z);
				//Get Clone position
				FCNPC_GetPosition(Clone[i][j][id], nx, ny, nz);
				//Does he need to follow?
				if(!IsPlayerInRangeOfPoint(i, 2.0, nx, ny, nz))
				{
					//Set The moving velocity if he's a driver
					if(FCNPC_GetVehicleID(Clone[i][j][id]) != INVALID_VEHICLE_ID)
					FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_DRIVE, 0.8, false);
					if(IsPlayerInAnyVehicle(i))
					{
                         new Float:vx, Float:vy, Float:vz;
                         GetVehicleVelocity(GetPlayerVehicleID(i), vx, vy, vz);
                         //FCNPC_SetVelocity(Clone[i][j][id], vx * 0.1, vy, vz);
				    }
				    else FCNPC_GoTo(Clone[i][j][id], x, y, z, MOVE_TYPE_RUN, 0.0, false);

			    }
			    else
			       FCNPC_Stop(Clone[i][j][id]);
		    }    // Process clone aiming
	        else if(Clone[i][j][aimat] != INVALID_PLAYER_ID)
		    {
		    	//Get target position
			    new Float:x, Float:y, Float:z;
			    GetPlayerPos(Clone[i][j][aimat], x, y, z);
			    //Aim at the target
			    FCNPC_AimAt(Clone[i][j][id], x, y, z);
		    }
		    //Process clone shooting
		    else if(Clone[i][j][shootat] != INVALID_PLAYER_ID)
		    {
				new Float:hp;
				GetPlayerHealth(Clone[i][j][shootat], hp);
				//Make sure the target isn't dead
				if(hp < 0.0) return FCNPC_StopAim(Clone[i][j][id]);
				else
				{
					//Get Target Position
					new Float:x, Float:y, Float:z;
					GetPlayerPos(Clone[i][j][shootat], x, y, z);
					//Shoot the target
					FCNPC_AimAt(Clone[i][j][id], x, y, z, true, -1, true);
				}
	        }
  	    }
	}
	return 1;
}

/*********************************************************************/
public OnFilterScriptInit()
{
    UsePlayerPedAnims();
        // Set the update rate
	FCNPC_SetUpdateRate(30);
	// Create the Clones update timer
 	SetTimer("UpdateClones", 100, -1);
	print("\n--------------------------------------");
	print("********ClonePower By. HeroBlade********");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	Clones[playerid] = 0;
	for(new i = 0; i < MAX_CLONES; i++)
	{
		Clone[playerid][i][id] = INVALID_PLAYER_ID;
		// Reset Clone stats
 		Clone[playerid][i][follow] = 0;
 		Clone[playerid][i][attackmode] = 0;
 		Clone[playerid][i][aimat] = INVALID_PLAYER_ID;
		Clone[playerid][i][shootat] = INVALID_PLAYER_ID;
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	for(new i = 0; i < Clones[playerid]; i++)
	{
	  	// Delete the Clone NPC
	  	FCNPC_Destroy(Clone[playerid][i][id]);
	  	// Free the slot
		Clone[playerid][i][id] = INVALID_PLAYER_ID;
		// Reset Clone stats
 		Clone[playerid][i][follow] = 0;
 		Clone[playerid][i][attackmode] = 0;
 		Clone[playerid][i][aimat] = INVALID_PLAYER_ID;
		Clone[playerid][i][shootat] = INVALID_PLAYER_ID;
	}
	Clones[playerid] = 0;
	return 1;
}
/***************************************************************/
CMD:clone(playerid, params[])
{
	new  cname[24], npc = FCNPC_Create(cname), option[15];
	if(sscanf(params, "s[15]", option))
	{
		SendClientMessage(playerid, -1, "USAGE: /clone [option]");
		SendClientMessage(playerid, -1, "OPTIONS: add, delete, attackmode");
	}
	if(!strcmp(option, "add", true))
    {
		if(Clones[playerid] == MAX_CLONES) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: Maximum Clones Reached!");
		format(cname, sizeof cname, "%s_%d", NameEx(playerid), Clones[playerid] + 1);
		// Increase Clones
		Clones[playerid]++;
		if(npc == INVALID_PLAYER_ID)
		{
			SendClientMessage(playerid, 0xFF0000AA, "ERROR: You failed to clone yourself. (Maximum Clones Reached???)");
			Clones[playerid]--;
		}
		// Setting Clone Slot
		Clone[playerid][Clones[playerid]][id] = npc;
		// Reset Clone Stats
		Clone[playerid][Clones[playerid]][follow] = 0;
		Clone[playerid][Clones[playerid]][aimat] = INVALID_PLAYER_ID;
		Clone[playerid][Clones[playerid]][shootat] = INVALID_PLAYER_ID;
		// Get Current Player Pos
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		// Get Interior
		new
		int = GetPlayerInterior(playerid),
		wep = GetPlayerWeapon(playerid),
		ammo = GetPlayerAmmo(playerid),
		skin = GetPlayerSkin(playerid),
		Float:armor = GetPlayerArmour(playerid, armor);
		// Set Clone
		FCNPC_Spawn(npc, skin, x+2, y+2, z);
		FCNPC_SetInterior(npc, int);
		FCNPC_SetAmmo(npc, ammo);
		FCNPC_SetArmour(npc, armor);
		FCNPC_SetWeapon(npc, wep);
	}
	if(!strcmp(option, "delete", true))
	{
		if(Clones[playerid] == 0) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You haven't clone yourself.");
		// Delete Clone
		FCNPC_Destroy(Clone[playerid][Clones[playerid] - 1][id]);
		// Free Clone Slot
		Clone[playerid][Clones[playerid] - 1][id] = INVALID_PLAYER_ID;
		// Decrease player Clones
		Clones[playerid]--;
	}
	if(!strcmp(option, "attackmode", true))
	{
		new cduel;
		if(Clones[playerid] == 0) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You haven't clone yourself.");
		if(sscanf(params, "i", cduel)) return SendClientMessage(playerid, -1, "USAGE: /clone attackmode [cloneid]");
		if(cduel == npc)
		{    //Follow Flag
            Clone[playerid][npc][attackmode] = 1;
		}
	}
	return 1;
}











/***************************************************************/
public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
