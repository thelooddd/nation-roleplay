
new Mmoney[MAX_PLAYERS];
/* ВНЕСТИ В МОД!!!!
public OnGameModeInit() {
	SetTimer("Loshadka",2000,1);
	return 1;
}
*/

forward Loshadka();
public Loshadka() {
	for(new i =0;i<MAX_PLAYERS;i++) {
		if(GetPlayerMoney(i) != PlayerInfo[i][Money]) {
			GivePlayerMoney(i,PlayerInfo[i][Money]-GetPlayerMoney(i));
			//SendClientMessage(i,0xFEFEFEFF,"Не шали с читами здесь!");
		}
	}
}
stock ResetPlMon(playerid) {
	Mmoney[playerid] =0;
	GivePlayerMoney(playerid,0-GetPlayerMoney(playerid));
	return 1;
}
stock GiveMoney(playerid,a) {
	PlayerInfo[playerid][Money] += a;
	GivePlayerMoney(playerid,a);
	new opsdgpq[64];
	format(opsdgpq, sizeof(opsdgpq), "~y~~n~~g~~w~~n~~w~%d$", a);
	GameTextForPlayer(playerid, opsdgpq, 3000, 1);
	return 1;
}
stock GiveMoneyM(playerid,a) {
	PlayerInfo[playerid][Money] -= a;
	GivePlayerMoney(playerid,-a);
	return 1;
}
