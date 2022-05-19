import 'dart:convert';
import 'package:counting_room/resurs/global_list.dart';
import 'global.dart';
import 'package:http/http.dart' as http;

///Глобальные Функции


///Функция добавление бизнеса в Справочниках
addBusinessesReference(String newBusinesses, String status) async {
  var response = await http.post(Uri.parse("http://$adress:$myPort/business/add"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'bussiness_name': newBusinesses,
          'status': status,
        },
      ));
  var vovas = jsonDecode(response.body);
  businessesRename = vovas;
  print(businessesRename);
}

///Функция Прихода добавление бизнеса
addBusinesses(String newBusinesses) async {
  var response = await http.post(Uri.parse("http://$adress:$myPort/add_business"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'add_business': newBusinesses,
        },
      ));
  var vovas = jsonDecode(response.body);
  businesses = vovas;
  print(businesses);
}

///Функции Расхода
consumptionMySource(String cel) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/rashod_cel"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'businesses': cel,
        },
      ));
  var vovas = jsonDecode(response.body);
  source = vovas;
  print(source);
}

///Получение списка бизнеса
 getMyBusiness() async {
  await Future(() async {
    final res = await http.get(
      Uri.parse("http://$adress:$myPort/prihod_business"),
    );
    var vova = jsonDecode(res.body);
    businesses = vova;
    print(businesses);
    myIndex = 0;
  });
}


///Получение источников прихода в СПРАВОЧНИКИ

 getMyReference() async {
  await Future(() async {
    final res = await http.get(
      Uri.parse("http://$adress:$myPort/spravochniki/istochniky"),
    );
    var vova = jsonDecode(res.body);
    istochnic = vova;
    print(istochnic);
  });
}


///Добовление источников прихода в список

addIstPrihod(String newNameIst, String status,List idIstochnik) async {
  var response = await http.post(Uri.parse("http://$adress:$myPort/spravochniki/istochniky/add_confirm"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'istochnik': newNameIst,
          'status': status,
          'id_business':idIstochnik,
        },
      ));
  var vova = jsonDecode(response.body);
  istochnic = vova;
  print(istochnic);
}


///Функция Удаление источников прихода

istochnicDelete(int name) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/spravochniki/istochniky/del"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'istochnik_id': name,

        },
      ));
  var vovas = jsonDecode(response.body);
  istochnic = vovas;
  print(istochnic);
}


///================================================================================

///Получение списков бизнесов для добавления нового источника прихода в СПРАВОЧНИКИ
addMyBissReference() async {
  await Future(() async {
    final res = await http.get(
      Uri.parse("http://$adress:$myPort/spravochniki/istochniky/add"),
    );
    var vova = jsonDecode(res.body);
    businesses = vova;
    print(businesses);
  });
}
///================================================================================

///Получение позиций в СПРАВОЧНИКИ
getMyPosition() async {
  await Future(() async {
    final res = await http.get(
      Uri.parse("http://$adress:$myPort/spravochniki/positions"),
    );
    var vova = jsonDecode(res.body);
    positionSpra = vova;
    print(positionSpra);
    print(positionSpra);
  });
}


///Функции получения цели и источника для позиций
positionCelIst(String pos, var busi) async {
  var response = await http.post(Uri.parse("http://$adress:$myPort/position_rename_spisok"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'business': busi,
          'position': pos,
        },
      ));
  var vovas = jsonDecode(response.body);
  getPostCelIst = vovas;
  print(getPostCelIst);
}


///Функции Получение Филтров Позиции


///Функция Получение Бизнес
getMyPosBusiness() async {
  await Future(() async {
    final res = await http.get(
      Uri.parse("http://$adress:$myPort/spravochniki/positions/filtr/business"),
    );
    var vova = jsonDecode(res.body);
    listFilterPosBusiness = vova;
    print(listFilterPosBusiness);
  });
}


///Функция Получение Источник

getMyPosIst() async {
  await Future(() async {
    final res = await http.get(
      Uri.parse("http://$adress:$myPort/default_istochnik"),
    );
    var vova = jsonDecode(res.body);
    listFilterPosIst = vova;
    print(listFilterPosIst);
  });
}
///Функция Получение Цель
///
getMyPosCel() async {
  await Future(() async {
    final res = await http.get(
      Uri.parse("http://$adress:$myPort/default_cel"),
    );
    var vova = jsonDecode(res.body);
    listFilterPosCel = vova;
    print(listFilterPosCel);
  });
}


