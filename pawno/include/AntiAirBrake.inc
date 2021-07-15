#include <a_samp>

#define DYS 30
#define DYS_A 140
#define PENALTY 2 // 0 - Бан | 1 - Кик | 2 - Оповещение администраторов.
//#define SetPlayerPos SetPos

new PosTimer[MAX_PLAYERS];
new playb[MAX_PLAYERS];
forward OnPlayerUpdated(playerid);

public OnPlayerConnect(playerid)
{
    PosTimer[playerid] = SetTimerEx("OnPlayerUpdated", 2000, true, "d", playerid);
	return 1;
}

public OnPlayerDisconnect(playerid)
{
    KillTimer(PosTimer[playerid]);
	return 1;
}

public OnPlayerUpdated(playerid)
{
	if(playb[playerid] == 1)
	{
    for(new playerid, g = GetMaxPlayers(); playerid < g; playerid++)
    {
        new Float:pos[3];
        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
        if(GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID && GetPlayerState(playerid) != PLAYER_STATE_SPAWNED)
        {
            if(!GetPVarInt(playerid, "NoAB"))
            {
                switch(GetPlayerAnimationIndex(playerid))
                {
                    case 958, 959, 961, 962, 965, 971, 1126, 1130, 1132, 1134, 1156, 1208:
                    {
                        SetPVarInt(playerid, "NoAB", 1);
                        continue;
                    }
                }
                if(IsPlayerInAnyVehicle(playerid))
                {
                    if((floatabs(pos[0] - GetPVarFloat(playerid, "OldPosX"))) > DYS_A || (floatabs(GetPVarFloat(playerid, "OldPosX") - pos[0])) > DYS_A ||
	                (floatabs(pos[1] - GetPVarFloat(playerid, "OldPosY"))) > DYS_A || (floatabs(GetPVarFloat(playerid, "OldPosY") - pos[1])) > DYS_A ||
	                (floatabs(pos[2] - GetPVarFloat(playerid, "OldPosZ"))) > DYS_A/2 || (floatabs(GetPVarFloat(playerid, "OldPosZ") - pos[2])) > DYS_A/2)
	                {
	                    switch(PENALTY)
	                    {
	                        case 0: BanEx(playerid, "Airbreak");
	                        case 1: Kick(playerid);
	                        case 2:
	                        {
	                            SendClientMessage(playerid, 0xFFFFFFFF, "{ff0000}Внимание! {ffffff}Вы были кикнуты за чит AirBreak{00A200}(In vehicle)");
	                            //Kick(playerid);
	                        }
	                    }
	                }
                }
                else
				{
	                if((floatabs(pos[0] - GetPVarFloat(playerid, "OldPosX"))) > DYS || (floatabs(GetPVarFloat(playerid, "OldPosX") - pos[0])) > DYS ||
	                (floatabs(pos[1] - GetPVarFloat(playerid, "OldPosY"))) > DYS || (floatabs(GetPVarFloat(playerid, "OldPosY") - pos[1])) > DYS ||
	                (floatabs(pos[2] - GetPVarFloat(playerid, "OldPosZ"))) > DYS/2 || (floatabs(GetPVarFloat(playerid, "OldPosZ") - pos[2])) > DYS/2)
	                {
	                    switch(PENALTY)
	                    {
	                        case 0: BanEx(playerid, "Airbreak");
	                        case 1: Kick(playerid);
	                        case 2:
	                        {
	                            SendClientMessage(playerid, 0xFFFFFFFF, "{ff0000}Внимание! {ffffff}Вы были кикнуты за чит AirBreak");
	                            //Kick(playerid);
	                        }
	                    }
	                }
				}
            }
            SetPVarInt(playerid, "NoAB", 0);
        }
        SetPVarFloat(playerid, "OldPosX", pos[0]);
        SetPVarFloat(playerid, "OldPosY", pos[1]);
        SetPVarFloat(playerid, "OldPosZ", pos[2]);
    }
	}
    return 1;
}

stock SetPos(playerid,Float:x,Float:y,Float:z)
{
	new Float:xx, Float:yy, Float: zz;
	xx = x;
	yy = y;
	zz = z;
	printf("xx = %f",xx);
	printf("yy = %f",yy);
	printf("zz = %f",zz);
	
    SetPVarInt(playerid, "NoAB", 1);
	SetPVarFloat(playerid, "OldPosX", xx);
    SetPVarFloat(playerid, "OldPosY", yy);
    SetPVarFloat(playerid, "OldPosZ", zz);
	
    return SetPlayerPos(playerid,xx,yy,zz);
}
public OnPlayerSpawn(playerid)
{
SetPos(playerid,1958.82, 1342.96, 15.37);
playb[playerid] = 1;

return 1;
}