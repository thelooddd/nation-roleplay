#pragma dynamic 7500
//include

#include <a_samp>
#include <a_mysql>
#include <sscanf2>
#include <streamer>
#include <utils>

//#include <core>
//#include <foreach>
#include <crashdetect>
//#include <AntiAirBrake>
//#include <mxINI>
//-include
main() {}
#undef MAX_PLAYERS
#define MAX_PLAYERS 300
#define MAX_BUSINESS 51
#define MAX_FERMA 3
#define MAX_HOUSE 1001
new Text3D:BusinessLabel[MAX_BUSINESS];
new Text:NRPL;
new BusinessPickupOut[MAX_BUSINESS], BusinessPickupIn[MAX_BUSINESS];
new HousePickupIn[MAX_HOUSE], HouseMapIcon[MAX_HOUSE];
new Text3D:FermaLabel[MAX_BUSINESS];

new FermaPickupOut[MAX_FERMA], FermaPickupIn[MAX_FERMA];

#define SQL_HOST        ""
#define SQL_USER        ""
#define SQL_DB          ""
#define SQL_PASS        ""
//Crashers

/* Bullet Crasher */

//-Crashers

enum pInfo {
    ID,
    Name[MAX_PLAYER_NAME],
    Password[64],
    bool: Logged,
    WrongPassword,
    Email[64],
    Level,
    Exp,
    Money,
    Admin,
    Donate,
    Skin,
    FSkin,
    BMoney,
    Float:Health,
    Float:Armour,
    House,
    Car,
    Float:PosX,
    Float:PosY,
    Float:PosZ,
    Interior,
    VW,
    Frac,
    Business,
    Bank,
    Drugs,
    Golod,
    Bann,
    BanTime,
    Sex,
    JailTime,
    Warn,
    Status,
    DeMorgan,
    Muted,
    AdminP[10],
    FermaLS,
    FermaSF,
    Emailaccount[64],
    Passwordaccount[64]
};
enum pHouse {
    ID,
    Price,
    Int,
    IntB,
    Boss,
    BossName[MAX_PLAYER_NAME],
    Bank,
    Heal,
    Float:HX,
    Float:HY,
    Float:HZ,
    Float:SHX,
    Float:SHY,
    Float:SHZ,
    Float:SHXB,
    Float:SHYB,
    Float:SHZB,
    Status,
    Float:Angle,
    Float:Angl,
    Float:AngleB,
    Klad,
    Signal
};
enum pGarage {
    ID,
    House,
    Float:GX,
    Float:GY,
    Float:GZ,
    Float:GA
};
enum pJob {
    Money,
    bool:Status,
    ID,
    car

};
enum bInfo {
    ID,
    Name[64],
    Boss,
    Ammount,
    Status,
    Float:TDX,
    Float:TDY,
    Float:TDZ,
    Float:SpawnX,
    Float:SpawnY,
    Float:SpawnZ,
    Interior,
    Float:Angel,
    Float:EnterX,
    Float:EnterY,
    Float:EnterZ,
    Float:EnterA,
    Float:sEnterX,
    Float:sEnterY,
    Float:sEnterZ,
    Sum,
    Price,
    Type,
    Int,
    Float:AngelE
};
enum fInfo {
    ID,
    Name[64],
    Boss,
    Ammount,
    Status,
    Float:TDX,
    Float:TDY,
    Float:TDZ,
    Float:SpawnX,
    Float:SpawnY,
    Float:SpawnZ,
    Interior,
    Float:Angel,
    Float:EnterX,
    Float:EnterY,
    Float:EnterZ,
    Float:EnterA,
    Float:sEnterX,
    Float:sEnterY,
    Float:sEnterZ,
    Sum,
    Price,
    Fermer1,
    Fermer2,
    Fermer3,
    Fermer4,
    Fermer5,
    Ur,
    UrP,
    Bank,
    Zerno
};
enum fcInfo {

    In,
    InG
};
enum vVehicle {
    bool:vEngine,
    Float:vFuel,
    bool:vLock,
    bool:Stop,
    Float:vPosx,
    Float:vPosy,
    Float:vPosz
};
new VehicleInfo[MAX_VEHICLES][vVehicle];
new SpeedTimer[MAX_PLAYERS];
enum AC_STRUCT_INFO {
    Float:LastOnFootPosition[3],
        checkmaptp,
        maptplastclick,
        Float:maptp[3]
}
//new
new JobInfo[MAX_PLAYERS][pJob];
new PlayerInfo[MAX_PLAYERS][pInfo];
new HouseInfo[MAX_HOUSE][pHouse];
new BusinessInfo[MAX_BUSINESS][bInfo];
new FermaInfo[MAX_FERMA][fInfo];
new GarageInfo[MAX_HOUSE][pGarage];
new acstruct[MAX_PLAYERS][AC_STRUCT_INFO];
#include <AntiMoneyCheat>
new kick_gTimer[MAX_PLAYERS];
new ChosenSkin[MAX_PLAYERS];
new AntiDM[MAX_PLAYERS];
new Text:ButtonLeft;
new Text:ButtonRight;
new Text:ButtonSelect;
new FermaID[MAX_PLAYERS];

new FermaLSKustPP[MAX_PLAYERS], FermaSFKustPP[MAX_PLAYERS];
new FermaLSCRC[MAX_PLAYERS];
new Float:FermaLSCheckR[][3] = {
    {-122.6293, 138.4576, 2.1521 },
    {-147.1021, 137.9830, 2.7887 },
    {-174.8122, 149.5019, 4.5536 },
    {-159.5110, 48.2357, 2.0874 },
    {-193.6959, 60.9019, 2.0797 },
    {-221.1485, 31.0224, 2.0753 },
    {-174.5943, 9.5469, 2.0753 },
    {-237.7350, -11.9633, 2.0583 },
    {-191.0618, -28.4812, 2.0596 },
    {-223.8080, -51.2993, 2.0513 },
    {-10.2183, -34.9318, 2.0973 },
    {-16.8811, -66.4460, 2.0809 },
    { 29.8388, -92.3242, -0.2685 },
    {-23.0750, -87.4022, 2.0978 },
    {-201.1016, -52.9245, 2.0682 },
    {-204.5053, 0.3005, 2.0617 }
};
new Float:FermaSFCheckR[][3] = {
    {-1181.7147, -1049.5505, 128.2023 },
    {-1176.6177, -1023.7700, 128.1941 },
    {-1173.4917, -976.8798, 128.1941 },
    {-1122.8475, -965.8723, 128.1740 },
    {-1128.7848, -1016.9715, 128.1704 },
    {-1133.4535, -1048.5024, 128.1794 },
    {-1070.8458, -1047.6188, 128.1728 },
    {-1059.4678, -1002.0901, 128.1397 },
    {-1044.8529, -952.0266, 128.1222 }
};
new FermaLSCheckP[][1] = {
    {-5 },
    {-4 },
    {-3 },
    {-2 },
    {-1 },
    { 1 },
    { 2 },
    { 3 },
    { 4 },
    { 5 }
};
new FermaSFCheckP[][1] = {
    {-5 },
    {-4 },
    {-3 },
    {-2 },
    {-1 },
    { 1 },
    { 2 },
    { 3 },
    { 4 },
    { 5 }
};
new FermaLSDynamicPR[MAX_VEHICLES], FermaSFDynamicPR[MAX_VEHICLES];
new Text3D:FermaLS3DTEXTR[MAX_VEHICLES], Text3D:FermaSF3DTEXTR[MAX_VEHICLES];
new Float:FermaLSCheckRRY[MAX_PLAYERS], Float:FermaSFCheckRRY[MAX_PLAYERS];
new Float:FermaLSCheckRRZ[MAX_PLAYERS], Float:FermaSFCheckRRZ[MAX_PLAYERS];
new Float:FermaLSCheckRRX[MAX_PLAYERS], Float:FermaSFCheckRRX[MAX_PLAYERS];
new strrs[MAX_PLAYERS];
new PlayerVehicleId[MAX_PLAYERS];
new ClothesRound[MAX_PLAYERS];
new SelectCharRegID[MAX_PLAYERS];
new BigEar[MAX_PLAYERS];
new sendername[256];
new shifthour;
new PINN0[MAX_PLAYERS];
new fermalscar[2], fermasfcar[2];
new PINN1[MAX_PLAYERS];
new PINN2[MAX_PLAYERS];
new FermaLSCR[MAX_PLAYERS], FermaSFCR[MAX_PLAYERS];
new PINN3[MAX_PLAYERS];
new PINN4[MAX_PLAYERS];
new PINN5[MAX_PLAYERS];
new PINN6[MAX_PLAYERS];
new Float:gpsmetkaX[MAX_PLAYERS], Float:gpsmetkaY[MAX_PLAYERS], Float:gpsmetkaZ[MAX_PLAYERS];
new FermaLSKustP[MAX_PLAYERS], FermaSFKustP[MAX_PLAYERS];
new PINN7[MAX_PLAYERS];
new PINN8[MAX_PLAYERS];
new PINN9[MAX_PLAYERS];
new lcarid[MAX_PLAYERS]; //ID личного транспорта при создании
new timeshift = 0;
new incar[MAX_PLAYERS];
new cbbb[MAX_PLAYERS];
new FermaLSKustPPS[MAX_PLAYERS], FermaSFKustPPS[MAX_PLAYERS];
new NewSpawn[MAX_PLAYERS];
new tFlood[MAX_PLAYERS];
new SpawnReg[MAX_PLAYERS];
new Spawner[MAX_PLAYERS];
new PosTimer[MAX_PLAYERS];
new playb[MAX_PLAYERS];
new gSpectateType[MAX_PLAYERS];
new plafk[MAX_PLAYERS];
new SpawnMZ[MAX_PLAYERS];
new Text:SM_HA[MAX_PLAYERS];
new SpawnC[MAX_PLAYERS];
new Inter[MAX_PLAYERS];
new InterN[MAX_PLAYERS];
new Text:PIN1;
new Text:PIN2;
new Text:PIN3;
new Text:PIN4;
new Text:PIN5;
new Text:PIN6;
new Text:PIN7;
new Text:PIN8;
new Text:PIN9;
new Text:PIN0;
new Text:PIN11;
new APin[MAX_PLAYERS];
new AirB[MAX_PLAYERS];
//мешки работа
new PlayerInJob[MAX_PLAYERS];
new Meshki[MAX_PLAYERS];
new Meshok[MAX_PLAYERS];
new FermaProd[MAX_PLAYERS];
new slapd[MAX_PLAYERS];
new gryz1;
new gryz2;
new CenInt[MAX_PLAYERS];
new FermaLSKust[MAX_PLAYERS], FermaSFKust[MAX_PLAYERS];
new Login[MAX_PLAYERS];
new gryz3;
new fermalsin[MAX_VEHICLES][fcInfo], fermasfin[MAX_VEHICLES][fcInfo];
new FermaLSSum[MAX_VEHICLES], FermaSFSum[MAX_VEHICLES];
new fermalsstatus[MAX_PLAYERS], fermasfstatus[MAX_PLAYERS];
new Weapons[MAX_PLAYERS][47];
new PickUp[MAX_PLAYERS];
new FermaLSKustt[MAX_PLAYERS], FermaSFKustt[MAX_PLAYERS];
new Float:cbEnterX, Float:cbEnterY, Float:cbEnterZ, Float:cbEnterA, cbSpawn;
new Oldskin2[MAX_PLAYERS];
new Float: PlayerHealth[MAX_PLAYERS];
new Float:PlayerArmour[MAX_PLAYERS];
new AntiCarHP[MAX_PLAYERS];
new Float:VehicleHealth[MAX_VEHICLES] = 1000.0;
new fermalspickup, fermasfpickup;
new fermalspickupzp, fermasfpickupzp;
new fermalszp[MAX_PLAYERS], fermasfzp[MAX_PLAYERS];
new Float:PosPic[3][MAX_PLAYERS];
new Dpic[MAX_PLAYERS];
new bool:times[MAX_PLAYERS];
new AntiFly[MAX_PLAYERS];
new FermaSum[MAX_PLAYERS];
new HouseID[MAX_PLAYERS];
new HouseSum[MAX_PLAYERS];
new HouseProd[MAX_PLAYERS];
new Text:SPG0;
new Text:SPG1;
new PlayerText:SP0[MAX_PLAYERS];
new PlayerText:SP1[MAX_PLAYERS];
new PlayerText:SP2[MAX_PLAYERS];
new PlayerText:SP3[MAX_PLAYERS];
new PlayerText:SP4[MAX_PLAYERS];
new PlayerText:SP5[MAX_PLAYERS];
new PlayerText:SP6[MAX_PLAYERS];
new PlayerText:SP7[MAX_PLAYERS];
new PlayerText:SP8[MAX_PLAYERS];
new foodcar[2];

#pragma tabsize 0
//#define COLOR_RED 0xAA3333AA
#define COLOR_RED 0xE33014AA
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define FERMALS 1
#define FERMAUR 7
#define FERMAZERNO 1
#define Loop(%0,%1) for(new %0 = 0; %0 < %1; %0++)

#define JOBFOOD 1

//-мешки работа
new SpecHATimer[MAX_PLAYERS];
new gSpectateID[MAX_PLAYERS];
new Adm[][] = {
    { "                                     {ffffcc}Admin 1 lvl: \n" },
    { "{66ff00}/freeze [id] - заморозить\n" },
    //{"{66ff00}/unfreeze [id] - разморозить\n"},
    { "{66ff00}/get [id] - телепортировать игрока к себе\n" },
    { "{66ff00}/goto [id] - телепортироватся к игроку\n" },
    { "{66ff00}/cc - очистить чат\n" },
    { "{66ff00}/skin [id] - установить себе скин\n" },
    { "{66ff00}/a - админ чат(игрокам он не виден)\n" },
    { "{66ff00}/mute | /unmute - затычка игроку на чат | снять затычку с игрока\n" },
    { "{66ff00}/arepair - восстановить здоровье транспортного средства в котором находишься\n" },
    { "{66ff00}/pm - ответить игроку\n" },
    { "{66ff00}/ajail | /unajail - посадить в ДеМорган | выпустить\n" }
};
new Adm2[][] = {
    { "                                     {ffffcc}Admin 1 lvl: \n" },
    { "{66ff00}/freeze [id] - заморозить\n" },
    //{"{66ff00}/unfreeze [id] - разморозить\n"},
    { "{66ff00}/get [id] - телепортировать игрока к себе\n" },
    { "{66ff00}/goto [id] - телепортироватся к игроку\n" },
    { "{66ff00}/cc - очистить чат\n" },
    { "{66ff00}/skin [id] - установить себе скин\n" },
    { "{66ff00}/a - админ чат(игрокам он не виден)\n" },
    { "{66ff00}/mute | /unmute - затычка игроку на чат | снять затычку с игрока\n" },
    { "{66ff00}/arepair - восстановить здоровье транспортного средства в котором находишься\n" },
    { "{66ff00}/pm - ответить игроку\n" },
    { "{66ff00}/ajail | /unajail - посадить в ДеМорган | выпустить\n" },
    { "                                     {ffffcc}Admin 2 lvl:\n" },
    { "{66ff00}/spec [id] - следить за игроком \n" },
    { "{66ff00}/specoff [id] - перестать следить за игроком \n" },
    { "{66ff00}/akill [id] - убить игрока\n" },
    { "{66ff00}/disarm [id] - разоружить игрока\n" },
    { "{66ff00}/slap [id] - пнуть игрока\n" },
    { "{66ff00}/kick [id] [причина] - кикнуть игрока\n" },
    { "{66ff00}/warn [id] [причина] - выдать варн игроку\n" }
};
new Adm3[][] = {
    { "                                     {ffffcc}Admin 1 lvl: \n" },
    { "{66ff00}/freeze [id] - заморозить\n" },
    //{"{66ff00}/unfreeze [id] - разморозить\n"},
    { "{66ff00}/get [id] - телепортировать игрока к себе\n" },
    { "{66ff00}/goto [id] - телепортироватся к игроку\n" },
    { "{66ff00}/cc - очистить чат\n" },
    { "{66ff00}/skin [id] - установить себе скин\n" },
    { "{66ff00}/a - админ чат(игрокам он не виден)\n" },
    { "{66ff00}/mute | /unmute - затычка игроку на чат | снять затычку с игрока\n" },
    { "{66ff00}/arepair - восстановить здоровье транспортного средства в котором находишься\n" },
    { "{66ff00}/pm - ответить игроку\n" },
    { "{66ff00}/ajail | /unajail - посадить в ДеМорган | выпустить\n" },
    { "\n" },
    { "                                     {ffffcc}Admin 2 lvl:\n" },
    { "{66ff00}/spec [id] - следить за игроком \n" },
    { "{66ff00}/specoff [id] - перестать следить за игроком \n" },
    { "{66ff00}/akill [id] - убить игрока\n" },
    { "{66ff00}/disarm [id] - разоружить игрока\n" },
    { "{66ff00}/slap [id] - пнуть игрока\n" },
    { "{66ff00}/kick [id] [причина] - кикнуть игрока\n" },
    { "{66ff00}/warn [id] [причина] - выдать варн игроку\n" },
    { "\n" },
    { "                                     {ffffcc}Admin 3 lvl:\n" },
    { "{66ff00}/ban [id] 1 [причина] - забанить игрока\n" },
    { "\n" }
};
new Adm5[][] = {
    { "                                     {ffffcc}Admin 1 lvl: \n" },
    { "{66ff00}/freeze [id] - заморозить\n" },
    //{"{66ff00}/unfreeze [id] - разморозить\n"},
    { "{66ff00}/get [id] - телепортировать игрока к себе\n" },
    { "{66ff00}/goto [id] - телепортироватся к игроку\n" },
    { "{66ff00}/cc - очистить чат\n" },
    { "{66ff00}/skin [id] - установить себе скин\n" },
    { "{66ff00}/mute | /unmute - затычка игроку на чат | снять затычку с игрока\n" },
    { "{66ff00}/arepair - восстановить здоровье транспортного средства в котором находишься\n" },
    { "{66ff00}/pm - ответить игроку\n" },
    { "{66ff00}/ajail | /unajail - посадить в ДеМорган | выпустить\n" },
    { "                                     {ffffcc}Admin 2 lvl:\n" },
    { "{66ff00}/spec [id] - следить за игроком \n" },
    { "{66ff00}/specoff [id] - перестать следить за игроком \n" },
    { "{66ff00}/akill [id] - убить игрока\n" },
    { "{66ff00}/disarm [id] - разоружить игрока\n" },
    { "{66ff00}/slap [id] - пнуть игрока\n" },
    { "{66ff00}/kick [id] [причина] - кикнуть игрока\n" },
    { "{66ff00}/warn [id] [причина] - выдать варн игроку\n" },
    { "\n" },
    { "                                     {ffffcc}Admin 3 lvl:\n" },
    { "{66ff00}/ban [id] 1 [причина] - забанить игрока\n" },
    { "                                     {ffffcc}Admin 5 lvl:\n" },
    { "{66ff00}/respcar - респавнить все машины\n" },
    { "{66ff00}/cbb|cb - создать бизнес\n" },
    { "{66ff00}/createhouse - создать дом\n" },
    { "{66ff00}/creategarage - создать гараж\n" },
    { "\n" }
};
//-new

//define
#define PNSCS 9

new Float:PnSC[PNSCS][3] = {
    { 720.2800, -457.2757, 16.3359 },
    {-1421.1030, 2584.5122, 55.8433 },
    {-99.8468, 1118.1559, 19.7417 },
    { 2063.5869, -1831.5231, 13.5469 },
    {-2425.7590, 1021.3259, 50.3977 },
    { 1974.2336, 2162.3240, 11.0703 },
    { 487.1933, -1738.4077, 11.1189 },
    { 1025.2147, -1024.2096, 32.1016 },
    {-1904.1440, 283.5843, 41.0469 }
};

#define DIALOG_LOGIN            1
#define DIALOG_REGISTER         2
#define DIALOG_WRONGPAS     3
#define DIALOG_SEX     4
#define DIALOG_REGISTERR         5
#define DIALOG_SPAWN         6
#define DIALOG_ADMINS 7
#define DIALOG_MESHKI 8
#define DIALOG_MESHKII 9
#define DIALOG_MESHKIII 10
#define DIALOG_FERMALSMASH 11
#define DIALOG_FERMALS 12
#define DIALOG_FERMALSINFO 13
#define DIALOG_FERMALSMENU 14
#define DIALOG_FERMALSMENUU 15
#define DIALOG_FERMALSMENUUU 16
#define DIALOG_FERMALSURP 17
#define DIALOG_FERMALSMENUP 18
#define DIALOG_FERMALSPROD 19
#define DIALOG_FERMALSPRODD 20
#define DIALOG_RULES 21
#define DIALOG_FERMALSPRODDP 22
#define DIALOG_FERMALSPRODDPP 23
#define DIALOG_FERMALSPRODA 24
#define DIALOG_FERMALSZERNO 25
#define DIALOG_FERMASFMASH 26
#define DIALOG_HOUSEMENU 27
#define DIALOG_HOUSEINFOO 28
#define DIALOG_HOUSEUL 29
#define DIALOG_HOUSEPROD 30
#define DIALOG_HOUSEPRODD 31
#define DIALOG_HOUSEPRO 32
#define DIALOG_HOUSEPROO 33
#define DIALOG_HOUSEPR 34
#define DIALOG_HOUSEPROOO 35
#define DIALOG_GPS 36
#define DIALOG_GPSONE 37
#define DIALOG_HOUSEINFO 30000
#define DIALOG_HOUSEBUY 31000
#define KEY_AIM 128
#define DYS 50
#define DYS_A 140
#define ICON_GOLOD "hud:radar_diner"
#define PENALTY 1 // 0 - Бан | 1 - Кик | 2 - Оповещение администраторов.
#define COLOR_LIGHTRED          0xFF6347AA
#define COLOR_YELLOW            0xFFFF00AA
#define COLOR_ISPOLZUY 0x7FB151FF
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_SINIY 0x00004FAA
#define COLOR_LG 0x7FFF00FF
#define COLOR_BLUE 0x33AAFFFF
#define COLOR_SALMON 0xFA8072AA
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_KHAKI 0xF0E68CAA
#define COLOR_TEAL 0x008080FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_IVORY 0xFFFF82AA
#define COLOR_TEAL 0x008080FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GRAD7 0xF0F0F0FF
#define COLOR_GRAD8 0xF0F0F0FF
#define COLOR_BLACK 0x000000AA
#define COLOR_GREY 0xAFAFAFAA
#define Statuscolor 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_GRAY 0xAFAFAFAA
#define COLOR_BLUEGREEN 0x46BBAA00
#define COLOR_ORANGE 0xFF9900AA
//#define COLOR_RED 0xAA3333AA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_YELLOW2 0xF5DEB3AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_REDD 0xFF0000AA
#define COLOR_BROW 0xA85400AA
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_DBLUE 0x2641FEAA
#define COLOR_ALLDEPT 0xFF8282AA
#define COLOR_NEWS 0xFFA500AA
#define COLOR_LIFE 0xFEBC41AA
#define COLOR_OOC 0xE0FFFFAA
#define ADMIN_SPEC_TYPE_VEHICLE 2
#define ADMIN_SPEC_TYPE_PLAYER 1
#define ADMIN_SPEC_TYPE_NONE 0
//-define

//forward
forward FixHour(hour);
forward ABroadCast(color, const string[], level);
forward UnfreezePlayer(playerid);
forward UnfreezePlayerr(playa);
forward PickUpAga(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward OnPlayerUpdated(playerid);
forward SendAdminMessage(color, string[]);
forward Meshkii(playerid);
forward AntiOnCar(playerid);
forward Mute(playerid);
forward DeMorgann();
forward NoRoof(playerid);
forward anim2(playerid);
forward CheckHealth(playerid);
forward Bunny(playerid);
forward Hop(playerid);
forward PayDay(playerid);
forward fermalscars(carid);
forward fermasfcars(carid);
forward IsAVelik(carid);
forward ctd(playerid);
forward Unferma(playerid);
forward CheckEngine(carid);
forward AFP(playerid);
forward AirBB(playerid);
forward AntiDMM(playerid);
forward Weather();
forward Fooder();
forward foodcarj(carid);
forward CheckArmour(playerid); //античит на броню
//-forward

public OnGameModeInit() {
    ManualVehicleEngineAndLights();
    EnableStuntBonusForAll(0);
    DisableInteriorEnterExits();
    ConnectMySQL();
    SetGameModeText("Nation RolePlay");
    SendRconCommand("mapname Nation World");
    SetTimer("Loshadka", 10000, 1);
    SetTimer("tFlooder", 10000, 1);
    SetTimer("AFKSystem", 1000, 1);
    SetTimer("AntiOnCar", 1000, 1);
    SetTimer("AFP", 2000, 1);
    LimitPlayerMarkerRadius(100);
    LoadTextDraws();
    SetTimer("CheckHealth", 1000, 1);
    SetTimer("CheckArmour", 1000, 1);
    SetTimer("AirBB", 60000, 1);
    SetTimer("Meshkii", 1000, 1);
    SetTimer("incarr", 10000, 1);
    SetTimer("AntiDMM", 120000, 1);
    SetTimer("Weather", 3600000, 1);
    SetTimer("Fooder", 300000, 1);
    //спидометр
    SPG0 = TextDrawCreate(588.250000, 326.416687, "usebox");
    TextDrawLetterSize(SPG0, 0.000000, 7.137034);
    TextDrawTextSize(SPG0, 441.125000, 0.000000);
    TextDrawAlignment(SPG0, 1);
    TextDrawColor(SPG0, 0);
    TextDrawUseBox(SPG0, true);
    TextDrawBoxColor(SPG0, 102);
    TextDrawSetShadow(SPG0, 0);
    TextDrawSetOutline(SPG0, 0);
    TextDrawFont(SPG0, 0);
    SPG1 = TextDrawCreate(462.625000, 327.000000, "usebox");
    TextDrawLetterSize(SPG1, 0.000000, 6.981945);
    TextDrawTextSize(SPG1, 441.125000, 0.000000);
    TextDrawAlignment(SPG1, 1);
    TextDrawColor(SPG1, 0);
    TextDrawUseBox(SPG1, true);
    TextDrawBoxColor(SPG1, 102);
    TextDrawSetShadow(SPG1, 0);
    TextDrawSetOutline(SPG1, 0);
    TextDrawFont(SPG1, 0);
    //-спидоментр
    BusinessF();
    HouseLoad();
    GarageLoad();
    printf("MAX_PLAYERS = %d", MAX_PLAYERS);
    AllowInteriorWeapons(0);
    new hhh, mmm, sss;
    gettime(hhh, mmm, sss);
    Create3DTextLabel("Информация о ферме\n/finfo", COLOR_BLUE, -98.3798, 51.3281, 5.0188, 60.0, 0, 1);
    Create3DTextLabel("Информация о ферме\n/finfo", COLOR_BLUE, -1060.6987, -1195.5139, 130.5592, 60.0, 0, 1);
    SetWorldTime(hhh);
    for (new i = 1; i < MAX_VEHICLES; i++) VehicleHealth[i] = 1000;
    BusinessQ();
    SetTimer("CheckHArmour", 1000, 1);
    SetTimer("PayDay", 40000, 1);
    SetTimer("Checkhpcar", 1000, true);
    NRPL = TextDrawCreate(500.000000, 2.000000, "Nation RolePlay");
    TextDrawFont(NRPL, 1); //Шрифт текста
    TextDrawLetterSize(NRPL, 0.360000, 2.000000); //Устанавливает ширину и высоту букв.
    TextDrawSetOutline(NRPL, 1); //Добавляем черный контур в текст
    TextDrawColor(NRPL, 0xff0000FF);
    SetTimer("Mute", 1000, 1);
    SetTimer("DeMorgann", 1000, 1);

    PIN11 = TextDrawCreate(320.000000, 180.000000, "Enter");
    TextDrawAlignment(PIN11, 2);
    TextDrawBackgroundColor(PIN11, 255);
    TextDrawFont(PIN11, 2);
    TextDrawLetterSize(PIN11, 0.50000, 0.99999);
    TextDrawColor(PIN11, -1);
    TextDrawSetOutline(PIN11, 0);
    TextDrawSetProportional(PIN11, 1);
    TextDrawSetShadow(PIN11, 1);

    PIN1 = TextDrawCreate(320.000000, 205.000000, "1");
    TextDrawAlignment(PIN1, 2);
    TextDrawBackgroundColor(PIN1, 255);
    TextDrawFont(PIN1, 2);
    TextDrawLetterSize(PIN1, 0.260000, 0.799999);
    TextDrawColor(PIN1, -1);
    TextDrawSetOutline(PIN1, 0);
    TextDrawSetProportional(PIN1, 1);
    TextDrawSetShadow(PIN1, 1);

    PIN2 = TextDrawCreate(320.000000, 230.000000, "2");
    TextDrawAlignment(PIN2, 2);
    TextDrawBackgroundColor(PIN2, 255);
    TextDrawFont(PIN2, 2);
    TextDrawLetterSize(PIN1, 0.260000, 0.799999);
    TextDrawColor(PIN2, -1);
    TextDrawSetOutline(PIN2, 0);
    TextDrawSetProportional(PIN2, 1);
    TextDrawSetShadow(PIN2, 1);

    PIN3 = TextDrawCreate(320.000000, 255.000000, "3");
    TextDrawAlignment(PIN3, 2);
    TextDrawBackgroundColor(PIN3, 255);
    TextDrawFont(PIN3, 2);
    TextDrawLetterSize(PIN3, 0.260000, 0.799999);
    TextDrawColor(PIN3, -1);
    TextDrawSetOutline(PIN3, 0);
    TextDrawSetProportional(PIN3, 1);
    TextDrawSetShadow(PIN3, 1);

    PIN4 = TextDrawCreate(320.000000, 280.000000, "4");
    TextDrawAlignment(PIN4, 2);
    TextDrawBackgroundColor(PIN4, 255);
    TextDrawFont(PIN4, 2);
    TextDrawLetterSize(PIN4, 0.260000, 0.799999);
    TextDrawColor(PIN4, -1);
    TextDrawSetOutline(PIN4, 0);
    TextDrawSetProportional(PIN4, 1);
    TextDrawSetShadow(PIN4, 1);

    PIN5 = TextDrawCreate(320.000000, 305.000000, "5");
    TextDrawAlignment(PIN5, 2);
    TextDrawBackgroundColor(PIN5, 255);
    TextDrawFont(PIN5, 2);
    TextDrawLetterSize(PIN5, 0.260000, 0.799999);
    TextDrawColor(PIN5, -1);
    TextDrawSetOutline(PIN5, 0);
    TextDrawSetProportional(PIN5, 1);
    TextDrawSetShadow(PIN5, 1);

    PIN6 = TextDrawCreate(320.000000, 330.000000, "6");
    TextDrawAlignment(PIN6, 2);
    TextDrawBackgroundColor(PIN6, 255);
    TextDrawFont(PIN6, 2);
    TextDrawLetterSize(PIN6, 0.260000, 0.799999);
    TextDrawColor(PIN6, -1);
    TextDrawSetOutline(PIN6, 0);
    TextDrawSetProportional(PIN6, 1);
    TextDrawSetShadow(PIN6, 1);

    PIN7 = TextDrawCreate(320.000000, 355.000000, "7");
    TextDrawAlignment(PIN7, 2);
    TextDrawBackgroundColor(PIN7, 255);
    TextDrawFont(PIN7, 2);
    TextDrawLetterSize(PIN7, 0.260000, 0.799999);
    TextDrawColor(PIN7, -1);
    TextDrawSetOutline(PIN7, 0);
    TextDrawSetProportional(PIN7, 1);
    TextDrawSetShadow(PIN7, 1);

    PIN8 = TextDrawCreate(320.000000, 380.000000, "8");
    TextDrawAlignment(PIN8, 2);
    TextDrawBackgroundColor(PIN8, 255);
    TextDrawFont(PIN8, 2);
    TextDrawLetterSize(PIN8, 0.260000, 0.799999);
    TextDrawColor(PIN8, -1);
    TextDrawSetOutline(PIN8, 0);
    TextDrawSetProportional(PIN8, 1);
    TextDrawSetShadow(PIN8, 1);

    PIN9 = TextDrawCreate(320.000000, 405.000000, "9");
    TextDrawAlignment(PIN9, 2);
    TextDrawBackgroundColor(PIN9, 255);
    TextDrawFont(PIN9, 2);
    TextDrawLetterSize(PIN9, 0.260000, 0.799999);
    TextDrawColor(PIN9, -1);
    TextDrawSetOutline(PIN9, 0);
    TextDrawSetProportional(PIN9, 1);
    TextDrawSetShadow(PIN9, 1);

    PIN0 = TextDrawCreate(320.000000, 430.000000, "0");
    TextDrawAlignment(PIN0, 2);
    TextDrawBackgroundColor(PIN0, 255);
    TextDrawFont(PIN0, 2);
    TextDrawLetterSize(PIN0, 0.260000, 0.799999);
    TextDrawColor(PIN0, -1);
    TextDrawSetOutline(PIN0, 0);
    TextDrawSetProportional(PIN0, 1);
    TextDrawSetShadow(PIN0, 1);
    TextDrawSetSelectable(PIN11, true);
    TextDrawSetSelectable(PIN1, true);
    TextDrawSetSelectable(PIN2, true);
    TextDrawSetSelectable(PIN3, true);
    TextDrawSetSelectable(PIN4, true);
    TextDrawSetSelectable(PIN5, true);
    TextDrawSetSelectable(PIN6, true);
    TextDrawSetSelectable(PIN7, true);
    TextDrawSetSelectable(PIN8, true);
    TextDrawSetSelectable(PIN9, true);
    TextDrawSetSelectable(PIN0, true);
    //Объекты

    //Спавн бомжей
    CreateDynamicObject(984, 1730.89, -1860.03, 13.13, 0.00, 0.00, 269.69);
    CreateDynamicObject(984, 1745.56, -1860.13, 13.12, 0.00, 0.00, 269.69);
    CreateDynamicObject(984, 1758.32, -1860.19, 13.13, 0.00, 0.00, 269.69);
    CreateDynamicObject(984, 1771.07, -1860.24, 13.13, 0.00, 0.00, 269.69);
    CreateDynamicObject(984, 1783.84, -1860.31, 13.12, 0.00, 0.00, 269.69);
    CreateDynamicObject(984, 1796.63, -1860.41, 13.12, 0.00, 0.00, 269.69);
    CreateDynamicObject(984, 1804.64, -1860.46, 13.13, 0.00, 0.00, 269.69);
    CreateDynamicObject(984, 1811.28, -1866.91, 13.13, 0.00, 0.00, 182.22);
    CreateDynamicObject(984, 1805.12, -1873.39, 13.12, 0.00, 0.00, 90.76);
    CreateDynamicObject(984, 1700.56, -1849.08, 13.16, 0.00, 0.00, 0.00);
    CreateDynamicObject(984, 1700.55, -1863.07, 13.16, 0.00, 0.00, 0.00);
    CreateDynamicObject(984, 1700.56, -1875.88, 13.16, 0.00, 0.00, 0.00);
    CreateDynamicObject(984, 1718.09, -1859.99, 13.12, 0.00, 0.00, 269.69);
    CreateDynamicObject(984, 1706.98, -1859.92, 13.13, 0.00, 0.00, 269.69);
    CreateDynamicObject(984, 1700.15, -1936.04, 13.08, 0.00, 0.00, 359.60);
    CreateDynamicObject(984, 1706.53, -1942.48, 13.08, 0.00, 0.00, 269.69);
    CreateDynamicObject(984, 1720.34, -1942.57, 13.08, 0.00, 0.00, 269.69);

    //-Спавн бомжей
    //СТО бывшие

    CreateDynamicObject(7908, 2071.20, -1830.93, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2070.33, -1830.97, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2069.69, -1831.02, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2069.10, -1831.03, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2068.38, -1831.04, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2067.68, -1831.00, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2067.04, -1830.91, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2066.46, -1830.93, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2065.66, -1831.04, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2064.89, -1831.06, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2064.21, -1831.07, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2063.21, -1831.07, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2062.45, -1831.05, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2061.61, -1831.03, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 2060.84, -1831.07, 12.64, 0.00, 0.00, 269.96);
    CreateDynamicObject(7908, 488.18, -1735.73, 11.44, 0.00, 0.00, 352.57);
    CreateDynamicObject(7908, -2038.96, 174.04, 29.87, 0.00, 0.00, 270.00);
    CreateDynamicObject(7908, -2029.64, 129.15, 29.06, 0.00, 0.00, 0.00);
    CreateDynamicObject(7908, -2103.09, -20.46, 35.75, 0.00, 0.00, 270.00);
    CreateDynamicObject(7908, -1938.03, 238.89, 33.92, 0.00, 0.00, 180.00);
    CreateDynamicObject(7908, -1900.85, 278.30, 41.43, 0.00, 0.00, 180.00);
    CreateDynamicObject(7908, -2430.49, 1027.56, 50.25, 0.00, 0.00, 0.00);
    CreateDynamicObject(7908, 1046.72, -1025.66, 32.58, 0.00, 0.00, 180.00);
    CreateDynamicObject(7908, 1025.40, -1029.10, 31.75, 0.00, 0.00, 180.00);
    CreateDynamicObject(7908, 1968.93, 2164.38, 10.72, 0.00, 0.00, 90.00);
    CreateDynamicObject(7908, 2382.97, 1043.68, 11.61, 0.00, 0.00, 180.00);
    CreateDynamicObject(7908, -2716.40, 218.20, 4.40, 0.00, 0.00, 270.00);
    CreateDynamicObject(7908, -1787.92, 1209.65, 26.03, 0.00, 0.00, 180.00);
    //-СТО бывшие


    //мешки работа
    CreateObject(2060, 2172.89526367, -2256.86108398, 12.46142387, 0.00000000, 0.00000000, 44.00000000);
    CreateObject(2060, 2172.89453125, -2256.86035156, 12.46142387, 0.00000000, 0.00000000, 43.99475098);
    CreateObject(2060, 2172.42309570, -2256.42822266, 12.46099281, 0.00000000, 0.00000000, 47.25003052);
    CreateObject(2060, 2173.31835938, -2257.36694336, 12.46148300, 0.00000000, 0.00000000, 43.75000000);
    CreateObject(2060, 2172.75854492, -2256.49853516, 12.77687645, 0.00000000, 0.00000000, 315.24987793);
    CreateObject(2060, 2172.41381836, -2256.85815430, 12.77693558, 0.00000000, 0.00000000, 316.25000000);
    CreateObject(2060, 2173.61865234, -2257.31201172, 12.77693558, 0.00000000, 0.00000000, 136.00000000);
    CreateObject(2060, 2173.29321289, -2257.70800781, 12.77693558, 0.00000000, 0.00000000, 134.00000000);
    CreateObject(2060, 2173.73193359, -2257.77856445, 12.46504116, 0.00000000, 0.00000000, 42.00000000);
    CreateObject(2060, 2172.61962891, -2256.63281250, 13.09232903, 0.00000000, 0.00000000, 0.00000000);
    CreateObject(2060, 2229.29809570, -2286.05883789, 13.53178787, 0.00000000, 0.00000000, 226.00000000);
    CreateObject(2060, 2229.61987305, -2286.45825195, 13.53178787, 0.00000000, 0.00000000, 45.00000000);
    CreateObject(2060, 2230.00610352, -2286.81738281, 13.53178787, 0.00000000, 0.00000000, 44.00000000);
    CreateObject(2060, 2230.39746094, -2287.23168945, 13.53178787, 0.00000000, 0.00000000, 44.00000000);
    CreateObject(2060, 2229.35400391, -2286.54858398, 13.80724049, 0.00000000, 0.00000000, 134.00000000);
    CreateObject(2060, 2230.20898438, -2286.95312500, 13.82723999, 0.00000000, 0.00000000, 102.00000000);
    gryz1 = CreatePickup(1239, 23, 2137.8227539063, -2282.4379882813, 20.671875, -1);
    gryz2 = CreatePickup(1239, 23, 2127.6430664063, -2275.4113769531, 20.671875, -1);
    gryz3 = CreatePickup(1239, 23, 2182.0974121094, -2252.8625488281, 14.7734375, -1);
    Create3DTextLabel("[Раздевалка]\nВстань на иконку чтобы надеть рабочую одежду", 0x0000FFAA, 2137.8227539063, -2282.4379882813, 20.671875, 40.0, 0, 1);
    Create3DTextLabel("[Касса]\nВстань на иконку чтобы получить зарплату", 0x0000FFAA, 2127.6430664063, -2275.4113769531, 20.671875, 40.0, 0, 1);
    Create3DTextLabel("Помощь по работе", 0x0000FFAA, 2182.0974121094, -2252.8625488281, 14.7734375, 40.0, 0, 1);
    Create3DTextLabel("Помощь по работе", 0xFFFFFFAA, 2182.0974121094, -2252.8625488281, 14.7734375, 40.0, 0, 1);
    //дорога с лс



    //-дорога с лс
    //мешки работа
    CreateDynamicObject(970, 2200.53, -2248.81, 13.09, 0.00, 0.00, 314.76);
    CreateDynamicObject(970, 2203.47, -2251.78, 13.09, 0.00, 0.00, 314.76);
    CreateDynamicObject(970, 2206.42, -2254.75, 13.09, 0.00, 0.00, 314.76);
    CreateDynamicObject(970, 2209.37, -2257.72, 13.09, 0.00, 0.00, 314.76);
    CreateDynamicObject(970, 2214.61, -2262.96, 13.09, 0.00, 0.00, 314.76);

    //-мешки работа
    //ферма лс
    CreateDynamicObject(19458, 1723.48, -2440.47, 9.11, 0.00, 0.00, 0.00);
    CreateDynamicObject(19458, 1718.58, -2426.12, 9.11, 0.00, 0.00, 90.00);
    CreateDynamicObject(19458, 1723.48, -2430.84, 9.11, 0.00, 0.00, 0.00);
    CreateDynamicObject(19458, 1718.58, -242645.98, 9.11, 0.00, 0.00, 90.00);
    CreateDynamicObject(19458, 1718.58, -2445.19, 9.11, 0.00, 0.00, 90.00);
    CreateDynamicObject(19458, 1713.67, -2440.47, 9.11, 0.00, 0.00, 0.00);
    CreateDynamicObject(19458, 1713.67, -2430.84, 9.11, 0.00, 0.00, 0.00);
    CreateDynamicObject(19462, 1718.85, -2449.29, 7.27, 0.00, 90.00, 0.00);
    CreateDynamicObject(19462, 1718.85, -2430.02, 7.27, 0.00, 90.00, 0.00);
    CreateDynamicObject(19462, 1715.35, -2430.04, 7.27, 0.00, 90.00, 0.00);
    CreateDynamicObject(19462, 1722.35, -2430.02, 7.27, 0.00, 90.00, 0.00);
    CreateDynamicObject(19462, 1718.85, -2439.66, 7.27, 0.00, 90.00, 0.00);
    CreateDynamicObject(19462, 1722.35, -2439.66, 7.27, 0.00, 90.00, 0.00);
    CreateDynamicObject(19462, 1715.37, -2439.66, 7.27, 0.00, 90.00, 0.00);
    CreateDynamicObject(19462, 1715.35, -2449.29, 7.27, 0.00, 90.00, 0.00);
    CreateDynamicObject(19462, 1722.35, -2449.29, 7.27, 0.00, 90.00, 0.00);
    CreateDynamicObject(19448, 1721.83, -2430.84, 10.95, 0.00, 90.00, 0.00);
    CreateDynamicObject(19448, 1718.33, -2430.84, 10.95, 0.00, 90.00, 0.00);
    CreateDynamicObject(19448, 1714.83, -2430.84, 10.95, 0.00, 90.00, 0.00);
    CreateDynamicObject(19448, 1714.83, -2440.48, 10.95, 0.00, 90.00, 0.00);
    CreateDynamicObject(19448, 1718.33, -2440.48, 10.95, 0.00, 90.00, 0.00);
    CreateDynamicObject(19448, 1721.83, -2440.48, 10.95, 0.00, 90.00, 0.00);
    CreateDynamicObject(1498, 1713.76, -2440.71, 7.30, 0.00, 0.00, 90.00);
    CreateDynamicObject(2605, 1714.80, -2443.50, 7.80, 0.00, 0.00, 0.00);
    CreateDynamicObject(2607, 1716.77, -2443.48, 7.80, 0.00, 0.00, 180.00);
    CreateDynamicObject(1665, 1715.94, -2443.22, 8.24, 0.00, 0.00, 0.00);
    CreateDynamicObject(1520, 1714.75, -2443.35, 8.27, 0.00, 0.00, 0.00);
    CreateDynamicObject(1520, 1714.49, -2443.26, 8.27, 0.00, 0.00, 0.00);
    CreateDynamicObject(1520, 1714.59, -2443.40, 8.27, 0.00, 0.00, 0.00);
    CreateDynamicObject(19513, 1714.58, -2443.75, 8.21, 0.00, 0.00, -40.00);
    CreateDynamicObject(2161, 1723.37, -2444.24, 7.36, 0.00, 0.00, 270.00);
    CreateDynamicObject(2161, 1723.37, -2444.24, 8.70, 0.00, 0.00, 270.00);
    CreateDynamicObject(2164, 1723.36, -2442.47, 7.36, 0.00, 0.00, -90.00);
    CreateDynamicObject(2163, 1723.37, -2440.70, 7.36, 0.00, 0.00, -90.00);
    CreateDynamicObject(2162, 1723.41, -2440.70, 8.28, 0.00, 0.00, -90.00);
    CreateDynamicObject(1806, 1714.78, -2444.49, 7.36, 0.00, 0.00, 0.00);
    CreateDynamicObject(1806, 1716.75, -2444.49, 7.36, 0.00, 0.00, 0.00);
    CreateDynamicObject(1768, 1717.15, -2434.89, 7.36, 0.00, 0.00, 270.00);
    CreateDynamicObject(2297, 1714.03, -2437.11, 7.36, 0.00, 0.00, 45.00);
    CreateDynamicObject(2231, 1714.28, -2434.52, 7.36, 0.00, 0.00, 45.00);
    CreateDynamicObject(2231, 1713.85, -2437.90, 7.36, 0.00, 0.00, -235.38);
    CreateDynamicObject(2391, 1721.37, -2426.89, 9.02, 0.00, 0.00, 0.00);
    CreateDynamicObject(2391, 1722.69, -2426.89, 9.02, 0.00, 0.00, 0.00);
    CreateDynamicObject(2391, 1722.07, -2426.88, 9.02, 0.00, 0.00, 0.00);
    CreateDynamicObject(2378, 1719.54, -2426.88, 9.02, 0.00, 0.00, 0.00);
    CreateDynamicObject(2378, 1718.83, -2426.89, 9.02, 0.00, 0.00, 0.00);
    CreateDynamicObject(2378, 1720.35, -2426.87, 9.02, 0.00, 0.00, 0.00);
    CreateDynamicObject(2239, 1722.88, -2427.68, 7.36, 0.00, 0.00, 0.00);
    CreateDynamicObject(2202, 1722.90, -2436.72, 7.35, 0.00, 0.00, 270.00);
    CreateDynamicObject(2280, 1716.27, -2426.77, 9.00, 0.00, 0.00, 0.00);
    CreateDynamicObject(2276, 1722.90, -2434.48, 9.00, 0.00, 0.00, 270.00);
    CreateDynamicObject(2276, 1716.79, -2426.42, 7.36, 0.00, 0.00, 0.00);
    CreateDynamicObject(2708, 1721.33, -2426.48, 7.36, 0.00, 0.00, 0.00);
    CreateDynamicObject(2708, 1718.85, -2426.47, 7.36, 0.00, 0.00, 0.00);

    CreateDynamicObject(17005, -88.26, 55.01, 10.05, 0.00, 0.00, 161.40);
    CreateDynamicObject(1498, -93.50, 63.79, 2.97, 0.00, 0.00, 251.75);
    //-ферма лс
    //24/7
    CreateDynamicObject(19454, 1730.94, -2466.51, 7.35, 0.00, 90.00, 0.00);
    CreateDynamicObject(19454, 1734.44, -2476.14, 7.35, 0.00, 90.00, 0.00);
    CreateDynamicObject(19454, 1734.44, -2466.51, 7.35, 0.00, 90.00, 0.00);
    CreateDynamicObject(19454, 1730.94, -2476.14, 7.35, 0.00, 90.00, 0.00);
    CreateDynamicObject(19454, 1737.94, -2476.14, 7.35, 0.00, 90.00, 0.00);
    CreateDynamicObject(19454, 1737.94, -2466.52, 7.35, 0.00, 90.00, 0.00);
    CreateDynamicObject(19450, -3737.09, 5908.14, -2148.59, 0.00, 0.00, 0.00);
    CreateDynamicObject(19450, 1729.28, -2466.51, 9.02, 0.00, 0.00, 0.00);
    CreateDynamicObject(19450, 1729.28, -2476.14, 9.02, 0.00, 0.00, 0.00);
    CreateDynamicObject(19450, 1734.04, -2480.87, 9.02, 0.00, 0.00, 90.00);
    CreateDynamicObject(19450, 1738.91, -2480.87, 9.02, 0.00, 0.00, 90.00);
    CreateDynamicObject(19450, 1739.60, -2476.14, 9.02, 0.00, 0.00, 0.00);
    CreateDynamicObject(19450, 1739.60, -2466.50, 9.02, 0.00, 0.00, 0.00);
    CreateDynamicObject(19450, 1734.03, -2461.78, 9.02, 0.00, 0.00, 90.00);
    CreateDynamicObject(19450, 1743.66, -2461.78, 9.02, 0.00, 0.00, 90.00);
    CreateDynamicObject(19454, 1734.44, -2466.51, 10.86, 0.00, 90.00, 0.00);
    CreateDynamicObject(19454, 1730.94, -2466.51, 10.86, 0.00, 90.00, 0.00);
    CreateDynamicObject(19454, 1737.94, -2466.52, 10.86, 0.00, 90.00, 0.00);
    CreateDynamicObject(19454, 1730.94, -2476.14, 10.86, 0.00, 90.00, 0.00);
    CreateDynamicObject(19454, 1734.44, -2476.14, 10.86, 0.00, 90.00, 0.00);
    CreateDynamicObject(19454, 1737.94, -2476.14, 10.86, 0.00, 90.00, 0.00);
    CreateDynamicObject(2448, 1737.58, -2462.15, 7.44, 0.00, 0.00, 0.00);
    CreateDynamicObject(2453, 1739.01, -2462.29, 9.42, 0.00, 0.00, 30.00);
    CreateDynamicObject(1843, 1735.60, -2462.31, 7.44, 0.00, 0.00, 0.00);
    CreateDynamicObject(1984, 1736.96, -2478.88, 7.44, 0.00, 0.00, 0.00);
    CreateDynamicObject(1983, 1730.23, -2462.39, 7.44, 0.00, 0.00, 0.00);
    CreateDynamicObject(2543, 1739.01, -2467.04, 7.44, 0.00, 0.00, 270.00);
    CreateDynamicObject(2583, 1739.26, -2468.30, 8.27, 0.00, 0.00, 270.00);
    CreateDynamicObject(2582, 1739.25, -2469.78, 8.28, 0.00, 0.00, 270.00);
    CreateDynamicObject(1560, 1734.69, -2480.75, 7.44, 0.00, 0.00, 180.00);
    CreateDynamicObject(1847, 1729.90, -2467.39, 7.44, 0.00, 0.00, 90.00);
    CreateDynamicObject(1848, 1729.90, -2472.36, 7.44, 0.00, 0.00, 90.00);
    CreateDynamicObject(1885, 1735.98, -2478.75, 7.44, 0.00, 0.00, 0.00);
    CreateDynamicObject(1981, 1738.99, -2471.08, 7.44, 0.00, 0.00, 270.00);
    CreateDynamicObject(2585, 1731.18, -2480.67, 8.96, 0.00, 0.00, 180.00);
    CreateDynamicObject(1890, 1734.45, -2468.38, 7.44, 0.00, 0.00, 0.00);
    CreateDynamicObject(1899, 1733.30, -2467.76, 7.81, 0.00, 0.00, 0.00);
    CreateDynamicObject(1889, 1734.44, -2473.04, 7.44, 0.00, 0.00, 0.00);
    CreateDynamicObject(1844, 1732.57, -2462.29, 7.44, 0.00, 0.00, 0.00);
    CreateDynamicObject(1844, 1729.88, -2476.46, 7.44, 0.00, 0.00, 90.00);

    //-24/7
    //ДеМорган
    CreateDynamicObject(18759, -655.18, 2719.91, 303.32, 0.00, 0.00, 0.00, 7000);
    //-ДеМорган
    //-Объекты
    //ферма лс
    fermalspickup = CreatePickup(1275, 23, 1721.9370, -2428.1897, 8.2847, 1001);
    fermalspickupzp = CreateDynamicPickup(1274, 23, 1714.6017, -2442.9399, 8.1798, 1001);
    Create3DTextLabel("Смена одежды", COLOR_BLUE, 1721.7898, -2428.2476, 8.6927, 60.0, 1001, 1);
    Create3DTextLabel("Получить заработную плату", COLOR_BLUE, 1714.7631, -2442.9763, 8.4415, 60.0, 1001, 1);
    fermalscar[0] = AddStaticVehicleEx(478, -96.7934, 84.2924, 3.4387, 249.6301, -1, -1, 60000);
    AddStaticVehicleEx(478, -95.6362, 86.9229, 3.4387, 249.6301, -1, -1, 60000);
    AddStaticVehicleEx(478, -94.6074, 89.6912, 3.4387, 249.6301, -1, -1, 60000);
    AddStaticVehicleEx(478, -93.5120, 92.2935, 3.4387, 249.6301, -1, -1, 60000);
    AddStaticVehicleEx(478, -92.3664, 95.1512, 3.4387, 249.6301, -1, -1, 60000);
    AddStaticVehicleEx(478, -91.0670, 98.5696, 3.4387, 249.6301, -1, -1, 60000);
    AddStaticVehicleEx(478, -89.6363, 102.1797, 3.4387, 249.6301, -1, -1, 60000);
    AddStaticVehicleEx(532, -89.5087, 111.0290, 4.0216, 249.9037, -1, -1, 60000);
    fermalscar[1] = AddStaticVehicleEx(478, -88.4383, 105.0026, 3.4387, 249.6301, -1, -1, 60000);
    //-ферма лс
    //ферма сф
    fermasfpickup = CreatePickup(1275, 23, 1721.9370, -2428.1897, 8.2847, 1002);
    fermasfpickupzp = CreateDynamicPickup(1274, 23, 1714.6017, -2442.9399, 8.1798, 1002);
    Create3DTextLabel("Смена одежды", COLOR_BLUE, 1721.7898, -2428.2476, 8.6927, 60.0, 1002, 1);
    Create3DTextLabel("Получить заработную плату", COLOR_BLUE, 1714.7631, -2442.9763, 8.4415, 60.0, 1002, 1);
    fermasfcar[0] = AddStaticVehicleEx(478, -1058.9772, -1179.2850, 129.5483, 270.4050, -1, -1, 60000);
    AddStaticVehicleEx(478, -1058.8418, -1176.0680, 129.5483, 270.4050, -1, -1, 60000);
    AddStaticVehicleEx(478, -1058.3634, -1172.8436, 129.5483, 270.4050, -1, -1, 60000);
    AddStaticVehicleEx(478, -1058.1461, -1169.3367, 129.5483, 270.4050, -1, -1, 60000);
    AddStaticVehicleEx(478, -1059.0747, -1182.6219, 129.5483, 270.4050, -1, -1, 60000);
    AddStaticVehicleEx(478, -1057.8381, -1166.1143, 129.5483, 270.4050, -1, -1, 60000);
    AddStaticVehicleEx(478, -1057.7711, -1162.5540, 129.5483, 270.4050, -1, -1, 60000);
    fermasfcar[1] = AddStaticVehicleEx(532, -1035.4625, -1168.5667, 130.0514, 92.7335, -1, -1, 60000);
    //-ферма сф
    //Стоянки машин для продажи еды
    foodcar[0] = AddStaticVehicleEx(423, 1198.3890, -1835.9216, 13.5121, 268.5913, -1, -1, 100);
    AddStaticVehicleEx(423, 1198.6525, -1832.0675, 13.5121, 268.5913, -1, -1, 100);
    AddStaticVehicleEx(423, 1198.8307, -1827.4922, 13.5121, 268.5913, -1, -1, 100);
    AddStaticVehicleEx(588, 1262.4838, -1798.6349, 13.6322, 180.0000, -1, -1, 100);
    AddStaticVehicleEx(588, 1268.8436, -1798.9473, 13.6322, 180.0000, -1, -1, 100);
    AddStaticVehicleEx(588, 1274.3889, -1799.1482, 13.6322, 180.0000, -1, -1, 100);
    AddStaticVehicleEx(588, 1280.1616, -1799.5062, 13.6322, 180.0000, -1, -1, 100);
    AddStaticVehicleEx(423, 1279.5129, -1835.3955, 13.4844, 90.0000, -1, -1, 100);
    AddStaticVehicleEx(423, 1279.4332, -1829.5342, 13.4844, 90.0000, -1, -1, 100);
    AddStaticVehicleEx(423, 1279.4034, -1823.7047, 13.4844, 90.0000, -1, -1, 100);
    AddStaticVehicleEx(423, 1279.4209, -1817.4093, 13.4844, 90.0000, -1, -1, 100);
    AddStaticVehicleEx(423, -2355.9529, -126.2954, 35.5286, 178.8322, -1, -1, 100);
    AddStaticVehicleEx(423, -2352.2666, -126.3316, 35.5286, 178.8322, -1, -1, 100);
    AddStaticVehicleEx(423, -2326.2251, -126.9402, 35.5286, 178.8322, -1, -1, 100);
    AddStaticVehicleEx(423, -2337.1199, -126.6969, 35.5286, 178.8322, -1, -1, 100);
    AddStaticVehicleEx(588, -2348.3508, -125.8806, 35.5357, 180.0000, -1, -1, 100);
    AddStaticVehicleEx(588, -2344.5078, -125.8564, 35.5357, 180.0000, -1, -1, 100);
    AddStaticVehicleEx(588, -2340.7349, -125.7782, 35.5357, 180.0000, -1, -1, 100);
    AddStaticVehicleEx(588, -2333.6479, -125.9830, 35.5357, 180.0000, -1, -1, 100);
    AddStaticVehicleEx(588, -2329.9976, -126.0136, 35.5357, 180.0000, -1, -1, 100);
    AddStaticVehicleEx(588, -2322.4475, -126.3400, 35.5357, 180.0000, -1, -1, 100);
    AddStaticVehicleEx(588, -2318.7935, -126.5646, 35.5357, 180.0000, -1, -1, 100);
    AddStaticVehicleEx(588, -2315.0078, -126.6603, 35.5357, 180.0000, -1, -1, 100);
    AddStaticVehicleEx(588, 2441.5466, 2017.3524, 10.9190, 270.2562, -1, -1, 100);
    AddStaticVehicleEx(588, 2441.4775, 2009.4860, 10.9190, 270.2562, -1, -1, 100);
    AddStaticVehicleEx(588, 2449.0566, 1991.7170, 10.9190, 359.8215, -1, -1, 100);
    AddStaticVehicleEx(588, 2467.5154, 1991.8914, 10.9190, 359.8215, -1, -1, 100);
    AddStaticVehicleEx(588, 2481.4150, 1991.7443, 10.9190, 359.8215, -1, -1, 100);
    AddStaticVehicleEx(423, 2476.8748, 1992.5228, 11.2069, 0.0000, -1, -1, 100);
    AddStaticVehicleEx(423, 2472.0872, 1993.1730, 11.2069, 0.0000, -1, -1, 100);
    AddStaticVehicleEx(423, 2459.0027, 1993.5812, 11.2069, 0.0000, -1, -1, 100);
    foodcar[1] = AddStaticVehicleEx(423, 1279.6936, -1811.9170, 13.4844, 90.0000, -1, -1, 100);
    //-Стоянки машин для продажи еды
    for (new i = 0; i < MAX_VEHICLES; i++) { if (!IsAVelik(i)) { SetVehicleParamsEx(i, false, false, false, false, false, false, false); } else { SetVehicleParamsEx(i, true, false, false, false, false, false, false); } }
    for (new i = 0; i < MAX_VEHICLES; i++) {
        VehicleInfo[i][vFuel] = 30;
        VehicleHealth[i] = 1000;
        VehicleInfo[i][Stop] = true;
    }
    return 1;
}

public OnGameModeExit() {
    for (new i = 0; i < MAX_PLAYERS; i++) {
        SaveAccount(i);
    }
    for (new i = 0; i < MAX_PLAYERS; i++) {
        Statuss(i);
    }
    BusinessSave();
    FermaSave();
    HouseSave();
    TextDrawDestroy(PIN11);
    TextDrawDestroy(PIN1);
    TextDrawDestroy(PIN2);
    TextDrawDestroy(PIN3);
    TextDrawDestroy(PIN4);
    TextDrawDestroy(PIN5);
    TextDrawDestroy(PIN6);
    TextDrawDestroy(PIN8);
    TextDrawDestroy(PIN9);
    TextDrawDestroy(PIN0);
    DisconnectMySQL();


    return 1;
}
stock SPD(playerid, dialogid, style, caption[], info[], button1[], button2[]) {
    ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
    SetPVarInt(playerid, "USEDIALOGID", dialogid);
    return 1;
}
#define ShowPlayerDialog SPD
public OnPlayerRequestClass(playerid, classid) {

    SetSpawnInfo(playerid, 255, 0, PlayerInfo[playerid][Skin], 10, 0, 0, 0, 0, 0, 0, 0, 0);
    SendClientMessage(playerid, COLOR_ORANGE, "Добро пожаловать на Nation RolePlay!");
    return SpawnPlayer(playerid);

}

public OnPlayerConnect(playerid) {
    AirB[playerid] = 0;
    FermaLSKust[playerid] = 0;
    Spawner[playerid] = 1;
    Mmoney[playerid] = 0;
    ClothesRound[playerid] = 0;
    NewSpawn[playerid] = 0;
    tFlood[playerid] = 0;
    FermaLSKustt[playerid] = 0;
    PlayerVehicleId[playerid] = 0;
    SpawnReg[playerid] = 0;
    playb[playerid] = 0;
    FermaID[playerid] = 50000;
    HouseID[playerid] = 50000;
    cbbb[playerid] = 0;
    FermaLSKustPP[playerid] = 0;
    FermaLSKustPPS[playerid] = 0;
    PickUp[playerid] = 0;
    FermaLSKustP[playerid] = 0;
    fermalsstatus[playerid] = 0;
    PlayerHealth[playerid] = 0;
    AntiDM[playerid] = 0;
    AntiCarHP[playerid] = 0;
    FermaLSCR[playerid] = 0;
    PlayerArmour[playerid] = 0;
    APin[playerid] = 0;
    FermaLSCRC[playerid] = 0;
    fermalszp[playerid] = 0;
    times[playerid] = true;
    strrs[playerid] = 0;

    SetTimerEx("Unferma", 5000, false, "i", playerid);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, 1, 0, 0, 0, 0);
    for (new i = 0; i < 47; i++) Weapons[playerid][i] = 0; //обнуление
    //автоматы с едой
    // Лос-Сантос
    RemoveBuildingForPlayer(playerid, 956, 2480.8594, -1959.2734, 12.9609, 0.1); // Чипсы возле малого аммо
    RemoveBuildingForPlayer(playerid, 955, 1928.7344, -1772.4453, 12.9453, 0.1); // Старый, Спранк на заправке
    RemoveBuildingForPlayer(playerid, 955, 1729.7891, -1943.0469, 12.9453, 0.1); // Старый, на Юнити Стейшн
    RemoveBuildingForPlayer(playerid, 955, 1789.2109, -1369.2656, 15.1641, 0.1); // Старый, за экстрим-парком

    // San-Fierro
    RemoveBuildingForPlayer(playerid, 956, -2229.1875, 286.4141, 34.7031, 0.1); // Чипсы на парковке за стройкой
    RemoveBuildingForPlayer(playerid, 955, -1980.7891, 142.6641, 27.0703, 0.1); // Старый, вокзал
    RemoveBuildingForPlayer(playerid, 955, -2118.6172, -422.4141, 34.7266, 0.1); // Старый, Стадион
    RemoveBuildingForPlayer(playerid, 955, -2118.9688, -423.6484, 34.7266, 0.1); // Старый 2, Стадион
    RemoveBuildingForPlayer(playerid, 1209, -2420.2188, 984.5781, 44.2969, 0.1); // CODA возле p'n's возле Jizzy
    RemoveBuildingForPlayer(playerid, 1302, -2420.1797, 985.9453, 44.2969, 0.1); // CODA 2 возле p'n's возле Jizzy

    // Лас-Вентурас
    RemoveBuildingForPlayer(playerid, 956, 2845.7266, 1295.0469, 10.7891, 0.1); // Чипсы, вокзал
    RemoveBuildingForPlayer(playerid, 955, 2085.7734, 2071.3594, 10.4531, 0.1); // Старый, Секс-шоп
    RemoveBuildingForPlayer(playerid, 955, 2319.9922, 2532.8516, 10.2188, 0.1); // Старый, Полицейский участок
    RemoveBuildingForPlayer(playerid, 955, 1520.1484, 1055.2656, 10.0000, 0.1); // Старый, за аэропортом (2 база дальнобойщиков)

    // Интерьеры
    RemoveBuildingForPlayer(playerid, 1776, 500.5625, -1.3672, 1000.7344, 0.1); // Чипсы, Альхамбра (в углу)
    RemoveBuildingForPlayer(playerid, 1775, 495.9688, -24.3203, 1000.7344, 0.1); // Новый, Альхамбра (вход)
    RemoveBuildingForPlayer(playerid, 1775, 501.8281, -1.4297, 1000.7344, 0.1); // Новый, Альхамбра (в углу)

    RemoveBuildingForPlayer(playerid, 1776, -33.8750, -186.7656, 1003.6328, 0.1); // Чипсы, 24/7
    RemoveBuildingForPlayer(playerid, 1775, -32.4453, -186.6953, 1003.6328, 0.1); // Новый, 24/7

    RemoveBuildingForPlayer(playerid, 1776, -16.5313, -140.2969, 1003.6328, 0.1); // Чипсы, 24/7
    RemoveBuildingForPlayer(playerid, 1775, -35.7266, -140.2266, 1003.6328, 0.1); // Новый, 24/7
    RemoveBuildingForPlayer(playerid, 1775, -15.1016, -140.2266, 1003.6328, 0.1); // Новый, 24/7

    RemoveBuildingForPlayer(playerid, 1776, -17.5469, -91.7109, 1003.6328, 0.1); // Чипсы, 24/7
    RemoveBuildingForPlayer(playerid, 1775, -16.1172, -91.6406, 1003.6328, 0.1); // Новый, 24/7

    RemoveBuildingForPlayer(playerid, 1776, -36.1484, -57.8750, 1003.6328, 0.1); // Чипсы, 24/7
    RemoveBuildingForPlayer(playerid, 1775, -19.0391, -57.8359, 1003.6328, 0.1); // Новый, 24/7

    RemoveBuildingForPlayer(playerid, 1776, 374.8906, 188.9766, 1008.4766, 0.1); // чипсы, Архитекторская
    RemoveBuildingForPlayer(playerid, 1776, 350.9063, 206.0859, 1008.4766, 0.1); // чипсы, Архитекторская
    //-автоматы с едой
    TextDrawShowForPlayer(playerid, NRPL);
    plafk[playerid] = -2;
    PlayerInfo[playerid][Logged] = false;
    PINN0[playerid] = 0;
    PINN1[playerid] = 0;
    PINN2[playerid] = 0;
    PINN3[playerid] = 0;
    PINN4[playerid] = 0;
    PINN5[playerid] = 0;
    PINN6[playerid] = 0;
    PINN7[playerid] = 0;
    PINN8[playerid] = 0;
    PINN9[playerid] = 0;
    lcarid[playerid] = 65000;

    //спидометр
    SP0[playerid] = CreatePlayerTextDraw(playerid, 463.125000, 331.916656, "SPEED:");
    PlayerTextDrawLetterSize(playerid, SP0[playerid], 0.449999, 1.600000);
    PlayerTextDrawAlignment(playerid, SP0[playerid], 1);
    PlayerTextDrawColor(playerid, SP0[playerid], -2139062017);
    PlayerTextDrawSetShadow(playerid, SP0[playerid], 0);
    PlayerTextDrawSetOutline(playerid, SP0[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, SP0[playerid], 51);
    PlayerTextDrawFont(playerid, SP0[playerid], 2);
    PlayerTextDrawSetProportional(playerid, SP0[playerid], 1);

    SP1[playerid] = CreatePlayerTextDraw(playerid, 464.375000, 351.166595, "FUEL:");
    PlayerTextDrawLetterSize(playerid, SP1[playerid], 0.449999, 1.600000);
    PlayerTextDrawAlignment(playerid, SP1[playerid], 1);
    PlayerTextDrawColor(playerid, SP1[playerid], -2139062017);
    PlayerTextDrawSetShadow(playerid, SP1[playerid], 0);
    PlayerTextDrawSetOutline(playerid, SP1[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, SP1[playerid], 51);
    PlayerTextDrawFont(playerid, SP1[playerid], 2);
    PlayerTextDrawSetProportional(playerid, SP1[playerid], 1);

    SP2[playerid] = CreatePlayerTextDraw(playerid, 540.625000, 332.499908, "10");
    PlayerTextDrawLetterSize(playerid, SP2[playerid], 0.449999, 1.600000);
    PlayerTextDrawAlignment(playerid, SP2[playerid], 1);
    PlayerTextDrawColor(playerid, SP2[playerid], -1);
    PlayerTextDrawSetShadow(playerid, SP2[playerid], 0);
    PlayerTextDrawSetOutline(playerid, SP2[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, SP2[playerid], 51);
    PlayerTextDrawFont(playerid, SP2[playerid], 2);
    PlayerTextDrawSetProportional(playerid, SP2[playerid], 1);

    SP3[playerid] = CreatePlayerTextDraw(playerid, 541.250000, 351.750030, "10");
    PlayerTextDrawLetterSize(playerid, SP3[playerid], 0.449999, 1.600000);
    PlayerTextDrawAlignment(playerid, SP3[playerid], 1);
    PlayerTextDrawColor(playerid, SP3[playerid], -1);
    PlayerTextDrawSetShadow(playerid, SP3[playerid], 0);
    PlayerTextDrawSetOutline(playerid, SP3[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, SP3[playerid], 51);
    PlayerTextDrawFont(playerid, SP3[playerid], 2);
    PlayerTextDrawSetProportional(playerid, SP3[playerid], 1);

    SP4[playerid] = CreatePlayerTextDraw(playerid, 446.250000, 331.916748, "L");
    PlayerTextDrawLetterSize(playerid, SP4[playerid], 0.449999, 1.600000);
    PlayerTextDrawAlignment(playerid, SP4[playerid], 1);
    PlayerTextDrawColor(playerid, SP4[playerid], -16776961);
    PlayerTextDrawSetShadow(playerid, SP4[playerid], 0);
    PlayerTextDrawSetOutline(playerid, SP4[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, SP4[playerid], 51);
    PlayerTextDrawFont(playerid, SP4[playerid], 2);
    PlayerTextDrawSetProportional(playerid, SP4[playerid], 1);

    SP5[playerid] = CreatePlayerTextDraw(playerid, 446.250000, 350.583435, "E");
    PlayerTextDrawLetterSize(playerid, SP5[playerid], 0.449999, 1.600000);
    PlayerTextDrawAlignment(playerid, SP5[playerid], 1);
    PlayerTextDrawColor(playerid, SP5[playerid], -16776961);
    PlayerTextDrawSetShadow(playerid, SP5[playerid], 0);
    PlayerTextDrawSetOutline(playerid, SP5[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, SP5[playerid], 51);
    PlayerTextDrawFont(playerid, SP5[playerid], 2);
    PlayerTextDrawSetProportional(playerid, SP5[playerid], 1);

    SP6[playerid] = CreatePlayerTextDraw(playerid, 446.250000, 369.250000, "S");
    PlayerTextDrawLetterSize(playerid, SP6[playerid], 0.449999, 1.600000);
    PlayerTextDrawAlignment(playerid, SP6[playerid], 1);
    PlayerTextDrawColor(playerid, SP6[playerid], -16776961);
    PlayerTextDrawSetShadow(playerid, SP6[playerid], 0);
    PlayerTextDrawSetOutline(playerid, SP6[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, SP6[playerid], 51);
    PlayerTextDrawFont(playerid, SP6[playerid], 2);
    PlayerTextDrawSetProportional(playerid, SP6[playerid], 1);

    SP7[playerid] = CreatePlayerTextDraw(playerid, 465.625000, 370.416717, "HEALTH:");
    PlayerTextDrawLetterSize(playerid, SP7[playerid], 0.449999, 1.600000);
    PlayerTextDrawAlignment(playerid, SP7[playerid], 1);
    PlayerTextDrawColor(playerid, SP7[playerid], -1);
    PlayerTextDrawSetShadow(playerid, SP7[playerid], 0);
    PlayerTextDrawSetOutline(playerid, SP7[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, SP7[playerid], 51);
    PlayerTextDrawFont(playerid, SP7[playerid], 1);
    PlayerTextDrawSetProportional(playerid, SP7[playerid], 1);

    SP8[playerid] = CreatePlayerTextDraw(playerid, 541.250000, 370.416625, "1000");
    PlayerTextDrawLetterSize(playerid, SP8[playerid], 0.449999, 1.600000);
    PlayerTextDrawAlignment(playerid, SP8[playerid], 1);
    PlayerTextDrawColor(playerid, SP8[playerid], -1);
    PlayerTextDrawSetShadow(playerid, SP8[playerid], 0);
    PlayerTextDrawSetOutline(playerid, SP8[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, SP8[playerid], 51);
    PlayerTextDrawFont(playerid, SP8[playerid], 1);
    PlayerTextDrawSetProportional(playerid, SP8[playerid], 1);


    //-спидометр


    if (strfind(PlayerName(playerid), "_", true) == -1) SendClientMessage(playerid, 0xFFFFFFAA, "Ваш никнейм(имя) не корректно, верный пример - Имя_Фамилия") && lKick(playerid);
    RemovePlayerVariables(playerid);
    PosTimer[playerid] = SetTimerEx("OnPlayerUpdated", 1100, true, "d", playerid);

    //------------------------------------------------------------------------------
    GetPlayerName(playerid, PlayerInfo[playerid][Name], MAX_PLAYER_NAME);
    //------------------------------------------------------------------------------

    ClearAnimations(playerid);
    return 1;
}

public OnPlayerDisconnect(playerid, reason) {
    SaveAccount(playerid);
    Statuss(playerid);
    RemovePlayerVariables(playerid);
    BigEar[playerid] = 0;
    AntiFly[playerid] = 0;
    playb[playerid] = 0;
    SpawnC[playerid] = 0;
    fermasfstatus[playerid] = 0;
    DestroyVehicle(lcarid[playerid]);
    lcarid[playerid] = 0;
    Inter[playerid] = 0;
    incar[playerid] = 0;
    gpsmetkaX[playerid] = 0;
    gpsmetkaY[playerid] = 0;
    gpsmetkaZ[playerid] = 0;
    PlayerInfo[playerid][Emailaccount] = 0;
    PlayerInfo[playerid][Passwordaccount] = 0;
    CenInt[playerid] = 0;
    JobInfo[playerid][Money] = 0;
    JobInfo[playerid][Status] = false;
    JobInfo[playerid][ID] = 0;
    slapd[playerid] = 0;
    FermaProd[playerid] = 0;
    FermaID[playerid] = 0;
    InterN[playerid] = 0;
    SpawnMZ[playerid] = 0;
    for (new io = 0; io < MAX_PLAYER_ATTACHED_OBJECTS; io++) {
        if (IsPlayerAttachedObjectSlotUsed(playerid, io)) RemovePlayerAttachedObject(playerid, io);
    }
    for (new is = 1; is <= 40; is++) {
        Weapons[playerid][is] = 0;
    }
    ClothesRound[playerid] = 0;
    kick_gTimer[playerid] = 0;
    ChosenSkin[playerid] = 0;
    SelectCharRegID[playerid] = 0;
    NewSpawn[playerid] = 0;
    HouseID[playerid] = 0;
    HouseSum[playerid] = 0;
    HouseProd[playerid] = 0;
    SetPos(playerid, 0, 0, 0);
    Mmoney[playerid] = 0;
    KillTimer(Login[playerid]);
    fermalszp[playerid] = 0;
    fermasfzp[playerid] = 0;
    fermalsstatus[playerid] = 0;
    Spawner[playerid] = 0;
    AntiCarHP[playerid] = 0;
    playb[playerid] = 0;
    SpawnReg[playerid] = 0;
    PlayerInJob[playerid] = 0;
    Meshok[playerid] = 0;
    Meshki[playerid] = 0;
    cbbb[playerid] = 0;
    strrs[playerid] = 0;
    PINN0[playerid] = 0;
    PINN1[playerid] = 0;
    PINN2[playerid] = 0;
    PINN3[playerid] = 0;
    PINN4[playerid] = 0;
    PINN5[playerid] = 0;
    PINN6[playerid] = 0;
    PINN7[playerid] = 0;
    PINN8[playerid] = 0;
    PINN9[playerid] = 0;
    TextDrawHideForPlayer(playerid, SPG0);
    TextDrawHideForPlayer(playerid, SPG1);
    PlayerTextDrawHide(playerid, SP0[playerid]);
    PlayerTextDrawHide(playerid, SP1[playerid]);
    PlayerTextDrawHide(playerid, SP2[playerid]);
    PlayerTextDrawHide(playerid, SP3[playerid]);
    PlayerTextDrawHide(playerid, SP4[playerid]);
    PlayerTextDrawHide(playerid, SP5[playerid]);
    PlayerTextDrawHide(playerid, SP6[playerid]);
    PlayerTextDrawHide(playerid, SP7[playerid]);
    PlayerTextDrawHide(playerid, SP8[playerid]);
    KillTimer(SpeedTimer[playerid]);
    Oldskin2[playerid] = 0;
    KillTimer(PosTimer[playerid]);
    PlayerInfo[playerid][Logged] = false;



    return 1;
}

public OnPlayerSpawn(playerid) {
    plafk[playerid] = 0;
    SetPos(playerid, 2112.27, 2149.96, 6.17);
    SetPVarInt(playerid, "CheckSpawn", 1);
    SetPVarInt(playerid, "K_T", 0);
    SetPlayerHealthACC(playerid, 100);
    Weapons[playerid][24] = GivePlayerWeapon(playerid, 24, 100);
    Weapons[playerid][31] = GivePlayerWeapon(playerid, 31, 100);
    Weapons[playerid][25] = GivePlayerWeapon(playerid, 25, 100);
    Weapons[playerid][43] = GivePlayerWeapon(playerid, 43, 100);
    //SetPlayerArmourAC(playerid, 0);
    if (Spawner[playerid] == 1) {
        SetPlayerCameraLookAt(playerid, 2145.27, 2149.96, 36.17);
        SetPlayerCameraPos(playerid, 2115.27, 2149.96, 36.17);
        SetPlayerVirtualWorld(playerid, playerid);
        SetPlayerInterior(playerid, 0);
        if (mysql_ping() != -1) {
            if (GetAccountID(playerid)) { // Аккаунт зарегистрирован
                new dialog[128 + MAX_PLAYER_NAME];
                format(dialog, sizeof(dialog),
                    "Добро пожаловать!\n\
                        Этот аккаунт зарегистрирован.\n\n\
                        Логин: %s\n\
                        Введите пароль:",
                    PlayerInfo[playerid][Name]);
                ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Авторизация", dialog, "Войти", "Отмена");
                Login[playerid] = SetTimerEx("UnLogin", 60000, false, "i", playerid);
            } else { // Аккаунт не зарегистрирован (return 0, в функции GetAccountID, т.е. не нашло записи с аккаунтом).

                new dialog[280 + MAX_PLAYER_NAME];
                format(dialog, sizeof(dialog),
                    "Добро пожаловать!\n\
                    	Этот аккаунт не зарегистрирован.\n\n\
                    	Логин: %s\n\
                        Введите пароль и нажмите \"Далее\".\n\n\
                        Примечания:\n\
                        - Пароль чувствительный к регистру.\n\
                   	 	- Длина пароля от 6 до 32 символов.\n\
                    	- В пароле можно использовать символы на латинице и цифры.\n", PlayerInfo[playerid][Name]);
                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Регистрация", dialog, "Далее", "Отмена");
            }
        }
    }
    if (ClothesRound[playerid] == 2) {
        TogglePlayerControllable(playerid, 0);
        SetPlayerVirtualWorld(playerid, playerid);
        SetPlayerInterior(playerid, 0);
        SetPos(playerid, 1708.1248, -1930.9232, 1.6515);
        SetPlayerFacingAngle(playerid, 360);
        SetPlayerCameraPos(playerid, 1631.62, -1762.24, 110.61);
        SetPlayerCameraLookAt(playerid, 1631.62, -1762.24, 110.61);

    }
    if (ClothesRound[playerid] == 1) {
        TogglePlayerControllable(playerid, 0);
        SetPlayerVirtualWorld(playerid, playerid);
        SetPlayerInterior(playerid, 0);
        SetPos(playerid, 1708.1248, -1930.9232, 13.6515);
        SetPlayerFacingAngle(playerid, 360);
        SetPlayerCameraPos(playerid, 1707.7800, -1925.4385, 14.9881);
        SetPlayerCameraLookAt(playerid, 1708.1248, -1930.9232, 13.6515);

        TextDrawShowForPlayer(playerid, ButtonLeft);
        TextDrawShowForPlayer(playerid, ButtonRight);
        TextDrawShowForPlayer(playerid, ButtonSelect);
        SelectTextDraw(playerid, 0xFF4040AA);
        if (PlayerInfo[playerid][Sex] == 1) SetPlayerSkin(playerid, 78), SelectCharRegID[playerid] = 1, ChosenSkin[playerid] = 78;
        else SetPlayerSkin(playerid, 12), SelectCharRegID[playerid] = 1, ChosenSkin[playerid] = 12;
    }
    if (ClothesRound[playerid] == 3) {
        if (PlayerInfo[playerid][Logged] == true) {

            SetPlayerArmourAC(playerid, PlayerInfo[playerid][Armour]);
            SetPlayerHealthAC(playerid, PlayerInfo[playerid][Health]);
            if (NewSpawn[playerid] == 1) {
                if (PlayerInfo[playerid][Frac] == 0) {
                    if (PlayerInfo[playerid][House] == 0) {
                        SetPos(playerid, 1708.1248, -1930.9232, 14.2667);
                        TogglePlayerControllable(playerid, 1);
                        SetPlayerVirtualWorld(playerid, 0);
                        SetPlayerInterior(playerid, 0);
                        new Float:X, Float:Y, Float:Z;
                        GetPlayerPos(playerid, X, Y, Z);
                        new Float:sa = (Z + 500);
                        SetPlayerCameraPos(playerid, X, Y, sa);
                        SetPlayerCameraLookAt(playerid, X, Y, Z, 1);
                        SetCameraBehindPlayer(playerid);
                        SetPlayerFacingAngle(playerid, 360);
                        SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
                        SetPlayerColor(playerid, 0xFFFFFFAA);
                    }
                    if (PlayerInfo[playerid][House] != 0) {

                        if (SpawnC[playerid] == 0) {
                            if (PlayerInfo[playerid][Car] != 0) {
                                new l = PlayerInfo[playerid][House];
                                for (new i = 1; i < MAX_HOUSE; i++) {
                                    if (GarageInfo[i][House] == l) {
                                        lcar(playerid, i);
                                        SpawnC[playerid]++;
                                    }
                                }
                            }
                            SendClientMessage(playerid, COLOR_GREY, "Чтобы выйти с дома, используйте команду /exit");
                        }
                        new ids = PlayerInfo[playerid][House];
                        SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][House] + DIALOG_HOUSEINFO);
                        SetPos(playerid, HouseInfo[ids][SHX], HouseInfo[ids][SHY], HouseInfo[ids][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[ids][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[ids][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
                        SetPlayerColor(playerid, 0xFFFFFFAA);

                    }

                }
                if (PlayerInfo[playerid][Frac] != 0) {
                    if (PlayerInfo[playerid][House] == 0) {

                    }
                    if (PlayerInfo[playerid][House] != 0) {
                        new ids = PlayerInfo[playerid][House];
                        SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][House] + DIALOG_HOUSEINFO);
                        SetPos(playerid, HouseInfo[ids][SHX], HouseInfo[ids][SHY], HouseInfo[ids][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[ids][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[ids][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
                        //SetPlayerColor(playerid,цвет фракции);
                        SendClientMessage(playerid, COLOR_GREY, "Чтобы выйти с дома, используйте команду /exit");
                    }

                }
                playb[playerid] = 1;
            }
            if (NewSpawn[playerid] == 2) {

                if (PlayerInfo[playerid][VW] != 0) {
                    TogglePlayerControllable(playerid, false);
                    SetTimerEx("UnfreezePlayer", 1000, false, "i", playerid);
                }


                SetPos(playerid, PlayerInfo[playerid][PosX], PlayerInfo[playerid][PosY], PlayerInfo[playerid][PosZ]);
                new Float:X, Float:Y, Float:Z;
                GetPlayerPos(playerid, X, Y, Z);
                new Float:sa = (Z + 500);
                SetPlayerCameraPos(playerid, X, Y, sa);
                SetPlayerCameraLookAt(playerid, X, Y, Z, 1);
                SetCameraBehindPlayer(playerid);
                SetPlayerFacingAngle(playerid, 360);
                SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][VW]);
                SetPlayerInterior(playerid, PlayerInfo[playerid][Interior]);
                SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
                SetPlayerColor(playerid, 0xFFFFFFAA);
                playb[playerid] = 1;
            }
            if (NewSpawn[playerid] == 4) {

                SetPos(playerid, -651.4950, 2724.2354, 304.5334);
                SetPlayerVirtualWorld(playerid, 7000);
                SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
                SetPlayerColor(playerid, 0xFFFFFFAA);
                playb[playerid] = 1;
                TogglePlayerControllable(playerid, false);
                SetTimerEx("UnfreezePlayer", 2000, false, "i", playerid);
                SendClientMessage(playerid, COLOR_WHITE, "На данный момент Вы в ДеМорган, Вы можете посмотреть время до освобождения в /time");
            }
            if (NewSpawn[playerid] == 0) {
                if (SpawnReg[playerid] == 1) {
                    if (PlayerInfo[playerid][DeMorgan] == 0) {
                        new Float:sa;
                        SetPlayerVirtualWorld(playerid, playerid);
                        SetPlayerInterior(playerid, PlayerInfo[playerid][Interior]);
                        SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
                        if (PlayerInfo[playerid][Interior] == 0 && PlayerInfo[playerid][VW] == 0) {
                            sa = (PlayerInfo[playerid][PosZ] + 500);
                        } else if (PlayerInfo[playerid][Interior] != 0 && PlayerInfo[playerid][VW] != 0) {
                            sa = (PlayerInfo[playerid][PosZ] + 2);
                        } else {
                            sa = PlayerInfo[playerid][PosZ];
                        }
                        SetPos(playerid, PlayerInfo[playerid][PosX], PlayerInfo[playerid][PosY], PlayerInfo[playerid][PosZ]);
                        SetPlayerCameraPos(playerid, PlayerInfo[playerid][PosX], PlayerInfo[playerid][PosY], sa);
                        SetPlayerCameraLookAt(playerid, PlayerInfo[playerid][PosX], PlayerInfo[playerid][PosY], PlayerInfo[playerid][PosZ]);
                        if (PlayerInfo[playerid][Status] != 2) {
                            ShowPlayerDialog(playerid, DIALOG_SPAWN, DIALOG_STYLE_MSGBOX, "Пожалуйста, сделайте выбор.", "Желаете вернуться на позицию с которой закончили игру?", "Да", "Нет");
                        }
                    } else {
                        NewSpawn[playerid] = 4;
                        SetPos(playerid, -651.4950, 2724.2354, 304.5334);
                        SetPlayerVirtualWorld(playerid, 7000);
                        SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
                        SetPlayerColor(playerid, 0xFFFFFFAA);
                        playb[playerid] = 1;
                        TogglePlayerControllable(playerid, false);
                        SetTimerEx("UnfreezePlayer", 2000, false, "i", playerid);
                        SendClientMessage(playerid, COLOR_WHITE, "На данный момент Вы в ДеМорган, Вы можете посмотреть время до освобождения в /time");
                    }
                }
            }

        }
    }

    return 1;
}
public OnPlayerDeath(playerid, killerid, reason) {
    SetPVarInt(playerid, "CheckSpawn", 0);
    SetPVarInt(playerid, "K_T", GetPVarInt(playerid, "K_T") + 1);
    if (GetPVarInt(playerid, "K_T") > 1) return BanEx(playerid, "- AntiFlood Kill");
    DisablePlayerCheckpoint(playerid);
    if (PlayerInfo[playerid][DeMorgan] > 0) {
        NewSpawn[playerid] = 4;
        ClothesRound[playerid] = 3;
    } else {
        if (PlayerInJob[playerid] == 1) {
            PlayerInJob[playerid] = 0;
            if (PlayerInfo[playerid][Frac] > 0) {
                SetPlayerSkin(playerid, PlayerInfo[playerid][FSkin]);
            } else {
                SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
            }
            GiveMoney(playerid, Meshki[playerid] * 10);
            for (new io = 0; io < MAX_PLAYER_ATTACHED_OBJECTS; io++) {
                if (IsPlayerAttachedObjectSlotUsed(playerid, io)) RemovePlayerAttachedObject(playerid, io);
            }
            SendClientMessage(playerid, COLOR_SYSTEM, "Вы закончили работу грузчиком. Заработаные средства были переведены на Ваш баланс.");
            Meshki[playerid] = 0;
        }
        if (fermalsstatus[playerid] == 1) {
            NewSpawn[playerid] = 3;
            GiveMoney(playerid, fermalszp[playerid]);
            FermaInfo[1][Bank] -= fermalszp[playerid];
            fermalszp[playerid] = 0;
            if (PlayerInfo[playerid][Frac] > 0) {
                SetPlayerSkin(playerid, PlayerInfo[playerid][FSkin]);
            } else {
                SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
            }
            fermalsstatus[playerid] = 0;
            for (new io = 0; io < MAX_PLAYER_ATTACHED_OBJECTS; io++) {
                if (IsPlayerAttachedObjectSlotUsed(playerid, io)) RemovePlayerAttachedObject(playerid, io);
            }
            SendClientMessage(playerid, COLOR_SYSTEM, "Вы закончили работу на ферме Лос Сантоса. Заработаные средства были переведены на Ваш баланс.");
        }

        if (fermasfstatus[playerid] == 1) {
            NewSpawn[playerid] = 3;
            GiveMoney(playerid, fermasfzp[playerid]);
            FermaInfo[2][Bank] -= fermasfzp[playerid];
            fermasfzp[playerid] = 0;
            if (PlayerInfo[playerid][Frac] > 0) {
                SetPlayerSkin(playerid, PlayerInfo[playerid][FSkin]);
            } else {
                SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
            }
            fermasfstatus[playerid] = 0;
            for (new io = 0; io < MAX_PLAYER_ATTACHED_OBJECTS; io++) {
                if (IsPlayerAttachedObjectSlotUsed(playerid, io)) RemovePlayerAttachedObject(playerid, io);
            }
            SendClientMessage(playerid, COLOR_SYSTEM, "Вы закончили работу на ферме Сан Фиерро. Заработаные средства были переведены на Ваш баланс.");
        }

    }

    plafk[playerid] = -2;
    return 1;
}

public OnVehicleSpawn(vehicleid) {
    VehicleHealth[vehicleid] = 1000;
    return 1;
}

public OnVehicleDeath(vehicleid, killerid) {
    return 1;
}
public CheckHealth(playerid) {
    if (PlayerInfo[playerid][Logged] == true) {
        for (new i = 0; i < MAX_PLAYERS; i++) // Цикл, проверяем всех игроков онлайн
        {
            if (IsPlayerConnected(i)) {
                new Float: Healthh; // Переменная
                GetPlayerHealth(i, Healthh); // Узнаем, сколько у игрока жизней
                if (PlayerHealth[i] < Healthh) // Если жизни у игрока больше, чем нужно (чит)
                {
                    SetPlayerHealth(i, PlayerHealth[i]); // Возвращаем ему его настоящую жизни
                } else {
                    PlayerHealth[i] = Healthh;
                }
            }
        }
    }
    return 1;
}
forward Checkhpcar(playerid);
public Checkhpcar(playerid) {
    new Float:vehhl, vehid, str[MAX_PLAYER_NAME];

    for (new i; i < MAX_PLAYERS; i++) {
        vehid = GetPlayerVehicleID(i);
        if (!vehid) { continue; }
        GetVehicleHealth(vehid, vehhl);

        if (VehicleHealth[vehid] >= vehhl) {
            VehicleHealth[vehid] = vehhl;
            continue;
        }

        if (!IsPlayerAtPnSpray(i)) {
            //new strr[128];
            GetPlayerName(i, str, sizeof str);
            /* format(strr, sizeof(strr),
                 "[Античит]%s повысил машине здоровье(Было %01f, Стало %01f), но я ему не дал это сделать -_-",
                 str,VehicleHealth[vehid],vehhl);
             SendAdminMessage( COLOR_GREY, strr );//ну тут ставим что хотим*/
            SetVehicleHealth(vehid, VehicleHealth[vehid]); //я решил ставить машине столько хп сколько и было
            AntiCarHP[playerid]++;
            if (AntiCarHP[playerid] >= 3) {
                SendClientMessage(playerid, -1, "Всё время пытались восстанавливать здоровье машины, мне это надоело. Хватит!");
                lKick(playerid);
            }
        }

        VehicleHealth[vehid] = vehhl;
    }
}
public OnPlayerText(playerid, text[]) {

    if (PlayerInfo[playerid][Logged] == false) return 0;
    if (PlayerInfo[playerid][Logged] == true) {
        if ((GetTickCount() - GetPVarInt(playerid, "Flood_Command")) <= 750) {
            SendClientMessage(playerid, -1, "Не стоит флудить, пожалуйста.");
            tFlood[playerid]++;
            if (tFlood[playerid] >= 10) {
                SendClientMessage(playerid, -1, "Вы не прекращали флудить, пришлось Вас кикнуть из игры.");
                lKick(playerid);
            }
            return 0; //антифлуд
        }
        SetPVarInt(playerid, "Flood_Command", GetTickCount()); //антифлуд
        if (emptyMessage(text)) {
            tFlood[playerid]++;
            if (tFlood[playerid] >= 10) {
                SendClientMessage(playerid, -1, "Вы не прекращали флудить, пришлось Вас кикнуть из игры.");
                lKick(playerid);
            }
            return SendClientMessage(playerid, -1, "[FAIL]: Пустое сообщение!") & 0;
        }
        if (PlayerInfo[playerid][Muted] == 0) {
            new string[256];
            printf("- %s[%d] сказал: %s", PlayerInfo[playerid][Name], playerid, text);
            if (strcmp(text, ")", true) == 0 || strcmp(text, ":)", true) == 0 || strcmp(text, "))", true) == 0) {
                format(string, sizeof(string), "%s улыбается", PlayerInfo[playerid][Name]);
                ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
                SetPlayerChatBubble(playerid, "улыбается", COLOR_PURPLE, 30.0, 10000);
            } else if (strcmp(text, ":D", true) == 0 || strcmp(text, "xD", true) == 0) {
                format(string, sizeof(string), "%s смеётся", PlayerInfo[playerid][Name]);
                ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
                SetPlayerChatBubble(playerid, "смеётся", COLOR_PURPLE, 30.0, 10000);
            } else if (strcmp(text, "(", true) == 0 || strcmp(text, ":(", true) == 0 || strcmp(text, "((", true) == 0) {
                format(string, sizeof(string), "%s грустит", PlayerInfo[playerid][Name]);
                ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
                SetPlayerChatBubble(playerid, "грустит", COLOR_PURPLE, 30.0, 10000);
            } else {
                format(string, sizeof(string), "- %s[%d] сказал: %s", PlayerInfo[playerid][Name], playerid, text);
                ProxDetector(10.0, playerid, string, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_FADE1, COLOR_FADE2);
                if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
                    ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.1, 0, 1, 1, 1, 1, 1);
                    SetPlayerChatBubble(playerid, text, COLOR_YELLOW, 10.0, 10000);
                    SetTimerEx("CA", 4000, false, "i", playerid);
                }
            }
        }


        if (PlayerInfo[playerid][Muted] > 0) {
            new string[256];
            format(string, sizeof(string), "Для Вас чат заблокирован, Вы сможете писать в чат через - %i секунд.", PlayerInfo[playerid][Muted]);
            SendClientMessage(playerid, -1, string);
        }
    }


    return 0;
}

public OnPlayerCommandText(playerid, cmdtext[]) {
    new string[256];
    new cmd[256];
    new idx;
    new tmp[256];
    new playermoney;

    new giveplayerid, moneys;
    new giveplayer[MAX_PLAYER_NAME];
    new specplayerid;
    cmd = strtok(cmdtext, idx);
    if (PlayerInfo[playerid][Logged] == false) return 0;
    if (PlayerInfo[playerid][Logged] == true) {
        if ((GetTickCount() - GetPVarInt(playerid, "Flood_Command")) <= 1000) return SendClientMessage(playerid, -1, "Использовать команды разрешено не чаще,чем раз в 1 секунды."); //антифлуд
        SetPVarInt(playerid, "Flood_Command", GetTickCount()); //антифлуд
        printf("%s использовал команду: %s", PlayerInfo[playerid][Name], cmdtext);
        if (strcmp(cmd, "/menu", true) == 0 || strcmp(cmd, "/mn", true) == 0 || strcmp(cmd, "/mm", true) == 0) {
            SendClientMessage(playerid, COLOR_WHITE, "");
            return 1;
        }

        if (strcmp("/ahelp", cmdtext, true, 10) == 0) {

            new stadm[2500];
            if (PlayerInfo[playerid][Admin] == 1) {
                for (new i; i < sizeof(Adm); i++) {
                    strcat(stadm, Adm[i]);
                    ShowPlayerDialog(playerid, 211, DIALOG_STYLE_MSGBOX, "{ffff33}Админ команды:", stadm, "Готово", "");
                }
            }
            if (PlayerInfo[playerid][Admin] == 2) {
                for (new i; i < sizeof(Adm2); i++) {
                    strcat(stadm, Adm2[i]);
                    ShowPlayerDialog(playerid, 211, DIALOG_STYLE_MSGBOX, "{ffff33}Админ команды:", stadm, "Готово", "");
                }
            }
            if (PlayerInfo[playerid][Admin] == 3) {
                for (new i; i < sizeof(Adm3); i++) {
                    strcat(stadm, Adm3[i]);
                    ShowPlayerDialog(playerid, 211, DIALOG_STYLE_MSGBOX, "{ffff33}Админ команды:", stadm, "Готово", "");
                }
            }
            if (PlayerInfo[playerid][Admin] == 4) {
                for (new i; i < sizeof(Adm3); i++) {
                    strcat(stadm, Adm3[i]);
                    ShowPlayerDialog(playerid, 211, DIALOG_STYLE_MSGBOX, "{ffff33}Админ команды:", stadm, "Готово", "");
                }
            }
            if (PlayerInfo[playerid][Admin] == 1998) {
                for (new i; i < sizeof(Adm5); i++) {
                    strcat(stadm, Adm5[i]);
                    ShowPlayerDialog(playerid, 211, DIALOG_STYLE_MSGBOX, "{ffff33}Админ команды:", stadm, "Готово", "");
                }
            }
            return 1;
        }
        if (strcmp("/cc", cmdtext, true, 3) == 0) {
            if (IsPlayerConnected(playerid)) {
                if (PlayerInfo[playerid][Admin] >= 1) {
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    for (new i = 0; i < 50; i++) SendClientMessageToAll(COLOR_SYSTEM, " ");
                    format(string, sizeof(string), "{FF0000}Администратор %s очистил чат.", sendername);
                    SendClientMessageToAll(COLOR_SYSTEM, string);
                    return 1;
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/buyferma", true) == 0) {
            if (PlayerToPoint(30.0, playerid, -98.3798, 51.3281, 3.0188)) {
                if (FermaInfo[1][Boss] == 0 && FermaInfo[1][Status] == 2) {
                    if (PlayerInfo[playerid][Money] >= FermaInfo[1][Sum]) {
                        GiveMoney(playerid, -FermaInfo[1][Sum]);
                        SendClientMessage(playerid, COLOR_WHITE, "Вы купили ферму Лос Сантоса. Пополните счёт фермы в банке.");
                        SendClientMessage(playerid, COLOR_WHITE, "В случае, если на банковском счету фермы не будет достаточно средств, Ваш бизнес заберёт государство.");
                        SendClientMessage(playerid, COLOR_WHITE, "Меню для управления фермой - /fmenu, остальные команды Вы можете найти в меню сервера - /menu");
                        FermaInfo[1][Boss] = PlayerInfo[playerid][ID];
                        FermaInfo[1][Status] = 1;
                        FermaInfo[1][Bank] = 1000;
                        SaveAccount(playerid);
                        Update3DTextLabelText(FermaLabel[1], COLOR_BLUE, FermaInfo[1][Name]);
                    }
                }
            } else if (PlayerToPoint(30.0, playerid, -1055.3912, -1199.7893, 128.0437)) {
                if (FermaInfo[2][Boss] == 0 && FermaInfo[2][Status] == 2) {
                    if (PlayerInfo[playerid][Money] >= FermaInfo[2][Sum]) {
                        GiveMoney(playerid, -FermaInfo[2][Sum]);
                        SendClientMessage(playerid, COLOR_WHITE, "Вы купили ферму Сан Фиерро. Пополните счёт фермы в банке.");
                        SendClientMessage(playerid, COLOR_WHITE, "В случае, если на банковском счету фермы не будет достаточно средств, Ваш бизнес заберёт государство.");
                        SendClientMessage(playerid, COLOR_WHITE, "Меню для управления фермой - /fmenu, остальные команды Вы можете найти в меню сервера - /menu");
                        FermaInfo[2][Boss] = PlayerInfo[playerid][ID];
                        FermaInfo[2][Status] = 1;
                        FermaInfo[2][Bank] = 1000;
                        SaveAccount(playerid);
                        Update3DTextLabelText(FermaLabel[2], COLOR_BLUE, FermaInfo[2][Name]);
                    }
                }
            } else {
                SendClientMessage(playerid, COLOR_SYSTEM, "Необходимо быть ближе к ферме.");
            }
            return 1;
        }
        if (strcmp(cmd, "/hmenu", true) == 0) {
            new wvv = GetPlayerVirtualWorld(playerid);
            new ids = wvv - DIALOG_HOUSEINFO;
            if (PlayerInfo[playerid][House] == ids) {
                ShowPlayerDialog(playerid, DIALOG_HOUSEMENU, DIALOG_STYLE_LIST, "Управление жильём", "1. Открыть/Закрыть\n2. Доставить транспортное средство к жилью\n3. Улучшения\n4. Информация\n5. Продать", "Выбрать", "Закрыть");
            } else {
                if (PlayerInfo[playerid][House] != 0) {
                    SendClientMessage(playerid, COLOR_RED, "Необходимо находиться в Вашем доме!");
                }
                if (PlayerInfo[playerid][House] == 0) {
                    SendClientMessage(playerid, COLOR_RED, "У Вас нет жилья.");
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/fmenu", true) == 0) {
            if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID] || PlayerInfo[playerid][FermaLS] == 1 || FermaInfo[2][Boss] == PlayerInfo[playerid][ID] || PlayerInfo[playerid][FermaSF] == 1) {
                ShowPlayerDialog(playerid, DIALOG_FERMALSMENU, DIALOG_STYLE_LIST, "Управление фермой", "1. Установить цену за куст[Владелец]\n2. Принять на должность фермера[Владелец]\n3. Уволить с должности фермера[Владелец]\n4. Продать урожай[Владелец и фермер]\n5. Закупить зерно[Владелец и фермер]\n6. Продать ферму физическому лицу/государству[Владелец]\n7. Открыть/Закрыть ферму[Владелец]", "Выбрать", "Закрыть");
            }
            return 1;
        }
        if (strcmp(cmd, "/finfo", true) == 0) {
            if (PlayerToPoint(30.0, playerid, -98.3798, 51.3281, 3.0188)) {
                if (FermaInfo[1][Status] == 2) {
                    SendClientMessage(playerid, COLOR_WHITE, "Ферма Лос Сантоса продается, введите /buyferma чтобы её купить.");
                } else {
                    new pol[256];
                    new
                    query[128],
                        result[5 + 24 + 64];
                    new Bosss[64];
                    new Fermerr1[64];
                    new Fermerr2[64];
                    new Fermerr3[64];
                    new Fermerr4[64];
                    new Fermerr5[64];
                    format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", FermaInfo[1][Boss]);
                    mysql_query(query);
                    mysql_store_result();
                    if (mysql_num_rows() == 1) {
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>s[64]",
                            Bosss);
                        mysql_free_result(); // Очищаем память.
                    }
                    format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", FermaInfo[1][Fermer1]);
                    mysql_query(query);
                    mysql_store_result();
                    if (mysql_num_rows() == 1) {
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>s[64]",
                            Fermerr1);
                        mysql_free_result(); // Очищаем память.
                    }
                    format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", FermaInfo[1][Fermer2]);
                    mysql_query(query);
                    mysql_store_result();
                    if (mysql_num_rows() == 1) {
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>s[64]",
                            Fermerr2);
                        mysql_free_result(); // Очищаем память.
                    }
                    format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", FermaInfo[1][Fermer3]);
                    mysql_query(query);
                    mysql_store_result();
                    if (mysql_num_rows() == 1) {
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>s[64]",
                            Fermerr3);
                        mysql_free_result(); // Очищаем память.
                    }
                    format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", FermaInfo[1][Fermer4]);
                    mysql_query(query);
                    mysql_store_result();
                    if (mysql_num_rows() == 1) {
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>s[64]",
                            Fermerr4);
                        mysql_free_result(); // Очищаем память.
                    }
                    format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", FermaInfo[1][Fermer5]);
                    mysql_query(query);
                    mysql_store_result();
                    if (mysql_num_rows() == 1) {
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>s[64]",
                            Fermerr5);

                        mysql_free_result(); // Очищаем память.
                    }
                    if (FermaInfo[1][ID] == 0) {
                        format(pol, sizeof(pol), "\tФерма Лос Сантоса\n\nВладелец: Государство\n\t Продается");
                        ShowPlayerDialog(playerid, DIALOG_FERMALSINFO, DIALOG_STYLE_MSGBOX, "Информация о ферме", pol, "Хорошо", "");
                    } else {
                        format(pol, sizeof(pol), "\tФерма Лос Сантоса\n\nВладелец: %s\n\nЦена за куст: %d$\n\nНа складе зерна: %d/10000 кг.\nНа складе урожая: %d/10000 кг.\nЗасеяно зерна: %d кг.\n\n\nНа банковском счету фермы: %d$\n\nФермер: %s\nФермер: %s\nФермер: %s\nФермер: %s\nФермер: %s", Bosss, FermaInfo[1][Price], FermaInfo[1][Ammount], FermaInfo[1][Ur], FermaInfo[1][Zerno], FermaInfo[1][Bank], Fermerr1, Fermerr2, Fermerr3, Fermerr4, Fermerr5);
                        ShowPlayerDialog(playerid, DIALOG_FERMALSINFO, DIALOG_STYLE_MSGBOX, "Информация о ферме", pol, "Хорошо", "");
                    }
                }
            } else if (PlayerToPoint(30.0, playerid, -1060.6987, -1195.5139, 129.5592)) {
                if (FermaInfo[2][Status] == 2) {
                    SendClientMessage(playerid, COLOR_WHITE, "Ферма Сан Фиерро продается, введите /buyferma чтобы её купить.");
                } else {
                    new pol[256];
                    new
                    query[128],
                        result[5 + 24 + 64];
                    new Bosss[64];
                    new Fermerr1[64];
                    new Fermerr2[64];
                    new Fermerr3[64];
                    new Fermerr4[64];
                    new Fermerr5[64];
                    format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", FermaInfo[2][Boss]);
                    mysql_query(query);
                    mysql_store_result();
                    if (mysql_num_rows() == 1) {
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>s[64]",
                            Bosss);
                        mysql_free_result(); // Очищаем память.
                    }
                    format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", FermaInfo[2][Fermer1]);
                    mysql_query(query);
                    mysql_store_result();
                    if (mysql_num_rows() == 1) {
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>s[64]",
                            Fermerr1);
                        mysql_free_result(); // Очищаем память.
                    }
                    format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", FermaInfo[2][Fermer2]);
                    mysql_query(query);
                    mysql_store_result();
                    if (mysql_num_rows() == 1) {
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>s[64]",
                            Fermerr2);
                        mysql_free_result(); // Очищаем память.
                    }
                    format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", FermaInfo[2][Fermer3]);
                    mysql_query(query);
                    mysql_store_result();
                    if (mysql_num_rows() == 1) {
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>s[64]",
                            Fermerr3);
                        mysql_free_result(); // Очищаем память.
                    }
                    format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", FermaInfo[2][Fermer4]);
                    mysql_query(query);
                    mysql_store_result();
                    if (mysql_num_rows() == 1) {
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>s[64]",
                            Fermerr4);
                        mysql_free_result(); // Очищаем память.
                    }
                    format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", FermaInfo[2][Fermer5]);
                    mysql_query(query);
                    mysql_store_result();
                    if (mysql_num_rows() == 1) {
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>s[64]",
                            Fermerr5);

                        mysql_free_result(); // Очищаем память.
                    }
                    if (FermaInfo[2][ID] == 0) {
                        format(pol, sizeof(pol), "\tФерма Сан Фиерро\n\nВладелец: Государство\n\t Продается");
                        ShowPlayerDialog(playerid, DIALOG_FERMALSINFO, DIALOG_STYLE_MSGBOX, "Информация о ферме", pol, "Хорошо", "");
                    } else {
                        format(pol, sizeof(pol), "\tФерма Сан Фиерро\n\nВладелец: %s\n\nЦена за куст: %d$\n\nНа складе зерна: %d/10000 кг.\nНа складе урожая: %d/10000 кг.\nЗасеяно зерна: %d кг.\n\n\nНа банковском счету фермы: %d$\n\nФермер: %s\nФермер: %s\nФермер: %s\nФермер: %s\nФермер: %s", Bosss, FermaInfo[2][Price], FermaInfo[2][Ammount], FermaInfo[2][Ur], FermaInfo[2][Zerno], FermaInfo[2][Bank], Fermerr1, Fermerr2, Fermerr3, Fermerr4, Fermerr5);
                        ShowPlayerDialog(playerid, DIALOG_FERMALSINFO, DIALOG_STYLE_MSGBOX, "Информация о ферме", pol, "Хорошо", "");
                    }
                }
            } else {
                SendClientMessage(playerid, COLOR_SYSTEM, "Рядом с Вами нет ферм.");
            }

            return 1;
        }
        if (strcmp(cmd, "/freeze", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 1) {
                tmp = strtok(cmdtext, idx);
                if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, " Введите: /freeze [id]");
                new playa;
                playa = ReturnUser(tmp);
                //if(PlayerInfo[playa][pAdmin] > 0) return SendClientMessage(playerid, COLOR_GRAD2, "[Сервер:] {FF0000}Администратор не может быть заморожен!");
                if (PlayerInfo[playerid][Admin] >= 1) {
                    if (IsPlayerConnected(playa)) {
                        if (playa != INVALID_PLAYER_ID) {
                            GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                            GetPlayerName(playerid, sendername, sizeof(sendername));
                            //TogglePlayerControllable(playa, 0);
                            TogglePlayerControllable(playa, false);
                            SetTimerEx("UnfreezePlayer", 30000, false, "i", playa);
                            format(string, sizeof(string), "[Сервер]{FF0000}Администратор{CD0000} %s {FF0000}заморозил игрока {CD0000}%s", sendername, giveplayer);
                            printf("%s", string);
                            format(string, sizeof(string), "[Сервер]: {FF0000}Игрок {CD0000}%s {FF0000}был заморожен администратором {CD0000}%s", giveplayer, sendername);
                            SendClientMessageToAll(COLOR_RED, string);
                        }
                    }
                } else {
                    SendClientMessage(playerid, COLOR_GRAD1, "[Сервер:] Вы не уполномочены использовать эту команду!");
                }
            }
            return true;
        }
        /*if(strcmp(cmd, "/unfreeze", true) == 0)
     		{
         	if(PlayerInfo[playerid][Admin] >= 1)
     		{
       		tmp = strtok(cmdtext, idx);
         	if(!strlen(tmp))
          	{
                 SendClientMessage(playerid, COLOR_WHITE, " Введите: /unfreeze [id]");
                 return true;
           	}
           	new playa;
           	playa = ReturnUser(tmp);
            if (PlayerInfo[playerid][Admin] >= 1)
            {
                 if(IsPlayerConnected(playa))
                 {
                     if(playa != INVALID_PLAYER_ID)
                     {
                         GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                         GetPlayerName(playerid, sendername, sizeof(sendername));
                         TogglePlayerControllable(playa, 1);
                         format(string, sizeof(string), "[Сервер]{FF0000}Администратор{CD0000} %s {FF0000}разморозил игрока {CD0000}%s",sendername,  giveplayer);
                         printf("%s",string);
                         format(string, sizeof(string), "[Сервер]{FF0000}Администратор{CD0000} %s {FF0000}разморозил игрока {CD0000}%s ",sendername, giveplayer);
                         SendClientMessageToAll(COLOR_RED,string);
                     }
                 }
            }
            else
            {
                 SendClientMessage(playerid, COLOR_SYSTEM, "Вы не уполномочены использовать эту команду!");
            }
         	}
         	return true;
     		}*/
        if (strcmp(cmd, "/get", true) == 0) {
            if (IsPlayerConnected(playerid)) {
                if (PlayerInfo[playerid][Admin] >= 1) {
                    tmp = strtok(cmdtext, idx);
                    if (!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_SYSTEM, " {ffffff}[Используй]: /get [ID персонажа/Имя персонажа]");
                        return 1;
                    }
                    new Float:plocx, Float:plocy, Float:plocz;
                    new plo;
                    new inte, vw;
                    plo = ReturnUser(tmp);
                    if (IsPlayerConnected(plo)) {
                        if (plo != INVALID_PLAYER_ID) {
                            if (PlayerInfo[playerid][Admin] >= 1) {
                                GetPlayerPos(playerid, plocx, plocy, plocz);
                                if (GetPlayerState(plo) == 2) {
                                    inte = GetPlayerVirtualWorld(playerid);
                                    vw = GetPlayerInterior(playerid);
                                    new tmpcar = GetPlayerVehicleID(plo);
                                    SetVehiclePos(tmpcar, plocx, plocy + 4, plocz);
                                    SetPlayerVirtualWorld(plo, vw);
                                    SetPlayerInterior(plo, inte);

                                } else {
                                    inte = GetPlayerVirtualWorld(playerid);
                                    vw = GetPlayerInterior(playerid);
                                    SetPos(plo, plocx, plocy + 2, plocz);
                                    SetPlayerVirtualWorld(plo, vw);
                                    SetPlayerInterior(plo, inte);
                                }
                                SetPlayerInterior(plo, GetPlayerInterior(playerid));
                                SetPlayerVirtualWorld(plo, GetPlayerVirtualWorld(playerid));
                                SendClientMessage(plo, COLOR_SYSTEM, "* Вы были телепортированы Администрацией");
                            } else {
                                SendClientMessage(playerid, COLOR_SYSTEM, "*  Вы не уполномочены использовать эту команду!");
                            }
                        }
                    } else {
                        format(string, sizeof(string), "   %d не активный игрок.", plo);
                        SendClientMessage(playerid, COLOR_SYSTEM, string);
                    }
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/pm", true) == 0) {
            if (IsPlayerConnected(playerid)) {
                if (PlayerInfo[playerid][Admin] >= 1) {
                    tmp = strtok(cmdtext, idx);

                    giveplayerid = ReturnUser(tmp);
                    new length = strlen(cmdtext);
                    while ((idx < length) && (cmdtext[idx] <= ' ')) {
                        idx++;
                    }
                    new offset = idx;
                    new result[256];
                    while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
                        result[idx - offset] = cmdtext[idx];
                        idx++;
                    }
                    result[idx - offset] = EOS;

                    if (!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_WHITE, "Сервер: /pm [id] [сообщение]");
                        return 1;
                    }
                    if (!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_WHITE, "Сервер: /pm [id] [сообщение]");
                        return 1;
                    }
                    if (strlen(result) <= 64) {
                        if (IsPlayerConnected(giveplayerid)) {
                            new mess[256];
                            mess = result;
                            new str[256];
                            format(str, sizeof(str), "Администратор %s ответил Вам: %s", PlayerInfo[playerid][Name], mess);
                            SendClientMessage(giveplayerid, COLOR_YELLOW, str);
                            format(str, sizeof(str), "Вы ответили %s: %s", PlayerInfo[giveplayerid][Name], mess);
                            SendClientMessage(playerid, COLOR_YELLOW, str);
                            format(str, sizeof(str), "[PM]Администратор %s ответил %s: %s", PlayerInfo[playerid][Name], PlayerInfo[giveplayerid][Name], mess);
                            SendAdminMessage(COLOR_BLUE, str);
                            printf("[PM]Администратор %s ответил %s: %s", PlayerInfo[playerid][Name], PlayerInfo[giveplayerid][Name], mess);
                        } else {
                            SendClientMessage(playerid, COLOR_WHITE, "Под данным ID игрока нет в сети");
                        }
                    } else {
                        SendClientMessage(playerid, COLOR_WHITE, "Сообщение слишком большое.");
                    }
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/a", true) == 0) {
            if (IsPlayerConnected(playerid)) {
                if (PlayerInfo[playerid][Admin] >= 1) {
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    new length = strlen(cmdtext);
                    while ((idx < length) && (cmdtext[idx] <= ' ')) {
                        idx++;
                    }
                    new offset = idx;
                    new result[64];
                    while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
                        result[idx - offset] = cmdtext[idx];
                        idx++;
                    }
                    result[idx - offset] = EOS;
                    if (!strlen(result)) {
                        SendClientMessage(playerid, COLOR_YELLOW, " Подсказка: /a [текст]");
                        return 1;
                    }
                    new arank[64];
                    if (PlayerInfo[playerid][Admin] == 1998) { arank = "Главный Администратор Проекта"; } else if (PlayerInfo[playerid][Admin] == 4) { arank = "Зам.Гл.Админа"; } else if (PlayerInfo[playerid][Admin] == 3) { arank = "Администратор"; } else if (PlayerInfo[playerid][Admin] == 2) { arank = "Модератор"; } else if (PlayerInfo[playerid][Admin] == 1) { arank = "Хелпер"; } else { arank = "Хэлпер"; }

                    format(string, sizeof(string), "*** %s %s[%d]: %s. ***", arank, sendername, playerid, result);
                    if (PlayerInfo[playerid][Admin] >= 1) {
                        SendAdminMessage(COLOR_GREEN, string);
                    }
                    printf("%s %s[%d]: %s", arank, sendername, playerid, result);
                }
            }
            return 1;
        }
        if (strcmp(cmdtext, "/admins", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 1) {
                new alllstring[2000], ttext[50], AdminName[MAX_PLAYER_NAME];
                for (new i, j = MAX_PLAYERS; i != j; i++) {
                    ttext[0] = 0;
                    if (!IsPlayerConnected(i) || IsPlayerNPC(i) || PlayerInfo[i][Admin] <= 1) continue;
                    new Adminn = PlayerInfo[i][Admin];
                    switch (Adminn) {
                        case 1 : ttext = "{36D352}(Хелпер)";
                        case 2 : ttext = "{36D352}(Модератор)";
                        case 3 : ttext = "{33CCFF}(Администратор)";
                        case 4 : ttext = "{FF6347}(Зам.Гл.Админа)";
                        case 1998 : ttext = "{FF6347}(Главный Администратор Проекта)";
                        default: ttext = "---";
                    }
                    GetPlayerName(i, AdminName, sizeof(AdminName));
                    format(alllstring, sizeof(alllstring), "%s%s {FFFFFF}%s- ID-{22FF22}%d\n", alllstring, ttext, AdminName, i);
                }
                if (strlen(alllstring) < 1) strcat(alllstring, "{FFFFFF}Сейчас все администраторы {FF6347}оффлайн");
                ShowPlayerDialog(playerid, DIALOG_ADMINS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Nation RolePlay:{FFFFFF}Админы {22FF22}Онлайн", alllstring, "Хорошо", "");
            }
            return 1;
        }
        if (strcmp(cmd, "/goto", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 1) {
                tmp = strtok(cmdtext, idx);
                if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_SYSTEM, "[Используй]: /goto [ID/Имя]");
                new GotoId = strval(tmp);
                if (GotoId == playerid) return SendClientMessage(playerid, COLOR_SYSTEM, "[Сервер]: Ты не можешь телепортироваться к себе.");
                new Float:x, Float:y, Float:z, vw, inte;
                GetPlayerPos(GotoId, x, y, z);
                vw = GetPlayerVirtualWorld(GotoId);
                inte = GetPlayerInterior(GotoId);
                SetPos(playerid, x, y, z);
                SetPlayerVirtualWorld(playerid, vw);
                SetPlayerInterior(playerid, inte);
            }
            return 1;
        }
        if (strcmp(cmd, "/spec", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 2) {
                tmp = strtok(cmdtext, idx);
                GetPlayerName(specplayerid, giveplayer, sizeof(giveplayer));
                if (!strlen(tmp)) {
                    SendClientMessage(playerid, COLOR_WHITE, "Используй: /spec [playerid]");
                    return 1;
                }
                specplayerid = strval(tmp);
                if (!IsPlayerConnected(specplayerid)) {
                    SendClientMessage(playerid, COLOR_RED, "Не активный игрок.");
                    return 1;
                }
                if (PlayerInfo[playerid][Admin] >= 2) //проверка на админа[ставим свою]
                {
                    TogglePlayerSpectating(playerid, 1);
                    PlayerSpectatePlayer(playerid, specplayerid);
                    SetPlayerInterior(playerid, GetPlayerInterior(specplayerid));
                    gSpectateID[playerid] = specplayerid;
                    gSpectateType[playerid] = ADMIN_SPEC_TYPE_PLAYER;
                    SpecHATimer[playerid] = SetTimerEx("SpecHArefresh", 500, true, "ff", playerid, specplayerid); //запускаем таймер с TextDraw
                    TextDrawShowForPlayer(playerid, SM_HA[playerid]); //высвечиваем TextDraw
                }
                if (IsPlayerInAnyVehicle(specplayerid)) //если игрок в транспорте, то слежка ведётся за машиной...[ну как то так]
                {
                    SetPlayerInterior(playerid, GetPlayerInterior(specplayerid));
                    TogglePlayerSpectating(playerid, 1);
                    PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specplayerid));
                    gSpectateID[playerid] = specplayerid;
                    gSpectateType[playerid] = ADMIN_SPEC_TYPE_VEHICLE;
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/specoff", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 2) //проверка на админа
            {
                TogglePlayerSpectating(playerid, 0);
                gSpectateID[playerid] = INVALID_PLAYER_ID;
                gSpectateType[playerid] = ADMIN_SPEC_TYPE_NONE;
                TextDrawHideForPlayer(playerid, SM_HA[playerid]); //Спрячем TextDraw
                KillTimer(SpecHATimer[playerid]); //Остановим таймер
            }
            return 1;
        }
        if (strcmp(cmd, "/disarm", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 2) {
                tmp = strtok(cmdtext, idx);
                if (!strlen(tmp)) {
                    SendClientMessage(playerid, COLOR_GRAD2, "ИНФО: /disarm [ID/Ник]");
                    return 1;
                }
                giveplayerid = ReturnUser(tmp);
                tmp = strtok(cmdtext, idx);

                if (IsPlayerConnected(giveplayerid)) {
                    if (giveplayerid != INVALID_PLAYER_ID) {
                        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        printf("AC:%s has disarm %s", sendername, giveplayer);
                        format(string, sizeof(string), "Вы были разоружены админом %s", sendername);
                        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
                        format(string, sizeof(string), "Вы разоружили %s.", giveplayer);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        ResetPlayerWeapons(giveplayerid);
                    } else {
                        SendClientMessage(playerid, COLOR_GREY, "Этот игрок оффлайн");
                        return 1;
                    }
                }
            }
            return 1;
        }
        if (!strcmp(cmd, "/slap")) {
            if (PlayerInfo[playerid][Admin] <= 2) return true;
            new ebaaa;
            tmp = strtok(cmdtext, idx);
            if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_RED, "Используйте: /slap [id]");
            ebaaa = ReturnUser(tmp);
            new Float:x, Float:y, Float:z;
            GetPlayerPos(ebaaa, x, y, z);
            SetPlayerPos(ebaaa, x, y, z + 8);
            return true;
        }
        if (strcmp(cmd, "/kick", true) == 0) {
            if (IsPlayerConnected(playerid)) {
                if (PlayerInfo[playerid][Admin] >= 2) {
                    tmp = strtok(cmdtext, idx);
                    if (!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /kick [playerid/PartOfName] [reason]");
                        return 1;
                    }
                    giveplayerid = ReturnUser(tmp);
                    if (PlayerInfo[playerid][Admin] >= 2) {
                        if (IsPlayerConnected(giveplayerid)) {
                            if (giveplayerid != INVALID_PLAYER_ID) {
                                if (PlayerInfo[giveplayerid][Admin] < PlayerInfo[playerid][Admin]) {
                                    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
                                    GetPlayerName(playerid, sendername, sizeof(sendername));
                                    new length = strlen(cmdtext);
                                    while ((idx < length) && (cmdtext[idx] <= ' ')) {
                                        idx++;
                                    }
                                    new offset = idx;
                                    new result[64];
                                    while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
                                        result[idx - offset] = cmdtext[idx];
                                        idx++;
                                    }
                                    result[idx - offset] = EOS;
                                    if (!strlen(result)) {
                                        SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /kick [playerid/PartOfName] [reason]");
                                        return 1;
                                    }
                                    if (playerid != giveplayerid) {
                                        if (PlayerInfo[playerid][Admin] > PlayerInfo[giveplayerid][Admin]) {
                                            new year, month, day;
                                            getdate(year, month, day);
                                            format(string, sizeof(string), "%s кикнут администратором %s. Причина: %s. (%d-%d-%d)", giveplayer, sendername, (result), month, day, year);

                                            format(string, sizeof(string), "%s кикнут администратором %s. Причина: %s.", giveplayer, sendername, (result));
                                            SendClientMessageToAll(COLOR_LIGHTRED, string);
                                            new queryyy[300];
                                            new Hour, Minute, Second;
                                            gettime(Hour, Minute, Second);
                                            new Year, Month, Day;
                                            getdate(Year, Month, Day);
                                            format(queryyy, sizeof(queryyy), "INSERT INTO `kicks` (`AdmName`, `Name`, `time`, `reason`) VALUE ('%s', '%s', '%d:%d:%d %d/%d/%d', '%s')", sendername, giveplayer, Hour, Minute, Second, Day, Month, Year, result);
                                            mysql_query(queryyy);
                                            lKick(giveplayerid);
                                        }
                                    } else {
                                        SendClientMessage(playerid, COLOR_WHITE, "Вы не можете кикнуть самого себя!");
                                    }
                                }
                                return 1;
                            }
                        } else

                        {
                            format(string, sizeof(string), "   %d не верный id.", giveplayerid);
                            SendClientMessage(playerid, COLOR_GRAD1, string);
                        }
                    }
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/warn", true) == 0) {
            if (IsPlayerConnected(playerid)) {
                if (PlayerInfo[playerid][Admin] >= 2) {
                    tmp = strtok(cmdtext, idx);
                    if (!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /warn [playerid/PartOfName] [reason]");
                        return 1;
                    }
                    giveplayerid = ReturnUser(tmp);
                    if (PlayerInfo[playerid][Admin] >= 2) {
                        if (IsPlayerConnected(giveplayerid)) {
                            if (giveplayerid != INVALID_PLAYER_ID) {
                                if (PlayerInfo[giveplayerid][Admin] < PlayerInfo[playerid][Admin]) {
                                    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
                                    GetPlayerName(playerid, sendername, sizeof(sendername));
                                    new length = strlen(cmdtext);
                                    while ((idx < length) && (cmdtext[idx] <= ' ')) {
                                        idx++;
                                    }
                                    new offset = idx;
                                    new result[64];
                                    while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
                                        result[idx - offset] = cmdtext[idx];
                                        idx++;
                                    }
                                    result[idx - offset] = EOS;
                                    if (!strlen(result)) {
                                        SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /warn [playerid/PartOfName] [reason]");
                                        return 1;
                                    }
                                    if (playerid != giveplayerid) {
                                        if (PlayerInfo[playerid][Admin] > PlayerInfo[giveplayerid][Admin]) {
                                            new year, month, day;
                                            getdate(year, month, day);
                                            new Seconds = gettime();
                                            if (PlayerInfo[giveplayerid][Warn] == 2) {
                                                PlayerInfo[giveplayerid][BanTime] = Seconds;
                                                PlayerInfo[giveplayerid][Bann] = 1;
                                            }
                                            PlayerInfo[giveplayerid][Warn]++;
                                            format(string, sizeof(string), "%s получил предупреждение от администратора %s. Причина: %s. (%d-%d-%d)", giveplayer, sendername, (result), month, day, year);
                                            format(string, sizeof(string), "%s получил предупреждение от администратора %s. Причина: %s.", giveplayer, sendername, (result));
                                            SendClientMessageToAll(COLOR_LIGHTRED, string);

                                            new queryyy[300];
                                            format(queryyy, sizeof(queryyy), "INSERT INTO `warns` (`AdmName`, `Name`, `time`, `reason`) VALUE ('%s', '%s', '%i', '%s')", sendername, giveplayer, Seconds, result);
                                            mysql_query(queryyy);

                                            lKick(giveplayerid);

                                        }
                                    } else {
                                        SendClientMessage(playerid, COLOR_WHITE, "Вы не можете выдать предупреждение самому себе!");
                                    }
                                }
                                return 1;
                            }
                        } else

                        {
                            format(string, sizeof(string), "   %d не верный id.", giveplayerid);
                            SendClientMessage(playerid, COLOR_GRAD1, string);
                        }
                    }
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/respcar", true) == 0) {
            if (PlayerInfo[playerid][Admin] == 1998) {
                for (new i; i < MAX_VEHICLES; i++) {
                    SetVehicleToRespawn(i);
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/createhouse", true) == 0) {
            if (PlayerInfo[playerid][Admin] == 1998) {
                tmp = strtok(cmdtext, idx);

                new resultt = strval(tmp);
                printf("r= %d", resultt);
                if (resultt == 0) {
                    SendClientMessage(playerid, COLOR_GRAD1, "/createhouse [Класс дома от 1-20| 1 - 6 getto| 7-16 средний класс| 17-20 голивуд].");

                } else {
                    if (resultt != 0) {
                        new int, Float:CX, Float:CY, Float:CZ, Float:CHX, Float:CHZ, Float:CHY, Cprice, Float:Anglx;
                        GetPlayerPos(playerid, CX, CY, CZ);
                        new Float:Anglea;
                        GetPlayerFacingAngle(playerid, Anglea);
                        //Anl = (Anglea + 180);
                        //Anglea = Anl;
                        new result[1000];
                        new Cint = resultt;
                        if (Cint == 1) {
                            int = 1;
                            CHX = 243.72;
                            CHY = 304.91;
                            CHZ = 999.15;
                            Cprice = 40000;
                            Anglx = 270.0;
                        }
                        if (Cint == 2) {
                            int = 10;
                            CHX = 2259.38;
                            CHY = -1135.77;
                            CHZ = 1050.64;
                            Cprice = 60000;
                            Anglx = 270.0;
                        }
                        if (Cint == 3) {
                            int = 2;
                            CHX = 266.50;
                            CHY = 304.90;
                            CHZ = 999.15;
                            Cprice = 70000;
                            Anglx = 270.0;
                        }
                        if (Cint == 4) {
                            int = 6;
                            CHX = 2308.77;
                            CHY = -1212.94;
                            CHZ = 1049.02;
                            Cprice = 80000;
                            Anglx = 0;
                        }
                        /*if(Cint == 5)
			{
			int = 12;
			CHX = 446.90;
			CHY = 506.35;
			CHZ = 1001.42;
			Cprice = 80000;
            Anglx = 0;
			}*/
                        if (Cint == 6) {
                            int = 8;
                            CHX = -42.59;
                            CHY = 1405.47;
                            CHZ = 1084.43;
                            Cprice = 75000;
                            Anglx = 0;
                        }
                        if (Cint == 7) {
                            int = 1;
                            CHX = 2218.40;
                            CHY = -1076.18;
                            CHZ = 1050.48;
                            Cprice = 85000;
                            Anglx = 90;
                        }
                        if (Cint == 8) {
                            int = 5;
                            CHX = 2233.64;
                            CHY = -1115.26;
                            CHZ = 1050.88;
                            Cprice = 90000;
                            Anglx = 0;
                        }
                        if (Cint == 9) {
                            int = 11;
                            CHX = 2283.04;
                            CHY = -1140.28;
                            CHZ = 1050.90;
                            Cprice = 90000;
                            Anglx = 0;
                        }
                        if (Cint == 10) {
                            int = 15;
                            CHX = 295.04;
                            CHY = 1472.26;
                            CHZ = 1080.26;
                            Cprice = 100000;
                            Anglx = 0;
                        }
                        if (Cint == 11) {
                            int = 2;
                            CHX = 2237.59;
                            CHY = -1081.64;
                            CHZ = 1049.02;
                            Cprice = 110000;
                            Anglx = 0;
                        }
                        if (Cint == 12) {
                            int = 8;
                            CHX = 2365.31;
                            CHY = -1135.60;
                            CHZ = 1050.88;
                            Cprice = 120000;
                            Anglx = 0;
                        }
                        if (Cint == 13) {
                            int = 2;
                            CHX = 446.99;
                            CHY = 1397.07;
                            CHZ = 1084.30;
                            Cprice = 130000;
                            Anglx = 0;
                        }
                        if (Cint == 14) {
                            int = 10;
                            CHX = 2270.38;
                            CHY = -1210.35;
                            CHZ = 1047.56;
                            Cprice = 140000;
                            Anglx = 90.0;
                        }
                        if (Cint == 15) {
                            int = 6;
                            CHX = 2196.85;
                            CHY = -1204.25;
                            CHZ = 1049.02;
                            Cprice = 150000;
                            Anglx = 90;
                        }
                        if (Cint == 16) {
                            int = 9;
                            CHX = 2317.89;
                            CHY = -1026.76;
                            CHZ = 1050.22;
                            Cprice = 160000;
                            Anglx = 0;
                        }
                        if (Cint == 17) {
                            int = 5;
                            CHX = 140.17;
                            CHY = 1366.07;
                            CHZ = 1083.65;
                            Cprice = 300000;
                            Anglx = 0;
                        }
                        if (Cint == 18) {
                            int = 12;
                            CHX = 2324.53;
                            CHY = -1149.54;
                            CHZ = 1050.71;
                            Cprice = 400000;
                            Anglx = 0;
                        }
                        if (Cint == 19) {
                            int = 7;
                            CHX = 225.68;
                            CHY = 1021.45;
                            CHZ = 1084.02;
                            Cprice = 450000;
                            Anglx = 0;
                        }
                        if (Cint == 20) {
                            int = 6;
                            CHX = 234.19;
                            CHY = 1063.73;
                            CHZ = 1084.21;
                            Cprice = 500000;
                            Anglx = 0;
                        }
                        new Ids;
                        format(result, sizeof(result), "INSERT INTO `house` (`Price`, `Interior`, `InteriorB`, `X`, `Y`, `Z`, `SHX`, `SHY`, `SHZ`, `SHXB`, `SHYB`, `SHZB`, `Status`, `Angle`, `Angl`, `AngleB`) VALUE ('%d', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', 2, '%f', '%f', '%f')", Cprice, int, int, CX, CY, CZ, CHX, CHY, CHZ, CHX, CHY, CHZ, Anglx, Anglea, Anglx);
                        mysql_query(result);
                        printf("%s", result);
                        mysql_free_result();
                        mysql_query("SELECT `ID` FROM `house` ORDER BY `ID` DESC LIMIT 1");
                        mysql_store_result();
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>i",
                            Ids);
                        mysql_free_result();
                        new query[128];
                        format(query, sizeof(query), "SELECT * FROM `house` WHERE `ID` ='%i'", Ids);
                        mysql_query(query);
                        mysql_store_result();
                        if (mysql_num_rows() == 1) {
                            mysql_fetch_row_format(result, "|");
                            sscanf(result, "p<|>iiiiiiifffffffffifff",
                                HouseInfo[Ids][ID],
                                HouseInfo[Ids][Price],
                                HouseInfo[Ids][Boss],
                                HouseInfo[Ids][Int],
                                HouseInfo[Ids][IntB],
                                HouseInfo[Ids][Bank],
                                HouseInfo[Ids][Heal],
                                HouseInfo[Ids][HX],
                                HouseInfo[Ids][HY],
                                HouseInfo[Ids][HZ],
                                HouseInfo[Ids][SHX],
                                HouseInfo[Ids][SHY],
                                HouseInfo[Ids][SHZ],
                                HouseInfo[Ids][SHXB],
                                HouseInfo[Ids][SHYB],
                                HouseInfo[Ids][SHZB],
                                HouseInfo[Ids][Status],
                                HouseInfo[Ids][Angle],
                                HouseInfo[Ids][Angl],
                                HouseInfo[Ids][AngleB]);
                            mysql_free_result();
                        }
                        format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", HouseInfo[Ids][Boss]);
                        mysql_query(query);
                        mysql_store_result();
                        if (mysql_num_rows() == 1) {
                            mysql_fetch_row_format(result, "|");
                            sscanf(result, "p<|>s[64]",
                                HouseInfo[Ids][BossName]);
                            mysql_free_result(); // Очищаем память.
                        }
                        HousePickupIn[Ids] = CreateDynamicPickup(1273, 23, CX, CY, CZ, 0);
                        HouseMapIcon[Ids] = CreateDynamicMapIcon(CX, CY, CZ, 31, 0);

                    }
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/creategarage", true) == 0) {
            if (PlayerInfo[playerid][Admin] == 1998) {
                cbbb[playerid] = 1;

                SendClientMessage(playerid, COLOR_GRAD1, "Координаты позиции записаны.");

                CBBB(playerid);
                tmp = strtok(cmdtext, idx);

                new resultt = strval(tmp);
                printf("r= %d", resultt);
                if (resultt == 0) {
                    SendClientMessage(playerid, COLOR_GRAD1, "/creategarage [номер дома]");

                } else {
                    if (resultt != 0) {
                        new result[1000];
                        new Cint = resultt;

                        new Ids;
                        format(result, sizeof(result), "INSERT INTO `garage` (`House`, `X`, `Y`, `Z`, `A`) VALUE ('%d', '%f', '%f', '%f', '%f')", Cint, cbEnterX, cbEnterY, cbEnterZ, cbEnterA);
                        mysql_query(result);
                        printf("%s", result);
                        mysql_free_result();
                        mysql_query("SELECT `ID` FROM `garage` ORDER BY `ID` DESC LIMIT 1");
                        mysql_store_result();
                        mysql_fetch_row_format(result, "|");
                        sscanf(result, "p<|>i",
                            Ids);
                        mysql_free_result();
                        new query[128];
                        format(query, sizeof(query), "SELECT * FROM `garage` WHERE `ID` ='%i'", Ids);
                        mysql_query(query);
                        mysql_store_result();
                        if (mysql_num_rows() == 1) {
                            mysql_fetch_row_format(result, "|");
                            sscanf(result, "p<|>iiffff",
                                GarageInfo[Ids][ID],
                                GarageInfo[Ids][House],
                                GarageInfo[Ids][GX],
                                GarageInfo[Ids][GY],
                                GarageInfo[Ids][GZ],
                                GarageInfo[Ids][GA]);
                            mysql_free_result();
                        }
                        SendClientMessage(playerid, COLOR_GRAD1, "Гараж создан.");
                    }
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/cbb", true) == 0) {
            if (PlayerInfo[playerid][Admin] == 1998) {
                cbbb[playerid] = 1;

                tmp = strtok(cmdtext, idx);

                new resull = strval(tmp);
                SendClientMessage(playerid, COLOR_GRAD1, "Координаты позиции записаны.");

                CBB(playerid, resull);
            }
            return 1;
        }
        if (strcmp(cmd, "/cb", true) == 0) {
            if (PlayerInfo[playerid][Admin] == 1998) {
                if (cbbb[playerid] == 1) {
                    new length = strlen(cmdtext);
                    while ((idx < length) && (cmdtext[idx] <= ' ')) {
                        idx++;
                    }
                    new offset = idx;
                    new resultt[64];
                    while ((idx < length) && ((idx - offset) < (sizeof(resultt) - 1))) {
                        resultt[idx - offset] = cmdtext[idx];
                        idx++;
                    }
                    resultt[idx - offset] = EOS;
                    new Float:x, Float:y, Float:z, Float:ang, Float: angel;
                    GetPlayerPos(playerid, x, y, z);
                    GetPlayerFacingAngle(playerid, ang);
                    angel = (ang - 180);
                    new result[1100], ress[700];
                    new Float:SpawnXX, Float:SpawnYY, Float:SpawnZZ, Float:sEnterXX, Float:sEnterYY, Float:sEnterZZ, Summa, Inttt, Float:ae;
                    /*if(cbSpawn == 1)
			{//ферма
			sEnterXX = 1716.87;
            sEnterYY = -2439.98;
            sEnterZZ = 8.5645;
            SpawnXX = 1714.3;
            SpawnYY = -2440.09;
            SpawnZZ = 8.3;
            Summa = 500000;
			}*/
                    if (cbSpawn == 1) { //24/7 магазин
                        sEnterXX = 1734.2975;
                        sEnterYY = -2476.8591;
                        sEnterZZ = 8.5939;
                        SpawnXX = 1733.9170;
                        SpawnYY = -2480.5002;
                        SpawnZZ = 8.8097;
                        Summa = 80000;
                        Inttt = 0;
                        ae = 0;
                    }
                    if (cbSpawn == 2) { //Заправка
                        sEnterXX = 0;
                        sEnterYY = 0;
                        sEnterZZ = 0;
                        SpawnXX = 0;
                        SpawnYY = 0;
                        SpawnZZ = 0;
                        Summa = 100000;
                        Inttt = 0;
                        ae = 0;
                    }
                    if (cbSpawn == 3) { //Закусочная
                        sEnterXX = 365.82;
                        sEnterYY = -9.64;
                        sEnterZZ = 1001.85;
                        SpawnXX = 364.73;
                        SpawnYY = -11.66;
                        SpawnZZ = 1001.85;
                        Summa = 90000;
                        Inttt = 9;
                        ae = 341;
                    }
                    if (cbSpawn == 4) { //Закусочная
                        sEnterXX = 371.72;
                        sEnterYY = -130.47;
                        sEnterZZ = 1001.49;
                        SpawnXX = 372.21;
                        SpawnYY = -133.52;
                        SpawnZZ = 1001.49;
                        Summa = 90000;
                        Inttt = 5;
                        ae = 0;
                    }
                    if (cbSpawn == 5) { //Закусочная
                        sEnterXX = 365.85;
                        sEnterYY = -73.44;
                        sEnterZZ = 1001.51;
                        SpawnXX = 362.95;
                        SpawnYY = -75.25;
                        SpawnZZ = 1001.51;
                        Summa = 90000;
                        Inttt = 10;
                        ae = 300;
                    }
                    if (cbSpawn == 6) { //СТО
                        sEnterXX = 614.22;
                        sEnterYY = -124.65;
                        sEnterZZ = 997.99;
                        SpawnXX = 0;
                        SpawnYY = 0;
                        SpawnZZ = 0;
                        Summa = 200000;
                        Inttt = 3;
                        ae = 270;
                    }
                    if (cbSpawn == 7) { //Клуб
                        sEnterXX = 493.09;
                        sEnterYY = -21.18;
                        sEnterZZ = 1000.68;
                        SpawnXX = 493.19;
                        SpawnYY = -24.56;
                        SpawnZZ = 1000.68;
                        Summa = 200000;
                        Inttt = 17;
                        ae = 0;
                    }
                    if (cbSpawn == 8) { //Бар
                        sEnterXX = 502.81;
                        sEnterYY = -70.71;
                        sEnterZZ = 998.76;
                        SpawnXX = 502.12;
                        SpawnYY = -67.76;
                        SpawnZZ = 998.76;
                        Summa = 100000;
                        Inttt = 11;
                        ae = 180;
                    }
                    format(ress, sizeof(ress), "INSERT INTO `business` (`Name`, `Boss`, `Status`, `AngelE`, `TDX`, `TDY`, `TDZ`, `Angel`, `EnterX`, `EnterY`, `EnterZ`, `EnterA`, `SpawnX`, `SpawnY`, `SpawnZ`, `sEnterX`, `sEnterY`, `sEnterZ`, `Sum`, `Type`, `Interior`) VALUE (");

                    strcat(result, ress);
                    new rr[600];
                    format(rr, sizeof(rr), "'%s', '0', '2', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d', '%d')", resultt, ae, x, y, z, angel, cbEnterX, cbEnterY, cbEnterZ, cbEnterA, SpawnXX, SpawnYY, SpawnZZ, sEnterXX, sEnterYY, sEnterZZ, Summa, cbSpawn, Inttt);
                    strcat(result, rr);
                    mysql_query(result);
                    printf("%s", result);
                    new reset[264];
                    format(reset, sizeof(reset), "SELECT `ID` FROM `business` WHERE `Name` = '%s' AND `Status` = 2 AND `Type` = '%d' AND `Sum` = '%d' AND `Interior` = '%d'", resultt, cbSpawn, Summa, Inttt);
                    mysql_query(reset);
                    printf("%s", reset);
                    new resuld[5 + 24 + 64];

                    new au;
                    mysql_store_result();
                    if (mysql_num_rows() == 1) {
                        mysql_fetch_row_format(resuld, "|");
                        sscanf(resuld, "p<|>i",
                            au);
                        mysql_free_result(); // Очищаем память.

                    }
                    BusinessL(playerid, au);
                } else {
                    SendClientMessage(playerid, COLOR_GRAD1, "Координаты позиции не записаны.");
                }
            }
            return 1;
        }
        if (strcmp(cmdtext, "/arepair", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 1) {
                new Float:health;
                new veh = GetPlayerVehicleID(playerid);
                GetVehicleHealth(veh, health);
                SetVehicleHealthAC(veh, 1000);
                VehicleHealth[veh] = 1000;
                SetVehicleHealth(veh, 1000);
                RepairVehicle(veh);
                SendClientMessage(playerid, COLOR_GREEN, "Транспортное средство восстановлено!");
            }
            return 1;
        }

        if (strcmp(cmd, "/funinvite", true) == 0) {
            new que[128];
            tmp = strtok(cmdtext, idx);
            new otherplayer = strval(tmp);
            if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {

                if (!strlen(tmp)) {
                    SendClientMessage(playerid, COLOR_GREEN, "/funinvite [id], уволить фермера");
                }

                if (strlen(tmp)) {
                    if (IsPlayerConnected(otherplayer) && otherplayer != playerid) {
                        FermaSave();
                        PlayerInfo[otherplayer][FermaLS] = 0;
                        format(que, sizeof(que), "Вы уволили %s с должности фермера.", PlayerInfo[otherplayer][Name]);
                        SendClientMessage(playerid, COLOR_GREEN, que);
                        format(que, sizeof(que), "Вас уволил %s с должности фермера.", PlayerInfo[playerid][Name]);
                        SendClientMessage(otherplayer, COLOR_GREEN, que);
                        if (FermaInfo[1][Fermer1] == PlayerInfo[otherplayer][ID]) {
                            FermaInfo[1][Fermer1] = 0;
                        }
                        if (FermaInfo[1][Fermer2] == PlayerInfo[otherplayer][ID]) {
                            FermaInfo[1][Fermer2] = 0;
                        }
                        if (FermaInfo[1][Fermer3] == PlayerInfo[otherplayer][ID]) {
                            FermaInfo[1][Fermer3] = 0;
                        }
                        if (FermaInfo[1][Fermer4] == PlayerInfo[otherplayer][ID]) {
                            FermaInfo[1][Fermer4] = 0;
                        }
                        if (FermaInfo[1][Fermer5] == PlayerInfo[otherplayer][ID]) {
                            FermaInfo[1][Fermer5] = 0;
                        }
                    }
                }
            }
            if (FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                if (!strval(tmp)) {
                    SendClientMessage(playerid, COLOR_GREEN, "/funinvite [id], уволить фермера");
                }
                if (strval(tmp)) {
                    if (IsPlayerConnected(otherplayer)) {
                        PlayerInfo[otherplayer][FermaSF] = 0;
                        format(que, sizeof(que), "Вы уволили %s с должности фермера.", PlayerInfo[otherplayer][Name]);
                        SendClientMessage(playerid, COLOR_GREEN, que);
                        format(que, sizeof(que), "Вас уволил %s с должности фермера.", PlayerInfo[playerid][Name]);
                        SendClientMessage(otherplayer, COLOR_GREEN, que);
                        if (FermaInfo[2][Fermer1] == PlayerInfo[otherplayer][ID]) {
                            FermaInfo[2][Fermer1] = 0;
                        }
                        if (FermaInfo[2][Fermer2] == PlayerInfo[otherplayer][ID]) {
                            FermaInfo[2][Fermer2] = 0;
                        }
                        if (FermaInfo[2][Fermer3] == PlayerInfo[otherplayer][ID]) {
                            FermaInfo[2][Fermer3] = 0;
                        }
                        if (FermaInfo[2][Fermer4] == PlayerInfo[otherplayer][ID]) {
                            FermaInfo[2][Fermer4] = 0;
                        }
                        if (FermaInfo[2][Fermer5] == PlayerInfo[otherplayer][ID]) {
                            FermaInfo[2][Fermer5] = 0;
                        }
                    }
                }
            }


            return 1;
        }
        if (strcmp(cmd, "/finvite", true) == 0) {
            if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {
                tmp = strtok(cmdtext, idx);
                new rang;
                new otherplayer = strval(tmp);
                printf("%s", tmp);
                if (!strlen(tmp)) {
                    SendClientMessage(playerid, COLOR_GREEN, "/finvite [id], взять фермером");
                }
                if (strlen(tmp)) {
                    if (IsPlayerConnected(otherplayer) && otherplayer != playerid) {
                        new que[128];
                        if (ProxDetectorS(4.0, playerid, otherplayer)) {
                            if (FermaInfo[1][Fermer1] != PlayerInfo[otherplayer][ID] && FermaInfo[1][Fermer2] != PlayerInfo[otherplayer][ID] && FermaInfo[1][Fermer3] != PlayerInfo[otherplayer][ID] && FermaInfo[1][Fermer4] != PlayerInfo[otherplayer][ID] && FermaInfo[1][Fermer5] != PlayerInfo[otherplayer][ID]) {
                                if (FermaInfo[1][Fermer1] != 0 && FermaInfo[1][Fermer2] != 0 && FermaInfo[1][Fermer3] != 0 && FermaInfo[1][Fermer4] != 0 && FermaInfo[1][Fermer5] != 0) {
                                    SendClientMessage(otherplayer, COLOR_GREEN, "У Вас нет свободных мест для вакансии фермера. Вы можете уволить кого-то из фермеров, чтобы освободить место.");
                                } else {
                                    format(que, sizeof(que), "Вы приняли %s на должность фермера.", PlayerInfo[otherplayer][Name]);
                                    SendClientMessage(playerid, COLOR_GREEN, que);
                                    format(que, sizeof(que), "Вас принял %s на должность фермера.", PlayerInfo[playerid][Name]);
                                    SendClientMessage(otherplayer, COLOR_GREEN, que);
                                    PlayerInfo[otherplayer][FermaLS] = 1;
                                    FermaSave();
                                    if (FermaInfo[1][Fermer1] == 0) {
                                        if (rang == 0) {
                                            FermaInfo[1][Fermer1] = PlayerInfo[otherplayer][ID];
                                            rang = 1;
                                        }
                                    }
                                    if (FermaInfo[1][Fermer2] == 0) {
                                        if (rang == 0) {
                                            FermaInfo[1][Fermer2] = PlayerInfo[otherplayer][ID];
                                            rang = 1;
                                        }
                                    }
                                    if (FermaInfo[1][Fermer3] == 0) {
                                        if (rang == 0) {
                                            FermaInfo[1][Fermer3] = PlayerInfo[otherplayer][ID];
                                            rang = 1;
                                        }
                                    }
                                    if (FermaInfo[1][Fermer4] == 0) {
                                        if (rang == 0) {
                                            FermaInfo[1][Fermer4] = PlayerInfo[otherplayer][ID];
                                            rang = 1;
                                        }
                                    }
                                    if (FermaInfo[1][Fermer5] == 0) {
                                        if (rang == 0) {
                                            FermaInfo[1][Fermer5] = PlayerInfo[otherplayer][ID];
                                            rang = 1;
                                        }
                                    }
                                    rang = 0;
                                }
                            } else {
                                SendClientMessage(playerid, COLOR_GREEN, "Игрок уже работает фермером.");
                            }
                        } else {
                            SendClientMessage(playerid, COLOR_GREEN, "Вы должны находится рядом.");
                        }
                    } else {
                        SendClientMessage(playerid, COLOR_GREEN, "Игрок с указанным ID не в игре или это Ваш ID.");
                    }
                }
            }
            if (FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                tmp = strtok(cmdtext, idx);
                new rang;
                new otherplayer = strval(tmp);
                printf("%s", tmp);
                if (!strlen(tmp)) {
                    SendClientMessage(playerid, COLOR_GREEN, "/finvite [id], взять фермером");
                }
                if (strlen(tmp)) {
                    if (IsPlayerConnected(otherplayer) && otherplayer != playerid) {
                        new que[128];
                        if (ProxDetectorS(4.0, playerid, otherplayer)) {
                            if (FermaInfo[2][Fermer1] != PlayerInfo[otherplayer][ID] && FermaInfo[2][Fermer2] != PlayerInfo[otherplayer][ID] && FermaInfo[2][Fermer3] != PlayerInfo[otherplayer][ID] && FermaInfo[2][Fermer4] != PlayerInfo[otherplayer][ID] && FermaInfo[1][Fermer5] != PlayerInfo[otherplayer][ID]) {
                                if (FermaInfo[2][Fermer1] != 0 && FermaInfo[2][Fermer2] != 0 && FermaInfo[2][Fermer3] != 0 && FermaInfo[2][Fermer4] != 0 && FermaInfo[2][Fermer5] != 0) {
                                    SendClientMessage(otherplayer, COLOR_GREEN, "У Вас нет свободных мест для вакансии фермера. Вы можете уволить кого-то из фермеров, чтобы освободить место.");
                                } else {
                                    format(que, sizeof(que), "Вы приняли %s на должность фермера.", PlayerInfo[otherplayer][Name]);
                                    SendClientMessage(playerid, COLOR_GREEN, que);
                                    format(que, sizeof(que), "Вас принял %s на должность фермера.", PlayerInfo[playerid][Name]);
                                    SendClientMessage(otherplayer, COLOR_GREEN, que);
                                    PlayerInfo[otherplayer][FermaSF] = 1;
                                    FermaSave();
                                    if (FermaInfo[2][Fermer1] == 0) {
                                        if (rang == 0) {
                                            FermaInfo[2][Fermer1] = PlayerInfo[otherplayer][ID];
                                            rang = 1;
                                        }
                                    }
                                    if (FermaInfo[2][Fermer2] == 0) {
                                        if (rang == 0) {
                                            FermaInfo[2][Fermer2] = PlayerInfo[otherplayer][ID];
                                            rang = 1;
                                        }
                                    }
                                    if (FermaInfo[2][Fermer3] == 0) {
                                        if (rang == 0) {
                                            FermaInfo[2][Fermer3] = PlayerInfo[otherplayer][ID];
                                            rang = 1;
                                        }
                                    }
                                    if (FermaInfo[2][Fermer4] == 0) {
                                        if (rang == 0) {
                                            FermaInfo[2][Fermer4] = PlayerInfo[otherplayer][ID];
                                            rang = 1;
                                        }
                                    }
                                    if (FermaInfo[2][Fermer5] == 0) {
                                        if (rang == 0) {
                                            FermaInfo[2][Fermer5] = PlayerInfo[otherplayer][ID];
                                            rang = 1;
                                        }
                                    }
                                    rang = 0;
                                }
                            } else {
                                SendClientMessage(playerid, COLOR_GREEN, "Игрок уже работает фермером.");
                            }
                        } else {
                            SendClientMessage(playerid, COLOR_GREEN, "Вы должны находится рядом.");
                        }
                    } else {
                        SendClientMessage(playerid, COLOR_GREEN, "Игрок с указанным ID не в игре или это Ваш ID.");
                    }
                }

            }
            return 1;
        }
        if (strcmp(cmd, "/fcar", true) == 0) {
            if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID] || PlayerInfo[playerid][FermaLS] == 1) {
                for (new i; i < MAX_VEHICLES; i++) {
                    if (fermalscars(i)) {
                        SetVehicleToRespawn(i);
                    }
                }
                SendClientMessage(playerid, COLOR_SYSTEM, "Все машины доставлены на ферму. С Вас было снято $100.");
                GiveMoney(playerid, -100);
            }
            return 1;
        }
        if (strcmp(cmd, "/rules", true) == 0) {
            Rules(playerid);

            return 1;
        }
        if (strcmp(cmd, "/z", true) == 0) {

            tmp = strtok(cmdtext, idx);

            new otherplayer = strval(tmp);
            SetPlayerInterior(playerid, otherplayer);
            return 1;
        }
        if (strcmp(cmd, "/e", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 1) {
                new Float:Anglea, strin[26];
                GetPlayerFacingAngle(playerid, Anglea);
                format(strin, sizeof(strin), "Your facing angle: %0.2f", Anglea);
                SendClientMessage(playerid, 0xFFFFFFFF, strin);
                //PlayerInfo[playerid][House] = 0;
            }
            return 1;
        }
        if (strcmp(cmd, "/exit", true) == 0) {
            if (GetPlayerVirtualWorld(playerid) == playerid) {
                if (Inter[playerid] == 1) {
                    new l = PlayerInfo[playerid][House];
                    SetPlayerVirtualWorld(playerid, DIALOG_HOUSEINFO + l);
                    SetPos(playerid, HouseInfo[l][SHX], HouseInfo[l][SHY], HouseInfo[l][SHZ]);
                    SetPlayerInterior(playerid, HouseInfo[l][Int]);
                    SetPlayerFacingAngle(playerid, HouseInfo[l][Angle]);
                    TogglePlayerControllable(playerid, 1);
                    TextDrawHideForPlayer(playerid, ButtonLeft);
                    TextDrawHideForPlayer(playerid, ButtonRight);
                    TextDrawHideForPlayer(playerid, ButtonSelect);
                    CancelSelectTextDraw(playerid);
                    SetCameraBehindPlayer(playerid);
                    Inter[playerid] = 0;
                }
            } else {

                new ids = (GetPlayerVirtualWorld(playerid) - DIALOG_HOUSEINFO);
                if (ids >= 1 && ids <= 1001) {
                    SetPlayerVirtualWorld(playerid, 0);
                    SetPlayerInterior(playerid, 0);
                    SetPlayerFacingAngle(playerid, HouseInfo[ids][Angl] + 180);
                    new Float:vehxx, Float:vehyy, Float:vehzz;
                    GetPlayerPos(playerid, vehxx, vehyy, vehzz);
                    vehxx = HouseInfo[ids][HX];
                    vehyy = HouseInfo[ids][HY];
                    vehxx += (1.5 * floatsin(-HouseInfo[ids][Angl] + 180, degrees));
                    vehyy += (1.5 * floatcos(-HouseInfo[ids][Angl] + 180, degrees));
                    SetPos(playerid, vehxx, vehyy, HouseInfo[ids][HZ]);
                    SetCameraBehindPlayer(playerid);
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/gps", true) == 0) {
            ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS-навигатор", "1. Работа\n2. Закусочные\n3. Заправки\n4. Магазины 24/7\n5. Важные места\n6. Станции технического обслуживания [СТО]\n6. Местонахождение моего дома", "Выбрать", "Закрыть");
            return 1;
        }
        if (strcmp(cmd, "/lock", true) == 0) {
            new Float:cx, Float:cy, Float:cz;
            new engine, lights, alarm, doors, bonnet, boot, objective;
            GetVehiclePos(lcarid[playerid], cx, cy, cz);
            if (!PlayerToPoint(3.0, playerid, cx, cy, cz)) {

            } else {

                GetVehicleParamsEx(lcarid[playerid], engine, lights, alarm, doors, bonnet, boot, objective);
                if (doors) {
                    SetVehicleParamsEx(lcarid[playerid], engine, lights, alarm, false, bonnet, boot, objective);
                    GameTextForPlayer(playerid, "~g~Unlock", 1000, 6);
                    VehicleInfo[lcarid[playerid]][vLock] = false;
                }
                if (!doors) {
                    SetVehicleParamsEx(lcarid[playerid], engine, lights, alarm, true, bonnet, boot, objective);
                    GameTextForPlayer(playerid, "~y~Lock", 1000, 6);
                    VehicleInfo[lcarid[playerid]][vLock] = true;
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/food", true) == 0) {
            new a[70];
            format(a, sizeof(a), "Ваша сытость составляет %d%s.", PlayerInfo[playerid][Golod], "%%");
            SendClientMessage(playerid, COLOR_GREEN, a);
            return 1;
        }
        if (strcmp(cmd, "/healme", true) == 0) {
            new wvv = GetPlayerVirtualWorld(playerid);
            if (DIALOG_HOUSEINFO < wvv && wvv <= DIALOG_HOUSEBUY) {
                new ids = wvv - DIALOG_HOUSEINFO;
                if (HouseInfo[ids][Heal] > 0) {
                    SetPlayerHealthACC(playerid, 100);
                    HouseInfo[ids][Heal] -= 1;
                    SendClientMessage(playerid, COLOR_RED, "Вы использовали аптечку.");
                } else {
                    SendClientMessage(playerid, COLOR_RED, "В доме нет аптечек.");
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/v", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 1) {
                tmp = strtok(cmdtext, idx);

                new otherplayer = strval(tmp);
                new Float:x, Float:y, Float:z, Float:xx;
                GetPlayerPos(playerid, x, y, z);
                xx = (x - 5);
                new a;
                a = CreateVehicle(otherplayer, xx, y, z, 1, 1, 1, 6000);
                SetVehicleParamsEx(a, false, false, false, false, false, false, false);
            }
            return 1;
        }
        if (strcmp(cmd, "/skin", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 1) {
                tmp = strtok(cmdtext, idx);

                new otherplayer = strval(tmp);
                if (otherplayer >= 0 && otherplayer <= 299) {
                    SetPlayerSkin(playerid, otherplayer);
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/akill", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 3) {
                tmp = strtok(cmdtext, idx);
                if (strlen(tmp) && IsPlayerNPC(strval(tmp))) return 1;
                if (!strlen(tmp)) {
                    SendClientMessage(playerid, COLOR_SYSTEM, " Использование: /akill ID");
                } else {
                    if (!IsPlayerConnected(strval(tmp))) {
                        SendClientMessage(playerid, COLOR_SYSTEM, " Неверный ID.");
                    } else {
                        SetPlayerHealth(strval(tmp), 0);
                        format(string, sizeof(string), "%s был убит администратором %s", PlayerName(strval(tmp)));
                        SendClientMessageToAll(0xFF0000FF, string);
                    }
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/pay", true) == 0) {

            tmp = strtok(cmdtext, idx);

            if (!strlen(tmp)) {
                SendClientMessage(playerid, COLOR_WHITE, "Сервер: /pay [id] [количество]");
                return 1;
            }
            giveplayerid = strval(tmp);

            tmp = strtok(cmdtext, idx);
            if (!strlen(tmp)) {
                SendClientMessage(playerid, COLOR_WHITE, "Сервер: /pay [id] [количество]");
                return 1;
            }
            moneys = strval(tmp);


            if (PlayerInfo[playerid][Level] >= 2) {
                if (IsPlayerConnected(giveplayerid)) {
                    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    playermoney = PlayerInfo[playerid][Money];
                    if (moneys > 0 && playermoney >= moneys) {
                        if (ProxDetectorS(1.0, playerid, giveplayerid)) {
                            if (playerid != giveplayerid) {
                                if (moneys <= 1000) {
                                    new mn;
                                    printf("moneys = %d", moneys);
                                    printf("giveplayerid = %d", giveplayerid);
                                    printf("playerid = %d", playerid);

                                    mn = 0 - moneys;
                                    GiveMoney(playerid, mn);
                                    printf("%i", mn);
                                    printf("moneys = %i", moneys);
                                    printf("money 1");
                                    GiveMoney(giveplayerid, moneys);
                                    printf("money 2");
                                    format(string, sizeof(string), "Отправлено %s(%d), $%d.", giveplayer, giveplayerid, moneys);
                                    SendClientMessage(playerid, COLOR_YELLOW, string);
                                    printf("money 4");
                                    format(string, sizeof(string), "Вы получили $%d от %s(player: %d).", moneys, sendername, playerid);
                                    printf("money 5");
                                    SendClientMessage(giveplayerid, COLOR_YELLOW, string);
                                    printf("money 6");
                                    printf("%s(playerid:%d) has transfered %d to %s(playerid:%d)", sendername, playerid, moneys, giveplayer, giveplayerid);
                                    printf("money 7");
                                    SaveAccount(giveplayerid);
                                    SaveAccount(playerid);
                                    new queryyy[300];
                                    new Seconds = gettime();
                                    format(queryyy, sizeof(queryyy), "INSERT INTO `moneys` (`GiveName`, `Name`, `time`, `sum`) VALUE ('%s', '%s', '%i', '%i')", sendername, giveplayer, Seconds, moneys);
                                    mysql_query(queryyy);
                                } else {
                                    SendClientMessage(playerid, COLOR_YELLOW, "Сумма которую Вы передаёте не должна быть больше 1000.");
                                }
                            }
                        } else {
                            format(string, sizeof(string), "Подойдите ближе к игроку.");
                            SendClientMessage(playerid, COLOR_YELLOW, string);
                        }
                        if (playerid == giveplayerid) {
                            format(string, sizeof(string), "Вы не можете передать деньги себе.");
                            SendClientMessage(playerid, COLOR_YELLOW, string);
                        }
                    } else {
                        SendClientMessage(playerid, COLOR_YELLOW, "Неверная сумма.");
                    }
                } else {
                    format(string, sizeof(string), "Игрока с id %d нету в игре ", giveplayerid);
                    SendClientMessage(playerid, COLOR_YELLOW, string);
                }
            } else {
                format(string, sizeof(string), "Данная команда доступна с двух лет проживания в штате.");
                SendClientMessage(playerid, COLOR_YELLOW, string);
            }
            return 1;
        }
        /*
        		if(strcmp(cmd, "/pay", true) == 0)
        		{
        			tmp = strtok(cmdtext, idx);
        			if(!strlen(tmp)) return	SendClientMessage(playerid, COLOR_WHITE, "Введите: /pay [id] [сумма]");
        			//giveplayerid = strval(tmp);
        	        giveplayerid = ReturnUser(tmp);
        			tmp = strtok(cmdtext, idx);
        			if(!strlen(tmp)) return	SendClientMessage(playerid, COLOR_GRAD1, "Введите: /pay [id] [сумма]");
        			moneys = strval(tmp);
        			if(moneys > 100000 && PlayerInfo[playerid][Level] < 3) return SendClientMessage(playerid, COLOR_GRAD1, "Вы должны быть 3 уровня, чтобы передать 1000 и больше вирт!");
        			if(moneys < 1 || moneys > 1000) return   SendClientMessage(playerid, COLOR_GRAD1, "Нельзя передать меньше $1 и больше $999.");
        			if (IsPlayerConnected(giveplayerid))
        			{
        			    if(giveplayerid != INVALID_PLAYER_ID)
               			{
        					if (ProxDetectorS(5.0, playerid, giveplayerid))
        					{
        						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
        						GetPlayerName(playerid, sendername, sizeof(sendername));
        						playermoney = GiveMoney(playerid);
        						if (moneys > 0 && playermoney >= moneys)
        						{
        							GiveMoney(giveplayerid, moneys);
        							GiveMoneyM(playerid, moneys);
        							printf("GiveMoney(playerid, -%i",moneys);
        							format(string, sizeof(string), "Вы передали %s[%d], %d вирт.", giveplayer,giveplayerid, moneys);
        							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
        							SendClientMessage(playerid, COLOR_GRAD1, string);
        							format(string, sizeof(string), "Вы получили %d вирт от %s[%d].", moneys, sendername, playerid);
        							SendClientMessage(giveplayerid, COLOR_GRAD1, string);
        			    			format(string, sizeof(string), " - [1] Nick %s Peredal = %d | [2] Nick: %s Poluchil =%d\n", sendername, moneys, giveplayer,moneys);
        						    printf(string);
        							if(moneys >= 1000000)
        							{
        								ABroadCast(COLOR_YELLOW,string,1);
        							}
        							PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
        							format(string,sizeof(string), "достал бумажник и передал деньги %s",giveplayer);
        							SetPlayerChatBubble(playerid,string,COLOR_PURPLE,30.0,10000);
        						}
        						else
        						{
        							SendClientMessage(playerid, COLOR_GRAD1, "У вас нет столько денег");
        						}
        					}
        					else
        					{
        						SendClientMessage(playerid, COLOR_GRAD1, "Вы слишком далеко.");
        					}
        				}//invalid id
        			}
        			else
        			{
        				SendClientMessage(playerid, COLOR_GREY, "[Ошибка] Человек не найден!");
        			}
        		return 1;
        	}*/

        if (strcmp(cmd, "/s", true) == 0) {
            new length = strlen(cmdtext);
            while ((idx < length) && (cmdtext[idx] <= ' ')) {
                idx++;
            }
            new offset = idx;
            new result[64];
            while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
                result[idx - offset] = cmdtext[idx];
                idx++;
            }
            result[idx - offset] = EOS;
            if (!strlen(result)) return SendClientMessage(playerid, COLOR_WHITE, "Введите: /s [текст]");
            format(string, sizeof(string), "- %s кричит: %s!", PlayerInfo[playerid][Name], result);
            ProxDetector(60.0, playerid, string, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_FADE1, COLOR_FADE2);
            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
                ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 1000.0, 0, 0, 0, 0, 0, 1);
            }
            SetPlayerChatBubble(playerid, result, COLOR_YELLOW, 60.0, 10000);
            return 1;
        }
        if (strcmp(cmd, "/me", true) == 0) {
            new length = strlen(cmdtext);
            while ((idx < length) && (cmdtext[idx] <= ' ')) {
                idx++;
            }
            new offset = idx;
            new result[64];
            while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
                result[idx - offset] = cmdtext[idx];
                idx++;
            }
            result[idx - offset] = EOS;
            if (!strlen(result)) return SendClientMessage(playerid, COLOR_WHITE, "Введите: /me [текст]");
            format(string, sizeof(string), "- %s %s", PlayerInfo[playerid][Name], result);
            ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerChatBubble(playerid, result, COLOR_YELLOW, 10.0, 10000);
            return 1;
        }
        if (strcmp(cmd, "/w", true) == 0) {
            new length = strlen(cmdtext);
            while ((idx < length) && (cmdtext[idx] <= ' ')) {
                idx++;
            }
            new offset = idx;
            new result[64];
            while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
                result[idx - offset] = cmdtext[idx];
                idx++;
            }
            result[idx - offset] = EOS;
            if (!strlen(result)) return SendClientMessage(playerid, COLOR_WHITE, "Введите: /w [текст]");
            format(string, sizeof(string), "- %s шепотом: %s", PlayerInfo[playerid][Name], result);
            ProxDetector(3.0, playerid, string, COLOR_GRAY, COLOR_GRAY, COLOR_GRAY, COLOR_FADE1, COLOR_FADE2);
            return 1;
        }
        if (strcmp(cmd, "/ban", true) == 0) {
            if (PlayerInfo[playerid][Admin] == 3 || PlayerInfo[playerid][Admin] == 4 || PlayerInfo[playerid][Admin] == 1998) {
                new tmp2[256];
                tmp = strtok(cmdtext, idx);
                tmp2 = strtok(cmdtext, idx);
                if ((!strlen(tmp)) || (!strlen(tmp2)) || (!IsNumeric(tmp)) || (!IsNumeric(tmp2))) {
                    SendClientMessage(playerid, COLOR_GREY, "Используй: /ban [id] 1 [причина]");
                    return 1;
                }
                if (IsPlayerConnected(playerid)) {
                    new playeri, day, y, xsd, d, yy, mm, dd, nameme[MAX_PLAYER_NAME];
                    playeri = strval(tmp);
                    if (IsPlayerConnected(playeri)) {
                        if (PlayerInfo[playerid][Admin] < PlayerInfo[playeri][Admin]) {
                            SendClientMessage(playerid, COLOR_GREY, "Нельзя забанить администратора который старше вас!");
                            return 1;
                        }
                        new length = strlen(cmdtext);
                        while ((idx < length) && (cmdtext[idx] <= ' ')) {
                            idx++;
                        }
                        new offset = idx;
                        new result[64];
                        while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
                            result[idx - offset] = cmdtext[idx];
                            idx++;
                        }
                        result[idx - offset] = EOS;
                        new playername[MAX_PLAYER_NAME];
                        GetPlayerName(playeri, nameme, sizeof(nameme));
                        GetPlayerName(playerid, playername, sizeof(playername));
                        GetPlayerName(playeri, sendername, sizeof(sendername));
                        if (strlen(result)) {
                            if (playerid != playeri) {
                                format(string, sizeof(string), "{FF0000}Администратор %s забанил %s. Причина: %s.", playername, sendername, (result));
                                SendClientMessageToAll(COLOR_LIGHTRED, string);

                                getdate(y, xsd, d);
                                dd = d;
                                mm = xsd;
                                yy = y;
                                dd = dd + day;
                                while (dd > GetDayMount(xsd, y)) {
                                    mm++;
                                    if (mm > 12) {
                                        mm = 1;
                                        yy++;
                                    }
                                    dd = dd - GetDayMount(mm, yy);
                                }
                                format(string, sizeof(string), "%d,%d,%d", dd, mm, yy);
                                PlayerInfo[playeri][Bann] = 1;
                                new Seconds = gettime();
                                PlayerInfo[playeri][BanTime] = Seconds;
                                new queryyy[300];
                                format(queryyy, sizeof(queryyy), "INSERT INTO `bans` (`AdmName`, `Name`, `time`, `Reason`) VALUE ('%s', '%s', '%i', '%s')", playername, sendername, Seconds, result);
                                mysql_query(queryyy);
                                SaveAccount(playeri);
                                Statuss(playeri);
                                Ban(playeri);
                            }
                        } else {
                            SendClientMessage(playerid, COLOR_WHITE, "Вы не можете заблокировать себя!");
                        }
                    } else {
                        SendClientMessage(playerid, COLOR_GREY, "Игрок оффлайн!");
                    }
                }
            }
            return 1;
        }
        /*if(strcmp("/amakeadmin", cmdtext, true, 10) == 0)
    		{
        	if(IsPlayerConnected(playerid))
        	{
        	if(PlayerInfo[playerid][Admin] == 1998)
        	{
            tmp = strtok(cmdtext, idx);
            if(!strlen(tmp))
            {
                SendClientMessage(playerid, COLOR_SYSTEM, "[Используй]: /makeadmin [ID/Имя] [Lvl (0-4)]");
                return 1;
            }
            new para1;
            new level;
            para1 = ReturnUser(tmp);
            tmp = strtok(cmdtext, idx);
            level = strval(tmp);
            if(level > 4 || level < 0) { SendClientMessage(playerid, COLOR_SYSTEM, "[Сервер]: Lvl Админки может быть от 0 до 4"); return 1; }
            if(PlayerInfo[playerid][Admin] >= 5 || IsPlayerAdmin(playerid))
            {
                if(IsPlayerConnected(para1))
                {
                    if(para1 != INVALID_PLAYER_ID)
                    {
                        GetPlayerName(para1, giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        PlayerInfo[para1][Admin] = level;
                        printf("[Сервер]: %s продвинул %s на %d уровень админки.", sendername, giveplayer, level);
                        format(string, sizeof(string), "[Сервер]: {FF0000}Вам были выданы админ права %d -ого уровня админом %s ", level, sendername);
                        SendClientMessage(para1, COLOR_SYSTEM, string);
                        format(string, sizeof(string), "[Сервер]: {FF0000}Вы выдали игроку %s админ права %d уровня.", giveplayer,level);
                        SendClientMessage(playerid, COLOR_SYSTEM, string);
                        PlayerInfo[para1][Admin] = level;
                        SaveAccount(playerid);
                    }
                }
            }
           	}
        	}
        	return 1;
    		}*/
        if (strcmp(cmd, "/agivemoney", true) == 0) {
            if (IsPlayerConnected(playerid)) {
                if (PlayerInfo[playerid][Admin] == 1998) {
                    tmp = strtok(cmdtext, idx);
                    if (!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /GiveMoney [playerid/PartOfName] [money]");
                        return 1;
                    }
                    new playa;
                    new money;
                    playa = ReturnUser(tmp);
                    tmp = strtok(cmdtext, idx);
                    money = strval(tmp);
                    if (PlayerInfo[playerid][Admin] == 1998) {
                        if (IsPlayerConnected(playa)) {
                            if (playa != INVALID_PLAYER_ID) {
                                GiveMoney(playa, money);
                                SaveAccount(playa);
                            }
                        }
                    }
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/ajail", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 1) {
                tmp = strtok(cmdtext, idx);
                if (!strlen(tmp))
                    return SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /ajail [playerid] [reason]");
                new id = strval(tmp);
                if (!strlen(cmdtext[idx]))
                    return SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /ajail [playerid] [reason]");
                if (IsPlayerConnected(id)) {
                    if (id != INVALID_PLAYER_ID) {
                        format(string, sizeof(string), "Вы посадили в ДеМорган %s на 30 минут с причиной: %s", PlayerName(id), cmdtext[idx]);
                        SendClientMessage(playerid, COLOR_WHITE, string);
                        format(string, sizeof(string), "Вас посадил в ДеМорган %s на 30 минут. Причина: %s", PlayerName(playerid), cmdtext[idx]);
                        SendClientMessage(id, COLOR_WHITE, string);
                        format(string, sizeof(string), "%s посажен в ДеМорган администратором %s на 30 минут. Причина: %s", PlayerName(id), PlayerName(playerid), cmdtext[idx]);
                        SendClientMessageToAll(COLOR_RED, string);
                        //PlayerInfo[id][DeMorgan] = 1800;
                        PlayerInfo[id][DeMorgan] = 100;
                        NewSpawn[id] = 4;
                        OnPlayerSpawn(id);
                    }
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/unajail", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 1) {
                tmp = strtok(cmdtext, idx);
                if (!strlen(tmp))
                    return SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /unajail [playerid]");
                new id = strval(tmp);
                if (IsPlayerConnected(id)) {
                    if (id != INVALID_PLAYER_ID) {
                        format(string, sizeof(string), "Администратор %s выпустил с ДеМоргана %s.", PlayerName(playerid), PlayerName(id));
                        SendClientMessageToAll(COLOR_RED, string);
                        PlayerInfo[id][DeMorgan] = 0;
                        NewSpawn[playerid] = 1;
                        OnPlayerSpawn(playerid);
                    }
                }
            }
            return 1;
        }
        if (strcmp(cmd, "/mute", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 1) {
                tmp = strtok(cmdtext, idx);
                if (!strlen(tmp))
                    return SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /mute [playerid] [reason]");
                new id = strval(tmp);
                if (!strlen(cmdtext[idx]))
                    return SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /mute [playerid] [reason]");
                format(string, sizeof(string), "Вы заткнули %s на 60 минут с причиной: %s", PlayerName(id), cmdtext[idx]);
                SendClientMessage(playerid, COLOR_WHITE, string);
                format(string, sizeof(string), "Вас заткнул %s на 60 минут. Причина: %s", PlayerName(playerid), cmdtext[idx]);
                SendClientMessage(id, COLOR_WHITE, string);
                format(string, sizeof(string), "%s получил затычку от %s на 60 минут. Причина: %s", PlayerName(id), PlayerName(playerid), cmdtext[idx]);
                SendClientMessageToAll(COLOR_RED, string);
                PlayerInfo[id][Muted] = 3600;
            }
            return 1;
        }
        if (strcmp(cmd, "/unmute", true) == 0) {
            if (PlayerInfo[playerid][Admin] >= 1) {
                tmp = strtok(cmdtext, idx);
                if (!strlen(tmp))
                    return SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /unmute [playerid]");
                new id = strval(tmp);
                format(string, sizeof(string), "%s снял затычку c %s.", PlayerName(playerid), PlayerName(id));
                SendClientMessageToAll(COLOR_RED, string);
                PlayerInfo[id][Muted] = 0;
            }
            return 1;
        }
        if (strcmp(cmd, "/time", true) == 0) {
            if (IsPlayerConnected(playerid)) {
                if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
                    ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_watch", 4.1, 0, 0, 0, 0, 0);
                }
                GetPlayerName(playerid, sendername, sizeof(sendername));
                format(string, sizeof(string), "%s взглянул на часы", sendername);
                ProxDetector(25.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
                new mtext[20];
                new year, month, day;
                getdate(year, month, day);
                if (month == 1) { mtext = "January"; } else if (month == 2) { mtext = "February"; } else if (month == 3) { mtext = "March"; } else if (month == 4) { mtext = "April"; } else if (month == 5) { mtext = "May"; } else if (month == 6) { mtext = "June"; } else if (month == 7) { mtext = "July"; } else if (month == 8) { mtext = "August"; } else if (month == 9) { mtext = "September"; } else if (month == 10) { mtext = "October"; } else if (month == 11) { mtext = "November"; } else if (month == 12) { mtext = "December"; }
                new hour, minuite, second;
                gettime(hour, minuite, second);
                FixHour(hour);
                hour = shifthour;
                if (minuite < 10) {
                    if (PlayerInfo[playerid][JailTime] > 0) {
                        format(string, sizeof(string), "~y~%d %s~n~~g~~w~%d:0%d~n~~w~Jail Time Left: %d sec~n~~g~Location 1", day, mtext, hour, minuite, PlayerInfo[playerid][JailTime]);
                    } else {
                        format(string, sizeof(string), "~y~%d %s~n~~g~~w~%d:0%d~n~~g~Location 1", day, mtext, hour, minuite);
                    }
                    if (PlayerInfo[playerid][DeMorgan] > 0) {
                        format(string, sizeof(string), "~y~%d %s~n~~g~~w~%d:%d~n~~w~Jail Time Left: %d sec~n~~g~Location 1", day, mtext, hour, minuite, PlayerInfo[playerid][DeMorgan]);
                    }
                } else {
                    if (PlayerInfo[playerid][JailTime] > 0) {
                        format(string, sizeof(string), "~y~%d %s~n~~g~~w~%d:%d~n~~w~Jail Time Left: %d sec~n~~g~Location 1", day, mtext, hour, minuite, PlayerInfo[playerid][JailTime]);
                    } else {
                        format(string, sizeof(string), "~y~%d %s~n~~g~~w~%d:%d~n~~g~Location 1", day, mtext, hour, minuite);
                    }
                    if (PlayerInfo[playerid][DeMorgan] > 0) {
                        format(string, sizeof(string), "~y~%d %s~n~~g~~w~%d:%d~n~~w~Jail Time Left: %d sec~n~~g~Location 1", day, mtext, hour, minuite, PlayerInfo[playerid][DeMorgan]);
                    }
                }
                GameTextForPlayer(playerid, string, 5000, 6);
            }
            return 1;
        }

    }

    return SendClientMessage(playerid, COLOR_WHITE, "Сервер: Неизвестная команда");
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {

    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid) {

    return 1;
}
public IsAVelik(carid) { new model = GetVehicleModel(carid); if (model == 509 || model == 481 || model == 510) { return 1; } return 0; }

public OnPlayerStateChange(playerid, newstate, oldstate) {
    if (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER) {
        new model = GetVehicleModel(GetPlayerVehicleID(playerid));
        switch (model) {
            case 592, 577, 511, 512, 520, 593, 553, 476, 519, 460, 513, 548, 425, 417, 487, 488, 497, 563, 447, 469 : Weapons[playerid][46] = 1;
            case 457 : Weapons[playerid][2] = 1;
            case 596, 597, 598, 599 : Weapons[playerid][25] = 1;
        }

    }

    if (oldstate == PLAYER_STATE_DRIVER) {
        TextDrawHideForPlayer(playerid, SPG0);
        TextDrawHideForPlayer(playerid, SPG1);
        PlayerTextDrawHide(playerid, SP0[playerid]);
        PlayerTextDrawHide(playerid, SP1[playerid]);
        PlayerTextDrawHide(playerid, SP2[playerid]);
        PlayerTextDrawHide(playerid, SP3[playerid]);
        PlayerTextDrawHide(playerid, SP4[playerid]);
        PlayerTextDrawHide(playerid, SP5[playerid]);
        PlayerTextDrawHide(playerid, SP6[playerid]);
        PlayerTextDrawHide(playerid, SP7[playerid]);
        PlayerTextDrawHide(playerid, SP8[playerid]);
        KillTimer(SpeedTimer[playerid]);
        return 1;
    }
    if (oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT) {
        if (PlayerInfo[playerid][FermaLS] == 1 && fermalsstatus[playerid] == 1 || FermaInfo[1][Boss] == PlayerInfo[playerid][ID] && fermalsstatus[playerid] == 1) {
            DisablePlayerCheckpoint(playerid);
        }
    }
    if (newstate == PLAYER_STATE_DRIVER) {
        if (PlayerInfo[playerid][Level] <= 2) {
            SendClientMessage(playerid, COLOR_ORANGE, "Чтобы завести транспорт, нажмите 2 на Вашей клавиатуре.");
        }
    }
    if (newstate == PLAYER_STATE_DRIVER) {
        PlayerVehicleId[playerid] = GetPlayerVehicleID(playerid);
        new vehicleid = GetPlayerVehicleID(playerid);
        if (foodcarj(vehicleid)) {
            if (PlayerInfo[playerid][Level] >= 2) {

            } else {
                RemovePlayerFromVehicle(playerid);
                SendClientMessage(playerid, COLOR_ORANGE, "Работать продавцом еды можно лишь с двух лет проживания в штате.");
            }
        }
    }
    if (oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) {

        PlayerVehicleId[playerid] = GetPlayerVehicleID(playerid);
        new vehicleid = GetPlayerVehicleID(playerid);

        if (fermalscars(vehicleid)) {
            if (PlayerInfo[playerid][FermaLS] == 1 || FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {

                if (fermalsin[vehicleid][In] == 0) {
                    if (fermalsstatus[playerid] == 1) {
                        new randSpawn = random(sizeof(FermaLSCheckR));
                        FermaLSCheckRRX[playerid] = FermaLSCheckR[randSpawn][0];
                        FermaLSCheckRRZ[playerid] = FermaLSCheckR[randSpawn][2];
                        FermaLSCheckRRY[playerid] = FermaLSCheckR[randSpawn][1];
                        new models = GetVehicleModel(GetPlayerVehicleID(playerid));
                        if (models == 532) {
                            if (FermaInfo[1][Zerno] == 0) {
                                if (FermaInfo[1][Ammount] != 0) {
                                    SetPlayerCheckpoint(playerid, -121.6866, 146.7871, 2.4133, 4.0);
                                    SendClientMessage(playerid, COLOR_ORANGE, "Направляйтесь по указанному чек-поинтами маршруту.");
                                } else {
                                    SendClientMessage(playerid, COLOR_ORANGE, "На складе нет зерна.");
                                    RemovePlayerFromVehicle(playerid);
                                }
                            } else {
                                SendClientMessage(playerid, COLOR_ORANGE, "На поле ещё есть урожай.");
                                RemovePlayerFromVehicle(playerid);
                            }
                        }
                        if (models != 532) {
                            SetPlayerCheckpoint(playerid, FermaLSCheckR[randSpawn][0], FermaLSCheckR[randSpawn][1], FermaLSCheckR[randSpawn][2], 3.0);
                        }
                    } else {
                        SendClientMessage(playerid, COLOR_GREY, "Переоденьтесь в рабочую форму.");
                        RemovePlayerFromVehicle(playerid);
                    }
                }

                if (fermalsin[vehicleid][In] == 1) {
                    if (fermalsin[vehicleid][InG] == 1) {

                        if (fermalsstatus[playerid] == 1) {
                            SendClientMessage(playerid, COLOR_ORANGE, "Загрузка машины завершена. Отвезите груз на склад.");
                            DestroyPickup(FermaLSDynamicPR[vehicleid]);
                            Delete3DTextLabel(FermaLS3DTEXTR[vehicleid]);
                            DisablePlayerCheckpoint(playerid);
                            SetPlayerCheckpoint(playerid, -101.8093, 52.9478, 2.1020, 3.0);
                        } else {
                            SendClientMessage(playerid, COLOR_GREY, "Переоденьтесь в рабочую форму.");
                            RemovePlayerFromVehicle(playerid);
                        }



                    } else {
                        ShowPlayerDialog(playerid, DIALOG_FERMALSMASH, DIALOG_STYLE_MSGBOX, "Ферма Лос Сантоса", "Вы хотите прекратить загрузку машины?", " Да ", " Нет ");
                    }
                }
            } else {
                SendClientMessage(playerid, COLOR_GREY, "Транспорт принадлежит ферме Лос Сантоса.");
                RemovePlayerFromVehicle(playerid);
            }
        }

        if (fermasfcars(vehicleid)) {
            if (PlayerInfo[playerid][FermaSF] == 1 || FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {

                if (fermasfin[vehicleid][In] == 0) {
                    if (fermasfstatus[playerid] == 1) {
                        new randSpawn = random(sizeof(FermaSFCheckR));
                        FermaSFCheckRRX[playerid] = FermaSFCheckR[randSpawn][0];
                        FermaSFCheckRRZ[playerid] = FermaSFCheckR[randSpawn][2];
                        FermaSFCheckRRY[playerid] = FermaSFCheckR[randSpawn][1];
                        new models = GetVehicleModel(GetPlayerVehicleID(playerid));
                        if (models == 532) {
                            if (FermaInfo[2][Zerno] == 0) {
                                if (FermaInfo[2][Ammount] != 0) {
                                    SetPlayerCheckpoint(playerid, -1171.2776, -1033.9525, 128.1881, 4.0);
                                    SendClientMessage(playerid, COLOR_ORANGE, "Направляйтесь по указанному чек-поинтами маршруту.");
                                } else {
                                    SendClientMessage(playerid, COLOR_ORANGE, "На складе нет зерна.");
                                    RemovePlayerFromVehicle(playerid);
                                }
                            } else {
                                SendClientMessage(playerid, COLOR_ORANGE, "На поле ещё есть урожай.");
                                RemovePlayerFromVehicle(playerid);
                            }
                        }
                        if (models != 532) {
                            SetPlayerCheckpoint(playerid, FermaSFCheckR[randSpawn][0], FermaSFCheckR[randSpawn][1], FermaSFCheckR[randSpawn][2], 3.0);
                        }
                    } else {
                        SendClientMessage(playerid, COLOR_GREY, "Переоденьтесь в рабочую форму.");
                        RemovePlayerFromVehicle(playerid);
                    }
                }
                if (fermasfin[vehicleid][In] == 1) {
                    if (fermasfin[vehicleid][InG] == 1) {

                        if (fermasfstatus[playerid] == 1) {
                            SendClientMessage(playerid, COLOR_ORANGE, "Загрузка машины завершена. Отвезите груз на склад.");
                            DestroyPickup(FermaSFDynamicPR[vehicleid]);
                            Delete3DTextLabel(FermaSF3DTEXTR[vehicleid]);
                            DisablePlayerCheckpoint(playerid);
                            SetPlayerCheckpoint(playerid, -1056.8080, -1195.6364, 128.1294, 3.0);
                        } else {
                            SendClientMessage(playerid, COLOR_GREY, "Переоденьтесь в рабочую форму.");
                            RemovePlayerFromVehicle(playerid);
                        }



                    } else {
                        ShowPlayerDialog(playerid, DIALOG_FERMASFMASH, DIALOG_STYLE_MSGBOX, "Ферма Сан Фиерро", "Вы хотите прекратить загрузку машины?", " Да ", " Нет ");
                    }
                }
            } else {
                SendClientMessage(playerid, COLOR_GREY, "Транспорт принадлежит ферме Сан Фиерро.");
                RemovePlayerFromVehicle(playerid);
            }
        }
    }


    if (newstate == PLAYER_STATE_DRIVER) {

        new vehicle;
        vehicle = GetPlayerVehicleID(playerid);
        incar[playerid]++;
        if (incar[playerid] >= 5) {
            SendClientMessage(playerid, COLOR_RED, "Вы были отключены от сервера. Причина: Телепортация в машину.№1");
            lKick(playerid);
        }

        new engine, lights, alarm, doors, bonnet, boot, objective;
        GetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, boot, objective);
        if (doors) {
            if (!IsPlayerInVehicle(playerid, lcarid[playerid])) {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);
                SetPlayerPos(playerid, x, y, z + 8);
                slapd[playerid]++;
                if (slapd[playerid] >= 5) {
                    SendClientMessage(playerid, COLOR_RED, "Вы были отключены от сервера. Причина: Телепортация в машину.№2");
                    lKick(playerid);
                }
            }
        }
        if (!IsAVelik(GetPlayerVehicleID(playerid))) {
            new v = GetPlayerVehicleID(playerid);
            GetPlayerPos(playerid, VehicleInfo[v][vPosx], VehicleInfo[v][vPosy], VehicleInfo[v][vPosz]);
            TextDrawShowForPlayer(playerid, SPG0);
            TextDrawShowForPlayer(playerid, SPG1);
            PlayerTextDrawShow(playerid, SP0[playerid]);
            PlayerTextDrawShow(playerid, SP1[playerid]);
            PlayerTextDrawShow(playerid, SP2[playerid]);
            PlayerTextDrawShow(playerid, SP3[playerid]);
            PlayerTextDrawShow(playerid, SP4[playerid]);
            PlayerTextDrawShow(playerid, SP5[playerid]);
            PlayerTextDrawShow(playerid, SP6[playerid]);
            PlayerTextDrawShow(playerid, SP7[playerid]);
            PlayerTextDrawShow(playerid, SP8[playerid]);
            SpeedTimer[playerid] = SetTimerEx("UpdateSpeed", 100, 1, "d", playerid);
            return 1;
        }
    }



    return 1;
}


forward AFKSystem();
public AFKSystem() {
    for (new playerid; playerid < MAX_PLAYERS; playerid++) {
        if (IsPlayerConnected(playerid)) {
            if (PlayerInfo[playerid][Admin] == 0) {
                if (plafk[playerid] == 0) plafk[playerid] -= 1;
                else if (plafk[playerid] == -1) {
                    plafk[playerid] = 1;
                    new string[128];
                    format(string, sizeof(string), "АФК: %s", ConvertSeconds(plafk[playerid]));
                    SetPlayerChatBubble(playerid, string, COLOR_WHITE, 10.0, 70000000);
                } else if (plafk[playerid] > 0) {
                    new string[255];
                    plafk[playerid] += 1;
                    format(string, sizeof(string), "АФК: %s", ConvertSeconds(plafk[playerid]));
                    SetPlayerChatBubble(playerid, string, COLOR_WHITE, 10.0, 70000000);
                    if (plafk[playerid] >= 600) {
                        if (PlayerInfo[playerid][Admin] == 0) {
                            SendClientMessage(playerid, COLOR_RED, "Вы были кикнуты за АФК = 10 минут.");
                            lKick(playerid);
                        }
                    }
                }
            }
        }
    }
}
public OnPlayerLeaveCheckpoint(playerid) {
    return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid) {
    return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid) {
    return 1;
}

public OnRconCommand(cmd[]) {
    return 1;
}

public OnPlayerRequestSpawn(playerid) {
    return 1;
}

public OnObjectMoved(objectid) {
    return 1;
}

public OnPlayerObjectMoved(playerid, objectid) {
    return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid) {
    if (SpawnMZ[playerid] == 1) {
        if (Dpic[playerid] == 1) return false;
        else Dpic[playerid] = 1, GetPlayerPos(playerid, PosPic[0][playerid], PosPic[1][playerid], PosPic[2][playerid]);
        //if(PickUp[playerid] == 0)
        //{
        //	PickUp[playerid] = 1;
        //	SetTimerEx("PickUpAga", 4000, false, "i", playerid);

        if (pickupid == fermalspickupzp) {

            if (fermalsstatus[playerid] == 0) {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "Вы не работаете здесь.");
            }
            if (fermalsstatus[playerid] == 1) {
                DisablePlayerCheckpoint(playerid);
                if (fermalszp[playerid] == 0) {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Вы ничего ещё не заработали, но мы Вас отпускаем.");
                    for (new io = 0; io < MAX_PLAYER_ATTACHED_OBJECTS; io++) {
                        if (IsPlayerAttachedObjectSlotUsed(playerid, io)) RemovePlayerAttachedObject(playerid, io);
                    }
                    fermalsstatus[playerid] = 0;
                    SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
                } else {
                    GiveMoney(playerid, fermalszp[playerid]);
                    new st[128];
                    new opsdg[128];
                    format(st, sizeof(st), "Вы получили зарплату и закончили рабочий день.", fermalszp[playerid]);
                    format(opsdg, sizeof(opsdg), "~y~~n~~g~~w~~n~~w~+%d$", fermalszp[playerid]);
                    GameTextForPlayer(playerid, opsdg, 3000, 1);

                    fermalsstatus[playerid] = 1;
                    FermaInfo[1][Bank] -= fermalszp[playerid];
                    fermalszp[playerid] = 0;
                    SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);


                    SendClientMessage(playerid, COLOR_LIGHTBLUE, st);
                    for (new io = 0; io < MAX_PLAYER_ATTACHED_OBJECTS; io++) {
                        if (IsPlayerAttachedObjectSlotUsed(playerid, io)) RemovePlayerAttachedObject(playerid, io);
                    }
                    fermalsstatus[playerid] = 0;
                }
            }
        }

        if (pickupid == fermasfpickupzp) {

            if (fermasfstatus[playerid] == 0) {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "Вы не работаете здесь.");
            }
            if (fermasfstatus[playerid] == 1) {
                DisablePlayerCheckpoint(playerid);
                if (fermasfzp[playerid] == 0) {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Вы ничего ещё не заработали, но мы Вас отпускаем.");
                    for (new io = 0; io < MAX_PLAYER_ATTACHED_OBJECTS; io++) {
                        if (IsPlayerAttachedObjectSlotUsed(playerid, io)) RemovePlayerAttachedObject(playerid, io);
                    }
                    fermasfstatus[playerid] = 0;
                    SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
                } else {
                    GiveMoney(playerid, fermasfzp[playerid]);
                    new st[128];
                    new opsdg[128];
                    format(st, sizeof(st), "Вы получили зарплату и закончили рабочий день.", fermasfzp[playerid]);
                    format(opsdg, sizeof(opsdg), "~y~~n~~g~~w~~n~~w~+%d$", fermasfzp[playerid]);
                    GameTextForPlayer(playerid, opsdg, 3000, 1);

                    fermasfstatus[playerid] = 1;
                    FermaInfo[2][Bank] -= fermasfzp[playerid];
                    fermasfzp[playerid] = 0;
                    SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);


                    SendClientMessage(playerid, COLOR_LIGHTBLUE, st);
                    for (new io = 0; io < MAX_PLAYER_ATTACHED_OBJECTS; io++) {
                        if (IsPlayerAttachedObjectSlotUsed(playerid, io)) RemovePlayerAttachedObject(playerid, io);
                    }
                    fermasfstatus[playerid] = 0;
                }
            }
        }

        Loop(i, MAX_BUSINESS) {

            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
                if (pickupid == BusinessPickupIn[i]) {
                    SetPos(playerid, BusinessInfo[i][sEnterX], BusinessInfo[i][sEnterY], BusinessInfo[i][sEnterZ]);
                    new v;
                    v = (BusinessInfo[i][ID] + 1000);
                    SetPlayerVirtualWorld(playerid, v);
                    SetPlayerInterior(playerid, BusinessInfo[i][Interior]);
                    SetPlayerFacingAngle(playerid, BusinessInfo[i][AngelE]);
                    TogglePlayerControllable(playerid, false);
                    SetTimerEx("UnfreezePlayer", 1000, false, "i", playerid);
                    SetCameraBehindPlayer(playerid);
                }
                if (pickupid == BusinessPickupOut[i]) {
                    SetPlayerVirtualWorld(playerid, 0);
                    SetPlayerInterior(playerid, 0);
                    SetPos(playerid, BusinessInfo[i][EnterX], BusinessInfo[i][EnterY], BusinessInfo[i][EnterZ]);
                    SetPlayerFacingAngle(playerid, BusinessInfo[i][Angel]);
                    SetCameraBehindPlayer(playerid);
                }
            }
        }
        Loop(i, MAX_HOUSE) {

            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
                if (pickupid == HousePickupIn[i]) {
                    if (HouseInfo[i][Status] != 2) {
                        new string[256], kla[20];
                        if (HouseInfo[i][Price] <= 80000) {
                            format(kla, sizeof(kla), "Эконом");
                        }
                        if (HouseInfo[i][Price] > 80000 && HouseInfo[i][Price] <= 200000) {
                            format(kla, sizeof(kla), "Средний");
                        }
                        if (HouseInfo[i][Price] >= 300000) {
                            format(kla, sizeof(kla), "Бизнес");
                        }
                        format(string, sizeof(string), "Номер дома:\t\t%d\nВладелец:\t\t%s\nКласс дома:\t\t%s\nГос. цена:\t\t%d", HouseInfo[i][ID], HouseInfo[i][BossName], kla, HouseInfo[i][Price]);
                        ShowPlayerDialog(playerid, DIALOG_HOUSEINFO + i, DIALOG_STYLE_MSGBOX, "Информация о доме", string, "Войти", "Отмена");
                    } else {
                        new string[256], kla[20];
                        if (HouseInfo[i][Price] <= 80000) {
                            format(kla, sizeof(kla), "Эконом");
                        }
                        if (HouseInfo[i][Price] > 80000 && HouseInfo[i][Price] <= 200000) {
                            format(kla, sizeof(kla), "Средний");
                        }
                        if (HouseInfo[i][Price] >= 300000) {
                            format(kla, sizeof(kla), "Бизнес");
                        }
                        format(string, sizeof(string), "Номер дома:\t\t%d\nКласс дома:\t\t%s\nЦена дома:\t\t%d\n", HouseInfo[i][ID], kla, HouseInfo[i][Price]);
                        ShowPlayerDialog(playerid, DIALOG_HOUSEBUY + i, DIALOG_STYLE_MSGBOX, "Информация о доме", string, "Купить", "Отмена");
                    }
                }
            }
        }
        Loop(i, MAX_FERMA) {

            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
                if (pickupid == FermaPickupIn[i]) {
                    SetPos(playerid, FermaInfo[i][sEnterX], FermaInfo[i][sEnterY], FermaInfo[i][sEnterZ]);
                    new v;
                    v = (FermaInfo[i][ID] + 1000);
                    SetPlayerVirtualWorld(playerid, v);
                    TogglePlayerControllable(playerid, false);
                    SetPlayerFacingAngle(playerid, FermaInfo[i][Angel]);
                    SetTimerEx("UnfreezePlayer", 1000, false, "i", playerid);
                }
                if (pickupid == FermaPickupOut[i]) {
                    SetPlayerVirtualWorld(playerid, 0);
                    SetPos(playerid, FermaInfo[i][EnterX], FermaInfo[i][EnterY], FermaInfo[i][EnterZ]);
                    SetPlayerFacingAngle(playerid, FermaInfo[i][Angel]);
                }
            }
        }
        //	}
    }
    return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid) {
    if (SpawnMZ[playerid] == 1) {
        // if(PickUp[playerid] == 0)
        // {
        //PickUp[playerid] = 1;
        //SetTimerEx("PickUpAga", 5000, false, "i", playerid);
        if (Dpic[playerid] == 1) return false;
        else Dpic[playerid] = 1, GetPlayerPos(playerid, PosPic[0][playerid], PosPic[1][playerid], PosPic[2][playerid]);
        if (pickupid == gryz1) {
            ShowPlayerDialog(playerid, DIALOG_MESHKII, DIALOG_STYLE_MSGBOX, "Раздевалка", "Вы хотите переодеться чтобы начать работу?", "да", "нет");
        }

        if (pickupid == gryz2) {
            ShowPlayerDialog(playerid, DIALOG_MESHKI, DIALOG_STYLE_MSGBOX, "Касса", "Вы хотите получить зарплату и закончить работу?", "да", "нет");
        }

        if (pickupid == gryz3) {
            ShowPlayerDialog(playerid, DIALOG_MESHKIII, DIALOG_STYLE_MSGBOX, "Помощь", "1. Чтобы начать работу зайдите в это здание и переоденьтесь в рабочую одежду\n2. На вашей карте появится чекпоинт, идите на него чтобы взять мешок\n3. Отнесите мешок на склад и идите за новым мешком\n4. Когда отнесете нужное вам количество мешков\nприходите в кассу за зарплатой, она находится рядом с раздевалкой", "ОК", "");
        }
        //	}
        if (pickupid == fermalspickup) {
            if (FermaInfo[1][Status] == 1) {
                if (PlayerInfo[playerid][Sex] == 1) {
                    if (FermaInfo[1][Boss] != PlayerInfo[playerid][ID]) {
                        if (PlayerInfo[playerid][FermaLS] == 1) {
                            SetPlayerSkin(playerid, 161);
                        } else {
                            SetPlayerSkin(playerid, 202);
                        }
                    }
                    if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {
                        SetPlayerSkin(playerid, 34);
                    }
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Вы сменили одежду, теперь можете идти работать.");
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Идите к любой не загруженной машине.");
                    fermalsstatus[playerid] = 1;
                }
                if (PlayerInfo[playerid][Sex] == 2) {
                    if (FermaInfo[1][Boss] != PlayerInfo[playerid][ID]) {
                        if (PlayerInfo[playerid][FermaLS] == 1) {
                            SetPlayerSkin(playerid, 157);
                        } else {
                            SetPlayerSkin(playerid, 201);
                        }
                    }
                    if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {
                        SetPlayerSkin(playerid, 31);
                    }
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Вы сменили одежду, теперь можете идти работать.");
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Идите к любой не загруженной машине.");
                    fermalsstatus[playerid] = 1;
                }
            }
            if (FermaInfo[1][Status] == 2) {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "На данный момент ферма Лос Сантоса не работает, она находится на продаже.");
            }
            if (FermaInfo[1][Status] == 0) {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "На данный момент ферма Лос Сантоса не работает.");
            }
            ClearAnimations(playerid);
        }

        if (pickupid == fermasfpickup) {
            if (FermaInfo[2][Status] == 1) {
                if (PlayerInfo[playerid][Sex] == 1) {
                    if (FermaInfo[2][Boss] != PlayerInfo[playerid][ID]) {
                        if (PlayerInfo[playerid][FermaSF] == 1) {
                            SetPlayerSkin(playerid, 161);
                        } else {
                            SetPlayerSkin(playerid, 202);
                        }
                    }
                    if (FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                        SetPlayerSkin(playerid, 34);
                    }
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Вы сменили одежду, теперь можете идти работать.");
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Идите к любой не загруженной машине.");
                    fermasfstatus[playerid] = 1;
                }
                if (PlayerInfo[playerid][Sex] == 2) {
                    if (FermaInfo[2][Boss] != PlayerInfo[playerid][ID]) {
                        if (PlayerInfo[playerid][FermaSF] == 1) {
                            SetPlayerSkin(playerid, 157);
                        } else {
                            SetPlayerSkin(playerid, 201);
                        }
                    }
                    if (FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                        SetPlayerSkin(playerid, 31);
                    }
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Вы сменили одежду, теперь можете идти работать.");
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Идите к любой не загруженной машине.");
                    fermasfstatus[playerid] = 1;
                }
            }
            if (FermaInfo[2][Status] == 2) {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "На данный момент ферма Сан Фиерро не работает, она находится на продаже.");
            }
            if (FermaInfo[2][Status] == 0) {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "На данный момент ферма Сан Фиерро не работает.");
            }
            ClearAnimations(playerid);
        }


        Loop(i, MAX_VEHICLES) {
            if (i >= fermalscar[0] && i <= fermalscar[1])

            {
                if (pickupid == FermaLSDynamicPR[i]) {

                    if (fermalsstatus[playerid] == 0) {
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Вы не работаете на ферме Лос Сантоса.");
                    } else {

                        if (FermaLSKustP[playerid] == 5 || FermaLSKustPP[playerid] == 0 || FermaLSKustPPS[playerid] == 1) {
                            //DestroyDynamicPickup(FermaLSCR[playerid]);
                            FermaLSCR[playerid] = 1;

                            DisablePlayerCheckpoint(playerid);
                            GetPlayerPos(playerid, FermaLSCheckRRX[playerid], FermaLSCheckRRY[playerid], FermaLSCheckRRZ[playerid]);
                            //	SetTimerEx("Psd", 1000, false, "i", playerid);
                            SetPlayerCheckpoint(playerid, FermaLSCheckRRX[playerid] + random(sizeof(FermaLSCheckP)), FermaLSCheckRRY[playerid] + random(sizeof(FermaLSCheckP)), FermaLSCheckRRZ[playerid] + 0.5, 1.0);
                            if (FermaLSKustPPS[playerid] == 1) {
                                FermaLSKustPP[playerid] = 0;
                                for (new io = 0; io < MAX_PLAYER_ATTACHED_OBJECTS; io++) {
                                    if (IsPlayerAttachedObjectSlotUsed(playerid, io)) RemovePlayerAttachedObject(playerid, io);
                                }
                                FermaLSKustPPS[playerid] = 0;



                                if (FermaLSSum[i] < 1000) {
                                    new opsdg[128];
                                    FermaLSSum[i] += FermaLSKustP[playerid];

                                    new strg[64];
                                    FermaLSKustt[playerid] += FermaLSKust[playerid];
                                    if (FermaLSKustt[playerid] >= 1) {

                                        fermalszp[playerid] += FermaInfo[1][Price];
                                        FermaInfo[1][Zerno] -= 5;
                                    }
                                    format(strg, sizeof(strg), "Загружено\n%d/1000", FermaLSSum[i]);
                                    Update3DTextLabelText(FermaLS3DTEXTR[i], COLOR_YELLOW, strg);
                                    FermaLSKustP[playerid] = 0;


                                    format(opsdg, sizeof(opsdg), "~y~~n~~g~~w~~n~~w~COST: %d$", fermalszp[playerid]);

                                    GameTextForPlayer(playerid, opsdg, 3000, 1);

                                } else {
                                    DisablePlayerCheckpoint(playerid);
                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "В машине нет больше места.");
                                }
                            }
                        }
                    }
                }
            }


            if (i >= fermasfcar[0] && i <= fermasfcar[1])

            {
                if (pickupid == FermaSFDynamicPR[i]) {

                    if (fermasfstatus[playerid] == 0) {
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Вы не работаете на ферме Сан Фиерро.");
                    } else {

                        if (FermaSFKustP[playerid] == 5 || FermaSFKustPP[playerid] == 0 || FermaSFKustPPS[playerid] == 1) {
                            //DestroyDynamicPickup(FermaLSCR[playerid]);
                            FermaSFCR[playerid] = 1;

                            DisablePlayerCheckpoint(playerid);
                            GetPlayerPos(playerid, FermaSFCheckRRX[playerid], FermaSFCheckRRY[playerid], FermaSFCheckRRZ[playerid]);
                            //	SetTimerEx("Psd", 1000, false, "i", playerid);
                            SetPlayerCheckpoint(playerid, FermaSFCheckRRX[playerid] + random(sizeof(FermaSFCheckP)), FermaSFCheckRRY[playerid] + random(sizeof(FermaSFCheckP)), FermaSFCheckRRZ[playerid] + 0.5, 1.0);
                            if (FermaSFKustPPS[playerid] == 1) {
                                FermaSFKustPP[playerid] = 0;
                                for (new io = 0; io < MAX_PLAYER_ATTACHED_OBJECTS; io++) {
                                    if (IsPlayerAttachedObjectSlotUsed(playerid, io)) RemovePlayerAttachedObject(playerid, io);
                                }
                                FermaSFKustPPS[playerid] = 0;



                                if (FermaSFSum[i] < 1000) {
                                    new opsdg[128];
                                    FermaSFSum[i] += FermaSFKustP[playerid];

                                    new strg[64];
                                    FermaSFKustt[playerid] += FermaSFKust[playerid];
                                    if (FermaSFKustt[playerid] >= 1) {

                                        fermasfzp[playerid] += FermaInfo[2][Price];
                                        FermaInfo[2][Zerno] -= 5;
                                    }
                                    format(strg, sizeof(strg), "Загружено\n%d/1000", FermaSFSum[i]);
                                    Update3DTextLabelText(FermaSF3DTEXTR[i], COLOR_YELLOW, strg);
                                    FermaSFKustP[playerid] = 0;


                                    format(opsdg, sizeof(opsdg), "~y~~n~~g~~w~~n~~w~COST: %d$", fermasfzp[playerid]);

                                    GameTextForPlayer(playerid, opsdg, 3000, 1);

                                } else {
                                    DisablePlayerCheckpoint(playerid);
                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "В машине нет больше места.");
                                }
                            }
                        }
                    }
                }
            }

        }

    }
    return 1;
}
public OnVehicleMod(playerid, vehicleid, componentid) {
    if (!Tuning(playerid)) {
        RemoveVehicleComponent(vehicleid, componentid);
        SetVehicleToRespawn(vehicleid);
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Античит: Ты был(а) кикнут(а) за тюнинг хак.");
        lKick(playerid);
        return true;
    }
    return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid) {
    return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2) {
    return 1;
}

public OnPlayerSelectedMenuRow(playerid, row) {
    return 1;
}

public OnPlayerExitedMenu(playerid) {
    return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) {
    return 1;
}
public Bunny(playerid) {
    ApplyAnimation(playerid, "PED", "getup_front", 4.0, 0, 0, 0, 0, 0);
    times[playerid] = false;
    SetTimerEx("Hop", 1500, false, "i", playerid);
    return 1;
}

public Hop(playerid) {
    times[playerid] = true;
}
public Unferma(playerid) {
    if (fermalsstatus[playerid] == 1) {
        ClearAnimations(playerid);
        FermaLSKustPPS[playerid] = 1;
        FermaLSKustPP[playerid] = 1;
        DisablePlayerCheckpoint(playerid);
    }
    if (fermasfstatus[playerid] == 1) {
        ClearAnimations(playerid);
        FermaSFKustPPS[playerid] = 1;
        FermaSFKustPP[playerid] = 1;
        DisablePlayerCheckpoint(playerid);
    }


}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    if (newkeys == 65410 || newkeys == 130) //при одновременном нажатии c+сторона будут следующие действия
    {
        SendClientMessage(playerid, COLOR_WHITE, "Не нужно использовать (+С)"); //отправит сообщение нарушителю
        TogglePlayerControllable(playerid, false);
        SetTimerEx("UnfreezePlayer", 5000, false, "i", playerid);
    }
    if (newkeys & KEY_SPRINT && newkeys & KEY_JUMP) {
        if (!IsPlayerInAnyVehicle(playerid)) {
            if (times[playerid] == true) {
                SetTimerEx("Bunny", 1000, false, "i", playerid);
            }
        }
    }

    if ((newkeys & KEY_FIRE) || ((newkeys & KEY_AIM) && (oldkeys & KEY_AIM) && (newkeys & KEY_SECONDARY_ATTACK)) || (newkeys & KEY_ACTION) && (oldkeys & 128)) {
        if (PlayerToPoint(60.0, playerid, 1715.05, -1912.10, 12.57)) {
            if (GetPlayerVehicleSeat(playerid) != 0) {
                SendClientMessage(playerid, 0xFFFFFFAA, "Не деритесь на вокзале, пожалуйста!");
                TogglePlayerControllable(playerid, false);
                SetTimerEx("UnfreezePlayer", 10000, false, "i", playerid);
                if (AntiDM[playerid] == 5) {
                    SendClientMessage(playerid, 0xFFFFFFAA, "В последнее время, Вы очень активно проявляете жестокость к тому что Вас окружает. Нам пришлось Вас отключить от сервера.");
                    lKick(playerid);
                } else {
                    AntiDM[playerid]++;
                }
            }
        }
        if (PlayerToPoint(60.0, playerid, 1476.11, -1714.36, 13.75)) {
            if (GetPlayerVehicleSeat(playerid) != 0) {
                SendClientMessage(playerid, 0xFFFFFFAA, "Не деритесь у мэрии, пожалуйста!");
                TogglePlayerControllable(playerid, false);
                SetTimerEx("UnfreezePlayer", 10000, false, "i", playerid);
                if (AntiDM[playerid] == 5) {
                    SendClientMessage(playerid, 0xFFFFFFAA, "В последнее время, Вы очень активно проявляете жестокость к тому что Вас окружает. Нам пришлось Вас отключить от сервера.");
                    lKick(playerid);
                } else {
                    AntiDM[playerid]++;
                }
            }
        }
        if (PlayerToPoint(50.0, playerid, 2184.4380, -2259.5325, 12.3590)) {
            if (GetPlayerVehicleSeat(playerid) != 0) {
                SendClientMessage(playerid, 0xFFFFFFAA, "Не деритесь на работе, пожалуйста!");
                TogglePlayerControllable(playerid, false);
                SetTimerEx("UnfreezePlayer", 10000, false, "i", playerid);
                if (AntiDM[playerid] == 5) {
                    SendClientMessage(playerid, 0xFFFFFFAA, "В последнее время, Вы очень активно проявляете жестокость к тому что Вас окружает. Нам пришлось Вас отключить от сервера.");
                    lKick(playerid);
                } else {
                    AntiDM[playerid]++;
                }
            }
        }
        if (PlayerToPoint(200.0, playerid, -82.0117, 2.8241, 2.3509)) {
            if (GetPlayerVehicleSeat(playerid) != 0) {
                SendClientMessage(playerid, 0xFFFFFFAA, "Не деритесь на ферме, пожалуйста!");
                TogglePlayerControllable(playerid, false);
                SetTimerEx("UnfreezePlayer", 10000, false, "i", playerid);
                if (AntiDM[playerid] == 5) {
                    SendClientMessage(playerid, 0xFFFFFFAA, "В последнее время, Вы очень активно проявляете жестокость к тому что Вас окружает. Нам пришлось Вас отключить от сервера.");
                    lKick(playerid);
                } else {
                    AntiDM[playerid]++;
                }
            }
        }
        if (PlayerToPoint(200.0, playerid, -1076.4369, -1063.1982, 128.1335)) {
            if (GetPlayerVehicleSeat(playerid) != 0) {
                SendClientMessage(playerid, 0xFFFFFFAA, "Не деритесь на ферме, пожалуйста!");
                TogglePlayerControllable(playerid, false);
                SetTimerEx("UnfreezePlayer", 10000, false, "i", playerid);
                if (AntiDM[playerid] == 5) {
                    SendClientMessage(playerid, 0xFFFFFFAA, "В последнее время, Вы очень активно проявляете жестокость к тому что Вас окружает. Нам пришлось Вас отключить от сервера.");
                    lKick(playerid);
                } else {
                    AntiDM[playerid]++;
                }
            }
        }
        if (PlayerToPoint(10.0, playerid, 1718.8076, -2435.0791, 7.3569)) {
            if (GetPlayerVehicleSeat(playerid) != 0) {
                SendClientMessage(playerid, 0xFFFFFFAA, "Не деритесь на ферме, пожалуйста!");
                TogglePlayerControllable(playerid, false);
                SetTimerEx("UnfreezePlayer", 10000, false, "i", playerid);
                if (AntiDM[playerid] == 5) {
                    SendClientMessage(playerid, 0xFFFFFFAA, "В последнее время, Вы очень активно проявляете жестокость к тому что Вас окружает. Нам пришлось Вас отключить от сервера.");
                    lKick(playerid);
                } else {
                    AntiDM[playerid]++;
                }
            }
        }

        if (PlayerToPoint(15.0, playerid, 1734.53, -2471.35, 8.44)) {
            if (GetPlayerVehicleSeat(playerid) != 0) {
                SendClientMessage(playerid, 0xFFFFFFAA, "Не деритесь в магазине, пожалуйста!");
                TogglePlayerControllable(playerid, false);
                SetTimerEx("UnfreezePlayer", 10000, false, "i", playerid);
                if (AntiDM[playerid] == 5) {
                    SendClientMessage(playerid, 0xFFFFFFAA, "В последнее время, Вы очень активно проявляете жестокость к тому что Вас окружает. Нам пришлось Вас отключить от сервера.");
                    lKick(playerid);
                } else {
                    AntiDM[playerid]++;
                }
            }
        }
        return 1;
    }
    new vid = GetPlayerVehicleID(playerid);
    new string[256];
    new Hour, Minute, Second;
    gettime(Hour, Minute, Second);
    if (newkeys == 1 && IsPlayerInVehicle(playerid, vid) && !IsAVelik(vid)) {
        if (GetPlayerVehicleSeat(playerid) == 0) {
            switch (VehicleInfo[vid][Stop]) {
                case 0: {

                    VehicleInfo[vid][Stop] = true;
                }
                case 1: {

                    VehicleInfo[vid][Stop] = false;
                }
            }
        }

    }
    if (newkeys == 512 && IsPlayerInVehicle(playerid, vid) && !IsAVelik(vid)) {
        if (GetPlayerVehicleSeat(playerid) == 0) {
            if (VehicleInfo[vid][vFuel] > 0) {
                new engine, lights, alarm, doors, bonnet, boot, objective;
                GetVehicleParamsEx(vid, engine, lights, alarm, doors, bonnet, boot, objective);
                if (engine) {
                    SetVehicleParamsEx(vid, false, false, alarm, doors, bonnet, boot, objective);
                    format(string, sizeof(string), "* %s заглушил двигатель.", PlayerInfo[playerid][Name]);
                    VehicleInfo[vid][vEngine] = false;
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
                } else if (!engine) {

                    if (Hour < 7 || Hour > 21) {
                        VehicleInfo[vid][vEngine] = true;
                        SetVehicleParamsEx(vid, true, true, alarm, doors, bonnet, boot, objective);
                    } else {
                        VehicleInfo[vid][vEngine] = true;
                        SetVehicleParamsEx(vid, true, false, alarm, doors, bonnet, boot, objective);
                    }
                    format(string, sizeof(string), "* %s завел двигатель.", PlayerInfo[playerid][Name]);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);

                } else {
                    SendClientMessage(playerid, COLOR_RED, "В машине нет бензина! Заправьте её с помощью канистры или же вызовите механика.");
                }
            }
        }
        if (newkeys == 1 && IsPlayerInVehicle(playerid, GetPlayerVehicleID(playerid)) && !IsAVelik(vid)) {

            new engine, lights, alarm, doors, bonnet, boot, objective;

            GetVehicleParamsEx(vid, engine, lights, alarm, doors, bonnet, boot, objective);

            if (lights) { SetVehicleParamsEx(vid, engine, false, alarm, doors, bonnet, boot, objective); } else if (!lights) {
                SetVehicleParamsEx(vid, engine, true, alarm, doors, bonnet, boot, objective);
            }
        }



    }
    return 1;
}
forward UnAntiFly(playerid);
public UnAntiFly(playerid) {
    AntiFly[playerid] = 0;
}
public Weather() {
    new Hour, Minute, Second;
    gettime(Hour, Minute, Second);
    new value = random(2);
    new valuee = random(35);
    new val = random(10);
    new vs;
    new sa[64];
    if (valuee <= 20) {
        vs = (20 + val);
    } else {
        vs = valuee;

    }
    if (Hour == 6 || Hour == 7 || Hour == 21 || Hour == 22) {


        if (value == 0) {
            SendClientMessageToAll(COLOR_ORANGE, "--- SA News ---");
            SendClientMessageToAll(COLOR_ORANGE, "  Прогноз погоды   ");
            SendClientMessageToAll(COLOR_ORANGE, "Ожидается солнечная погода.");
            format(sa, sizeof(sa), "Температура: %d°C", vs);
            SendClientMessageToAll(COLOR_ORANGE, sa);
            SendClientMessageToAll(COLOR_ORANGE, "---------------");
            SetTimerEx("Weatherr", 100000, false, "i", 1);

        }
        if (value == 1) {
            SendClientMessageToAll(COLOR_ORANGE, "--- SA News ---");
            SendClientMessageToAll(COLOR_ORANGE, "  Прогноз погоды   ");
            SendClientMessageToAll(COLOR_ORANGE, "Ожидается дождь.");
            format(sa, sizeof(sa), "Температура: %d°C", vs);
            SendClientMessageToAll(COLOR_ORANGE, sa);
            SendClientMessageToAll(COLOR_ORANGE, "---------------");
            SetTimerEx("Weatherr", 100000, false, "i", 8);

        }
        if (value == 2) {
            SendClientMessageToAll(COLOR_ORANGE, "--- SA News ---");
            SendClientMessageToAll(COLOR_ORANGE, "  Прогноз погоды   ");
            SendClientMessageToAll(COLOR_ORANGE, "Ожидается туманная погода.");
            format(sa, sizeof(sa), "Температура: %d°C", vs);
            SendClientMessageToAll(COLOR_ORANGE, sa);
            SendClientMessageToAll(COLOR_ORANGE, "---------------");
            SetTimerEx("Weatherr", 100000, false, "i", 9);

        }
    } else {
        new values = random(2);
        if (values == 0) {
            SendClientMessageToAll(COLOR_ORANGE, "--- SA News ---");
            SendClientMessageToAll(COLOR_ORANGE, "  Прогноз погоды   ");
            SendClientMessageToAll(COLOR_ORANGE, "Ожидается солнечная погода.");
            format(sa, sizeof(sa), "Температура: %d°C", vs);
            SendClientMessageToAll(COLOR_ORANGE, sa);
            SendClientMessageToAll(COLOR_ORANGE, "---------------");
            SetTimerEx("Weatherr", 100000, false, "i", 1);

        }
        if (values == 1) {
            SendClientMessageToAll(COLOR_ORANGE, "--- SA News ---");
            SendClientMessageToAll(COLOR_ORANGE, "  Прогноз погоды   ");
            SendClientMessageToAll(COLOR_ORANGE, "Ожидается дождь.");
            format(sa, sizeof(sa), "Температура: %d°C", vs);
            SendClientMessageToAll(COLOR_ORANGE, sa);
            SendClientMessageToAll(COLOR_ORANGE, "---------------");
            SetTimerEx("Weatherr", 100000, false, "i", 8);

        }
    }


    return 1;
}
public OnRconLoginAttempt(ip[], password[], success) {

    return 1;
}
public OnPlayerEnterCheckpoint(playerid) {

    new string[256];

    if (PlayerToPoint(4.0, playerid, -1171.2776, -1033.9525, 128.1881)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -1110.4109, -1032.5914, 128.1770, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -1110.4109, -1032.5914, 128.1770)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -1050.1387, -1000.0851, 128.1424, 4.0);
            }
        }

    }

    if (PlayerToPoint(4.0, playerid, -1050.1387, -1000.0851, 128.1424)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -1116.8154, -963.5654, 128.1895, 4.0);
            }
        }

    }

    if (PlayerToPoint(4.0, playerid, -1116.8154, -963.5654, 128.1895)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -1169.4484, -962.2961, 128.2012, 4.0);
            }
        }

    }

    if (PlayerToPoint(4.0, playerid, -1169.4484, -962.2961, 128.2012)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SendClientMessage(playerid, COLOR_ORANGE, "Вы засеяли поле зерном. Возвращайтесь назад и продолжайте работу.");
                if (FermaInfo[2][Ammount] >= 5000) {
                    FermaInfo[2][Zerno] = 5000;
                    FermaInfo[2][Ammount] -= 5000;
                } else {
                    FermaInfo[2][Zerno] = FermaInfo[2][Ammount];
                    FermaInfo[2][Ammount] = 0;
                }
                DisablePlayerCheckpoint(playerid);
            }
        }

    }

    if (PlayerToPoint(4.0, playerid, -121.6866, 146.7871, 2.4133)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -151.4282, 157.1120, 4.2125, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -151.4282, 157.1120, 4.2125)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -184.6172, 169.4856, 7.1148, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -184.6172, 169.4856, 7.1148)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -199.3456, 146.4898, 3.8373, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -199.3456, 146.4898, 3.8373)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -173.7765, 129.2127, 2.7179, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -173.7765, 129.2127, 2.7179)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -137.7068, 113.5545, 2.1762, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -137.7068, 113.5545, 2.1762)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -138.0159, 57.9369, 2.0879, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -138.0159, 57.9369, 2.0879)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -157.0541, 1.6245, 2.0617, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -157.0541, 1.6245, 2.0617)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -186.1051, -55.1366, 2.0672, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -186.1051, -55.1366, 2.0672)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -229.2093, -63.6982, 2.0543, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -229.2093, -63.6982, 2.0543)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -198.8006, 5.6840, 2.0857, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -198.8006, 5.6840, 2.0857)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -180.6069, 52.6300, 2.0698, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -180.6069, 52.6300, 2.0698)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -216.7153, 75.5213, 1.7463, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -216.7153, 75.5213, 1.7463)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -238.9144, 19.0115, 1.6908, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -238.9144, 19.0115, 1.6908)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -258.7725, -33.5453, 2.0347, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -258.7725, -33.5453, 2.0347)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, 23.9523, 40.5300, 2.0885, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, 23.9523, 40.5300, 2.0885)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, 59.7236, 2.3209, 0.4351, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, 59.7236, 2.3209, 0.4351)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -12.1947, -27.6370, 2.0744, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -12.1947, -27.6370, 2.0744)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, -32.6535, -90.0122, 2.0532, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, -32.6535, -90.0122, 2.0532)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, 4.7768, -100.8249, 0.9399, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, 4.7768, -100.8249, 0.9399)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, 22.7153, -63.4379, 1.4298, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, 22.7153, -63.4379, 1.4298)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SetPlayerCheckpoint(playerid, 40.6766, -95.6769, -0.4512, 4.0);
            }
        }

    }
    if (PlayerToPoint(4.0, playerid, 40.6766, -95.6769, -0.4512)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                SendClientMessage(playerid, COLOR_ORANGE, "Вы засеяли поле зерном. Возвращайтесь назад и продолжайте работу.");
                if (FermaInfo[1][Ammount] >= 5000) {
                    FermaInfo[1][Zerno] = 5000;
                    FermaInfo[1][Ammount] -= 5000;
                } else {
                    FermaInfo[1][Zerno] = FermaInfo[1][Ammount];
                    FermaInfo[1][Ammount] = 0;
                }
                DisablePlayerCheckpoint(playerid);
            }
        }

    }
    if (PlayerToPoint(3.0, playerid, -101.8093, 52.9478, 3.1020)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                new vehicleid = GetPlayerVehicleID(playerid);
                if (fermalsin[vehicleid][InG] == 1) {
                    if (PlayerInfo[playerid][FermaLS] == 1 || FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {
                        fermalsin[vehicleid][InG] = 0;
                        new zz;
                        zz = FermaInfo[1][Ur] + FermaLSSum[vehicleid];
                        if (zz <= 10000) {
                            if (FermaLSSum[vehicleid] != 0) {
                                FermaInfo[1][Ur] += FermaLSSum[vehicleid];
                                new a, b;
                                a = FermaLSSum[vehicleid] / 5;
                                b = FermaInfo[1][Price] * 2;
                                fermalszp[playerid] += a * b;
                                new opsdg[64];
                                format(opsdg, sizeof(opsdg), "~y~~n~~g~~w~~n~~w~COST: %d$", fermalszp[playerid]);
                                GameTextForPlayer(playerid, opsdg, 3000, 1);
                                SendClientMessage(playerid, COLOR_ORANGE, "Вы успешно выгрузили урожай на склад, можете продолжать работу.");
                                format(string, sizeof(string), "Выгружено с машины %d кг. урожая, на складе теперь %d кг. урожая.", FermaLSSum[vehicleid], FermaInfo[1][Ur]);
                                SendClientMessage(playerid, COLOR_YELLOW, string);
                                FermaLSSum[vehicleid] = 0;
                                new randSpawn = random(sizeof(FermaLSCheckR));
                                FermaLSCheckRRX[playerid] = FermaLSCheckR[randSpawn][0];
                                FermaLSCheckRRZ[playerid] = FermaLSCheckR[randSpawn][2];
                                FermaLSCheckRRY[playerid] = FermaLSCheckR[randSpawn][1];
                                SetPlayerCheckpoint(playerid, FermaLSCheckR[randSpawn][0], FermaLSCheckR[randSpawn][1], FermaLSCheckR[randSpawn][2], 3.0);
                            } else {
                                SendClientMessage(playerid, COLOR_ORANGE, "Машина пуста, в ней нет урожая...");
                            }
                        } else {
                            SendClientMessage(playerid, COLOR_ORANGE, "На складе не достаточно места для хранения урожая.");
                        }
                    }
                }
            }

        }
    }

    if (PlayerToPoint(3.0, playerid, -1056.8080, -1195.6364, 128.1294)) {

        if (IsPlayerInAnyVehicle(playerid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                new vehicleid = GetPlayerVehicleID(playerid);
                if (fermasfin[vehicleid][InG] == 1) {
                    if (PlayerInfo[playerid][FermaSF] == 1 || FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                        fermasfin[vehicleid][InG] = 0;
                        new zz;
                        zz = FermaInfo[2][Ur] + FermaSFSum[vehicleid];
                        if (zz <= 10000) {
                            if (FermaSFSum[vehicleid] != 0) {
                                FermaInfo[2][Ur] += FermaSFSum[vehicleid];
                                new a, b;
                                a = FermaSFSum[vehicleid] / 5;
                                b = FermaInfo[2][Price] * 2;
                                fermasfzp[playerid] += a * b;
                                new opsdg[64];
                                format(opsdg, sizeof(opsdg), "~y~~n~~g~~w~~n~~w~COST: %d$", fermasfzp[playerid]);
                                GameTextForPlayer(playerid, opsdg, 3000, 1);
                                SendClientMessage(playerid, COLOR_ORANGE, "Вы успешно выгрузили урожай на склад, можете продолжать работу.");
                                format(string, sizeof(string), "Выгружено с машины %d кг. урожая, на складе теперь %d кг. урожая.", FermaSFSum[vehicleid], FermaInfo[2][Ur]);
                                SendClientMessage(playerid, COLOR_YELLOW, string);
                                FermaSFSum[vehicleid] = 0;
                                new randSpawn = random(sizeof(FermaSFCheckR));
                                FermaSFCheckRRX[playerid] = FermaSFCheckR[randSpawn][0];
                                FermaSFCheckRRZ[playerid] = FermaSFCheckR[randSpawn][2];
                                FermaSFCheckRRY[playerid] = FermaSFCheckR[randSpawn][1];
                                SetPlayerCheckpoint(playerid, FermaSFCheckR[randSpawn][0], FermaSFCheckR[randSpawn][1], FermaSFCheckR[randSpawn][2], 3.0);
                            } else {
                                SendClientMessage(playerid, COLOR_ORANGE, "Машина пуста, в ней нет урожая...");
                            }
                        } else {
                            SendClientMessage(playerid, COLOR_ORANGE, "На складе не достаточно места для хранения урожая.");
                        }
                    }
                }
            }

        }
    }

    if (FermaLSCR[playerid] == 1) {
        if (!IsPlayerInAnyVehicle(playerid)) {
            if (FermaInfo[1][Zerno] < 5) {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "Нет засеянного зерна на поле.");
            } else {
                SetTimerEx("Unferma", 15000, false, "i", playerid);
                SetPlayerAttachedObject(playerid, 3, 2247, 6, -0.003353, 0.093383, 0.176903, 0.000000, 0.000000, 0.000000, 0.788097, 1.000000, 0.991011); //RemovePlayerAttachedObject(playerid,2);
                ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, 1, 0, 0, 0, 0);

                FermaLSKust[playerid] = 1;
                FermaLSKustP[playerid] = 5;
                FermaLSCR[playerid] = 0;
            }
        }
    }

    if (FermaSFCR[playerid] == 1) {
        if (!IsPlayerInAnyVehicle(playerid)) {
            if (FermaInfo[2][Zerno] < 5) {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "Нет засеянного зерна на поле.");
            } else {
                SetTimerEx("Unferma", 15000, false, "i", playerid);
                SetPlayerAttachedObject(playerid, 3, 2247, 6, -0.003353, 0.093383, 0.176903, 0.000000, 0.000000, 0.000000, 0.788097, 1.000000, 0.991011); //RemovePlayerAttachedObject(playerid,2);
                ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, 1, 0, 0, 0, 0);

                FermaSFKust[playerid] = 1;
                FermaSFKustP[playerid] = 5;
                FermaSFCR[playerid] = 0;
            }
        }
    }
    if (PlayerToPoint(2.0, playerid, 2230.8132324219, -2285.7043457031, 13.531787872314)) {
        Meshok[playerid] = 1;
        ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 0, 1, 1, 1, 1);
        SetPlayerAttachedObject(playerid, 2, 2060, 5, 0.01, 0.1, 0.2, 100, 10, 85);
        SetPlayerCheckpoint(playerid, 2172.1313476563, -2255.2292480469, 12.454199790955, 2.0);
    }

    if (PlayerToPoint(2.0, playerid, 2172.1313476563, -2255.2292480469, 12.454199790955)) {
        Meshok[playerid] = 0;
        ApplyAnimation(playerid, "PED", "IDLE_tired", 4.1, 0, 1, 1, 0, 1);
        Meshki[playerid]++;
        if (IsPlayerAttachedObjectSlotUsed(playerid, 2)) RemovePlayerAttachedObject(playerid, 2);
        format(string, sizeof(string), "Мешков перетащено {A52A2A}%d", Meshki[playerid]);
        SendClientMessage(playerid, COLOR_SYSTEM, string);
        SetPlayerCheckpoint(playerid, 2230.8132324219, -2285.7043457031, 13.531787872314, 2.0);
    }
    if (PlayerToPoint(3.0, playerid, FermaLSCheckRRX[playerid], FermaLSCheckRRY[playerid], FermaLSCheckRRZ[playerid])) {


        DisablePlayerCheckpoint(playerid);
        ctd(playerid);
        new vehicleid = GetPlayerVehicleID(playerid);
        fermalsin[vehicleid][In] = 1;

    }

    if (PlayerToPoint(3.0, playerid, FermaSFCheckRRX[playerid], FermaSFCheckRRY[playerid], FermaSFCheckRRZ[playerid])) {


        DisablePlayerCheckpoint(playerid);
        ctd(playerid);
        new vehicleid = GetPlayerVehicleID(playerid);
        fermasfin[vehicleid][In] = 1;

    }
    if (PlayerToPoint(3.0, playerid, gpsmetkaX[playerid], gpsmetkaY[playerid], gpsmetkaZ[playerid])) {
        DisablePlayerCheckpoint(playerid);
        SendClientMessage(playerid, COLOR_GREEN, "Вы достигли отмеченной точки.");
    }


    return 1;
}
public Meshkii(playerid) {
    new animlib[32];
    new animname[32];

    if (Meshok[playerid] == 1) {
        GetAnimationName(GetPlayerAnimationIndex(playerid), animlib, 32, animname, 32);
        if (strcmp(animname, "IDLE_STANCE", true) != 0 && strcmp(animname, "RUN_CIVI", true) != 0 && strcmp(animname, "WALK_CIVI", true) != 0 && strcmp(animname, "crry_prtial", true) != 0 && strcmp(animname, "SPRINT_PANIC", true) != 0 && strcmp(animname, "RUN_PLAYER", true) != 0 && strcmp(animname, "WALK_PLAYER", true) != 0 && strcmp(animname, "SPRINT_CIVI", true) != 0) {
            Meshok[playerid] = 0;
            SendClientMessage(playerid, COLOR_RED, "Вы уронили мешок!");
            if (IsPlayerAttachedObjectSlotUsed(playerid, 2)) RemovePlayerAttachedObject(playerid, 2);
            ApplyAnimation(playerid, "PED", "IDLE_tired", 4.1, 0, 1, 1, 0, 1);
            SetPlayerCheckpoint(playerid, 2230.8132324219, -2285.7043457031, 13.531787872314, 2.0);
        }
    }
}
public UnfreezePlayer(playerid) {
    TogglePlayerControllable(playerid, true);
}
public UnfreezePlayerr(playa) {
    TogglePlayerControllable(playa, true);
}
forward Weatherr(vsid);
public Weatherr(vsid) {
    new s = vsid;
    SetWeather(s);
}
public CheckArmour(playerid) {
    if (PlayerInfo[playerid][Logged] == true) {
        for (new i = 0; i < MAX_PLAYERS; i++) {
            if (IsPlayerConnected(i)) {
                new Float: Armourr;
                GetPlayerArmour(i, Armourr);
                if (PlayerArmour[i] < Armourr) SetPlayerArmour(i, PlayerArmour[i]);
                else PlayerArmour[i] = Armourr;
            }
        }
    }
    return 1;

}


forward CA(playerid);
public CA(playerid) {
    ApplyAnimation(playerid, "PED", "facanger", 4.1, 0, 1, 1, 1, 1);
}
public PickUpAga(playerid) {
    PickUp[playerid] = 0;
}

public OnPlayerUpdate(playerid) {
    if (acstruct[playerid][checkmaptp] == 1) {
        new Float:dis = GetPlayerDistanceFromPoint(playerid, acstruct[playerid][maptp][0], acstruct[playerid][maptp][1], acstruct[playerid][maptp][2]);
        if (dis < 5.0) {
            new Float:disd = GetPlayerDistanceFromPoint(playerid, acstruct[playerid][LastOnFootPosition][0], acstruct[playerid][LastOnFootPosition][1], acstruct[playerid][LastOnFootPosition][2]);
            if (disd > 25.0) {
                if (PlayerInfo[playerid][Admin] == 0) {
                    SendClientMessage(playerid, 0xFFFFFFAA, "Вы были кикнуты - OnClickMapTeleport");
                    lKick(playerid);
                }
            }
        }
        acstruct[playerid][checkmaptp] = 0;
    }
    GetPlayerPos(playerid, acstruct[playerid][LastOnFootPosition][0], acstruct[playerid][LastOnFootPosition][1], acstruct[playerid][LastOnFootPosition][2]);
    if (plafk[playerid] > -2) {
        if (plafk[playerid] > 0) {
            //new string[128];
            //format(string,sizeof(string),"Время вашего АФК: %s",ConvertSeconds(plafk[playerid]));
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            SetPlayerChatBubble(playerid, "АФК: завершено", COLOR_WHITE, 10.0, 1);
        }
        plafk[playerid] = 0;
    }
    new weap = GetPlayerWeapon(playerid);
    if (weap != 0 && !Weapons[playerid][weap] && weap != 40) {
        SendClientMessage(playerid, 0xFFFFFFAA, "Вы были кикнуты - чит на оружие.");
        lKick(playerid);
    }
    /*if(IsPlayerInAnyVehicle(playerid))
                {
                    if(GetPlayerVehicleSeat(playerid) == 0)
                    {
   						new	float:speed = GetVehicleSpeed(vehicleid);
   						*/
    NoRoof(playerid);


    return 1;

}
public PayDay(playerid) {
    new Hour, Minute, Second;
    gettime(Hour, Minute, Second);
    SetWorldTime(Hour);

    if (Minute == 0) {
        if (PlayerInfo[playerid][Logged] == true) {
            new lvl;
            PlayerInfo[playerid][Exp]++;
            lvl = (PlayerInfo[playerid][Level] * 5);
            if (PlayerInfo[playerid][Exp] == lvl) {
                new string[128];
                PlayerInfo[playerid][Level] += 1;
                PlayerInfo[playerid][Exp] = 0;
                format(string, sizeof(string), "Теперь Ваш персонаж достиг %d уровня", PlayerInfo[playerid][Level]);
                SendClientMessage(playerid, 0xFFFFFFAA, string);
            }
        }
        for (new i; i < MAX_HOUSE; i++) {
            if (HouseInfo[i][Status] != 2) {
                HouseInfo[i][Bank] -= 25;
                if (HouseInfo[i][Bank] < 0) {
                    HouseInfo[i][Boss] = 0;
                    HouseInfo[i][Int] = HouseInfo[i][IntB];
                    HouseInfo[i][Bank] = 0;
                    HouseInfo[i][Heal] = 0;
                    HouseInfo[i][SHX] = HouseInfo[i][SHXB];
                    HouseInfo[i][SHY] = HouseInfo[i][SHYB];
                    HouseInfo[i][SHZ] = HouseInfo[i][SHZB];
                    HouseInfo[i][Signal] = 0;
                    HouseInfo[i][Klad] = 0;
                    HouseInfo[i][Angle] = HouseInfo[i][AngleB];
                    HouseInfo[i][Status] = 2;
                    DestroyDynamicPickup(HousePickupIn[i]);
                    HousePickupIn[i] = CreateDynamicPickup(1273, 23, HouseInfo[i][HX], HouseInfo[i][HY], HouseInfo[i][HZ], 0);
                    DestroyDynamicMapIcon(HouseMapIcon[i]);
                    HouseMapIcon[i] = CreateDynamicMapIcon(HouseInfo[i][HX], HouseInfo[i][HY], HouseInfo[i][HZ], 31, 0);
                    new string[128];
                    format(string, sizeof(string), "UPDATE `accounts` SET `House` = 0 WHERE `House` = %d", HouseInfo[i][ID]);
                    mysql_query(string);
                    mysql_free_result();
                }
            }
        }
        for (new i; i < MAX_FERMA; i++) {
            if (FermaInfo[i][Status] != 2) {
                FermaInfo[i][Bank] -= 100;
                if (FermaInfo[i][Bank] < 0) {
                    FermaInfo[i][Bank] = 0;
                    FermaInfo[i][Boss] = 0;
                    FermaInfo[i][Status] = 2;
                    FermaInfo[i][Fermer1] = 0;
                    FermaInfo[i][Fermer2] = 0;
                    FermaInfo[i][Fermer3] = 0;
                    FermaInfo[i][Fermer4] = 0;
                    FermaInfo[i][Fermer5] = 0;
                    FermaInfo[i][Price] = 6;
                    FermaInfo[i][Ur] = 0;
                    FermaInfo[1][UrP] = 0;
                    FermaInfo[i][Ammount] = 0;
                    FermaInfo[i][Zerno] = 0;
                    if (FermaInfo[i][ID] == 1) {
                        new string[64];
                        for (new ii; ii < MAX_PLAYERS; ii++) {
                            PlayerInfo[ii][FermaLS] = 0;
                        }
                        format(string, sizeof(string), "UPDATE `accounts` SET `FermaLS` = 0");
                        mysql_query(string);
                    }
                    if (FermaInfo[i][ID] == 2) {
                        new string[64];
                        for (new ii; ii < MAX_PLAYERS; ii++) {
                            PlayerInfo[ii][FermaSF] = 0;
                        }
                        format(string, sizeof(string), "UPDATE `accounts` SET `FermaSF` = 0");
                        mysql_query(string);
                    }
                    new str[256];
                    format(str, sizeof(str), "Ферма продается.\nДля покупки введите /buyferma\nСтоимость %d", FermaInfo[i][Sum]);

                    Update3DTextLabelText(FermaLabel[i], COLOR_BLUE, str);
                }
            }
        }
        mysql_free_result();
        if (PlayerInfo[playerid][Logged] == true) {
            SaveAccount(playerid);

            SetPlayerScore(playerid, PlayerInfo[playerid][Level]);
        }
        BusinessSave();
        FermaSave();
        HouseSave();

    }
    return 1;
}
public NoRoof(playerid) {
    new carid = GetPlayerSurfingVehicleID(playerid); // получаем айди авто на котором игрок
    if (carid != INVALID_VEHICLE_ID) // если айди правильный(тоесть игрок на авто)
    {
        new Float:speed = GetVehicleSpeed(carid); // получаем скорость авто
        new cm = GetVehicleModel(carid); // получаем модель авто
        switch (cm) {
            case 430, 446, 452, 453, 454, 472, 473, 484, 493, 478, 595 : { return 1; } // если это лодка, скидывать ненадо)
            default: {}
        }
        if (speed > 30) // Если скорость больше 30км\час
        {
            new Float:slx, Float:sly, Float:slz;
            GetPlayerPos(playerid, slx, sly, slz);
            SetPlayerPos(playerid, slx, sly, slz + 2.5); // Немного подкинем игрока чтоб он не остался на авто
            ApplyAnimation(playerid, "ped", "BIKE_fallR", 4.0, 0, 1, 0, 0, 0, 0); // Применим анимку падения
            SetTimerEx("anim2", 1100, 0, "d", playerid); // Поставим на таймер анимку чтобы игрок нормально встал
        }
    }
    return 1;
}
public anim2(playerid) {
    ApplyAnimation(playerid, "ped", "getup", 4.0, 0, 1, 0, 0, 0, 0);
    return 1;
}
public OnPlayerStreamIn(playerid, forplayerid) {
    return 1;
}

public OnPlayerStreamOut(playerid, forplayerid) {
    return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid) {
    return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid) {
    return 1;
}
public AntiOnCar(playerid) {
    new Float:x, Float:y, Float:z;
    if (GetPlayerSurfingVehicleID(playerid) != INVALID_VEHICLE_ID) GetPlayerPos(playerid, x, y, z), SetPos(playerid, x + 2, y + 2, z);
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if (GetPVarInt(playerid, "USEDIALOGID") != dialogid) return 1;
    printf("%s: dialogid - %d; inputtext = '%s'", PlayerInfo[playerid][Name], dialogid, inputtext);
    if (SpawnMZ[playerid] == 1 || dialogid == DIALOG_SPAWN || dialogid == DIALOG_LOGIN || dialogid == DIALOG_WRONGPAS || dialogid == DIALOG_SEX || dialogid == DIALOG_REGISTER || dialogid == DIALOG_REGISTERR) {
        if (DIALOG_HOUSEINFO < dialogid && dialogid <= DIALOG_HOUSEBUY) {
            if (response) {
                new ids = dialogid - DIALOG_HOUSEINFO;
                if (HouseInfo[ids][Status] == 1) {
                    SetPlayerVirtualWorld(playerid, dialogid);
                    SetPos(playerid, HouseInfo[ids][SHX], HouseInfo[ids][SHY], HouseInfo[ids][SHZ]);
                    SetPlayerInterior(playerid, HouseInfo[ids][Int]);
                    SetPlayerFacingAngle(playerid, HouseInfo[ids][Angle]);
                    SetCameraBehindPlayer(playerid);
                    SendClientMessage(playerid, COLOR_GREY, "Чтобы выйти с дома, используйте команду /exit");
                } else {
                    if (HouseInfo[ids][ID] != PlayerInfo[playerid][House]) {
                        SendClientMessage(playerid, COLOR_GREY, "Дом закрыт!");
                    }
                    if (HouseInfo[ids][ID] == PlayerInfo[playerid][House]) {
                        SetPlayerVirtualWorld(playerid, dialogid);
                        SetPos(playerid, HouseInfo[ids][SHX], HouseInfo[ids][SHY], HouseInfo[ids][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[ids][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[ids][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREY, "Чтобы выйти с дома, используйте команду /exit");
                    }
                }
            }
        }
        if (DIALOG_HOUSEBUY < dialogid) {
            if (response) {
                new ids = dialogid - DIALOG_HOUSEBUY;
                if (HouseInfo[ids][Status] == 2) {
                    if (PlayerInfo[playerid][Money] >= HouseInfo[ids][Price]) {
                        if (PlayerInfo[playerid][House] == 0) {
                            GiveMoney(playerid, -HouseInfo[ids][Price]);
                            new result[128];
                            new Hour, Minute, Second;
                            gettime(Hour, Minute, Second);
                            new Year, Month, Day;
                            getdate(Year, Month, Day);
                            format(result, sizeof(result), "INSERT INTO `logs` (`Name`, `Do`, `time`) VALUE ('%s', 'buy house %d', '%d:%d:%d %d/%d/%d')", PlayerInfo[playerid][ID], ids, Hour, Minute, Second, Day, Month, Year);
                            mysql_query(result);
                            mysql_free_result();

                            HouseInfo[ids][Boss] = PlayerInfo[playerid][ID];
                            new query[100];
                            format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", HouseInfo[ids][Boss]);
                            mysql_query(query);
                            mysql_store_result();
                            if (mysql_num_rows() == 1) {
                                mysql_fetch_row_format(result, "|");
                                sscanf(result, "p<|>s[64]",
                                    HouseInfo[ids][BossName]);
                                mysql_free_result(); // Очищаем память.
                            }
                            HouseInfo[ids][Bank] = 1000;
                            HouseInfo[ids][Status] = 1;
                            DestroyDynamicPickup(HousePickupIn[ids]);
                            HousePickupIn[ids] = CreateDynamicPickup(1272, 23, HouseInfo[ids][HX], HouseInfo[ids][HY], HouseInfo[ids][HZ], 0);
                            DestroyDynamicMapIcon(HouseMapIcon[ids]);
                            HouseMapIcon[ids] = CreateDynamicMapIcon(HouseInfo[ids][HX], HouseInfo[ids][HY], HouseInfo[ids][HZ], 32, 0);
                            PlayerInfo[playerid][House] = ids;
                            HouseSaveO(ids);
                            SaveAccount(playerid);
                            SendClientMessage(playerid, COLOR_GREEN, "Вы купили дом! Поздравляем! Для управления домом, используйте команду - /hmenu");
                            SendClientMessage(playerid, COLOR_GREEN, "Пополните баланс жилья в банке, в случае нехватки средств на счету жилья - государство заберёт имушество без компенсации.");
                        } else {
                            SendClientMessage(playerid, COLOR_ORANGE, "У Вас уже есть дом, для покупки нового дома - продайте свой старый через команду - /hmenu");
                        }
                    } else {
                        SendClientMessage(playerid, COLOR_ORANGE, "У Вас не достаточно средств для покупки дома.");
                    }
                }
            }
        }
        switch (dialogid) {

            case DIALOG_LOGIN:  {
                if (!response) {
                    SendClientMessage(playerid, COLOR_YELLOW, "* Введите /q(uit), чтобы выйти из игры.");
                    lKick(playerid);
                    return 1;
                }
                if (!strlen(inputtext)) {
                    new dialog[134 + MAX_PLAYER_NAME];
                    format(dialog, sizeof(dialog),
                        "Добро пожаловать!\n\
                                        Этот аккаунт зарегистрирован.\n\n\
                                        Логин: %s\n\
                                        Введите пароль:",
                        PlayerInfo[playerid][Name]);
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Авторизация", dialog, "Войти", "Отмена");
                    return 1;
                }
                LoadAccount(playerid, inputtext);
            }
            case DIALOG_REGISTER:  {
                if (!response) {
                    SendClientMessage(playerid, COLOR_YELLOW, "* Введите /q(uit), чтобы выйти из игры.");
                    lKick(playerid);
                    return 1;
                }
                for (new i = strlen(inputtext); i != 0; --i)

                    switch (inputtext[i]) {
                        case 'А'..
                        'Я', 'а'..
                        'я', ' ':
                            return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Регистрация", "Пароль должен содержать только цифры, символы на латинице! Введите пароль повторно:", "Далее", "Отмена");
                    }

                if (!strlen(inputtext) || strlen(inputtext) < 6 || strlen(inputtext) > 32) {
                    new dialog[300];
                    format(dialog, sizeof(dialog), "Добро пожаловать!\nЭтот аккаунт не зарегистрирован.\n\nЛогин: %s\nВведите пароль и нажмите 'Далее'.\n\nПримечания:\n- Пароль чувствительный к регистру.\n- Длина пароля от 6 до 32 символов.\n- В пароле можно использовать символы на латинице и цифры.\n", PlayerInfo[playerid][Name]);
                    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Регистрация", dialog, "Далее", "Отмена");
                    return 1;
                } else {
                    //PlayerInfo[playerid][Password] = inputtext;
                    format(PlayerInfo[playerid][Passwordaccount], 64, "%s", inputtext);
                    printf("inputtext = %s; Passwordaccount = %s", inputtext, PlayerInfo[playerid][Passwordaccount]);
                    SetSex(playerid);
                }

            }
            case DIALOG_WRONGPAS:  {
                if (response) {
                    new dialog[134 + MAX_PLAYER_NAME];
                    format(dialog, sizeof(dialog),
                        "Добро пожаловать!\n\
                                        Этот аккаунт зарегистрирован.\n\n\
                                        Логин: %s\n\
                                        Введите пароль:",
                        PlayerInfo[playerid][Name]);
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Авторизация", dialog, "Войти", "Отмена");
                    return 1;
                } else {
                    lKick(playerid);
                    return 1;
                }
            }
            case DIALOG_SEX:  {
                if (response) {
                    PlayerInfo[playerid][Sex] = 1;
                    ClothesRound[playerid] = 1;
                    Spawner[playerid] = 0;
                    SpawnPlayer(playerid);
                    OnPlayerSpawn(playerid);
                } else {


                    PlayerInfo[playerid][Sex] = 2;
                    ClothesRound[playerid] = 1;
                    Spawner[playerid] = 0;
                    SpawnPlayer(playerid);
                    OnPlayerSpawn(playerid);
                }
            }
            case DIALOG_GPSONE:  {
                if (response) {
                    if (listitem == 0) {
                        gpsmetkaX[playerid] = 2202.38;
                        gpsmetkaY[playerid] = -2238.19;
                        gpsmetkaZ[playerid] = 13.55;
                        DisablePlayerCheckpoint(playerid);
                        SetPlayerCheckpoint(playerid, gpsmetkaX[playerid], gpsmetkaY[playerid], gpsmetkaZ[playerid], 3.0);
                        SendClientMessage(playerid, COLOR_GREEN, "На карте и радаре установлена метка, следуйте к ней чтобы достигнуть нужной позиции.");
                    }
                    if (listitem == 1) {
                        gpsmetkaX[playerid] = -104.01;
                        gpsmetkaY[playerid] = 69.11;
                        gpsmetkaZ[playerid] = 3.12;
                        DisablePlayerCheckpoint(playerid);
                        SetPlayerCheckpoint(playerid, gpsmetkaX[playerid], gpsmetkaY[playerid], gpsmetkaZ[playerid], 3.0);
                        SendClientMessage(playerid, COLOR_GREEN, "На карте и радаре установлена метка, следуйте к ней чтобы достигнуть нужной позиции.");
                    }
                    if (listitem == 2) {
                        gpsmetkaX[playerid] = -1052.62;
                        gpsmetkaY[playerid] = -1204.95;
                        gpsmetkaZ[playerid] = 128.94;
                        DisablePlayerCheckpoint(playerid);
                        SetPlayerCheckpoint(playerid, gpsmetkaX[playerid], gpsmetkaY[playerid], gpsmetkaZ[playerid], 3.0);
                        SendClientMessage(playerid, COLOR_GREEN, "На карте и радаре установлена метка, следуйте к ней чтобы достигнуть нужной позиции.");
                    }
                    if (listitem == 3) {
                        gpsmetkaX[playerid] = 1258.34;
                        gpsmetkaY[playerid] = -1820.21;
                        gpsmetkaZ[playerid] = 13.11;
                        DisablePlayerCheckpoint(playerid);
                        SetPlayerCheckpoint(playerid, gpsmetkaX[playerid], gpsmetkaY[playerid], gpsmetkaZ[playerid], 3.0);
                        SendClientMessage(playerid, COLOR_GREEN, "На карте и радаре установлена метка, следуйте к ней чтобы достигнуть нужной позиции.");
                    }
                    if (listitem == 4) {
                        gpsmetkaX[playerid] = -2329.12;
                        gpsmetkaY[playerid] = -135.93;
                        gpsmetkaZ[playerid] = 35.03;
                        DisablePlayerCheckpoint(playerid);
                        SetPlayerCheckpoint(playerid, gpsmetkaX[playerid], gpsmetkaY[playerid], gpsmetkaZ[playerid], 3.0);
                        SendClientMessage(playerid, COLOR_GREEN, "На карте и радаре установлена метка, следуйте к ней чтобы достигнуть нужной позиции.");
                    }
                    if (listitem == 5) {
                        gpsmetkaX[playerid] = 2450.72;
                        gpsmetkaY[playerid] = 2002.57;
                        gpsmetkaZ[playerid] = 10.53;
                        DisablePlayerCheckpoint(playerid);
                        SetPlayerCheckpoint(playerid, gpsmetkaX[playerid], gpsmetkaY[playerid], gpsmetkaZ[playerid], 3.0);
                        SendClientMessage(playerid, COLOR_GREEN, "На карте и радаре установлена метка, следуйте к ней чтобы достигнуть нужной позиции.");
                    }
                }
            }
            case DIALOG_GPS:  {
                if (response) {
                    if (listitem == 0) {
                        ShowPlayerDialog(playerid, DIALOG_GPSONE, DIALOG_STYLE_LIST, "GPS-навигатор [Работа]", "1. Работа грузчика\n2. Ферма Лос Сантоса\n3. Ферма Сан Фиерро\n4. Стоянка машин для продажи еды Лос Сантоса\n5. Стоянка машин для продажи еды Сан Фиерро\n6. Стоянка машин для продажи еды Лас Вентурас", "Выбрать", "Закрыть");
                    }
                    if (listitem == 1) {

                    }
                    if (listitem == 2) {

                    }
                    if (listitem == 3) {

                    }
                    if (listitem == 4) {

                    }
                    if (listitem == 5) {

                    }
                    if (listitem == 6) {

                    }
                }
            }
            case DIALOG_HOUSEPR:  {
                if (response) {
                    new a = HouseID[playerid];
                    new o = GetPlayerVirtualWorld(playerid);
                    new ids = 0;
                    ids = (o - DIALOG_HOUSEINFO);
                    if (HouseID[playerid] != 50000) {
                        if (PlayerInfo[playerid][Money] >= HouseSum[a]) {
                            if (PlayerInfo[a][House] == ids) {
                                if (PlayerInfo[a][ID] == HouseInfo[ids][Boss]) {
                                    if (PlayerInfo[playerid][House] == 0) {
                                        new string[128];

                                        GiveMoney(playerid, -HouseSum[a]);
                                        GiveMoney(a, HouseSum[a]);
                                        HouseInfo[ids][Boss] = PlayerInfo[playerid][ID];
                                        HouseInfo[ids][Bank] = 1000;
                                        HouseInfo[ids][Heal] = 0;
                                        HouseInfo[ids][Signal] = 0;
                                        HouseInfo[ids][Klad] = 0;
                                        HouseInfo[ids][Status] = 1;
                                        PlayerInfo[a][House] = 0;
                                        OnPlayerCommandText(playerid, "/exit");
                                        OnPlayerCommandText(a, "/exit");

                                        new result[128];
                                        new Hour, Minute, Second;
                                        gettime(Hour, Minute, Second);
                                        new Year, Month, Day;
                                        getdate(Year, Month, Day);
                                        PlayerInfo[playerid][House] = ids;
                                        new query[100];
                                        format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", HouseInfo[ids][Boss]);
                                        mysql_query(query);
                                        mysql_store_result();
                                        if (mysql_num_rows() == 1) {
                                            mysql_fetch_row_format(result, "|");
                                            sscanf(result, "p<|>s[64]",
                                                HouseInfo[ids][BossName]);
                                            mysql_free_result(); // Очищаем память.
                                        }
                                        format(result, sizeof(result), "INSERT INTO `logs` (`Name`, `Do`, `time`) VALUE ('%s', 'buy house %d', '%d:%d:%d %d/%d/%d')", PlayerInfo[playerid][ID], ids, Hour, Minute, Second, Day, Month, Year);
                                        mysql_query(result);
                                        mysql_free_result();
                                        SaveAccount(playerid);
                                        SaveAccount(a);
                                        HouseSaveO(ids);
                                        SendClientMessage(playerid, COLOR_GREEN, "Вы купили дом! Поздравляем! Для управления домом, используйте команду - /hmenu");
                                        SendClientMessage(playerid, COLOR_GREEN, "Пополните баланс жилья в банке, в случае нехватки средств на счету жилья - государство заберёт имушество без компенсации.");
                                        format(string, sizeof(string), "Вы успешно продали своё жилье %s за %d$.", PlayerInfo[playerid][Name], HouseSum[a]);
                                        SendClientMessage(a, COLOR_GREEN, string);
                                    } else {
                                        SendClientMessage(playerid, COLOR_RED, "У Вас уже есть дом, продайте его чтобы купить новый.");
                                        SendClientMessage(a, COLOR_RED, "У покупателя уже есть дом, ему его необходимо продать чтобы купить новый.");
                                    }
                                }
                            }
                        } else {

                            SendClientMessage(playerid, COLOR_RED, "У Вас не достаточно средств на руках.");
                            SendClientMessage(a, COLOR_RED, "У покупателя на руках нет достаточной суммы.");
                        }
                    }
                }
            }



            case DIALOG_HOUSEPROOO:  {

                if (response) {
                    new ids = PlayerInfo[playerid][House];
                    new ll = HouseProd[playerid];
                    new str[128];
                    new l = strval(inputtext);

                    if (l >= HouseInfo[ids][Price]) {

                        format(str, sizeof(str), "Вы предложили %s купить жилье за %d$", PlayerInfo[ll][Name], l);
                        SendClientMessage(playerid, COLOR_GREEN, str);
                        HouseSum[playerid] = l;
                        HouseID[ll] = playerid;
                        format(str, sizeof(str), "%s предлагает Вам купить жилье.\n Цена: %d$", PlayerInfo[playerid][Name], l);
                        ShowPlayerDialog(ll, DIALOG_HOUSEPR, DIALOG_STYLE_MSGBOX, "Покупка жилья", str, "Покупаю", "Отмена");
                    } else {
                        format(str, sizeof(str), "Вы не можете продать жилье дешевле чем она стоит на рынке - %d$", HouseInfo[ids][Price]);
                        SendClientMessage(playerid, COLOR_RED, str);
                    }



                }
            }
            case DIALOG_HOUSEPROO:  {

                if (response) {
                    if (strlen(inputtext) && strlen(inputtext) > 0 && strlen(inputtext) < 4) {
                        new l = strval(inputtext);
                        if (IsPlayerConnected(l) && l != playerid) {
                            if (ProxDetectorS(5.0, playerid, l)) {
                                new str[128];
                                format(str, sizeof(str), "Вы хотите продать жилье %s?\nВ таком случае введите цену для продажи жилья.", PlayerInfo[l][Name]);
                                HouseProd[playerid] = l;
                                ShowPlayerDialog(playerid, DIALOG_HOUSEPROOO, DIALOG_STYLE_INPUT, "Продажа жилья", str, "ОК", "Отмена");
                            } else {
                                SendClientMessage(playerid, COLOR_RED, "Вы должны быть рядом с покупателем.");
                            }
                        } else {
                            SendClientMessage(playerid, COLOR_RED, "Игрока с указанным ID нет в игре.");
                        }
                    }

                }
            }
            case DIALOG_HOUSEPRO:  {
                if (response) {
                    new i = PlayerInfo[playerid][House];
                    new m = HouseInfo[i][Price] / 2;
                    HouseInfo[i][Boss] = 0;
                    HouseInfo[i][Int] = HouseInfo[i][IntB];
                    HouseInfo[i][Bank] = 0;
                    HouseInfo[i][Heal] = 0;
                    HouseInfo[i][SHX] = HouseInfo[i][SHXB];
                    HouseInfo[i][SHY] = HouseInfo[i][SHYB];
                    HouseInfo[i][SHZ] = HouseInfo[i][SHZB];
                    HouseInfo[i][Signal] = 0;
                    HouseInfo[i][Klad] = 0;
                    HouseInfo[i][Angle] = HouseInfo[i][AngleB];
                    HouseInfo[i][Status] = 2;
                    PlayerInfo[playerid][House] = 0;
                    DestroyDynamicPickup(HousePickupIn[i]);
                    HousePickupIn[i] = CreateDynamicPickup(1273, 23, HouseInfo[i][HX], HouseInfo[i][HY], HouseInfo[i][HZ], 0);
                    DestroyDynamicMapIcon(HouseMapIcon[i]);
                    HouseMapIcon[i] = CreateDynamicMapIcon(HouseInfo[i][HX], HouseInfo[i][HY], HouseInfo[i][HZ], 31, 0);
                    GiveMoney(playerid, m);
                    SaveAccount(playerid);
                    HouseSaveO(i);
                    SendClientMessage(playerid, COLOR_GREEN, "Вы успешно продали жилье государству!");
                    OnPlayerCommandText(playerid, "/exit");
                }
            }
            case DIALOG_HOUSEPROD:  {
                if (response) {
                    if (listitem == 0) {
                        ShowPlayerDialog(playerid, DIALOG_HOUSEPROO, DIALOG_STYLE_INPUT, "Продажа жилья", "Введите ID игрока, которому Вы решили продать жилье.", "Дальше", "Отмена");
                    }
                    if (listitem == 1) {
                        new str[128];
                        new ids = PlayerInfo[playerid][House];
                        new m = HouseInfo[ids][Price] / 2;
                        format(str, sizeof(str), "Вы действительно хотите продать жилье государству? Вы получите {E33014}$%d", m);
                        ShowPlayerDialog(playerid, DIALOG_HOUSEPRO, DIALOG_STYLE_MSGBOX, "Продажа жилья", str, "Продать", "Отмена");
                    }
                }
            }
            case DIALOG_HOUSEUL:  {
                if (response) {
                    new ids = PlayerInfo[playerid][House];
                    if (listitem == 0) {
                        if (HouseInfo[ids][Klad] == 0) {

                            HouseInfo[ids][Klad] = 1;
                            SendClientMessage(playerid, COLOR_GREEN, "У Вас появилась кладовка! Теперь Вы можете хранить больше вещей.");
                        } else {
                            SendClientMessage(playerid, COLOR_RED, "У Вас уже имеется кладовка.");
                        }
                    }
                    if (listitem == 1) {
                        if (HouseInfo[ids][Signal] == 0) {
                            HouseInfo[ids][Signal] = 1;
                            SendClientMessage(playerid, COLOR_GREEN, "Вы установили в доме сигнализацию. Теперь Вас воры не будут беспокоить!");
                        } else {
                            SendClientMessage(playerid, COLOR_RED, "У Вас уже имеется сигнализация.");
                        }
                    }
                    if (listitem == 2) {
                        Inter[playerid] = 1;
                        new kla[20];
                        new j = PlayerInfo[playerid][House];
                        SendClientMessage(playerid, COLOR_ORANGE, "Вам предоставлены возможные варианты иньерьеров, которые соответствуют Вашему класу дома.");
                        SendClientMessage(playerid, COLOR_ORANGE, "Чтобы выйти с выбора нового интерьера, введите - /exit");
                        SetPlayerVirtualWorld(playerid, playerid);
                        TextDrawShowForPlayer(playerid, ButtonLeft);
                        TextDrawShowForPlayer(playerid, ButtonRight);
                        TextDrawShowForPlayer(playerid, ButtonSelect);
                        SelectTextDraw(playerid, 0xFF4040AA);
                        if (HouseInfo[j][Price] <= 80000) {
                            format(kla, sizeof(kla), "Эконом");
                            TogglePlayerControllable(playerid, 0);
                            SetPlayerInterior(playerid, 1);
                            SetPos(playerid, 243.72, 304.91, 999.15);
                            SetPlayerFacingAngle(playerid, 270.0);
                            SetPlayerCameraPos(playerid, 246.11, 306.57, 999.15);
                            SetPlayerCameraLookAt(playerid, 246.35, 302.19, 999.15);
                            SelectCharRegID[playerid] = 1;
                            InterN[playerid] = 1;
                            new opsdgpq[64];
                            CenInt[playerid] = 40000;
                            format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                            GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                        }
                        if (HouseInfo[j][Price] > 80000 && HouseInfo[j][Price] <= 200000) {
                            format(kla, sizeof(kla), "Средний");
                            TogglePlayerControllable(playerid, 0);
                            SetPlayerInterior(playerid, 1);
                            SetPos(playerid, 2218.61, -1075.95, 1050.48);
                            SetPlayerCameraPos(playerid, 2218.40, -1076.18, 1050.48);
                            SetPlayerCameraLookAt(playerid, 2209.52, -1076.31, 1050.48);
                            SelectCharRegID[playerid] = 1;
                            SetPlayerFacingAngle(playerid, 90.0);
                            InterN[playerid] = 7;
                            new opsdgpq[64];
                            CenInt[playerid] = 85000;
                            format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                            GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                        }
                        if (HouseInfo[j][Price] >= 300000) {
                            format(kla, sizeof(kla), "Бизнес");
                            TogglePlayerControllable(playerid, 0);
                            SetPlayerInterior(playerid, 5);
                            SetPos(playerid, 140.17, 1366.07, 1083.65);
                            SetPlayerCameraPos(playerid, 140.17, 1366.07, 1083.65);
                            SetPlayerCameraLookAt(playerid, 140.17, 1370.07, 1083.65);
                            SelectCharRegID[playerid] = 1;
                            SetPlayerFacingAngle(playerid, 0);
                            InterN[playerid] = 17;
                            new opsdgpq[64];
                            CenInt[playerid] = 300000;
                            format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                            GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                        }

                    }
                }
            }
            case DIALOG_HOUSEMENU: {
                if (response) {
                    if (listitem == 0) {
                        new ids = PlayerInfo[playerid][House];
                        new shar;
                        if (shar == 0) {
                            if (HouseInfo[ids][Status] == 1) {
                                HouseInfo[ids][Status] = 0;
                                SendClientMessage(playerid, COLOR_ORANGE, "Вы закрыли дом!");
                                shar = 1;
                            }
                        }
                        if (shar == 0) {
                            if (HouseInfo[ids][Status] == 0) {
                                HouseInfo[ids][Status] = 1;
                                SendClientMessage(playerid, COLOR_ORANGE, "Вы открыли дом!");
                            }
                        }
                        shar = 0;
                    }
                    if (listitem == 1) {
                        if (PlayerInfo[playerid][Car] != 0) {
                            new l = PlayerInfo[playerid][House];
                            new bn;
                            for (new i = 1; i < MAX_HOUSE; i++) {
                                if (GarageInfo[i][House] == l) {
                                    bn = 1;
                                    lcar(playerid, i);
                                    GiveMoney(playerid, -100);
                                    SendClientMessage(playerid, COLOR_GREEN, "Ваш личный транспорт доставлен к дому.");
                                }
                            }
                            if (bn != 1) {
                                SendClientMessage(playerid, COLOR_RED, "У Вашего дома нет гаража");
                            }
                        } else {
                            SendClientMessage(playerid, COLOR_RED, "У Ваc нет личного транспорта.");
                        }
                    }
                    if (listitem == 2) {
                        ShowPlayerDialog(playerid, DIALOG_HOUSEUL, DIALOG_STYLE_LIST, "Улучшения", "1. Кладовка(позволяет хранить больше аптечек и других вещей)\n2. Сигнализация(защитит от грабежей)\n3. Изменить интерьер", "Выбрать", "Закрыть");
                    }
                    if (listitem == 3) {
                        new ids = PlayerInfo[playerid][House];
                        new kl[23], sig[23], kla[20], string[256];
                        if (HouseInfo[ids][Klad] == 1) {
                            format(kl, sizeof(kl), "{33AA33}Присутствует");
                        }
                        if (HouseInfo[ids][Klad] == 0) {
                            format(kl, sizeof(kl), "{E33014}Отсутствует");
                        }
                        if (HouseInfo[ids][Signal] == 1) {
                            format(sig, sizeof(sig), "{33AA33}Присутствует");
                        }
                        if (HouseInfo[ids][Signal] == 0) {
                            format(sig, sizeof(sig), "{E33014}Отсутствует");
                        }
                        if (HouseInfo[ids][Price] <= 80000) {
                            format(kla, sizeof(kla), "Эконом");
                        }
                        if (HouseInfo[ids][Price] > 80000 && HouseInfo[ids][Price] <= 200000) {
                            format(kla, sizeof(kla), "Средний");
                        }
                        if (HouseInfo[ids][Price] >= 300000) {
                            format(kla, sizeof(kla), "Бизнес");
                        }
                        format(string, sizeof(string), "{FFFFFF}Номер дома\t\t{33AA33}%d{FFFFFF}\nВладелец\t\t{33AA33}%s{FFFFFF}\nКласс\t\t\t{33AA33}%s{FFFFFF}\nЦена\t\t\t{33AA33}%d{FFFFFF}\n\nАптечек\t\t{33AA33}%d{FFFFFF}\n\nУлучшения\nКладовка\t\t%s{FFFFFF}\nСигнализация\t\t%s{FFFFFF}\n", HouseInfo[ids][ID], PlayerInfo[playerid][Name], kla, HouseInfo[ids][Price], HouseInfo[ids][Heal], kl, sig);
                        ShowPlayerDialog(playerid, DIALOG_HOUSEINFOO, DIALOG_STYLE_MSGBOX, "Информация", string, "ОК", "");
                    }
                    if (listitem == 4) {
                        ShowPlayerDialog(playerid, DIALOG_HOUSEPROD, DIALOG_STYLE_LIST, "Улучшения", "1. Продать гражданину\n2. Продать государству", "Выбрать", "Закрыть");
                    }
                }
            }
            case DIALOG_FERMALSMASH:  {

                if (response) {
                    new vehicleid = GetPlayerVehicleID(playerid);
                    fermalsin[vehicleid][InG] = 1;
                    SendClientMessage(playerid, COLOR_GREEN, "Вы закончили загрузку машины. Необходимо отвезти груз на склад.");
                    DestroyPickup(FermaLSDynamicPR[vehicleid]);
                    Delete3DTextLabel(FermaLS3DTEXTR[vehicleid]);
                    DisablePlayerCheckpoint(playerid);
                    RemovePlayerFromVehicle(playerid);
                } else {
                    new vehicleid = GetPlayerVehicleID(playerid);

                    fermalsin[vehicleid][InG] = 0;
                    RemovePlayerFromVehicle(playerid);
                    return 1;
                }
            }
            case DIALOG_FERMASFMASH:  {

                if (response) {
                    new vehicleid = GetPlayerVehicleID(playerid);
                    fermasfin[vehicleid][InG] = 1;
                    SendClientMessage(playerid, COLOR_GREEN, "Вы закончили загрузку машины. Необходимо отвезти груз на склад.");
                    DestroyPickup(FermaSFDynamicPR[vehicleid]);
                    Delete3DTextLabel(FermaSF3DTEXTR[vehicleid]);
                    DisablePlayerCheckpoint(playerid);
                    RemovePlayerFromVehicle(playerid);
                } else {
                    new vehicleid = GetPlayerVehicleID(playerid);

                    fermasfin[vehicleid][InG] = 0;
                    RemovePlayerFromVehicle(playerid);
                    return 1;
                }
            }
            case DIALOG_FERMALSURP:  {
                if (response) {
                    new ss;
                    ss = strval(inputtext);
                    if (ss >= 6) {
                        if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {
                            FermaInfo[1][Price] = ss;
                        }
                        if (FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                            FermaInfo[2][Price] = ss;
                        }
                        SendClientMessage(playerid, COLOR_GREEN, "Цена за куст изменена.");
                    } else {
                        SendClientMessage(playerid, COLOR_GREEN, "Цена за куст не должна быть ниже 6");
                    }
                }

            }
            case DIALOG_FERMALSMENUP:  {
                if (response) {
                    if (PlayerInfo[playerid][FermaLS] == 1 || FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {
                        FermaInfo[1][Bank] += FERMAUR * FermaInfo[1][Ur];
                        FermaInfo[1][Ur] = 0;
                        SendClientMessage(playerid, COLOR_GREEN, "Урожай продан, средства были переведены на банковский счёт фермы.");
                    }
                    if (PlayerInfo[playerid][FermaSF] == 1 || FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                        FermaInfo[2][Bank] += FERMAUR * FermaInfo[2][Ur];
                        FermaInfo[2][Ur] = 0;
                        SendClientMessage(playerid, COLOR_GREEN, "Урожай продан, средства были переведены на банковский счёт фермы.");
                    }
                }
            }
            case DIALOG_FERMALSPROD:  {
                if (response) {
                    if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {
                        ShowPlayerDialog(playerid, DIALOG_FERMALSPRODD, DIALOG_STYLE_LIST, "Продажа фермы", "1. Продать физическому лицу\n2. Продать государству", "ОК", "Отмена");
                    }
                    if (FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                        ShowPlayerDialog(playerid, DIALOG_FERMALSPRODD, DIALOG_STYLE_LIST, "Продажа фермы", "1. Продать физическому лицу\n2. Продать государству", "ОК", "Отмена");
                    }
                }
            }
            case DIALOG_FERMALSPRODA:  {
                if (response) {
                    if (FermaID[playerid] != 50000) {
                        new a = FermaID[playerid];
                        if (PlayerInfo[playerid][Money] >= FermaSum[a]) {
                            if (PlayerInfo[a][ID] == FermaInfo[1][Boss]) {
                                new string[128];

                                GiveMoney(playerid, -FermaSum[a]);
                                GiveMoney(a, FermaSum[a]);
                                new result[128];
                                new Hour, Minute, Second;
                                gettime(Hour, Minute, Second);
                                new Year, Month, Day;
                                getdate(Year, Month, Day);
                                format(result, sizeof(result), "INSERT INTO `logs` (`Name`, `Do`, `time`) VALUE ('%s', 'buy ferma %d', '%d:%d:%d %d/%d/%d')", PlayerInfo[playerid][ID], FermaInfo[1][ID], Hour, Minute, Second, Day, Month, Year);
                                mysql_query(result);
                                mysql_free_result();
                                SendClientMessage(playerid, COLOR_WHITE, "Вы купили ферму Лос Сантоса. Пополните счёт фермы в банке.");
                                SendClientMessage(playerid, COLOR_WHITE, "В случае, если на банковском счету фермы не будет достаточно средств, Ваш бизнес заберёт государство.");
                                SendClientMessage(playerid, COLOR_WHITE, "Меню для управления фермой - /fmenu, остальные команды Вы можете найти в меню сервера - /menu");
                                FermaInfo[1][Boss] = PlayerInfo[playerid][ID];
                                FermaInfo[1][Status] = 1;
                                FermaInfo[1][Bank] = 1000;
                                FermaInfo[1][Fermer1] = 0;
                                FermaInfo[1][Fermer2] = 0;
                                FermaInfo[1][Fermer3] = 0;
                                FermaInfo[1][Fermer4] = 0;
                                FermaInfo[1][Fermer5] = 0;
                                FermaInfo[1][Ur] = 0;
                                FermaInfo[1][UrP] = 0;
                                FermaInfo[1][Zerno] = 0;
                                for (new iis; iis < MAX_PLAYERS; iis++) {
                                    PlayerInfo[iis][FermaLS] = 0;
                                }
                                format(string, sizeof(string), "UPDATE `accounts` SET `FermaLS` = 0");
                                mysql_query(string);
                                SaveAccount(playerid);
                                SaveAccount(a);
                                FermaSave();
                                format(string, sizeof(string), "Вы успешно продали ферму Лос Сантоса %s за %d$.", PlayerInfo[playerid][Name], FermaSum[a]);
                                SendClientMessage(a, COLOR_GREEN, string);
                            }
                            if (PlayerInfo[a][ID] == FermaInfo[2][Boss]) {
                                new string[128];

                                GiveMoney(playerid, -FermaSum[a]);
                                GiveMoney(a, FermaSum[a]);
                                new result[128];
                                new Hour, Minute, Second;
                                gettime(Hour, Minute, Second);
                                new Year, Month, Day;
                                getdate(Year, Month, Day);
                                format(result, sizeof(result), "INSERT INTO `logs` (`Name`, `Do`, `time`) VALUE ('%s', 'buy ferma %d', '%d:%d:%d %d/%d/%d')", PlayerInfo[playerid][ID], FermaInfo[2][ID], Hour, Minute, Second, Day, Month, Year);
                                mysql_query(result);
                                mysql_free_result();
                                SendClientMessage(playerid, COLOR_WHITE, "Вы купили ферму Сан Фиерро. Пополните счёт фермы в банке.");
                                SendClientMessage(playerid, COLOR_WHITE, "В случае, если на банковском счету фермы не будет достаточно средств, Ваш бизнес заберёт государство.");
                                SendClientMessage(playerid, COLOR_WHITE, "Меню для управления фермой - /fmenu, остальные команды Вы можете найти в меню сервера - /menu");
                                FermaInfo[2][Boss] = PlayerInfo[playerid][ID];
                                FermaInfo[2][Status] = 1;
                                FermaInfo[2][Bank] = 1000;
                                FermaInfo[2][Fermer1] = 0;
                                FermaInfo[2][Fermer2] = 0;
                                FermaInfo[2][Fermer3] = 0;
                                FermaInfo[2][Fermer4] = 0;
                                FermaInfo[2][Fermer5] = 0;
                                FermaInfo[2][Ur] = 0;
                                FermaInfo[2][UrP] = 0;
                                FermaInfo[2][Zerno] = 0;
                                for (new iis; iis < MAX_PLAYERS; iis++) {
                                    PlayerInfo[iis][FermaSF] = 0;
                                }
                                format(string, sizeof(string), "UPDATE `accounts` SET `FermaSF` = 0");
                                mysql_query(string);
                                SaveAccount(playerid);
                                SaveAccount(a);
                                FermaSave();
                                format(string, sizeof(string), "Вы успешно продали ферму Сан Фиерро %s за %d$.", PlayerInfo[playerid][Name], FermaSum[a]);
                                SendClientMessage(a, COLOR_GREEN, string);
                            }
                        }
                    }
                }
            }
            case DIALOG_FERMALSPRODDPP:  {
                if (response) {
                    if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {
                        if (strlen(inputtext) && strlen(inputtext) > 0) {
                            new l = strval(inputtext);
                            new str[128];
                            if (l >= FermaInfo[1][Sum]) {
                                new ll = FermaProd[playerid];
                                format(str, sizeof(str), "Вы предложили %s купить ферму за %d$", PlayerInfo[ll][Name], l);
                                SendClientMessage(playerid, COLOR_GREEN, str);
                                FermaSum[playerid] = l;
                                FermaID[ll] = playerid;
                                format(str, sizeof(str), "%s предлагает Вам купить ферму Лос Сантоса.\n Цена: %d$", PlayerInfo[playerid][Name], l);
                                ShowPlayerDialog(ll, DIALOG_FERMALSPRODA, DIALOG_STYLE_MSGBOX, "Покупка фермы", str, "Покупаю", "Отмена");
                            } else {
                                format(str, sizeof(str), "Вы не можете продать ферму дешевле чем она стоит на рынке - %d$", FermaInfo[1][Sum]);
                                SendClientMessage(playerid, COLOR_RED, str);
                            }
                        }
                    }
                    if (FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                        if (strlen(inputtext) && strlen(inputtext) > 0) {
                            new l = strval(inputtext);
                            new str[128];
                            if (l >= FermaInfo[2][Sum]) {
                                new ll = FermaProd[playerid];
                                format(str, sizeof(str), "Вы предложили %s купить ферму за %d$", PlayerInfo[ll][Name], l);
                                SendClientMessage(playerid, COLOR_GREEN, str);
                                FermaSum[playerid] = l;
                                FermaID[ll] = playerid;
                                format(str, sizeof(str), "%s предлагает Вам купить ферму Лос Сантоса.\n Цена: %d$", PlayerInfo[playerid][Name], l);
                                ShowPlayerDialog(ll, DIALOG_FERMALSPRODA, DIALOG_STYLE_MSGBOX, "Покупка фермы", str, "Покупаю", "Отмена");
                            } else {
                                format(str, sizeof(str), "Вы не можете продать ферму дешевле чем она стоит на рынке - %d$", FermaInfo[2][Sum]);
                                SendClientMessage(playerid, COLOR_RED, str);
                            }
                        }
                    }
                }
            }
            case DIALOG_FERMALSPRODDP:  {
                if (response) {
                    if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {
                        if (strlen(inputtext) && strlen(inputtext) > 0 && strlen(inputtext) < 4) {
                            new l = strval(inputtext);
                            if (IsPlayerConnected(l) && l != playerid) {
                                if (ProxDetectorS(5.0, playerid, l)) {
                                    new str[128];
                                    format(str, sizeof(str), "Вы хотите продать ферму %s?\nВ таком случае введите цену для продажи фермы.", PlayerInfo[l][Name]);
                                    FermaProd[playerid] = l;
                                    ShowPlayerDialog(playerid, DIALOG_FERMALSPRODDPP, DIALOG_STYLE_INPUT, "Продажа фермы", str, "ОК", "Отмена");
                                } else {
                                    SendClientMessage(playerid, COLOR_RED, "Вы должны быть рядом с покупателем.");
                                }
                            } else {
                                SendClientMessage(playerid, COLOR_RED, "Игрока с указанным ID нет в игре.");
                            }
                        }
                    }
                    if (FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                        if (strlen(inputtext) && strlen(inputtext) > 0 && strlen(inputtext) < 4) {
                            new l = strval(inputtext);
                            if (IsPlayerConnected(l) && l != playerid) {
                                new str[128];
                                format(str, sizeof(str), "Вы хотите продать ферму %s?\nВ таком случае введите цену для продажи фермы.", PlayerInfo[l][Name]);
                                FermaProd[playerid] = l;
                                ShowPlayerDialog(playerid, DIALOG_FERMALSPRODDPP, DIALOG_STYLE_INPUT, "Продажа фермы", str, "ОК", "Отмена");
                            } else {
                                SendClientMessage(playerid, COLOR_RED, "Игрока с указанным ID нет в игре.");
                            }
                        }
                    }
                }
            }
            case DIALOG_FERMALSPRODD:  {
                if (response) {
                    if (listitem == 0) {
                        ShowPlayerDialog(playerid, DIALOG_FERMALSPRODDP, DIALOG_STYLE_INPUT, "Продажа фермы", "Введите ID игрока, которому Вы решили продать ферму", "ОК", "Отмена");
                    }
                    if (listitem == 1) {
                        new string[64];
                        if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {
                            new q[64];
                            new result[128];
                            new Hour, Minute, Second;
                            gettime(Hour, Minute, Second);
                            new Year, Month, Day;
                            getdate(Year, Month, Day);
                            format(result, sizeof(result), "INSERT INTO `logs` (`Name`, `Do`, `time`) VALUE ('%s', 'buy ferma %d', '%d:%d:%d %d/%d/%d')", PlayerInfo[playerid][ID], FermaInfo[1][ID], Hour, Minute, Second, Day, Month, Year);
                            mysql_query(result);
                            mysql_free_result();
                            format(q, sizeof(q), "Ферма была продана государству, Вы получили %d.", FermaInfo[1][Sum]);
                            SendClientMessage(playerid, COLOR_GREEN, q);
                            GiveMoney(playerid, FermaInfo[1][Sum]);
                            FermaInfo[1][Bank] = 0;
                            FermaInfo[1][Boss] = 0;
                            FermaInfo[1][Status] = 2;
                            FermaInfo[1][Fermer1] = 0;
                            FermaInfo[1][Fermer2] = 0;
                            FermaInfo[1][Fermer3] = 0;
                            FermaInfo[1][Fermer4] = 0;
                            FermaInfo[1][Fermer5] = 0;
                            FermaInfo[1][Price] = 6;
                            FermaInfo[1][Ur] = 0;
                            FermaInfo[1][UrP] = 0;
                            FermaInfo[1][Ammount] = 0;
                            FermaInfo[1][Zerno] = 0;
                            for (new ii; ii < MAX_PLAYERS; ii++) {
                                PlayerInfo[ii][FermaLS] = 0;
                            }
                            format(string, sizeof(string), "UPDATE `accounts` SET `FermaLS` = 0");
                            mysql_query(string);
                            SaveAccount(playerid);
                            FermaSave();
                            new str[256];
                            format(str, sizeof(str), "Ферма продается.\nДля покупки введите /buyferma\nСтоимость %d", FermaInfo[1][Sum]);
                            Update3DTextLabelText(FermaLabel[1], COLOR_BLUE, str);
                        }
                        if (FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                            for (new ii; ii < MAX_PLAYERS; ii++) {
                                PlayerInfo[ii][FermaSF] = 0;
                            }
                            format(string, sizeof(string), "UPDATE `accounts` SET `FermaSF` = 0");
                            mysql_query(string);
                            new q[64];
                            new result[128];
                            new Hour, Minute, Second;
                            gettime(Hour, Minute, Second);
                            new Year, Month, Day;
                            getdate(Year, Month, Day);
                            format(result, sizeof(result), "INSERT INTO `logs` (`Name`, `Do`, `time`) VALUE ('%s', 'buy ferma %d', '%d:%d:%d %d/%d/%d')", PlayerInfo[playerid][ID], FermaInfo[2][ID], Hour, Minute, Second, Day, Month, Year);
                            mysql_query(result);
                            mysql_free_result();
                            format(q, sizeof(q), "Ферма была продана государству, Вы получили %d$.", FermaInfo[2][Sum]);
                            SendClientMessage(playerid, COLOR_GREEN, q);
                            GiveMoney(playerid, FermaInfo[2][Sum]);
                            FermaInfo[2][Bank] = 0;
                            FermaInfo[2][Boss] = 0;
                            FermaInfo[2][Status] = 2;
                            FermaInfo[2][Fermer1] = 0;
                            FermaInfo[2][Fermer2] = 0;
                            FermaInfo[2][Fermer3] = 0;
                            FermaInfo[2][Fermer4] = 0;
                            FermaInfo[2][Fermer5] = 0;
                            FermaInfo[2][Price] = 6;
                            FermaInfo[2][Ur] = 0;
                            FermaInfo[2][UrP] = 0;
                            FermaInfo[2][Ammount] = 0;
                            FermaInfo[2][Zerno] = 0;
                            SaveAccount(playerid);
                            FermaSave();
                            new str[256];
                            format(str, sizeof(str), "Ферма продается.\nДля покупки введите /buyferma\nСтоимость %d", FermaInfo[2][Sum]);
                            Update3DTextLabelText(FermaLabel[2], COLOR_BLUE, str);
                        }
                    }
                }
            }
            case DIALOG_FERMALSZERNO:  {
                if (PlayerInfo[playerid][ID] == FermaInfo[1][Boss] || PlayerInfo[playerid][FermaLS] == 1) {
                    if (response) {
                        if (strlen(inputtext) && strlen(inputtext) > 0 && strlen(inputtext) < 6) {
                            new l = strval(inputtext);
                            new z = (FermaInfo[1][Ammount] + l);
                            if (z <= 10000) {
                                new s = (l * FERMAZERNO);
                                if (FermaInfo[1][Bank] >= s) {
                                    FermaInfo[1][Bank] -= s;
                                    FermaInfo[1][Ammount] += l;
                                    SendClientMessage(playerid, COLOR_GREEN, "Зерно закуплено и доставлено на склад фермы.");
                                } else {
                                    SendClientMessage(playerid, COLOR_WHITE, "На счету фермы не достаточно средств для закупки зерна.");
                                }
                            } else {
                                SendClientMessage(playerid, COLOR_WHITE, "На складе фермы не достаточно места для закупки такого количества зерна.");
                            }
                        }
                    }
                }
                if (PlayerInfo[playerid][ID] == FermaInfo[2][Boss] || PlayerInfo[playerid][FermaSF] == 1) {
                    if (response) {
                        if (strlen(inputtext) && strlen(inputtext) > 0 && strlen(inputtext) < 6) {
                            new l = strval(inputtext);
                            new z = (FermaInfo[2][Ammount] + l);
                            if (z <= 10000) {
                                new s = (l * FERMAZERNO);
                                if (FermaInfo[2][Bank] >= s) {
                                    FermaInfo[2][Bank] -= s;
                                    FermaInfo[2][Ammount] += l;
                                    SendClientMessage(playerid, COLOR_GREEN, "Зерно закуплено и доставлено на склад фермы.");
                                } else {
                                    SendClientMessage(playerid, COLOR_WHITE, "На счету фермы не достаточно средств для закупки зерна.");
                                }
                            } else {
                                SendClientMessage(playerid, COLOR_WHITE, "На складе фермы не достаточно места для закупки такого количества зерна.");
                            }
                        }
                    }
                }
            }
            case DIALOG_FERMALSMENU:  {
                if (response) {
                    if (listitem == 0) {
                        if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {
                            new string[256];
                            format(string, sizeof(string), "Текущая цена за куст %d.\nФермер получает за каждый загруженный куст в машину при разгрузке урожая на склад в два раза больше цены за куст.\nНапример: В машине 1000 урожая : 5(один куст) = 200 (кустов в полной машине)\nВведите новую цену.", FermaInfo[1][Price]);
                            ShowPlayerDialog(playerid, DIALOG_FERMALSURP, DIALOG_STYLE_INPUT, "Цена за куст", string, "ОК", "Отмена");
                        } else if (FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                            new string[256];
                            format(string, sizeof(string), "Текущая цена за куст %d.\nФермер получает за каждый загруженный куст в машину при разгрузке урожая на склад в два раза больше цены за куст.\nНапример: В машине 1000 урожая : 5(один куст) = 200 (кустов в полной машине)\nВведите новую цену.", FermaInfo[2][Price]);
                            ShowPlayerDialog(playerid, DIALOG_FERMALSURP, DIALOG_STYLE_INPUT, "Цена за куст", string, "ОК", "Отмена");
                        } else {
                            SendClientMessage(playerid, COLOR_GREEN, "У Вас нет доступа к данной функции.");
                        }
                    }
                    if (listitem == 1) {
                        if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID] || FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                            OnPlayerCommandText(playerid, "/finvite");
                        } else {
                            SendClientMessage(playerid, COLOR_GREEN, "У Вас нет доступа к данной функции.");
                        }
                    }
                    if (listitem == 2) {
                        if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID] || FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                            OnPlayerCommandText(playerid, "/funinvite");
                        } else {
                            SendClientMessage(playerid, COLOR_GREEN, "У Вас нет доступа к данной функции.");
                        }
                    }
                    if (listitem == 3) {
                        new string[256], in ;
                        if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID] || PlayerInfo[playerid][FermaLS] == 1) {
                            in = FERMAUR * FermaInfo[1][Ur];
                            if (FermaInfo[1][Ur] != 0) {
                                format(string, sizeof(string), "Вы хотите продать урожай с фермы государству?\nТекущая цена урожая на рынке: %d$, за кг. урожая.\nНа складе: %d кг. урожая\nФерма получит %d$ за %d кг. урожая", FERMAUR, FermaInfo[1][Ur], in , FermaInfo[1][Ur]);
                                ShowPlayerDialog(playerid, DIALOG_FERMALSMENUP, DIALOG_STYLE_MSGBOX, "Продажа урожая", string, "ОК", "Отмена");
                            } else {
                                SendClientMessage(playerid, COLOR_GREEN, "На складе нет урожая.");
                            }
                        }
                        if (FermaInfo[2][Boss] == PlayerInfo[playerid][ID] || PlayerInfo[playerid][FermaSF] == 1) {
                            in = FERMAUR * FermaInfo[2][Ur];
                            if (FermaInfo[2][Ur] != 0) {
                                format(string, sizeof(string), "Вы хотите продать урожай с фермы государству?\nТекущая цена урожая на рынке: %d$, за кг. урожая.\nНа складе: %d кг. урожая\nФерма получит %d$ за %d кг. урожая", FERMAUR, FermaInfo[2][Ur], in , FermaInfo[2][Ur]);
                                ShowPlayerDialog(playerid, DIALOG_FERMALSMENUP, DIALOG_STYLE_MSGBOX, "Продажа урожая", string, "ОК", "Отмена");
                            } else {
                                SendClientMessage(playerid, COLOR_GREEN, "На складе нет урожая.");
                            }
                        }
                    }
                    if (listitem == 4) {
                        if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID] || PlayerInfo[playerid][FermaLS] == 1) {
                            if (FermaInfo[1][Bank] != 0) {
                                new string[256];
                                format(string, sizeof(string), "Вы хотите закупить зерно на ферму?\nТогда введите количество закупаемого зерна.\nТекущая цена зерна на рынке: %d$, за кг.", FERMAZERNO);
                                ShowPlayerDialog(playerid, DIALOG_FERMALSZERNO, DIALOG_STYLE_INPUT, "Покупка зерна", string, "ОК", "Отмена");
                            } else {
                                SendClientMessage(playerid, COLOR_GREEN, "В банке фермы нет средств.");
                            }
                        }
                        if (FermaInfo[2][Boss] == PlayerInfo[playerid][ID] || PlayerInfo[playerid][FermaSF] == 1) {
                            if (FermaInfo[2][Bank] != 0) {
                                new string[256];
                                format(string, sizeof(string), "Вы хотите закупить зерно на ферму?\nТогда введите количество закупаемого зерна.\nТекущая цена зерна на рынке: %d$, за кг.", FERMAZERNO);
                                ShowPlayerDialog(playerid, DIALOG_FERMALSZERNO, DIALOG_STYLE_INPUT, "Покупка зерна", string, "ОК", "Отмена");
                            } else {
                                SendClientMessage(playerid, COLOR_GREEN, "В банке фермы нет средств.");
                            }
                        }
                    }
                    if (listitem == 5) {
                        if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID] || FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                            ShowPlayerDialog(playerid, DIALOG_FERMALSPROD, DIALOG_STYLE_MSGBOX, "Продажа фермы", "Вы действительно хотите продать ферму?", "Да", "Отмена");
                        } else {
                            SendClientMessage(playerid, COLOR_GREEN, "У Вас нет доступа к данной функции.");
                        }
                    }
                    if (listitem == 6) {
                        if (FermaInfo[1][Boss] == PlayerInfo[playerid][ID]) {
                            if (FermaInfo[1][Status] == 1) {
                                FermaInfo[1][Status] = 0;
                                SendClientMessage(playerid, COLOR_GREEN, "Ферма закрыта.");
                            } else {
                                FermaInfo[1][Status] = 1;
                                SendClientMessage(playerid, COLOR_GREEN, "Ферма открыта.");
                            }
                        } else if (FermaInfo[2][Boss] == PlayerInfo[playerid][ID]) {
                            if (FermaInfo[2][Status] == 1) {
                                FermaInfo[2][Status] = 0;
                                SendClientMessage(playerid, COLOR_GREEN, "Ферма закрыта.");
                            } else {
                                FermaInfo[2][Status] = 1;
                                SendClientMessage(playerid, COLOR_GREEN, "Ферма открыта.");
                            }
                        } else {
                            SendClientMessage(playerid, COLOR_GREEN, "У Вас нет доступа к данной функции.");
                        }
                    }
                }
            }
            case DIALOG_REGISTERR:  {
                if (!response) {
                    SendClientMessage(playerid, COLOR_YELLOW, "* Введите /q(uit), чтобы выйти из игры.");
                    lKick(playerid);
                    return 1;
                }
                for (new i = strlen(inputtext); i != 0; --i)

                    switch (inputtext[i]) {
                        case 'А'..
                        'Я', 'а'..
                        'я', ' ':
                            return ShowPlayerDialog(playerid, DIALOG_REGISTERR, DIALOG_STYLE_INPUT, "Регистрация", "Пожалуйста, укажите Ваш E-mail адрес.\n(Он будет необходим для восстановления аккаунта и важных операций)", "Далее", "Отмена");
                    }


                if (!strlen(inputtext) || strlen(inputtext) < 5 || strlen(inputtext) > 32) {


                    ShowPlayerDialog(playerid, DIALOG_REGISTERR, DIALOG_STYLE_INPUT, "Регистрация", "Пожалуйста, укажите Ваш E-mail адрес.\n(Он будет необходим для восстановления аккаунта и важных операций)", "Далее", "Отмена");
                    return 1;
                } else {
                    format(PlayerInfo[playerid][Emailaccount], 64, "%s", inputtext);
                    printf("inputtext = %s; EmainAccount = %s", inputtext, PlayerInfo[playerid][Emailaccount]);
                    CreateAccount(playerid, PlayerInfo[playerid][Passwordaccount]);


                }

            }
            case DIALOG_SPAWN:  {
                if (response) {
                    NewSpawn[playerid] = 2;
                    SpawnMZ[playerid] = 1;
                    SpawnPlayer(playerid);
                    OnPlayerSpawn(playerid);
                } else {
                    NewSpawn[playerid] = 1;
                    SpawnMZ[playerid] = 1;
                    SpawnPlayer(playerid);
                    OnPlayerSpawn(playerid);
                    return 1;
                }

            }
            case DIALOG_MESHKI:  // касса
            {
                new string[128];
                if (response) {
                    if (!PlayerInJob[playerid]) {
                        SendClientMessage(playerid, COLOR_RED, "Вы не на работе");
                        SendClientMessage(playerid, COLOR_RED, "Переоденьтесь в раздевалке чтобы начать работу");
                        return 1;
                    }
                    PlayerInJob[playerid] = 0;
                    SetPlayerSkin(playerid, Oldskin2[playerid]);
                    DisablePlayerCheckpoint(playerid);
                    GiveMoney(playerid, Meshki[playerid] * 5);
                    format(string, sizeof(string), "{FFFAFA}Вы получили {228B22}%d$ {FFFAFA}за {A52A2A}%d {FFFAFA}мешка(ов)", Meshki[playerid] * 5, Meshki[playerid]);
                    SendClientMessage(playerid, COLOR_SYSTEM, string);
                    Meshki[playerid] = 0;
                }
                return 1;
            }

            case DIALOG_MESHKII:  //раздевалка
            {
                if (response) {
                    if (PlayerInJob[playerid]) {
                        SendClientMessage(playerid, COLOR_RED, "Вы уже на работе");
                        SendClientMessage(playerid, COLOR_RED, "Если хотите закончить рабочий день, идите в кассу");
                        return 1;
                    }
                    PlayerInJob[playerid] = 1;
                    Oldskin2[playerid] = GetPlayerSkin(playerid);
                    SetPlayerSkin(playerid, 16);
                    SetPlayerCheckpoint(playerid, 2230.8132324219, -2285.7043457031, 13.531787872314, 2.0);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "На вашей карте отмечен чекпоинт");
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Идите к нему чтобы взять мешок");
                }
                return 1;
            }

        }
    }
    return 1;
}
public CheckEngine(carid) { new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(carid, engine, lights, alarm, doors, bonnet, boot, objective); if (engine) { return 1; } else { return 0; } }


public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ) {

    acstruct[playerid][checkmaptp] = 1;
    acstruct[playerid][maptplastclick] = GetTickCount();
    acstruct[playerid][maptp][0] = fX;
    acstruct[playerid][maptp][1] = fY;
    acstruct[playerid][maptp][2] = fZ;
    if (PlayerInfo[playerid][Admin] >= 1) {
        if (!IsPlayerInAnyVehicle(playerid)) {
            SetPlayerPos(playerid, fX, fY, fZ);
            SetPlayerPosFindZ(playerid, fX, fY, 999.0);
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
        }
    }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source) {
    return 1;
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {
    if (!(-5000 < fX < 5000) || !(-5000 < fY < 5000) || !(-5000 < fZ < 5000)) { Kick(playerid); return 0; } //Bullet Crasher

    return 1;
}
forward UnLogin(playerid);
public UnLogin(playerid) {
    if (PlayerInfo[playerid][Logged] == false) {
        SendClientMessage(playerid, COLOR_RED, "Время на вход в аккаунт ограничено - 60 секунд. За превышение лимита Вы были отключены от сервера.");
        lKick(playerid);
    }
}
public ctd(playerid) {
    new vehicleid = GetPlayerVehicleID(playerid);
    new Float:vehx, Float:vehy, Float:vehz, Float:A;
    GetVehiclePos(vehicleid, vehx, vehy, vehz);
    //GetPlayerFacingAngle(playerid, A);
    GetVehicleZAngle(vehicleid, A);
    vehx += (2.5 * floatsin(-A + 180, degrees));
    vehy += (2.5 * floatcos(-A + 180, degrees));
    new strg[64];
    if (fermalsstatus[playerid] == 1) {

        format(strg, sizeof(strg), "Загружено\n%d/1000", FermaLSSum[vehicleid]);

        FermaLS3DTEXTR[vehicleid] = Create3DTextLabel(strg, COLOR_YELLOW, vehx, vehy, vehz + 1.5, 60.0, 0, 1);
        FermaLSDynamicPR[vehicleid] = CreatePickup(19197, 23, vehx, vehy, vehz + 1, 0);
    }
    if (fermasfstatus[playerid] == 1) {

        format(strg, sizeof(strg), "Загружено\n%d/1000", FermaSFSum[vehicleid]);

        FermaSF3DTEXTR[vehicleid] = Create3DTextLabel(strg, COLOR_YELLOW, vehx, vehy, vehz + 1.5, 60.0, 0, 1);
        FermaSFDynamicPR[vehicleid] = CreatePickup(19197, 23, vehx, vehy, vehz + 1, 0);
    }
    SetVehicleVelocity(GetPlayerVehicleID(playerid), 0.0, 0.0, 0.0);
    new alarm, doors, bonnet, boot, objective;
    SetVehicleParamsEx(vehicleid, false, false, alarm, doors, bonnet, boot, objective);
    RemovePlayerFromVehicle(playerid);
    return 1;
}
forward lKickD(playerid);
public lKickD(playerid) {
    //SaveAccount(playerid);
    //Statuss(playerid);
    Kick(playerid);
    return 1;
}
forward incarr(playerid);
public incarr(playerid) {
    incar[playerid] = 0;
    slapd[playerid] = 0;
    return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid) {

    if (Inter[playerid] == 1) {
        new il, kla[20];
        new j = PlayerInfo[playerid][House];
        new x = DIALOG_HOUSEINFO + HouseInfo[j][ID];
        if (HouseInfo[j][Price] <= 80000) {
            format(kla, sizeof(kla), "Эконом");
            il = 1;
        }
        if (HouseInfo[j][Price] > 80000 && HouseInfo[j][Price] <= 200000) {
            format(kla, sizeof(kla), "Средний");
            il = 2;
        }
        if (HouseInfo[j][Price] >= 300000) {
            format(kla, sizeof(kla), "Бизнес");
            il = 3;
        }
        if (clickedid == ButtonRight) {
            if (il == 1) {
                switch (SelectCharRegID[playerid]) {

                    case 1: {
                        SelectCharRegID[playerid] = 2;
                        InterN[playerid] = 2;
                        SetPlayerInterior(playerid, 10);
                        SetPos(playerid, 2259.38, -1135.77, 1050.64);
                        SetPlayerCameraPos(playerid, 2259.38, -1135.77, 1050.64);
                        SetPlayerCameraLookAt(playerid, 2265.38, -1135.77, 1050.64);
                        SetPlayerFacingAngle(playerid, 270);
                        new opsdgpq[64];
                        CenInt[playerid] = 60000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 2: {
                        SelectCharRegID[playerid] = 3;
                        InterN[playerid] = 3;
                        SetPlayerInterior(playerid, 2);
                        SetPos(playerid, 266.50, 304.90, 999.15);
                        SetPlayerFacingAngle(playerid, 270);
                        SetPlayerCameraPos(playerid, 266.50, 304.90, 999.15);
                        SetPlayerCameraLookAt(playerid, 270.50, 304.90, 999.15);
                        new opsdgpq[64];
                        CenInt[playerid] = 70000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 3: {
                        SelectCharRegID[playerid] = 4;
                        InterN[playerid] = 4;
                        SetPlayerInterior(playerid, 6);
                        SetPos(playerid, 2308.77, -1212.94, 1049.02);
                        SetPlayerFacingAngle(playerid, 0);
                        SetPlayerCameraPos(playerid, 2308.77, -1212.94, 1049.02);
                        SetPlayerCameraLookAt(playerid, 270.50, 310.90, 999.15);
                        new opsdgpq[64];
                        CenInt[playerid] = 80000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    /* case 4:
                    {
                    SelectCharRegID[playerid] = 5;
                    SetPlayerInterior(playerid, 12);
                    InterN[playerid] = 5;
					SetPos(playerid, 446.90, 506.35, 1001.42);
					SetPlayerFacingAngle(playerid, 0);
					SetPlayerCameraPos(playerid, 446.90, 506.35, 1001.42);
					SetPlayerCameraLookAt(playerid, 446.90, 510.35, 1001.42);
					new opsdgpq[64];
					CenInt[playerid] = 80000;
					format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
					GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }*/
                    case 4: {
                        SelectCharRegID[playerid] = 0;
                        SetPlayerInterior(playerid, 8);
                        InterN[playerid] = 6;
                        SetPos(playerid, -42.59, 1405.47, 1084.43);
                        SetPlayerFacingAngle(playerid, 0);
                        SetPlayerCameraPos(playerid, -42.59, 1405.47, 1084.43);
                        SetPlayerCameraLookAt(playerid, -42.59, 1410.47, 1084.43);
                        new opsdgpq[64];
                        CenInt[playerid] = 75000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 0: {
                        SetPlayerInterior(playerid, 1);
                        InterN[playerid] = 1;
                        SetPos(playerid, 243.72, 304.91, 999.15);
                        SetPlayerCameraPos(playerid, 246.11, 306.57, 999.15);
                        SetPlayerCameraLookAt(playerid, 246.35, 302.19, 999.15);
                        SetPlayerFacingAngle(playerid, 270);
                        SelectCharRegID[playerid] = 1;
                        new opsdgpq[64];
                        CenInt[playerid] = 40000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                }
            }
            if (il == 2) {
                switch (SelectCharRegID[playerid]) {
                    case 0: {
                        SetPlayerInterior(playerid, 1);
                        SetPos(playerid, 2218.61, -1075.95, 1050.48);
                        SetPlayerCameraPos(playerid, 2218.40, -1076.18, 1050.48);
                        SetPlayerCameraLookAt(playerid, 2209.52, -1076.31, 1050.48);
                        SelectCharRegID[playerid] = 1;
                        SetPlayerFacingAngle(playerid, 90.0);
                        InterN[playerid] = 7;
                        new opsdgpq[64];
                        CenInt[playerid] = 85000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 1: {
                        SelectCharRegID[playerid] = 2;
                        InterN[playerid] = 8;
                        SetPlayerInterior(playerid, 5);
                        SetPos(playerid, 2233.64, -1115.26, 1050.88);
                        SetPlayerCameraPos(playerid, 2233.64, -1115.26, 1050.88);
                        SetPlayerCameraLookAt(playerid, 2233.64, -1105.26, 1050.88);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 90000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 2: {
                        SelectCharRegID[playerid] = 3;
                        InterN[playerid] = 9;
                        SetPlayerInterior(playerid, 11);
                        SetPos(playerid, 2283.04, -1140.28, 1050.90);
                        SetPlayerCameraPos(playerid, 2283.04, -1140.28, 1050.90);
                        SetPlayerCameraLookAt(playerid, 2283.04, -1136.28, 1050.90);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 90000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 3: {
                        SelectCharRegID[playerid] = 4;
                        InterN[playerid] = 10;
                        SetPlayerInterior(playerid, 15);
                        SetPos(playerid, 295.04, 1472.26, 1080.26);
                        SetPlayerCameraPos(playerid, 295.04, 1472.26, 1080.26);
                        SetPlayerCameraLookAt(playerid, 295.04, 1475.26, 1080.26);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 100000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 4: {
                        SelectCharRegID[playerid] = 5;
                        InterN[playerid] = 11;
                        SetPlayerInterior(playerid, 2);
                        SetPos(playerid, 2237.59, -1081.64, 1049.02);
                        SetPlayerCameraPos(playerid, 2237.59, -1081.64, 1049.02);
                        SetPlayerCameraLookAt(playerid, 2237.59, -1076.64, 1049.02);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 110000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 5: {
                        SelectCharRegID[playerid] = 6;
                        InterN[playerid] = 12;
                        SetPlayerInterior(playerid, 8);
                        SetPos(playerid, 2365.31, -1135.60, 1050.88);
                        SetPlayerCameraPos(playerid, 2365.31, -1135.60, 1050.88);
                        SetPlayerCameraLookAt(playerid, 2365.31, -1130.60, 1050.88);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 120000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 6: {
                        SelectCharRegID[playerid] = 7;
                        InterN[playerid] = 13;
                        SetPlayerInterior(playerid, 2);
                        SetPos(playerid, 446.99, 1397.07, 1084.30);
                        SetPlayerCameraPos(playerid, 446.99, 1397.07, 1084.30);
                        SetPlayerCameraLookAt(playerid, 446.99, 1400.07, 1084.30);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 130000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 7: {
                        SelectCharRegID[playerid] = 8;
                        InterN[playerid] = 14;
                        SetPlayerInterior(playerid, 10);
                        SetPos(playerid, 2270.38, -1210.35, 1047.56);
                        SetPlayerCameraPos(playerid, 2270.38, -1210.35, 1047.56);
                        SetPlayerCameraLookAt(playerid, 2268.38, -1210.35, 1047.56);
                        SetPlayerFacingAngle(playerid, 90);
                        new opsdgpq[64];
                        CenInt[playerid] = 140000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 8: {
                        SelectCharRegID[playerid] = 9;
                        InterN[playerid] = 15;
                        SetPlayerInterior(playerid, 6);
                        SetPos(playerid, 2196.85, -1204.25, 1049.02);
                        SetPlayerCameraPos(playerid, 2195.85, -1204.25, 1049.02);
                        SetPlayerCameraLookAt(playerid, 2188.85, -1204.25, 1049.02);
                        SetPlayerFacingAngle(playerid, 90);
                        new opsdgpq[64];
                        CenInt[playerid] = 150000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 9: {
                        SelectCharRegID[playerid] = 0;
                        InterN[playerid] = 16;
                        SetPlayerInterior(playerid, 9);
                        SetPos(playerid, 2317.89, -1026.76, 1050.22);
                        SetPlayerCameraPos(playerid, 2317.89, -1026.76, 1050.22);
                        SetPlayerCameraLookAt(playerid, 2317.89, -1020.76, 1050.22);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 160000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                }
            }
            if (il == 3) {
                switch (SelectCharRegID[playerid]) {
                    case 0: {
                        SetPlayerInterior(playerid, 5);
                        SetPos(playerid, 140.17, 1366.07, 1083.65);
                        SetPlayerCameraPos(playerid, 140.17, 1366.07, 1083.65);
                        SetPlayerCameraLookAt(playerid, 140.17, 1370.07, 1083.65);
                        SelectCharRegID[playerid] = 1;
                        SetPlayerFacingAngle(playerid, 0);
                        InterN[playerid] = 17;
                        new opsdgpq[64];
                        CenInt[playerid] = 300000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 1: {
                        SetPlayerInterior(playerid, 12);
                        InterN[playerid] = 18;
                        SetPos(playerid, 2324.53, -1149.54, 1050.71);
                        SetPlayerCameraPos(playerid, 2324.53, -1149.54, 1050.71);
                        SetPlayerCameraLookAt(playerid, 2324.53, -1143.54, 1050.71);
                        SetPlayerFacingAngle(playerid, 0);
                        SelectCharRegID[playerid] = 2;
                        new opsdgpq[64];
                        CenInt[playerid] = 400000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 2: {
                        SetPlayerInterior(playerid, 7);
                        InterN[playerid] = 19;
                        SetPos(playerid, 224.71, 1032.53, 1084.02);
                        SetPlayerCameraPos(playerid, 224.71, 1032.53, 1084.02);
                        SetPlayerCameraLookAt(playerid, 230.68, 1025.45, 1084.02);
                        SetPlayerFacingAngle(playerid, 0);
                        SelectCharRegID[playerid] = 3;
                        new opsdgpq[64];
                        CenInt[playerid] = 450000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 3: {
                        SetPlayerInterior(playerid, 6);
                        InterN[playerid] = 20;
                        SetPos(playerid, 234.19, 1063.73, 1084.21);
                        SetPlayerCameraPos(playerid, 234.19, 1063.73, 1084.21);
                        SetPlayerCameraLookAt(playerid, 234.19, 1070.73, 1084.21);
                        SetPlayerFacingAngle(playerid, 0);
                        SelectCharRegID[playerid] = 0;
                        new opsdgpq[64];
                        CenInt[playerid] = 500000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                }

            }
        } else if (clickedid == ButtonLeft) {

            if (il == 1) {
                switch (SelectCharRegID[playerid]) {

                    case 1: {
                        SelectCharRegID[playerid] = 0;
                        InterN[playerid] = 2;
                        SetPlayerInterior(playerid, 10);
                        SetPos(playerid, 2259.38, -1135.77, 1050.64);
                        SetPlayerCameraPos(playerid, 2259.38, -1135.77, 1050.64);
                        SetPlayerCameraLookAt(playerid, 2265.38, -1135.77, 1050.64);
                        SetPlayerFacingAngle(playerid, 270);
                        new opsdgpq[64];
                        CenInt[playerid] = 60000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 2: {
                        SelectCharRegID[playerid] = 1;
                        InterN[playerid] = 3;
                        SetPlayerInterior(playerid, 2);
                        SetPos(playerid, 266.50, 304.90, 999.15);
                        SetPlayerFacingAngle(playerid, 270);
                        SetPlayerCameraPos(playerid, 266.50, 304.90, 999.15);
                        SetPlayerCameraLookAt(playerid, 270.50, 304.90, 999.15);
                        new opsdgpq[64];
                        CenInt[playerid] = 70000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 3: {
                        SelectCharRegID[playerid] = 2;
                        InterN[playerid] = 4;
                        SetPlayerInterior(playerid, 6);
                        SetPos(playerid, 2308.77, -1212.94, 1049.02);
                        SetPlayerFacingAngle(playerid, 0);
                        SetPlayerCameraPos(playerid, 2308.77, -1212.94, 1049.02);
                        SetPlayerCameraLookAt(playerid, 270.50, 310.90, 999.15);
                        new opsdgpq[64];
                        CenInt[playerid] = 80000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    /*case 4:
                    {
                    SelectCharRegID[playerid] = 3;
                    InterN[playerid] = 5;
                    SetPlayerInterior(playerid, 12);
					SetPos(playerid, 446.90, 506.35, 1001.42);
					SetPlayerFacingAngle(playerid, 0);
					SetPlayerCameraPos(playerid, 446.90, 506.35, 1001.42);
					SetPlayerCameraLookAt(playerid, 446.90, 510.35, 1001.42);
					new opsdgpq[64];
					CenInt[playerid] = 80000;
					format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
					GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }*/
                    case 5: {
                        SelectCharRegID[playerid] = 3;
                        InterN[playerid] = 6;
                        SetPlayerInterior(playerid, 8);
                        SetPos(playerid, -42.59, 1405.47, 1084.43);
                        SetPlayerFacingAngle(playerid, 0);
                        SetPlayerCameraPos(playerid, -42.59, 1405.47, 1084.43);
                        SetPlayerCameraLookAt(playerid, -42.59, 1410.47, 1084.43);
                        new opsdgpq[64];
                        CenInt[playerid] = 75000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 0: {
                        SetPlayerInterior(playerid, 1);
                        InterN[playerid] = 1;
                        SetPos(playerid, 243.72, 304.91, 999.15);
                        SetPlayerCameraPos(playerid, 246.11, 306.57, 999.15);
                        SetPlayerCameraLookAt(playerid, 246.35, 302.19, 999.15);
                        SetPlayerFacingAngle(playerid, 270);
                        SelectCharRegID[playerid] = 5;
                        new opsdgpq[64];
                        CenInt[playerid] = 40000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                }
            }
            if (il == 2) {
                switch (SelectCharRegID[playerid]) {
                    case 0: {
                        SetPlayerInterior(playerid, 1);
                        SetPos(playerid, 2218.61, -1075.95, 1050.48);
                        SetPlayerCameraPos(playerid, 2218.40, -1076.18, 1050.48);
                        SetPlayerCameraLookAt(playerid, 2209.52, -1076.31, 1050.48);
                        SelectCharRegID[playerid] = 9;
                        SetPlayerFacingAngle(playerid, 90.0);
                        InterN[playerid] = 7;
                        new opsdgpq[64];
                        CenInt[playerid] = 85000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 1: {
                        SelectCharRegID[playerid] = 0;
                        InterN[playerid] = 8;
                        SetPlayerInterior(playerid, 5);
                        SetPos(playerid, 2233.64, -1115.26, 1050.88);
                        SetPlayerCameraPos(playerid, 2233.64, -1115.26, 1050.88);
                        SetPlayerCameraLookAt(playerid, 2233.64, -1105.26, 1050.88);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 90000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 2: {
                        SelectCharRegID[playerid] = 1;
                        InterN[playerid] = 9;
                        SetPlayerInterior(playerid, 11);
                        SetPos(playerid, 2283.04, -1140.28, 1050.90);
                        SetPlayerCameraPos(playerid, 2283.04, -1140.28, 1050.90);
                        SetPlayerCameraLookAt(playerid, 2283.04, -1136.28, 1050.90);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 90000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 3: {
                        SelectCharRegID[playerid] = 2;
                        InterN[playerid] = 10;
                        SetPlayerInterior(playerid, 15);
                        SetPos(playerid, 295.04, 1472.26, 1080.26);
                        SetPlayerCameraPos(playerid, 295.04, 1472.26, 1080.26);
                        SetPlayerCameraLookAt(playerid, 295.04, 1475.26, 1080.26);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 100000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 4: {
                        SelectCharRegID[playerid] = 3;
                        InterN[playerid] = 11;
                        SetPlayerInterior(playerid, 2);
                        SetPos(playerid, 2237.59, -1081.64, 1049.02);
                        SetPlayerCameraPos(playerid, 2237.59, -1081.64, 1049.02);
                        SetPlayerCameraLookAt(playerid, 2237.59, -1076.64, 1049.02);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 110000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 5: {
                        SelectCharRegID[playerid] = 4;
                        InterN[playerid] = 12;
                        SetPlayerInterior(playerid, 8);
                        SetPos(playerid, 2365.31, -1135.60, 1050.88);
                        SetPlayerCameraPos(playerid, 2365.31, -1135.60, 1050.88);
                        SetPlayerCameraLookAt(playerid, 2365.31, -1130.60, 1050.88);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 120000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 6: {
                        SelectCharRegID[playerid] = 5;
                        InterN[playerid] = 13;
                        SetPlayerInterior(playerid, 2);
                        SetPos(playerid, 446.99, 1397.07, 1084.30);
                        SetPlayerCameraPos(playerid, 446.99, 1397.07, 1084.30);
                        SetPlayerCameraLookAt(playerid, 446.99, 1400.07, 1084.30);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 130000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 7: {
                        SelectCharRegID[playerid] = 6;
                        InterN[playerid] = 14;
                        SetPlayerInterior(playerid, 10);
                        SetPos(playerid, 2270.38, -1210.35, 1047.56);
                        SetPlayerCameraPos(playerid, 2270.38, -1210.35, 1047.56);
                        SetPlayerCameraLookAt(playerid, 2268.38, -1210.35, 1047.56);
                        SetPlayerFacingAngle(playerid, 90);
                        new opsdgpq[64];
                        CenInt[playerid] = 140000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 8: {
                        SelectCharRegID[playerid] = 7;
                        InterN[playerid] = 15;
                        SetPlayerInterior(playerid, 6);
                        SetPos(playerid, 2196.85, -1204.25, 1049.02);
                        SetPlayerCameraPos(playerid, 2195.85, -1204.25, 1049.02);
                        SetPlayerCameraLookAt(playerid, 2188.85, -1204.25, 1049.02);
                        SetPlayerFacingAngle(playerid, 90);
                        new opsdgpq[64];
                        CenInt[playerid] = 150000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 9: {
                        SelectCharRegID[playerid] = 8;
                        InterN[playerid] = 16;
                        SetPlayerInterior(playerid, 9);
                        SetPos(playerid, 2317.89, -1026.76, 1050.22);
                        SetPlayerCameraPos(playerid, 2317.89, -1026.76, 1050.22);
                        SetPlayerCameraLookAt(playerid, 2317.89, -1020.76, 1050.22);
                        SetPlayerFacingAngle(playerid, 0);
                        new opsdgpq[64];
                        CenInt[playerid] = 160000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                }
            }
            if (il == 3) {
                switch (SelectCharRegID[playerid]) {
                    case 0: {
                        SetPlayerInterior(playerid, 5);
                        SetPos(playerid, 140.17, 1366.07, 1083.65);
                        SetPlayerCameraPos(playerid, 140.17, 1366.07, 1083.65);
                        SetPlayerCameraLookAt(playerid, 140.17, 1370.07, 1083.65);
                        SelectCharRegID[playerid] = 1;
                        SetPlayerFacingAngle(playerid, 0);
                        InterN[playerid] = 17;
                        new opsdgpq[64];
                        CenInt[playerid] = 300000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 1: {
                        SetPlayerInterior(playerid, 12);
                        InterN[playerid] = 18;
                        SetPos(playerid, 2324.53, -1149.54, 1050.71);
                        SetPlayerCameraPos(playerid, 2324.53, -1149.54, 1050.71);
                        SetPlayerCameraLookAt(playerid, 2324.53, -1143.54, 1050.71);
                        SetPlayerFacingAngle(playerid, 0);
                        SelectCharRegID[playerid] = 3;
                        new opsdgpq[64];
                        CenInt[playerid] = 400000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 2: {
                        SetPlayerInterior(playerid, 7);
                        InterN[playerid] = 19;
                        SetPos(playerid, 224.71, 1032.53, 1084.02);
                        SetPlayerCameraPos(playerid, 224.71, 1032.53, 1084.02);
                        SetPlayerCameraLookAt(playerid, 230.68, 1025.45, 1084.02);
                        SetPlayerFacingAngle(playerid, 0);
                        SelectCharRegID[playerid] = 0;
                        new opsdgpq[64];
                        CenInt[playerid] = 450000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                    case 3: {
                        SetPlayerInterior(playerid, 6);
                        InterN[playerid] = 20;
                        SetPos(playerid, 234.19, 1063.73, 1084.21);
                        SetPlayerCameraPos(playerid, 234.19, 1063.73, 1084.21);
                        SetPlayerCameraLookAt(playerid, 234.19, 1070.73, 1084.21);
                        SetPlayerFacingAngle(playerid, 0);
                        SelectCharRegID[playerid] = 2;
                        new opsdgpq[64];
                        CenInt[playerid] = 500000;
                        format(opsdgpq, sizeof(opsdgpq), "~y~%d$", CenInt[playerid]);
                        GameTextForPlayer(playerid, opsdgpq, 1000, 0);
                    }
                }

            }

        } else if (clickedid == ButtonSelect) {
            if (il == 1) {
                if (Inter[playerid] == 1) {


                    if (InterN[playerid] == 1) {
                        HouseInfo[j][Int] = 1;
                        HouseInfo[j][SHX] = 243.72;
                        HouseInfo[j][SHY] = 304.91;
                        HouseInfo[j][SHZ] = 999.15;
                        HouseInfo[j][Angle] = 270.0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 2) {
                        HouseInfo[j][Int] = 10;
                        HouseInfo[j][SHX] = 2259.38;
                        HouseInfo[j][SHY] = -1135.77;
                        HouseInfo[j][SHZ] = 1050.64;
                        HouseInfo[j][Angle] = 270.0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 3) {
                        HouseInfo[j][Int] = 2;
                        HouseInfo[j][SHX] = 266.50;
                        HouseInfo[j][SHY] = 304.90;
                        HouseInfo[j][SHZ] = 999.15;
                        HouseInfo[j][Angle] = 270.0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 4) {
                        HouseInfo[j][Int] = 6;
                        HouseInfo[j][SHX] = 2308.77;
                        HouseInfo[j][SHY] = -1212.94;
                        HouseInfo[j][SHZ] = 1049.02;
                        HouseInfo[j][Angle] = 0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    /*	if(InterN[playerid] == 5)
			{
			HouseInfo[j][Int] = 12;
			HouseInfo[j][SHX] = 446.90;
			HouseInfo[j][SHY] = 506.35;
			HouseInfo[j][SHZ] = 1001.42;
            HouseInfo[j][Angle] = 0;
            GiveMoney(playerid, -CenInt[playerid]);
            HouseSaveO(j);
            SaveAccount(playerid);
            SetPlayerVirtualWorld(playerid, x);
			SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
			SetPlayerInterior(playerid, HouseInfo[j][Int]);
			SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
			SetCameraBehindPlayer(playerid);
			SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
			TogglePlayerControllable(playerid, 0);
			}*/
                    if (InterN[playerid] == 6) {
                        HouseInfo[j][Int] = 8;
                        HouseInfo[j][SHX] = -42.59;
                        HouseInfo[j][SHY] = 1405.47;
                        HouseInfo[j][SHZ] = 1084.43;
                        HouseInfo[j][Angle] = 0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    TextDrawHideForPlayer(playerid, ButtonLeft);
                    TextDrawHideForPlayer(playerid, ButtonRight);
                    TextDrawHideForPlayer(playerid, ButtonSelect);
                    CancelSelectTextDraw(playerid);
                }

            }
            if (il == 2) {
                if (Inter[playerid] == 1) {
                    if (InterN[playerid] == 7) {
                        HouseInfo[j][Int] = 1;
                        HouseInfo[j][SHX] = 2218.40;
                        HouseInfo[j][SHY] = -1076.18;
                        HouseInfo[j][SHZ] = 1050.48;
                        HouseInfo[j][Angle] = 90;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 8) {
                        HouseInfo[j][Int] = 5;
                        HouseInfo[j][SHX] = 2233.64;
                        HouseInfo[j][SHY] = -1115.26;
                        HouseInfo[j][SHZ] = 1050.88;
                        HouseInfo[j][Angle] = 0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 9) {
                        HouseInfo[j][Int] = 11;
                        HouseInfo[j][SHX] = 2283.04;
                        HouseInfo[j][SHY] = -1140.28;
                        HouseInfo[j][SHZ] = 1050.90;
                        HouseInfo[j][Angle] = 0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 10) {
                        HouseInfo[j][Int] = 15;
                        HouseInfo[j][SHX] = 295.04;
                        HouseInfo[j][SHY] = 1472.26;
                        HouseInfo[j][SHZ] = 1080.26;
                        HouseInfo[j][Angle] = 0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 11) {
                        HouseInfo[j][Int] = 2;
                        HouseInfo[j][SHX] = 2237.59;
                        HouseInfo[j][SHY] = -1081.64;
                        HouseInfo[j][SHZ] = 1049.02;
                        HouseInfo[j][Angle] = 0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 12) {
                        HouseInfo[j][Int] = 8;
                        HouseInfo[j][SHX] = 2365.31;
                        HouseInfo[j][SHY] = -1135.60;
                        HouseInfo[j][SHZ] = 1050.88;
                        HouseInfo[j][Angle] = 0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 13) {
                        HouseInfo[j][Int] = 2;
                        HouseInfo[j][SHX] = 446.99;
                        HouseInfo[j][SHY] = 1397.07;
                        HouseInfo[j][SHZ] = 1084.30;
                        HouseInfo[j][Angle] = 0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 14) {
                        HouseInfo[j][Int] = 10;
                        HouseInfo[j][SHX] = 2270.38;
                        HouseInfo[j][SHY] = -1210.35;
                        HouseInfo[j][SHZ] = 1047.56;
                        HouseInfo[j][Angle] = 90;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 15) {
                        HouseInfo[j][Int] = 6;
                        HouseInfo[j][SHX] = 2196.85;
                        HouseInfo[j][SHY] = -1204.25;
                        HouseInfo[j][SHZ] = 1049.02;
                        HouseInfo[j][Angle] = 90;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 16) {
                        HouseInfo[j][Int] = 9;
                        HouseInfo[j][SHX] = 2317.89;
                        HouseInfo[j][SHY] = -1026.76;
                        HouseInfo[j][SHZ] = 1050.22;
                        HouseInfo[j][Angle] = 0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    TextDrawHideForPlayer(playerid, ButtonLeft);
                    TextDrawHideForPlayer(playerid, ButtonRight);
                    TextDrawHideForPlayer(playerid, ButtonSelect);
                    CancelSelectTextDraw(playerid);
                }

            }
            if (il == 3) {
                if (Inter[playerid] == 1) {


                    if (InterN[playerid] == 17) {
                        HouseInfo[j][Int] = 5;
                        HouseInfo[j][SHX] = 140.17;
                        HouseInfo[j][SHY] = 1366.07;
                        HouseInfo[j][SHZ] = 1083.65;
                        HouseInfo[j][Angle] = 0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 18) {
                        HouseInfo[j][Int] = 12;
                        HouseInfo[j][SHX] = 2324.53;
                        HouseInfo[j][SHY] = -1149.54;
                        HouseInfo[j][SHZ] = 1050.71;
                        HouseInfo[j][Angle] = 0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 19) {
                        HouseInfo[j][Int] = 7;
                        HouseInfo[j][SHX] = 225.68;
                        HouseInfo[j][SHY] = 1021.45;
                        HouseInfo[j][SHZ] = 1084.02;
                        HouseInfo[j][Angle] = 0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    if (InterN[playerid] == 20) {
                        HouseInfo[j][Int] = 6;
                        HouseInfo[j][SHX] = 234.19;
                        HouseInfo[j][SHY] = 1063.73;
                        HouseInfo[j][SHZ] = 1084.21;
                        HouseInfo[j][Angle] = 0;
                        GiveMoney(playerid, -CenInt[playerid]);
                        HouseSaveO(j);
                        SaveAccount(playerid);
                        SetPlayerVirtualWorld(playerid, x);
                        SetPos(playerid, HouseInfo[j][SHX], HouseInfo[j][SHY], HouseInfo[j][SHZ]);
                        SetPlayerInterior(playerid, HouseInfo[j][Int]);
                        SetPlayerFacingAngle(playerid, HouseInfo[j][Angle]);
                        SetCameraBehindPlayer(playerid);
                        SendClientMessage(playerid, COLOR_GREEN, "Заказ отправлен и успешно выполнен строительной фирмой.");
                        TogglePlayerControllable(playerid, 1);
                        Inter[playerid] = 0;
                        InterN[playerid] = 0;
                    }
                    TextDrawHideForPlayer(playerid, ButtonLeft);
                    TextDrawHideForPlayer(playerid, ButtonRight);
                    TextDrawHideForPlayer(playerid, ButtonSelect);
                    CancelSelectTextDraw(playerid);
                }

            }
        }
        if (clickedid == Text:INVALID_TEXT_DRAW) {


        }

    }
    if (clickedid == PIN0) {
        PINN0[playerid] = 0;
        TextDrawShowForPlayer(playerid, PIN11);
        TextDrawShowForPlayer(playerid, PIN1);
        TextDrawShowForPlayer(playerid, PIN2);
        TextDrawShowForPlayer(playerid, PIN3);
        TextDrawShowForPlayer(playerid, PIN4);
        TextDrawShowForPlayer(playerid, PIN5);
        TextDrawShowForPlayer(playerid, PIN6);
        TextDrawShowForPlayer(playerid, PIN7);
        TextDrawShowForPlayer(playerid, PIN8);
        TextDrawShowForPlayer(playerid, PIN9);
        TextDrawShowForPlayer(playerid, PIN0);
        SelectTextDraw(playerid, 0xA3B4C5FF);
    }
    if (clickedid == PIN1) {
        PINN1[playerid] = 1;
        TextDrawShowForPlayer(playerid, PIN11);
        TextDrawShowForPlayer(playerid, PIN1);
        TextDrawShowForPlayer(playerid, PIN2);
        TextDrawShowForPlayer(playerid, PIN3);
        TextDrawShowForPlayer(playerid, PIN4);
        TextDrawShowForPlayer(playerid, PIN5);
        TextDrawShowForPlayer(playerid, PIN6);
        TextDrawShowForPlayer(playerid, PIN8);
        TextDrawShowForPlayer(playerid, PIN9);
        TextDrawShowForPlayer(playerid, PIN0);
        TextDrawShowForPlayer(playerid, PIN7);
        SelectTextDraw(playerid, 0xA3B4C5FF);
    }
    if (clickedid == PIN2) {
        PINN2[playerid] = 2;
        TextDrawShowForPlayer(playerid, PIN11);
        TextDrawShowForPlayer(playerid, PIN1);
        TextDrawShowForPlayer(playerid, PIN2);
        TextDrawShowForPlayer(playerid, PIN3);
        TextDrawShowForPlayer(playerid, PIN4);
        TextDrawShowForPlayer(playerid, PIN5);
        TextDrawShowForPlayer(playerid, PIN6);
        TextDrawShowForPlayer(playerid, PIN8);
        TextDrawShowForPlayer(playerid, PIN9);
        TextDrawShowForPlayer(playerid, PIN0);
        TextDrawShowForPlayer(playerid, PIN7);
        SelectTextDraw(playerid, 0xA3B4C5FF);
    }
    if (clickedid == PIN3) {
        PINN3[playerid] = 3;
        TextDrawShowForPlayer(playerid, PIN11);
        TextDrawShowForPlayer(playerid, PIN1);
        TextDrawShowForPlayer(playerid, PIN2);
        TextDrawShowForPlayer(playerid, PIN3);
        TextDrawShowForPlayer(playerid, PIN4);
        TextDrawShowForPlayer(playerid, PIN5);
        TextDrawShowForPlayer(playerid, PIN6);
        TextDrawShowForPlayer(playerid, PIN8);
        TextDrawShowForPlayer(playerid, PIN9);
        TextDrawShowForPlayer(playerid, PIN0);
        TextDrawShowForPlayer(playerid, PIN7);
        SelectTextDraw(playerid, 0xA3B4C5FF);
    }
    if (clickedid == PIN4) {
        PINN4[playerid] = 4;
        TextDrawShowForPlayer(playerid, PIN11);
        TextDrawShowForPlayer(playerid, PIN1);
        TextDrawShowForPlayer(playerid, PIN2);
        TextDrawShowForPlayer(playerid, PIN3);
        TextDrawShowForPlayer(playerid, PIN4);
        TextDrawShowForPlayer(playerid, PIN5);
        TextDrawShowForPlayer(playerid, PIN6);
        TextDrawShowForPlayer(playerid, PIN8);
        TextDrawShowForPlayer(playerid, PIN9);
        TextDrawShowForPlayer(playerid, PIN0);
        TextDrawShowForPlayer(playerid, PIN7);
        SelectTextDraw(playerid, 0xA3B4C5FF);
    }
    if (clickedid == PIN5) {
        PINN5[playerid] = 5;
        TextDrawShowForPlayer(playerid, PIN11);
        TextDrawShowForPlayer(playerid, PIN1);
        TextDrawShowForPlayer(playerid, PIN2);
        TextDrawShowForPlayer(playerid, PIN3);
        TextDrawShowForPlayer(playerid, PIN4);
        TextDrawShowForPlayer(playerid, PIN5);
        TextDrawShowForPlayer(playerid, PIN6);
        TextDrawShowForPlayer(playerid, PIN8);
        TextDrawShowForPlayer(playerid, PIN9);
        TextDrawShowForPlayer(playerid, PIN0);
        TextDrawShowForPlayer(playerid, PIN7);
        SelectTextDraw(playerid, 0xA3B4C5FF);
    }
    if (clickedid == PIN6) {
        PINN6[playerid] = 6;
        TextDrawShowForPlayer(playerid, PIN11);
        TextDrawShowForPlayer(playerid, PIN1);
        TextDrawShowForPlayer(playerid, PIN2);
        TextDrawShowForPlayer(playerid, PIN3);
        TextDrawShowForPlayer(playerid, PIN4);
        TextDrawShowForPlayer(playerid, PIN5);
        TextDrawShowForPlayer(playerid, PIN6);
        TextDrawShowForPlayer(playerid, PIN8);
        TextDrawShowForPlayer(playerid, PIN9);
        TextDrawShowForPlayer(playerid, PIN0);
        TextDrawShowForPlayer(playerid, PIN7);
        SelectTextDraw(playerid, 0xA3B4C5FF);
    }
    if (clickedid == PIN7) {
        PINN7[playerid] = 7;
        TextDrawShowForPlayer(playerid, PIN11);
        TextDrawShowForPlayer(playerid, PIN1);
        TextDrawShowForPlayer(playerid, PIN2);
        TextDrawShowForPlayer(playerid, PIN3);
        TextDrawShowForPlayer(playerid, PIN4);
        TextDrawShowForPlayer(playerid, PIN5);
        TextDrawShowForPlayer(playerid, PIN6);
        TextDrawShowForPlayer(playerid, PIN8);
        TextDrawShowForPlayer(playerid, PIN9);
        TextDrawShowForPlayer(playerid, PIN0);
        TextDrawShowForPlayer(playerid, PIN7);
        SelectTextDraw(playerid, 0xA3B4C5FF);
    }
    if (clickedid == PIN8) {
        PINN8[playerid] = 8;
        TextDrawShowForPlayer(playerid, PIN11);
        TextDrawShowForPlayer(playerid, PIN1);
        TextDrawShowForPlayer(playerid, PIN2);
        TextDrawShowForPlayer(playerid, PIN3);
        TextDrawShowForPlayer(playerid, PIN4);
        TextDrawShowForPlayer(playerid, PIN5);
        TextDrawShowForPlayer(playerid, PIN6);
        TextDrawShowForPlayer(playerid, PIN8);
        TextDrawShowForPlayer(playerid, PIN9);
        TextDrawShowForPlayer(playerid, PIN7);
        TextDrawShowForPlayer(playerid, PIN0);
        SelectTextDraw(playerid, 0xA3B4C5FF);
    }
    if (clickedid == PIN9) {
        PINN9[playerid] = 9;
        TextDrawShowForPlayer(playerid, PIN11);
        TextDrawShowForPlayer(playerid, PIN1);
        TextDrawShowForPlayer(playerid, PIN2);
        TextDrawShowForPlayer(playerid, PIN3);
        TextDrawShowForPlayer(playerid, PIN4);
        TextDrawShowForPlayer(playerid, PIN5);
        TextDrawShowForPlayer(playerid, PIN6);
        TextDrawShowForPlayer(playerid, PIN8);
        TextDrawShowForPlayer(playerid, PIN9);
        TextDrawShowForPlayer(playerid, PIN0);
        TextDrawShowForPlayer(playerid, PIN7);
        SelectTextDraw(playerid, 0xA3B4C5FF);
    }
    if (clickedid == PIN11) {
        new strin[256];
        APin[playerid] = 0;
        strrs[playerid] = 0;

        format(strin, sizeof(strin), "%d%d%d%d%d%d%d%d%d%d", PINN0[playerid], PINN1[playerid], PINN2[playerid], PINN3[playerid], PINN4[playerid], PINN5[playerid], PINN6[playerid], PINN7[playerid], PINN8[playerid], PINN9[playerid]);

        strrs[playerid] = strval(strin);
        if (strrs[playerid] == PlayerInfo[playerid][AdminP]) {
            TextDrawHideForPlayer(playerid, PIN11);
            TextDrawHideForPlayer(playerid, PIN1);
            TextDrawHideForPlayer(playerid, PIN2);
            TextDrawHideForPlayer(playerid, PIN3);
            TextDrawHideForPlayer(playerid, PIN4);
            TextDrawHideForPlayer(playerid, PIN5);
            TextDrawHideForPlayer(playerid, PIN7);
            TextDrawHideForPlayer(playerid, PIN6);
            TextDrawHideForPlayer(playerid, PIN8);
            TextDrawHideForPlayer(playerid, PIN9);
            TextDrawHideForPlayer(playerid, PIN0);
            CancelSelectTextDraw(playerid);
            APin[playerid] = 1;
            LoadAccount(playerid, PlayerInfo[playerid][Password]);
        } else {
            PlayerInfo[playerid][Logged] = true;
            NewSpawn[playerid] = 1;
            PlayerInfo[playerid][Bann] = 1;
            new Second;
            Second = gettime();
            PlayerInfo[playerid][BanTime] = Second;
            SendClientMessage(playerid, COLOR_WHITE, "Извините, но нужно вводить корректные данные.");
            lKick(playerid);
        }
    }
    if (ClothesRound[playerid] == 1) {
        if (clickedid == ButtonRight) {
            if (PlayerInfo[playerid][Sex] == 1) {
                switch (SelectCharRegID[playerid]) {
                    case 1 : SetPlayerSkin(playerid, 79), SelectCharRegID[playerid] = 2, ChosenSkin[playerid] = 79;
                    case 2 : SetPlayerSkin(playerid, 135), SelectCharRegID[playerid] = 3, ChosenSkin[playerid] = 135;
                    case 3 : SetPlayerSkin(playerid, 230), SelectCharRegID[playerid] = 4, ChosenSkin[playerid] = 230;
                    case 4 : SetPlayerSkin(playerid, 137), SelectCharRegID[playerid] = 5, ChosenSkin[playerid] = 137;
                    case 5 : SetPlayerSkin(playerid, 200), SelectCharRegID[playerid] = 6, ChosenSkin[playerid] = 200;
                    case 6 : SetPlayerSkin(playerid, 78), SelectCharRegID[playerid] = 1, ChosenSkin[playerid] = 78;
                }
            } else {
                switch (SelectCharRegID[playerid]) {
                    case 1 : SetPlayerSkin(playerid, 13), SelectCharRegID[playerid] = 2, ChosenSkin[playerid] = 13;
                    case 2 : SetPlayerSkin(playerid, 55), SelectCharRegID[playerid] = 3, ChosenSkin[playerid] = 55;
                    case 3 : SetPlayerSkin(playerid, 90), SelectCharRegID[playerid] = 4, ChosenSkin[playerid] = 90;
                    case 4 : SetPlayerSkin(playerid, 193), SelectCharRegID[playerid] = 5, ChosenSkin[playerid] = 193;
                    case 5 : SetPlayerSkin(playerid, 12), SelectCharRegID[playerid] = 1, ChosenSkin[playerid] = 12;
                }
            }
        } else if (clickedid == ButtonLeft) {
            if (PlayerInfo[playerid][Sex] == 1) {
                switch (SelectCharRegID[playerid]) {
                    case 1 : SetPlayerSkin(playerid, 200), SelectCharRegID[playerid] = 6, ChosenSkin[playerid] = 200;
                    case 6 : SetPlayerSkin(playerid, 137), SelectCharRegID[playerid] = 5, ChosenSkin[playerid] = 137;
                    case 5 : SetPlayerSkin(playerid, 230), SelectCharRegID[playerid] = 4, ChosenSkin[playerid] = 230;
                    case 4 : SetPlayerSkin(playerid, 135), SelectCharRegID[playerid] = 3, ChosenSkin[playerid] = 135;
                    case 3 : SetPlayerSkin(playerid, 79), SelectCharRegID[playerid] = 2, ChosenSkin[playerid] = 79;
                    case 2 : SetPlayerSkin(playerid, 78), SelectCharRegID[playerid] = 1, ChosenSkin[playerid] = 78;
                }
            } else {
                switch (SelectCharRegID[playerid]) {
                    case 1 : SetPlayerSkin(playerid, 193), SelectCharRegID[playerid] = 5, ChosenSkin[playerid] = 193;
                    case 5 : SetPlayerSkin(playerid, 90), SelectCharRegID[playerid] = 4, ChosenSkin[playerid] = 90;
                    case 4 : SetPlayerSkin(playerid, 55), SelectCharRegID[playerid] = 3, ChosenSkin[playerid] = 55;
                    case 3 : SetPlayerSkin(playerid, 13), SelectCharRegID[playerid] = 2, ChosenSkin[playerid] = 13;
                    case 2 : SetPlayerSkin(playerid, 12), SelectCharRegID[playerid] = 1, ChosenSkin[playerid] = 12;
                }
            }
        } else if (clickedid == ButtonSelect) {
            PlayerInfo[playerid][Skin] = ChosenSkin[playerid];
            SelectCharRegID[playerid] = 0;
            ClothesRound[playerid] = 0;
            PostSex(playerid);
            TextDrawHideForPlayer(playerid, ButtonLeft);
            TextDrawHideForPlayer(playerid, ButtonRight);
            TextDrawHideForPlayer(playerid, ButtonSelect);
            CancelSelectTextDraw(playerid);
            PlayerInfo[playerid][Level] = 1;
            SetPlayerScore(playerid, 1);
        }
        if (clickedid == Text:INVALID_TEXT_DRAW) {
            if (ClothesRound[playerid] == 1) {
                TextDrawShowForPlayer(playerid, ButtonLeft);
                TextDrawShowForPlayer(playerid, ButtonRight);
                TextDrawShowForPlayer(playerid, ButtonSelect);
                SelectTextDraw(playerid, 0xFF4040AA);
                if (PlayerInfo[playerid][Sex] == 1) SetPlayerSkin(playerid, 78), SelectCharRegID[playerid] = 1, ChosenSkin[playerid] = 78;
                else SetPlayerSkin(playerid, 12), SelectCharRegID[playerid] = 1, ChosenSkin[playerid] = 12;
            }
        }
    }
    return 1;
}
forward UpdateSpeed(playerid);
public UpdateSpeed(playerid) {
    if (IsPlayerInAnyVehicle(playerid)) {
        new vid = GetPlayerVehicleID(playerid);
        if (IsPlayerInVehicle(playerid, vid) && !IsAVelik(vid)) {
            if (GetPlayerVehicleSeat(playerid) == 0) {
                new string[256];
                new v = GetPlayerVehicleID(playerid);
                if (VehicleInfo[v][Stop] == true) {
                    if (GetVehicleSpeed(v) > 50) {
                        format(string, sizeof(string), "50");
                    } else {
                        format(string, sizeof(string), "%d", GetVehicleSpeed(v));
                    }
                } else {
                    format(string, sizeof(string), "%d", GetVehicleSpeed(v));
                }
                PlayerTextDrawSetString(playerid, SP2[playerid], string);
                format(string, sizeof(string), "%d", floatround(VehicleInfo[v][vFuel]));
                PlayerTextDrawSetString(playerid, SP3[playerid], string);
                format(string, sizeof(string), "%d%", floatround(VehicleHealth[v] / 10), "%%");
                PlayerTextDrawSetString(playerid, SP8[playerid], string);
                switch (VehicleInfo[v][vLock]) {
                    case 0: {
                        PlayerTextDrawHide(playerid, SP4[playerid]);
                        PlayerTextDrawColor(playerid, SP4[playerid], -16776961);
                        PlayerTextDrawShow(playerid, SP4[playerid]);
                    }
                    case 1: {
                        PlayerTextDrawHide(playerid, SP4[playerid]);
                        PlayerTextDrawColor(playerid, SP4[playerid], 16777215);
                        PlayerTextDrawShow(playerid, SP4[playerid]);
                    }
                }
                switch (VehicleInfo[v][Stop]) {
                    case 0: {
                        PlayerTextDrawHide(playerid, SP6[playerid]);
                        PlayerTextDrawColor(playerid, SP6[playerid], -16776961);
                        PlayerTextDrawShow(playerid, SP6[playerid]);
                    }
                    case 1: {
                        PlayerTextDrawHide(playerid, SP6[playerid]);
                        PlayerTextDrawColor(playerid, SP6[playerid], 16777215);
                        PlayerTextDrawShow(playerid, SP6[playerid]);
                    }
                }
                if (VehicleInfo[v][vEngine]) {
                    PlayerTextDrawHide(playerid, SP5[playerid]);
                    PlayerTextDrawColor(playerid, SP5[playerid], 16777215);
                    PlayerTextDrawShow(playerid, SP5[playerid]);
                } else {
                    PlayerTextDrawHide(playerid, SP5[playerid]);
                    PlayerTextDrawColor(playerid, SP5[playerid], -16776961);
                    PlayerTextDrawShow(playerid, SP5[playerid]);
                }
                if (VehicleInfo[v][vFuel] <= 0) {
                    VehicleInfo[v][vEngine] = false;
                    VehicleInfo[v][vFuel] = 0.0;
                    new engine, lights, alarm, doors, bonnet, boot, objective;
                    GetVehicleParamsEx(v, engine, lights, alarm, doors, bonnet, boot, objective);
                    SetVehicleParamsEx(v, VehicleInfo[v][vEngine], lights, alarm, doors, bonnet, boot, objective);
                }
                new engine, lights, alarm, doors, bonnet, boot, objective;
                GetVehicleParamsEx(v, engine, lights, alarm, doors, bonnet, boot, objective);
                if (engine) {
                    VehicleInfo[v][vFuel] -= 0.00165;
                }
                if (VehicleInfo[v][Stop] == true) {
                    new Float:x, Float:y, Float:z;
                    GetVehicleVelocity(v, x, y, z);
                    if ((x > 0.5 || x < -0.5) || (y > 0.5 || y < -0.5)) {
                        SetVehicleVelocity(v, x * 0.9, y * 0.9, z);
                    }
                    /* if(GetVehicleSpeed(v) > 100)
                     {
                     SetVehicleSpeed(v, 50);
                     }*/
                }
            }
        }
    }
    return 1;
}

public FixHour(hour) {
    hour = timeshift + hour;
    if (hour < 0) {
        hour = hour + 24;
    } else if (hour > 23) {
        hour = hour - 24;
    }
    shifthour = hour;
    return 1;
}
forward tFlooder(playerid);
public tFlooder(playerid) {
    tFlood[playerid] = 0;
}
public ABroadCast(color, const string[], level) {
    for (new i = 0; i < MAX_PLAYERS; i++) {
        if (IsPlayerConnected(i)) {
            if (PlayerInfo[i][Admin] >= level) {
                SendClientMessage(i, color, string);
            }
        }
    }
    return 1;
}
forward bool:emptyMessage(const string[]);
bool:emptyMessage(const string[]) {
    for (new i; string[i] != 0x0; i++) {
        switch (string[i]) {
            case 0x20 : continue;
            default: return false;
        }
    }
    return true;
}
public SendAdminMessage(color, string[]) {
    for (new i = 0; i < MAX_PLAYERS; i++) {
        if (IsPlayerConnected(i)) {
            if (PlayerInfo[i][Admin] >= 1) {
                SendClientMessage(i, color, string);
            }
        }
    }
}
public AFP(playerid) {
    for (new i; i < MAX_PLAYERS; i++) {
        if (!PlayerToPoint(2.0, i, PosPic[0][i], PosPic[1][i], PosPic[2][i])) Dpic[i] = 0;
    }
}
public fermalscars(carid) {
    if ((carid >= fermalscar[0]) && (carid <= fermalscar[1])) {
        return 1;
    }
    return 0;
}
public foodcarj(carid) {
    if ((carid >= foodcar[0]) && (carid <= foodcar[1])) {
        return 1;
    }
    return 0;
}
public fermasfcars(carid) {
    if ((carid >= fermasfcar[0]) && (carid <= fermasfcar[1])) {
        return 1;
    }
    return 0;
}
public Mute(playerid) {
    if (PlayerInfo[playerid][Muted] > 0) {
        new a;
        a = 1;
        new b;
        b = PlayerInfo[playerid][Muted];
        PlayerInfo[playerid][Muted] = (b - a);
    }
}
public DeMorgann() {
    for (new i; i < MAX_PLAYERS; i++) {
        if (IsPlayerConnected(i)) {
            if (PlayerInfo[i][DeMorgan] > 0) {
                new at;
                at = 1;
                new bt;
                bt = PlayerInfo[i][DeMorgan];
                PlayerInfo[i][DeMorgan] = (bt - at);
                if (PlayerInfo[i][DeMorgan] < 3) {
                    PlayerInfo[i][DeMorgan] = 0;
                    NewSpawn[i] = 1;
                    OnPlayerSpawn(i);
                }
            }
        }
    }
}

public OnPlayerUpdated(playerid) {
    new Hour, Minute, Second;
    gettime(Hour, Minute, Second);

    if (Minute > 2 && Minute < 59) {
        if (PlayerInfo[playerid][Logged] == true) {
            if (playb[playerid] == 1) {

                new Float:pos[3];
                GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
                if (GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID && GetPlayerState(playerid) != PLAYER_STATE_SPAWNED) {

                    if (!GetPVarInt(playerid, "NoAB")) {
                        switch (GetPlayerAnimationIndex(playerid)) {
                            case 958, 959, 961, 962, 965, 971, 1126, 1130, 1132, 1134, 1156, 1208: {
                                SetPVarInt(playerid, "NoAB", 1);
                            }
                        }
                        if (IsPlayerInAnyVehicle(playerid)) {
                            if (GetPlayerVehicleSeat(playerid) == 0) {
                                if ((floatabs(pos[0] - GetPVarFloat(playerid, "OldPosX"))) > DYS_A || (floatabs(GetPVarFloat(playerid, "OldPosX") - pos[0])) > DYS_A ||
                                    (floatabs(pos[1] - GetPVarFloat(playerid, "OldPosY"))) > DYS_A || (floatabs(GetPVarFloat(playerid, "OldPosY") - pos[1])) > DYS_A ||
                                    (floatabs(pos[2] - GetPVarFloat(playerid, "OldPosZ"))) > DYS_A / 2 || (floatabs(GetPVarFloat(playerid, "OldPosZ") - pos[2])) > DYS_A / 2) {
                                    switch (PENALTY) {
                                        case 0 : BanEx(playerid, "Airbreak");
                                        case 1: {
                                            SendClientMessage(playerid, 0xFFFFFFFF, "{ff0000}Внимание! {ffffff}Вы были кикнуты за чит AirBreak/FlyHack, возможное использование SpeedHack{00A200}(В транспорте)");
                                            lKick(playerid);
                                        }
                                        case 2: {
                                            SendClientMessage(playerid, 0xFFFFFFFF, "{ff0000}Внимание! {ffffff}Вы были кикнуты за чит AirBreak/FlyHack, возможное использование SpeedHack{00A200}(В транспорте)");
                                            lKick(playerid);
                                        }
                                    }
                                }
                            }
                        } else {
                            if (PlayerInfo[playerid][Admin] <= 2) {
                                if ((floatabs(pos[0] - GetPVarFloat(playerid, "OldPosX"))) > DYS || (floatabs(GetPVarFloat(playerid, "OldPosX") - pos[0])) > DYS ||
                                    (floatabs(pos[1] - GetPVarFloat(playerid, "OldPosY"))) > DYS || (floatabs(GetPVarFloat(playerid, "OldPosY") - pos[1])) > DYS ||
                                    (floatabs(pos[2] - GetPVarFloat(playerid, "OldPosZ"))) > DYS / 2 || (floatabs(GetPVarFloat(playerid, "OldPosZ") - pos[2])) > DYS / 2) {
                                    if (PlayerInfo[playerid][Logged] == true) {
                                        if (playb[playerid] == 1) {
                                            if (GetPVarInt(playerid, "NoAB") != 1) {
                                                switch (PENALTY) {

                                                    case 0 : BanEx(playerid, "Airbreak");
                                                    case 1: {
                                                        if (AntiFly[playerid] == 0) {
                                                            SendClientMessage(playerid, 0xFFFFFFFF, "{ff0000}Внимание! {ffffff}Вы были кикнуты за чит AirBreak/FlyHack");
                                                            lKick(playerid);
                                                        }
                                                    }
                                                    case 2: {
                                                        //AirB[playerid]++;
                                                        //if(AirB[playerid] >= 15)
                                                        //{


                                                        //}
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    SetPVarInt(playerid, "NoAB", 0);

                    SetPVarFloat(playerid, "OldPosX", pos[0]);
                    SetPVarFloat(playerid, "OldPosY", pos[1]);
                    SetPVarFloat(playerid, "OldPosZ", pos[2]);
                }
            }
        }
    }
    return 1;
}
public AirBB(playerid) {
    AirB[playerid] = 0;
    return 1;
}
public AntiDMM(playerid) {
    AntiDM[playerid] = 0;
    return 1;
}
public Fooder() {
    for (new i; i < MAX_PLAYERS; i++) {
        if (IsPlayerConnected(i)) {
            if (PlayerInfo[i][Logged] == true) {
                PlayerInfo[i][Golod] -= 5;
                if (PlayerInfo[i][Golod] < 0) {
                    PlayerInfo[i][Golod] = 0;
                }
                if (PlayerInfo[i][Golod] <= 30) {
                    if (PlayerInfo[i][Golod] != 0) {
                        SendClientMessage(i, COLOR_ORANGE, "Вы голодны, Вам необходимо покушать. Иначе Вы начнёте терять здоровье и можете заболеть.");
                        SendClientMessage(i, COLOR_YELLOW, "[Подсказка]: Наблюдать за уровнем Вашей сытости Вы можете используя команду /food");
                    }
                    if (PlayerInfo[i][Golod] == 0) {
                        SendClientMessage(i, COLOR_RED, "Вы очень давно не кушали, слишком голодны. У Вас наблюдается потеря здоровья, высока вероятность заболеть.");
                        SendClientMessage(i, COLOR_YELLOW, "[Подсказка]: Наблюдать за уровнем сытости Вы можете используя команду /food");
                        PlayerInfo[i][Health] -= 5;
                    }
                }
            }
        }
    }
    return 1;
}
forward ProxDetectorS(Float:radi, playerid, targetid);

public ProxDetectorS(Float:radi, playerid, targetid) {
    if (IsPlayerConnected(playerid) && IsPlayerConnected(targetid)) {
        new Float:posx, Float:posy, Float:posz;
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
        GetPlayerPos(targetid, posx, posy, posz);
        tempposx = (oldposx - posx);
        tempposy = (oldposy - posy);
        tempposz = (oldposz - posz);
        if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) {
            return 1;
        }
    }
    return 0;
}

//stock
stock ConnectMySQL() {
    mysql_connect(SQL_HOST, SQL_USER, SQL_DB, SQL_PASS);
    mysql_set_charset("cp1251_general_ci");
    mysql_query("SET NAMES 'cp1251'");
    mysql_query("SET CHARACTER SET 'cp1251'");
    return 1;
}

stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z) {
    if (IsPlayerConnected(playerid)) {
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
        tempposx = (oldposx - x);
        tempposy = (oldposy - y);
        tempposz = (oldposz - z);
        if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) { return true; }
    }
    return false;
}
stock DisconnectMySQL() {
    mysql_close();
    print("MySQL connection closed.");
}

stock CheckMySQLConnection() {
    if (mysql_ping() == -1) {
        printf("Нет коннекта с MySQL сервером, попытка переподключится.");
        mysql_reconnect();
        mysql_set_charset("cp1251_general_ci");
        mysql_query("SET NAMES 'cp1251'");
        mysql_query("SET CHARACTER SET 'cp1251'");
    }
    return 1;
}
stock CBB(playerid, resull) {
    new Float:x, Float:y, Float:z, Float:ang;
    GetPlayerPos(playerid, x, y, z);
    cbEnterX = x;
    cbEnterY = y;
    cbEnterZ = z;
    cbSpawn = resull;
    GetPlayerFacingAngle(playerid, ang);
    cbEnterA = ang;
    return 1;
}
stock CBBB(playerid) {
    new Float:x, Float:y, Float:z, Float:ang;
    GetPlayerPos(playerid, x, y, z);
    cbEnterX = x;
    cbEnterY = y;
    cbEnterZ = z;
    GetPlayerFacingAngle(playerid, ang);
    cbEnterA = ang;
    return 1;
}
stock SetPlayerHealthAC(playerid, Float: Healthh) {
    if (IsPlayerConnected(playerid)) {
        PlayerHealth[playerid] = Healthh; // Принимаем массив
        SetPlayerHealth(playerid, Healthh); // Устанавливаем игроку жизни
        PlayerInfo[playerid][Health] = Healthh;
    }
    return 1;
}
stock SetPlayerHealthACC(playerid, Float: Healthh) {
    if (IsPlayerConnected(playerid)) {
        PlayerHealth[playerid] = Healthh; // Принимаем массив
        SetPlayerHealth(playerid, Healthh); // Устанавливаем игроку жизни
    }
    return 1;
}
stock BusinessQ() {
    CheckMySQLConnection();
    new
    query[128],

        result[5 + 24 + 64];
    for (new i = 1; i < MAX_BUSINESS; i++) {
        format(query, sizeof(query), "SELECT * FROM `business` WHERE `ID` ='%i'", i);
        mysql_query(query);
        mysql_store_result();
        if (mysql_num_rows() == 1) {
            mysql_fetch_row_format(result, "|");
            sscanf(result, "p<|>is[64]iiiffffffiffffffffiiif",
                BusinessInfo[i][ID],
                BusinessInfo[i][Name],
                BusinessInfo[i][Boss],
                BusinessInfo[i][Ammount],
                BusinessInfo[i][Status],
                BusinessInfo[i][TDX],
                BusinessInfo[i][TDY],
                BusinessInfo[i][TDZ],
                BusinessInfo[i][SpawnX],
                BusinessInfo[i][SpawnY],
                BusinessInfo[i][SpawnZ],
                BusinessInfo[i][Interior],
                BusinessInfo[i][Angel],
                BusinessInfo[i][EnterX],
                BusinessInfo[i][EnterY],
                BusinessInfo[i][EnterZ],
                BusinessInfo[i][EnterA],
                BusinessInfo[i][sEnterX],
                BusinessInfo[i][sEnterY],
                BusinessInfo[i][sEnterZ],
                BusinessInfo[i][Sum],
                BusinessInfo[i][Price],
                BusinessInfo[i][Type],
                BusinessInfo[i][AngelE]);
            mysql_free_result(); // Очищаем память.
        }
        new Float:ze;
        ze = (BusinessInfo[i][TDZ] + 1);

        if (BusinessInfo[i][Type] == 1) {
            CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 40, 0);
        }
        if (BusinessInfo[i][Type] == 2) {
            CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 11, 0);
        }
        if (BusinessInfo[i][Type] == 3) {
            CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 14, 0);
        }
        if (BusinessInfo[i][Type] == 4) {
            CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 29, 0);
        }
        if (BusinessInfo[i][Type] == 5) {
            CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 10, 0);
        }
        if (BusinessInfo[i][Type] == 6) {
            CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 27, 0);
        }
        if (BusinessInfo[i][Type] == 7) {
            CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 48, 0);
        }
        if (BusinessInfo[i][Type] == 8) {
            CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 49, 0);
        }

        BusinessLabel[i] = Create3DTextLabel(BusinessInfo[i][Name], COLOR_WHITE, BusinessInfo[i][TDX], BusinessInfo[i][TDY], ze, 60.0, 0, 1);
        BusinessPickupIn[i] = CreateDynamicPickup(1318, 23, BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 0);
        new v;
        v = (BusinessInfo[i][ID] + 1000);
        BusinessPickupOut[i] = CreateDynamicPickup(1318, 23, BusinessInfo[i][SpawnX], BusinessInfo[i][SpawnY], BusinessInfo[i][SpawnZ], v);
    }


}
stock BusinessF() {
    CheckMySQLConnection();
    new
    query[128],

        result[5 + 24 + 64];
    for (new i; i < MAX_FERMA; i++) {
        format(query, sizeof(query), "SELECT * FROM `ferma` WHERE `ID` ='%i'", i);
        mysql_query(query);
        mysql_store_result();
        if (mysql_num_rows() == 1) {
            mysql_fetch_row_format(result, "|");
            sscanf(result, "p<|>is[64]iiiiiffffffiffffffffiiiiiiiii",
                FermaInfo[i][ID],
                FermaInfo[i][Name],
                FermaInfo[i][Boss],
                FermaInfo[i][Ammount],
                FermaInfo[i][Ur],
                FermaInfo[i][UrP],
                FermaInfo[i][Status],
                FermaInfo[i][TDX],
                FermaInfo[i][TDY],
                FermaInfo[i][TDZ],
                FermaInfo[i][SpawnX],
                FermaInfo[i][SpawnY],
                FermaInfo[i][SpawnZ],
                FermaInfo[i][Interior],
                FermaInfo[i][Angel],
                FermaInfo[i][EnterX],
                FermaInfo[i][EnterY],
                FermaInfo[i][EnterZ],
                FermaInfo[i][EnterA],
                FermaInfo[i][sEnterX],
                FermaInfo[i][sEnterY],
                FermaInfo[i][sEnterZ],
                FermaInfo[i][Sum],
                FermaInfo[i][Price],
                FermaInfo[i][Fermer1],
                FermaInfo[i][Fermer2],
                FermaInfo[i][Fermer3],
                FermaInfo[i][Fermer4],
                FermaInfo[i][Fermer5],
                FermaInfo[i][Bank],
                FermaInfo[i][Zerno]);
            mysql_free_result(); // Очищаем память.
        }

        new Float:ze;
        ze = (FermaInfo[i][TDZ] + 1);
        if (FermaInfo[i][Boss] == 0 && FermaInfo[i][Status] == 2) {
            new str[72];
            format(str, sizeof(str), "Ферма продается.\nДля покупки введите /buyferma\nСтоимость %d", FermaInfo[i][Sum]);
            FermaLabel[i] = Create3DTextLabel(str, COLOR_BLUE, FermaInfo[i][TDX], FermaInfo[i][TDY], ze, 60.0, 0, 1);
        } else {
            FermaLabel[i] = Create3DTextLabel(FermaInfo[i][Name], COLOR_BLUE, FermaInfo[i][TDX], FermaInfo[i][TDY], ze, 60.0, 0, 1);
        }
        FermaPickupIn[i] = CreateDynamicPickup(1318, 23, FermaInfo[i][TDX], FermaInfo[i][TDY], FermaInfo[i][TDZ], 0);
        new v;
        v = (FermaInfo[i][ID] + 1000);
        FermaPickupOut[i] = CreateDynamicPickup(1318, 23, FermaInfo[i][SpawnX], FermaInfo[i][SpawnY], FermaInfo[i][SpawnZ], v);
    }


}
stock HouseSave() {
    for (new i; i < MAX_HOUSE; i++) {
        CheckMySQLConnection();
        new
        query[1000],
            ste[1000];
        format(ste, sizeof(ste),
            "UPDATE `house` SET `Boss` = '%i', `Interior` = '%i', `Bank` = '%i', `Heal` = '%i', `SHX` = '%f', `SHY` = '%f', `SHZ` = '%f', `Status` = '%i', `Angle` = '%f', `Klad` = '%i', `Signal` = '%i' WHERE `ID` =  '%i'", HouseInfo[i][Boss],
            HouseInfo[i][Int],
            HouseInfo[i][Bank],
            HouseInfo[i][Heal],
            HouseInfo[i][SHX],
            HouseInfo[i][SHY],
            HouseInfo[i][SHZ],
            HouseInfo[i][Status],
            HouseInfo[i][Angle],
            HouseInfo[i][Klad],
            HouseInfo[i][Signal],
            HouseInfo[i][ID]);
        strcat(query, ste);
        mysql_query(query);
        printf(query);

    }
}
stock HouseSaveO(ids) {
    CheckMySQLConnection();
    new
    query[1500],
        ste[1500];
    format(ste, sizeof(ste),
        "UPDATE `house` SET `Boss` = '%i', `Interior` = '%i', `Bank` = '%i', `Heal` = '%i', `SHX` = '%f', `SHY` = '%f', `SHZ` = '%f', `Status` = '%i', `Angle` = '%f', `Klad` = '%i', `Signal` = '%i' WHERE `ID` =  '%i'", HouseInfo[ids][Boss],
        HouseInfo[ids][Int],
        HouseInfo[ids][Bank],
        HouseInfo[ids][Heal],
        HouseInfo[ids][SHX],
        HouseInfo[ids][SHY],
        HouseInfo[ids][SHZ],
        HouseInfo[ids][Status],
        HouseInfo[ids][Angle],
        HouseInfo[ids][Klad],
        HouseInfo[ids][Signal],
        ids);
    strcat(query, ste);
    mysql_query(query);
    printf(query);

}
stock HouseLoad() {
    CheckMySQLConnection();
    new
    query[128],

        result[128];
    for (new i = 1; i < MAX_HOUSE; i++) {
        format(query, sizeof(query), "SELECT * FROM `house` WHERE `ID` ='%i'", i);
        mysql_query(query);
        mysql_store_result();
        if (mysql_num_rows() == 1) {
            mysql_fetch_row_format(result, "|");
            sscanf(result, "p<|>iiiiiiifffffffffifffii",
                HouseInfo[i][ID],
                HouseInfo[i][Price],
                HouseInfo[i][Boss],
                HouseInfo[i][Int],
                HouseInfo[i][IntB],
                HouseInfo[i][Bank],
                HouseInfo[i][Heal],
                HouseInfo[i][HX],
                HouseInfo[i][HY],
                HouseInfo[i][HZ],
                HouseInfo[i][SHX],
                HouseInfo[i][SHY],
                HouseInfo[i][SHZ],
                HouseInfo[i][SHXB],
                HouseInfo[i][SHYB],
                HouseInfo[i][SHZB],
                HouseInfo[i][Status],
                HouseInfo[i][Angle],
                HouseInfo[i][Angl],
                HouseInfo[i][AngleB],
                HouseInfo[i][Klad],
                HouseInfo[i][Signal]);
            mysql_free_result();
        }
        format(query, sizeof(query), "SELECT `Name` FROM `accounts` WHERE `ID` = '%d'", HouseInfo[i][Boss]);
        mysql_query(query);
        mysql_store_result();
        if (mysql_num_rows() == 1) {
            mysql_fetch_row_format(result, "|");
            sscanf(result, "p<|>s[64]",
                HouseInfo[i][BossName]);
            mysql_free_result(); // Очищаем память.
        }
        if (HouseInfo[i][Status] == 2) {
            HousePickupIn[i] = CreateDynamicPickup(1273, 23, HouseInfo[i][HX], HouseInfo[i][HY], HouseInfo[i][HZ], 0);
            CreateDynamicMapIcon(HouseInfo[i][HX], HouseInfo[i][HY], HouseInfo[i][HZ], 31, 0);
        } else {
            HousePickupIn[i] = CreateDynamicPickup(1272, 23, HouseInfo[i][HX], HouseInfo[i][HY], HouseInfo[i][HZ], 0);
            HouseMapIcon[i] = CreateDynamicMapIcon(HouseInfo[i][HX], HouseInfo[i][HY], HouseInfo[i][HZ], 32, 0);
        }
    }


}
stock GarageLoad() {
    CheckMySQLConnection();
    new
    query[128],

        result[128];
    for (new i = 1; i < MAX_HOUSE; i++) {
        format(query, sizeof(query), "SELECT * FROM `garage` WHERE `ID` ='%i'", i);
        mysql_query(query);
        mysql_store_result();
        if (mysql_num_rows() == 1) {
            mysql_fetch_row_format(result, "|");
            sscanf(result, "p<|>iiffff",
                GarageInfo[i][ID],
                GarageInfo[i][House],
                GarageInfo[i][GX],
                GarageInfo[i][GY],
                GarageInfo[i][GZ],
                GarageInfo[i][GA]);
            mysql_free_result();
        }
    }


}
stock BusinessL(playerid, io) {
    CheckMySQLConnection();
    new
    query[128],

        result[5 + 24 + 64];
    new i = io;
    format(query, sizeof(query), "SELECT * FROM `business` WHERE `ID` ='%i'", i);
    mysql_query(query);
    mysql_store_result();
    if (mysql_num_rows() == 1) {
        mysql_fetch_row_format(result, "|");
        sscanf(result, "p<|>is[64]iiiffffffiffffffffiiif",
            BusinessInfo[i][ID],
            BusinessInfo[i][Name],
            BusinessInfo[i][Boss],
            BusinessInfo[i][Ammount],
            BusinessInfo[i][Status],
            BusinessInfo[i][TDX],
            BusinessInfo[i][TDY],
            BusinessInfo[i][TDZ],
            BusinessInfo[i][SpawnX],
            BusinessInfo[i][SpawnY],
            BusinessInfo[i][SpawnZ],
            BusinessInfo[i][Interior],
            BusinessInfo[i][Angel],
            BusinessInfo[i][EnterX],
            BusinessInfo[i][EnterY],
            BusinessInfo[i][EnterZ],
            BusinessInfo[i][EnterA],
            BusinessInfo[i][sEnterX],
            BusinessInfo[i][sEnterY],
            BusinessInfo[i][sEnterZ],
            BusinessInfo[i][Sum],
            BusinessInfo[i][Price],
            BusinessInfo[i][Type],
            BusinessInfo[i][AngelE]);
        mysql_free_result(); // Очищаем память.

    }
    new Float:ze;
    ze = (BusinessInfo[i][TDZ] + 1);
    if (BusinessInfo[i][Type] == 1) {
        CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 40, 0);
    }
    if (BusinessInfo[i][Type] == 2) {
        CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 11, 0);
    }
    if (BusinessInfo[i][Type] == 3) {
        CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 14, 0);
    }
    if (BusinessInfo[i][Type] == 4) {
        CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 29, 0);
    }
    if (BusinessInfo[i][Type] == 5) {
        CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 10, 0);
    }
    if (BusinessInfo[i][Type] == 6) {
        CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 27, 0);
    }
    if (BusinessInfo[i][Type] == 7) {
        CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 48, 0);
    }
    if (BusinessInfo[i][Type] == 8) {
        CreateDynamicMapIcon(BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 49, 0);
    }
    BusinessLabel[i] = Create3DTextLabel(BusinessInfo[i][Name], COLOR_WHITE, BusinessInfo[i][TDX], BusinessInfo[i][TDY], ze, 60.0, 0, 1);

    BusinessPickupIn[i] = CreateDynamicPickup(1318, 23, BusinessInfo[i][TDX], BusinessInfo[i][TDY], BusinessInfo[i][TDZ], 0);
    new v;
    v = (BusinessInfo[i][ID] + 1000);
    BusinessPickupOut[i] = CreateDynamicPickup(1318, 23, BusinessInfo[i][SpawnX], BusinessInfo[i][SpawnY], BusinessInfo[i][SpawnZ], v);
    cbbb[playerid] = 0;
}
stock CreateAccount(playerid, password[]) {
    new
    query[256],
        sqlname[MAX_PLAYER_NAME],
        sqlpassword[32];
    mysql_real_escape_string(PlayerInfo[playerid][Name], sqlname); // Защитит от sql inject
    mysql_real_escape_string(password, sqlpassword); // Защитит от sql inject
    mysql_real_escape_string(PlayerInfo[playerid][Emailaccount], PlayerInfo[playerid][Email]); // Защитит от sql inject
    format(query, sizeof(query), "INSERT INTO `accounts` (`Name`, `Password`, `Health`, `Golod`, `Sex`, `Skin`, `Level`, `Status`, `Email`) VALUE ('%s', '%s', '100', '100', '%i', '%i', '%i', '1', '%s')", sqlname, sqlpassword, PlayerInfo[playerid][Sex], PlayerInfo[playerid][Skin], PlayerInfo[playerid][Level], PlayerInfo[playerid][Email]);
    mysql_query(query);
    GetAccountID(playerid);
    strmid(PlayerInfo[playerid][Password], password, 0, 64, 255);
    PlayerInfo[playerid][Logged] = true;
    ClothesRound[playerid] = 3;
    NewSpawn[playerid] = 1;
    SpawnReg[playerid] = 0;
    PlayerInfo[playerid][Health] = 100;
    PlayerInfo[playerid][Golod] = 100;
    SetPlayerHealthAC(playerid, PlayerInfo[playerid][Health]);
    PlayerInfo[playerid][Frac] = 0;
    Spawner[playerid] = 0;
    SpawnPlayer(playerid);
    OnPlayerSpawn(playerid);

    SendClientMessage(playerid, -1, "Регистрация прошла успешно!");
    SendClientMessage(playerid, COLOR_YELLOW, "В первую очередь Вам необходимо заработать на права для управления автомобилем.");
    SendClientMessage(playerid, COLOR_YELLOW, "Направляйтесь к работам (Команда /gps - Работа - Работа грузчика).");
    SendClientMessage(playerid, COLOR_YELLOW, "Также Вы можете заработать деньги на ферме (Команда /gps - Работа - Ферма Лос Сантоса/Ферма Сан Фиерро).");
    Rules(playerid);
    return 1;
}

stock LoadAccount(playerid, password[]) {
    new
    query[128],
        sqlpass[32],
        result[5 + 24 + 64],
        dialog[128];
    mysql_real_escape_string(password, sqlpass); // Защита от SQL Inject, шифрует кодировку.
    format(query, sizeof(query), "SELECT * FROM `accounts` WHERE `Password` = '%s' AND `ID` = '%i'", sqlpass, PlayerInfo[playerid][ID]);
    mysql_query(query);
    mysql_store_result();
    if (mysql_num_rows() == 1) {
        mysql_fetch_row_format(result, "|"); // split, данные в результате записываются типо "1|LOD|parol"
        sscanf(result, "p<|>is[24]s[32]s[64]iiiiiiiiffiifffiiiiiiiiiiiiiiiiii", // i - ид (int), s[размер] - string, ник и пароль.
            PlayerInfo[playerid][ID],
            PlayerInfo[playerid][Name],
            PlayerInfo[playerid][Password],
            PlayerInfo[playerid][Email],
            PlayerInfo[playerid][Level],
            PlayerInfo[playerid][Exp],
            PlayerInfo[playerid][Money],
            PlayerInfo[playerid][Admin],
            PlayerInfo[playerid][Donate],
            PlayerInfo[playerid][Skin],
            PlayerInfo[playerid][FSkin],
            PlayerInfo[playerid][BMoney],
            PlayerInfo[playerid][Health],
            PlayerInfo[playerid][Armour],
            PlayerInfo[playerid][House],
            PlayerInfo[playerid][Car],
            PlayerInfo[playerid][PosX],
            PlayerInfo[playerid][PosY],
            PlayerInfo[playerid][PosZ],
            PlayerInfo[playerid][Interior],
            PlayerInfo[playerid][VW],
            PlayerInfo[playerid][Frac],
            PlayerInfo[playerid][Business],
            PlayerInfo[playerid][Bank],
            PlayerInfo[playerid][Drugs],
            PlayerInfo[playerid][Golod],
            PlayerInfo[playerid][Bann],
            PlayerInfo[playerid][BanTime],
            PlayerInfo[playerid][Sex],
            PlayerInfo[playerid][JailTime],
            PlayerInfo[playerid][Warn],
            PlayerInfo[playerid][Muted],
            PlayerInfo[playerid][DeMorgan],
            PlayerInfo[playerid][Status],
            PlayerInfo[playerid][AdminP],
            PlayerInfo[playerid][FermaLS],
            PlayerInfo[playerid][FermaSF]);

        mysql_free_result(); // Очищаем память.
        if (PlayerInfo[playerid][Admin] != 0) {
            if (APin[playerid] == 0) {
                TextDrawShowForPlayer(playerid, PIN11);
                TextDrawShowForPlayer(playerid, PIN1);
                TextDrawShowForPlayer(playerid, PIN2);
                TextDrawShowForPlayer(playerid, PIN3);
                TextDrawShowForPlayer(playerid, PIN4);
                TextDrawShowForPlayer(playerid, PIN5);
                TextDrawShowForPlayer(playerid, PIN6);
                TextDrawShowForPlayer(playerid, PIN7);
                TextDrawShowForPlayer(playerid, PIN8);
                TextDrawShowForPlayer(playerid, PIN9);
                TextDrawShowForPlayer(playerid, PIN0);
                SelectTextDraw(playerid, 0xA3B4C5FF);
            }
            if (APin[playerid] == 1) {
                SetPlayerHealthAC(playerid, PlayerInfo[playerid][Health]);
                SetPlayerArmourAC(playerid, PlayerInfo[playerid][Armour]);

                if (PlayerInfo[playerid][Warn] == 3) {
                    SendClientMessage(playerid, COLOR_LIGHTRED, "Ваш аккаунт заблокирован на сервере, обратитесь при необходимости в поддержку на нашем сайте.");
                    lKick(playerid);
                }
                if (PlayerInfo[playerid][Bann] == 1) {
                    SendClientMessage(playerid, COLOR_LIGHTRED, "Ваш аккаунт заблокирован на сервере, обратитесь при необходимости в поддержку на нашем сайте.");
                    lKick(playerid);
                } else
                if (PlayerInfo[playerid][Status] == 2) {
                    SendClientMessage(playerid, COLOR_LIGHTRED, "Извините, но для продолжения игры Вам необходимо выйти с панели управления персонажем на нашем сайте - nation-rp.ru");
                    lKick(playerid);
                }
                PlayerInfo[playerid][Logged] = true;
                ClothesRound[playerid] = 3;
                format(query, sizeof(query), "UPDATE `accounts` SET `Status` = 1 WHERE `ID` = '%i'", PlayerInfo[playerid][ID]);
                mysql_query(query);
                Mmoney[playerid] = PlayerInfo[playerid][Money];
                SetPlayerScore(playerid, PlayerInfo[playerid][Level]);
                GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
                Spawner[playerid] = 0;
                SpawnReg[playerid] = 1;
                SpawnPlayer(playerid);
                OnPlayerSpawn(playerid);
            }
        }
        if (PlayerInfo[playerid][Admin] == 0) {
            PlayerInfo[playerid][Logged] = true;
            ClothesRound[playerid] = 3;
            format(query, sizeof(query), "UPDATE `accounts` SET `Status` = 1 WHERE `ID` = '%i'", PlayerInfo[playerid][ID]);
            mysql_query(query);
            Mmoney[playerid] = PlayerInfo[playerid][Money];
            SetPlayerScore(playerid, PlayerInfo[playerid][Level]);
            GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
            Spawner[playerid] = 0;
            SpawnReg[playerid] = 1;
            SpawnPlayer(playerid);
            OnPlayerSpawn(playerid);
        }

        return 1;
    } else {
        if (PlayerInfo[playerid][WrongPassword] == 2) {
            SendClientMessage(playerid, COLOR_LIGHTRED, "Вы 3 раза ввели неверный пароль и были отключены от сервера.");
            lKick(playerid);
            return 1;
        }
        PlayerInfo[playerid][WrongPassword] = PlayerInfo[playerid][WrongPassword] + 1;
        format(dialog, sizeof(dialog),
            "Вы ввели неверный пароль.\n\
                        У Вас осталось %i/3 попыток ввода.", 3 - PlayerInfo[playerid][WrongPassword]);
        ShowPlayerDialog(playerid, DIALOG_WRONGPAS, DIALOG_STYLE_MSGBOX, "Ошибка.", dialog, "Повтор", "Отмена");
    }
    return 1;
}
stock GetAccountID(playerid) {
    CheckMySQLConnection();
    new
    query[128];
    format(query, sizeof(query), "SELECT `ID` FROM `accounts` WHERE `Name` = '%s'", PlayerInfo[playerid][Name]);
    mysql_query(query);
    mysql_store_result();
    if (mysql_num_rows() == 1) {
        PlayerInfo[playerid][ID] = mysql_fetch_int();
        mysql_free_result();
        return PlayerInfo[playerid][ID];
    }
    return 0;
}
stock Statuss(playerid) {
    if (PlayerInfo[playerid][Logged] == true) {
        if (NewSpawn[playerid] != 0) {
            CheckMySQLConnection();
            new query[500];
            format(query, sizeof(query), "UPDATE `accounts` SET `Status` = 0 WHERE `ID` = '%i'", PlayerInfo[playerid][ID]);
            mysql_query(query);
        }
    }
    return 1;
}
stock SaveAccount(playerid) {
    if (PlayerInfo[playerid][Logged] == true) {
        if (NewSpawn[playerid] != 0) {
            CheckMySQLConnection();
            new
            query[1500],
                ste[1500],
                sqlname[MAX_PLAYER_NAME],
                sqlpass[64];
            mysql_real_escape_string(PlayerInfo[playerid][Name], sqlname);
            mysql_real_escape_string(PlayerInfo[playerid][Password], sqlpass);
            new Float:x, Float:y, Float:z, interior, vw;
            GetPlayerPos(playerid, x, y, z);

            interior = GetPlayerInterior(playerid);
            vw = GetPlayerVirtualWorld(playerid);
            PlayerInfo[playerid][VW] = vw;
            PlayerInfo[playerid][Interior] = interior;
            PlayerInfo[playerid][PosX] = x;
            PlayerInfo[playerid][PosY] = y;
            PlayerInfo[playerid][PosZ] = z;
            PlayerInfo[playerid][Armour] = PlayerArmour[playerid];
            PlayerInfo[playerid][Health] = PlayerHealth[playerid];
            format(ste, sizeof(ste),
                "UPDATE `accounts` SET `Name` = '%s', `Password` = '%s', `Level` = '%i', `Exp` = '%i', `Money` = '%i', `Skin` = '%i', `FSkin` = '%i', `BMoney` = '%i', `Health` = '%f', `Armour` = '%f', `House` = '%i', `Car` = '%i', `PosX` = '%f', `PosY` = '%f', `PosZ` = '%f', `Interior` = '%i', `VW` = '%i', `Frac` = '%i', `Business` = '%i', `Bank` = '%i', `Drugs` = '%i', `Golod` = '%i', `Bann` = '%i', `BanTime` = '%i', `Sex` = '%i', `JailTime` = '%i', `Warn` = '%i', `Muted` = '%i'", sqlname,
                sqlpass,
                PlayerInfo[playerid][Level],
                PlayerInfo[playerid][Exp],
                PlayerInfo[playerid][Money],
                PlayerInfo[playerid][Skin],
                PlayerInfo[playerid][FSkin],
                PlayerInfo[playerid][BMoney],
                PlayerInfo[playerid][Health],
                PlayerInfo[playerid][Armour],
                PlayerInfo[playerid][House],
                PlayerInfo[playerid][Car],
                PlayerInfo[playerid][PosX],
                PlayerInfo[playerid][PosY],
                PlayerInfo[playerid][PosZ],
                PlayerInfo[playerid][Interior],
                PlayerInfo[playerid][VW],
                PlayerInfo[playerid][Frac],
                PlayerInfo[playerid][Business],
                PlayerInfo[playerid][Bank],
                PlayerInfo[playerid][Drugs],
                PlayerInfo[playerid][Golod],
                PlayerInfo[playerid][Bann],
                PlayerInfo[playerid][BanTime],
                PlayerInfo[playerid][Sex],
                PlayerInfo[playerid][JailTime],
                PlayerInfo[playerid][Warn],
                PlayerInfo[playerid][Muted]);
            strcat(query, ste);
            format(ste, sizeof(ste), ", `DeMorgan` = '%d', `FermaLS` = '%d', `FermaSF` = '%d' WHERE `ID` = '%i'", PlayerInfo[playerid][DeMorgan],
                PlayerInfo[playerid][FermaLS],
                PlayerInfo[playerid][FermaSF],
                PlayerInfo[playerid][ID]);
            strcat(query, ste);
            mysql_query(query);
            printf(query);
        }
    }
    return 1;
}
stock lcar(playerid, i) {
    DestroyVehicle(lcarid[playerid]);
    lcarid[playerid] = CreateVehicle(PlayerInfo[playerid][Car], GarageInfo[i][GX], GarageInfo[i][GY], GarageInfo[i][GZ], GarageInfo[i][GA], 1, 1, 3600);
    if (!IsAVelik(lcarid[playerid])) { SetVehicleParamsEx(lcarid[playerid], false, false, false, true, false, false, false); } else { SetVehicleParamsEx(lcarid[playerid], true, false, false, true, false, false, false); }
}
stock FermaSave() {
    for (new i; i < MAX_FERMA; i++) {
        CheckMySQLConnection();
        new
        query[1500],
            ste[1500];
        format(ste, sizeof(ste),
            "UPDATE `ferma` SET `Boss` = '%i', `Ammount` = '%i', `Ur` = '%i', `Status` = '%i', `Price` = '%i', `Fermer1` = '%i', `Fermer2` = '%i', `Fermer3` = '%i', `Fermer4` = '%i', `Fermer5` = '%i', `UrP` = '%i', `Bank` = '%i', `Zerno` = '%i' WHERE `ID` =  '%i'", FermaInfo[i][Boss],
            FermaInfo[i][Ammount],
            FermaInfo[i][Ur],
            FermaInfo[i][Status],
            FermaInfo[i][Price],
            FermaInfo[i][Fermer1],
            FermaInfo[i][Fermer2],
            FermaInfo[i][Fermer3],
            FermaInfo[i][Fermer4],
            FermaInfo[i][Fermer5],
            FermaInfo[i][UrP],
            FermaInfo[i][Bank],
            FermaInfo[i][Zerno],
            FermaInfo[i][ID]);
        strcat(query, ste);
        mysql_query(query);
        printf(query);
    }
    return 1;
}
stock BusinessSave() {
    for (new i; i < MAX_BUSINESS; i++) {
        CheckMySQLConnection();
        new
        query[1500],
            ste[1500];
        format(ste, sizeof(ste),
            "UPDATE `business` SET `Name` = '%s', `Boss` = '%i', `Ammount` = '%i', `Status` = '%i', `TDX` = '%f', `TDY` = '%f', `TDZ` = '%f', `SpawnX` = '%f', `SpawnY` = '%f', `SpawnZ` = '%f', `EnterX` = '%f', `EnterY` = '%f', `EnterA` = '%f', `sEnterX` = '%f', `sEnterY` = '%f', `sEnterZ` = '%f', `Sum` = '%i', `Price` = '%i' WHERE `ID` =  '%i'", BusinessInfo[i][Name],
            BusinessInfo[i][Boss],
            BusinessInfo[i][Ammount],
            BusinessInfo[i][Status],
            BusinessInfo[i][TDX],
            BusinessInfo[i][TDY],
            BusinessInfo[i][TDZ],
            BusinessInfo[i][SpawnX],
            BusinessInfo[i][SpawnY],
            BusinessInfo[i][SpawnZ],
            BusinessInfo[i][EnterX],
            BusinessInfo[i][EnterY],
            BusinessInfo[i][EnterZ],
            BusinessInfo[i][EnterA],
            BusinessInfo[i][sEnterX],
            BusinessInfo[i][sEnterY],
            BusinessInfo[i][sEnterZ],
            BusinessInfo[i][Sum],
            BusinessInfo[i][Price],
            BusinessInfo[i][ID]);
        strcat(query, ste);
        mysql_query(query);
        printf(query);
    }
    return 1;
}
stock SetPlayerArmourAC(playerid, Float: Armorr) {
    if (IsPlayerConnected(playerid)) {
        PlayerArmour[playerid] = Armorr;
        SetPlayerArmour(playerid, Armorr);
        PlayerInfo[playerid][Armour] = PlayerArmour[playerid];
    }
}
stock IsPlayerAtPnSpray(playerid) {
    if (!GetPlayerInterior(playerid)) return false;
    for (new i = 0; i < PNSCS; i++) {
        if (IsPlayerInRangeOfPoint(playerid, 15.0, PnSC[i][0], PnSC[i][1], PnSC[i][2])) { return true; }
    }
    return false;
}
stock Rules(playerid) {
    new query[1500];
    new ste[1500];
    format(ste, sizeof(ste), "\t Запрещено \n1. Продажа аккаунтов и игрового имущества.\n2. Оскорбления игроков/администрации.\n3. Употребление не нормативной лексики.\n4. Использование читов/клео и прочего ПО(программного обеспечения) что даёт преимущество над остальными игроками или может мешать их игре.\n");
    strcat(query, ste);
    format(ste, sizeof(ste), "5. Неадекватное поведение, DM в анти-DM зонах(Общественные места).\n6. Обман или ввод в заблуждение администрации/игроков.\n7. Мошенничество.\n\n\t Необходимо \n");
    strcat(query, ste);
    format(ste, sizeof(ste), "1. Отыгровка роли Вашего персонажа.\n2. Знание основных RP-тэрминов и их соблюдение.\n3. Адекватное поведение.");
    strcat(query, ste);
    ShowPlayerDialog(playerid, DIALOG_RULES, DIALOG_STYLE_MSGBOX, "Правила сервера", query, "Согласен", "Согласен");
}
/*stock GetVehicleSpeed(vehicleid)
{
new Float:ST[4];
GetVehicleVelocity(vehicleid, ST[0], ST[1], ST[2]);
ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 170.3;
return floatround(ST[3]);
}
stock SetVehicleSpeed(vehicleid, Float:speed)
{
new Float:cr[4];
speed /= 1.609344;
GetVehicleZAngle(vehicleid, cr[0]);
GetVehicleVelocity(vehicleid, cr[1], cr[2], cr[3]);
SetVehicleVelocity(vehicleid, floatsin(-cr[0],degrees)*(speed/99), floatcos(-cr[0],degrees)*(speed/99), cr[3]);
return true;
}*/
stock SetVehicleSpeed(const vehicleid, const Float:speed) {
    new Float:pos[7];
    GetVehicleVelocity(vehicleid, pos[0], pos[1], pos[2]);
    GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]);
    GetVehicleZAngle(vehicleid, pos[6]);
    pos[6] = 360 - pos[6];
    pos[0] = (floatsin(pos[6], degrees) * (speed / 100) + floatcos(pos[6], degrees) * 0 + pos[3]) - pos[3];
    pos[1] = (floatcos(pos[6], degrees) * (speed / 100) + floatsin(pos[6], degrees) * 0 + pos[4]) - pos[4];
    SetVehicleVelocity(vehicleid, pos[0], pos[1], pos[2]);
}
stock RemovePlayerVariables(playerid) {
    PlayerInfo[playerid][WrongPassword] = 0;
    PlayerInfo[playerid][ID] = 0;
    PlayerInfo[playerid][Name] = 0;
    PlayerInfo[playerid][Password] = 0;
    PlayerInfo[playerid][Email] = 0;
    PlayerInfo[playerid][Level] = 0;
    PlayerInfo[playerid][Exp] = 0;
    PlayerInfo[playerid][Money] = 0;
    PlayerInfo[playerid][Admin] = 0;
    PlayerInfo[playerid][Skin] = 0;
    PlayerInfo[playerid][FSkin] = 0;
    PlayerInfo[playerid][BMoney] = 0;
    PlayerInfo[playerid][Health] = 0;
    PlayerInfo[playerid][Armour] = 0;
    PlayerInfo[playerid][House] = 0;
    PlayerInfo[playerid][Car] = 0;
    PlayerInfo[playerid][PosX] = 0;
    PlayerInfo[playerid][PosY] = 0;
    PlayerInfo[playerid][PosZ] = 0;
    PlayerInfo[playerid][Interior] = 0;
    PlayerInfo[playerid][VW] = 0;
    PlayerInfo[playerid][Frac] = 0;
    PlayerInfo[playerid][Business] = 0;
    PlayerInfo[playerid][Bank] = 0;
    PlayerInfo[playerid][Drugs] = 0;
    PlayerInfo[playerid][Golod] = 0;
    PlayerInfo[playerid][Bann] = 0;
    PlayerInfo[playerid][BanTime] = 0;
    PlayerInfo[playerid][Sex] = 0;
    PlayerInfo[playerid][JailTime] = 0;
    PlayerInfo[playerid][Warn] = 0;
    PlayerInfo[playerid][Muted] = 0;
    PlayerInfo[playerid][DeMorgan] = 0;
    PlayerInfo[playerid][FermaLS] = 0;
    PlayerInfo[playerid][AdminP] = 0;
    PlayerInfo[playerid][FermaLS] = 0;
    PlayerInfo[playerid][FermaSF] = 0;
    PlayerInfo[playerid][Logged] = false;
    return 1;
}
stock lKick(playerid) {
    KillTimer(kick_gTimer[playerid]);
    playb[playerid] = 0;
    kick_gTimer[playerid] = SetTimerEx("lKickD", 100, false, "i", playerid);
    return 1;
}
stock PlayerName(playerid) {
    new nameoo[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nameoo, sizeof(nameoo));
    return nameoo;
}
stock LoadTextDraws() {
    ButtonLeft = TextDrawCreate(50.0, 200.0, "LD_BEAT:left");
    TextDrawFont(ButtonLeft, 4);
    TextDrawTextSize(ButtonLeft, 50, 25);
    TextDrawSetSelectable(ButtonLeft, 1);

    ButtonRight = TextDrawCreate(530.0, 200.0, "LD_BEAT:right");
    TextDrawFont(ButtonRight, 4);
    TextDrawTextSize(ButtonRight, 50, 25);
    TextDrawSetSelectable(ButtonRight, 1);

    ButtonSelect = TextDrawCreate(382.000000, 371.000000, "Select");
    TextDrawTextSize(ButtonSelect, 482.0, 22.0);
    TextDrawBackgroundColor(ButtonSelect, 255);
    TextDrawFont(ButtonSelect, 3);
    TextDrawLetterSize(ButtonSelect, 0.899999, 2.400000);
    TextDrawColor(ButtonSelect, 869072895);
    TextDrawSetOutline(ButtonSelect, 0);
    TextDrawSetProportional(ButtonSelect, 1);
    TextDrawSetShadow(ButtonSelect, 1);
    TextDrawSetSelectable(ButtonSelect, 1);
}
stock SetVehicleHealthAC(vehicleid, hh) {
    VehicleHealth[vehicleid] = hh;
}
stock SetSex(playerid) {
    TogglePlayerControllable(playerid, 1);
    SetPlayerVirtualWorld(playerid, playerid);
    SetPlayerInterior(playerid, 0);
    SetPos(playerid, 1708.1248, -1930.9232, 3.6515);
    SetPlayerFacingAngle(playerid, 360);
    SetPlayerCameraPos(playerid, 1707.7800, -1925.4385, 14.9881);
    SetPlayerCameraLookAt(playerid, 1708.1248, -1930.9232, 13.6515);
    new dialog[325 + MAX_PLAYER_NAME];
    format(dialog, sizeof(dialog),
        "Выберите Ваш пол:\n");
    ShowPlayerDialog(playerid, DIALOG_SEX, DIALOG_STYLE_MSGBOX, "Регистрация", dialog, " мужчина ", " женщина ");
}
stock GetNearestVehicle(playerid) {
    for (new i = 1, Float:x, Float:y, Float:z; i < MAX_VEHICLES; ++i)
        if (IsVehicleStreamedIn(i, playerid)) {
            GetVehiclePos(i, x, y, z);
            if (IsPlayerInRangeOfPoint(playerid, 10.0, x, y, z)) return i;
        }
    return 0;
}
stock GiveWeapon(player, weapid, ammo) {
    Weapons[player][weapid] = 1;
    GivePlayerWeapon(player, weapid, ammo);
    return;
}
stock PostSex(playerid) {
    SetPlayerVirtualWorld(playerid, playerid);
    SetPlayerInterior(playerid, PlayerInfo[playerid][Interior]);
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    new Float:sa = (Z + 500);
    SetPos(playerid, X, Y, Z);
    SetPlayerCameraPos(playerid, X, Y, sa);
    SetPlayerCameraLookAt(playerid, X, Y, Z);
    ShowPlayerDialog(playerid, DIALOG_REGISTERR, DIALOG_STYLE_INPUT, "Регистрация", "Пожалуйста, укажите Ваш E-mail адрес.\n(Он будет необходим для восстановления аккаунта и важных операций)", "Далее", "Отмена");
}
stock GetDayMount(mount, yer) {
    switch (mount) {
        case 1 : return 31;
        case 2: {
            if ((yer - 8) % 4 == 0) {
                return 29;
            } else {
                return 28;
            }
        }
        case 3 : return 31;
        case 4 : return 30;
        case 5 : return 31;
        case 6 : return 30;
        case 7 : return 31;
        case 8 : return 31;
        case 9 : return 30;
        case 10 : return 31;
        case 11 : return 30;
        case 12 : return 31;
    }
    return 1;
}

stock Tuning(playerid) {
    if (IsPlayerInRangeOfPoint(playerid, 10, 615.2878, -124.2391, 997.5602)) return true;
    if (IsPlayerInRangeOfPoint(playerid, 10, 617.5355, -1.9899, 1000.6155)) return true;
    if (IsPlayerInRangeOfPoint(playerid, 10, 616.7834, -74.8151, 997.7726)) return true;
    return false;
}
stock ProxDetector(Float:radi, playerid, string[], col1, col2, col3, col4, col5) {
    if (IsPlayerConnected(playerid)) {
        new Float:posx, Float:posy, Float:posz;
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
        for (new i = 0; i < MAX_PLAYERS; i++) {
            if (IsPlayerConnected(i)) {
                if (!BigEar[i]) {
                    GetPlayerPos(i, posx, posy, posz);
                    tempposx = (oldposx - posx);
                    tempposy = (oldposy - posy);
                    tempposz = (oldposz - posz);
                    if (((tempposx < radi / 16) && (tempposx > -radi / 16)) && ((tempposy < radi / 16) && (tempposy > -radi / 16)) && ((tempposz < radi / 16) && (tempposz > -radi / 16))) {
                        SendClientMessage(i, col1, string);
                        SetPlayerChatBubble(playerid, string, col1, radi, 10000);
                    } else if (((tempposx < radi / 8) && (tempposx > -radi / 8)) && ((tempposy < radi / 8) && (tempposy > -radi / 8)) && ((tempposz < radi / 8) && (tempposz > -radi / 8))) {
                        SendClientMessage(i, col2, string);
                        SetPlayerChatBubble(playerid, string, col1, radi, 10000);
                    } else if (((tempposx < radi / 4) && (tempposx > -radi / 4)) && ((tempposy < radi / 4) && (tempposy > -radi / 4)) && ((tempposz < radi / 4) && (tempposz > -radi / 4))) {
                        SendClientMessage(i, col3, string);
                        SetPlayerChatBubble(playerid, string, col1, radi, 10000);
                    } else if (((tempposx < radi / 2) && (tempposx > -radi / 2)) && ((tempposy < radi / 2) && (tempposy > -radi / 2)) && ((tempposz < radi / 2) && (tempposz > -radi / 2))) {
                        SendClientMessage(i, col4, string);
                        SetPlayerChatBubble(playerid, string, col1, radi, 10000);
                    } else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) {
                        SendClientMessage(i, col5, string);
                        SetPlayerChatBubble(playerid, string, col1, radi, 10000);
                    }
                } else {
                    SendClientMessage(i, col1, string);
                    SetPlayerChatBubble(playerid, string, col1, radi, 10000);
                }
            }
        }
    }
    return 1;
}
stock GN(playerid) {
    new Name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, Name, sizeof Name);
    return Name;
}
strtok(const string[], & index) {
    new length = strlen(string);
    while ((index < length) && (string[index] <= ' ')) {
        index++;
    }

    new offset = index;
    new result[20];
    while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1))) {
        result[index - offset] = string[index];
        index++;
    }
    result[index - offset] = EOS;
    return result;
}
stock ConvertSeconds(time) {
    new string[128];
    if (time < 60) format(string, sizeof(string), "%d секунд", time);
    else if (time == 60) string = "1 минуту";
    else if (time > 60 && time < 600) {
        new Float: minutes;
        new seconds;
        minutes = time / 60;
        seconds = time % 60;
        format(string, sizeof(string), "%.0f минут и %d секунд", minutes, seconds);
    }
    return string;
}
stock SetPos(playerid, Float:xx, Float:yy, Float:zz) {
    AntiFly[playerid] = 1;
    SetPVarInt(playerid, "NoAB", 1);
    SetPVarFloat(playerid, "OldPosX", xx);
    SetPVarFloat(playerid, "OldPosY", yy);
    SetPVarFloat(playerid, "OldPosZ", zz);
    SetPlayerPos(playerid, xx, yy, zz);
    SetTimerEx("UnAntiFly", 2333, false, "i", playerid);
}
stock GetVehicleSpeed(vehicleid) {
    new Float:Px, Float:Py, Float:Pz;
    GetVehicleVelocity(vehicleid, Px, Py, Pz);
    return floatround(floatsqroot(Px * Px + Py * Py + Pz * Pz) * 100.0);
}

//-stock