///=================================================

///Функции Отправки Филтров Позиции

///Функция отправки Бизнес
postMyPosBusiness(var ibBis) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/spravochniki/positions/filtr/business"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'id_businesses': ibBis,
        },
      ));
  var vovas = jsonDecode(response.body);
  positionSpra = vovas;
  print(positionSpra);
}

///Функция отправки Источник
posrMyPosIst(var istId) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/spravochniki/positions/filtr/istochniky"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'id_istochniki': istId,
        },
      ));
  var vovas = jsonDecode(response.body);
  positionSpra = vovas;
  print(positionSpra);
}

///Функция отправки Цели
postMyPosCel(var idCel) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/spravochniki/positions/filtr/cel"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'id_cel': idCel,
        },
      ));
  var vovas = jsonDecode(response.body);
  positionSpra = vovas;
  print(positionSpra);
}

///=================================================

///Функция Фильтр Бизнес
filterMyPosBiss(var biss, var prihod) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/spravochniki/positions/filtr/positions_buss_istochnik"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'id_businesses': biss,
          'id_ist_cel': prihod,
        },
      ));
  var vovas = jsonDecode(response.body);
  positionSpra = vovas;
  print(positionSpra);
}

///Функция Фильтр Источник
filterMyPosIst(var biss, var rashod) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/spravochniki/positions/filtr/positions_buss_cel"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'id_businesses': biss,
          'id_ist_cel': rashod,
        },
      ));
  var vovas = jsonDecode(response.body);
  positionSpra = vovas;
  print(positionSpra);
}

///Функция Фильтр Цель
filterMyPosCel(var biss ,var prihod, var cel) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/spravochniki/positions/filtr/positions_buss_istoch_cel"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'id_businesses': biss,
          'id_ist_cel': prihod + cel,
        },
      ));
  var vovas = jsonDecode(response.body);
  positionSpra = vovas;
  print(positionSpra);
}

///Функция Фильтр Источник + цель
filterMyPosIstCel(var istoch, var cel) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/spravochniki/positions/filtr/positions_istoch_cel"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'id_ist_cel': istoch + cel,

        },
      ));
  var vovas = jsonDecode(response.body);
  positionSpra = vovas;
  print(positionSpra);
}


///Функция проверки фильтров
filterCase()async{
  if(listSendPos['business']!.isNotEmpty && listSendPos['istocniki']!.isNotEmpty && listSendPos['celi']!.isEmpty){
   await filterMyPosBiss(listSendPos['business'],listSendPos['istocniki']);
  }else if(listSendPos['business']!.isNotEmpty && listSendPos['istocniki']!.isEmpty && listSendPos['celi']!.isNotEmpty){
    await filterMyPosIst(listSendPos['business'],listSendPos['celi']);
  }else if(listSendPos['business']!.isNotEmpty && listSendPos['istocniki']!.isNotEmpty && listSendPos['celi']!.isNotEmpty){
    await filterMyPosCel(listSendPos['business'],listSendPos['istocniki'],listSendPos['celi']);
  }
  else if(listSendPos['business']!.isEmpty && listSendPos['istocniki']!.isNotEmpty && listSendPos['celi']!.isNotEmpty){
    await filterMyPosIstCel(listSendPos['istocniki'],listSendPos['celi']);
  }
  else if(listSendPos['business']!.isNotEmpty && listSendPos['istocniki']!.isEmpty && listSendPos['celi']!.isEmpty){
    await postMyPosBusiness(listSendPos['business']);
  }
  else if(listSendPos['business']!.isEmpty && listSendPos['istocniki']!.isNotEmpty && listSendPos['celi']!.isEmpty){
    await posrMyPosIst(listSendPos['istocniki']);
  }
  else if(listSendPos['business']!.isEmpty && listSendPos['istocniki']!.isEmpty && listSendPos['celi']!.isNotEmpty){
    await postMyPosCel(listSendPos['celi']);
  }
}

///=================================================