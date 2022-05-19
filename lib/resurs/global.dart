
///Глобал
var adress = '192.168.6.149';
///'85.175.216.81';
///'192.168.6.149'; наш
var myPort = '5020';
///'5020';
///'5004'; наш
var listIndex = 0;
var myId;
var bellText = 1;
var bellList;
bool myFilter = false;

String? balance;
String? money;
String? myMoney;
var businesses;
var businessesRename;
var source;
var position;
var myGet;
var consumptionBiss;
//var make;
var myIndex;
bool myBoolGet = false;
bool addOperation = true;
bool myBellGet = false;
bool mySwitchTwo = false;
var userName;
var postTranslat;


var nameButton = 'Бизнес';
///График Диаграммы
Map grafikInfo = {};

var se;
var istRename;
var celRasRename;
var celRashod;
var positionSpra;
var getPostCelIst;
var diagramaList;

String prihodRashod = 'prihod';

///Списки Фильтров Позиций
var listFilterPosBusiness;
var listFilterPosIst;
var listFilterPosCel;

///Список для отправки фильтров позиций
var listSendPos = {
  'business': [],
  'istocniki': [],
  'celi':[]
};