import 'dart:convert';
import 'package:counting_room/my_class/class_business.dart';
import 'package:counting_room/my_class/class_istoch_prichod.dart';
import 'package:counting_room/my_class/class_position.dart';
import 'package:counting_room/pages/reference.dart';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global_list.dart';
import 'package:flutter/material.dart';
import '../resurs/global.dart';
import '../resurs/global_function.dart';
import 'package:http/http.dart' as http;

import 'books_users.dart';
import '../my_class/class_cel_rashod.dart';


///Фильтр СПРАВОЧНИКИ

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

///Функция Редоктировать бизнес

businessRename(int businessId, String newName, var mySwitch) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/bussinesses/rename"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'id_business': businessId,
          "new_name": newName,
          "status": mySwitch.toString(),
        },
      ));
  var vovas = jsonDecode(response.body);
  businessesRename = vovas;
  print(businessesRename);
}

final vovaTestTwo = GlobalKey<ScaffoldState>();

///Функция удалить бизнес

businessDelete(int nameId) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/bussinesses/del"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'id_business': nameId,
        },
      ));
  var vovas = jsonDecode(response.body);
  businessesRename = vovas;
  print(businessesRename);
}
///============================================================================

///Функция получения списка Бизнеса Редоктировать Источник

istochnicRename(int nameId) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/spravochniki/istochniky/edit"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'istochnik_id': nameId,
        },
      ));
  var vovas = jsonDecode(response.body);
  istRename = vovas;
  print(istRename);
}


///Функция получения списка Бизнеса Редоктирование позиции

posRename(int nameId) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/spravochniki/position/edit/business"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'position_id': nameId,
        },
      ));
  var vovas = jsonDecode(response.body);
  businesses = vovas;
  print(businesses);
}

///=========================================================================

///Функция Редоктировать Источник Прихода

istochnicPrihodRename(
    {required String name, var idListDelete, var idList,required String newName, required String status, required int istochnik_id}) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/spravochniki/istochniky/edit_confirm"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
        'id_businesses': idList,
        'id_businesses_del': idListDelete,
          'name': name,
          'new_name':newName,
          'status':status,
          'istochnik_id': istochnik_id,
        },
      ));
  var vovas = jsonDecode(response.body);
  istochnic = vovas;
  print(istochnic);
}

///=========================================================================

///Функция обратотки списков в Источниках
istochCheck(){
  for(var i = 0;i<istRename.length;i++){
    if(businesses[0].contains(istRename[i]['businesses'])){
      businesses[1][businesses[0].indexOf(istRename[i]['businesses'])] = true;
      checkCount++;
      listIstochPrihod.add(businesses[0][businesses[0].indexOf(istRename[i]['businesses'])]);
      print(businesses[0].contains(istRename[i]['businesses']));
      print(businesses[1]);
    }
  }
}
int checkCount = 0;
///=========================================================================

///Функция Филтр Источников по бизнесу

istochnicFilterBusiness(var filterBiss) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/spravochniki/istochniky/filtr"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'id_businesses': filterBiss,
        },
      ));
  var vovas = jsonDecode(response.body);
  istochnic = vovas;
  print(istochnic);
}

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    for (var i = 0; i < listFilter[0].length; i++) {
      if (listFilter[0][i][1] == myIndex) {
        setState(() {
          var r = listFilter[0].removeAt(i);
          listFilter[0].insert(0, r);
          print(listFilter[0][i]);
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: vovaTestTwo,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(113, 35),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    primary: MyColors().myBeige,
                    onPrimary: MyColors().myWhite,
                  ),
                  onPressed: () {
                    setState(() {
                      if (listIndex != 0) {
                        listIndex -= 1;
                      } else {
                        listSendPos['business']!.clear();
                        listSendPos['istocniki']!.clear();
                        listSendPos['celi']!.clear();
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chevron_left_sharp),
                        Text(
                          'Назад',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Справочники',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: MyColors().greenDark),
                ),
                SizedBox(height: 16),
                Container(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listFilter[0].length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: OutlinedButton(
                                onPressed: () async {
                                  var r = listFilter[0].removeAt(index);
                                  listFilter[0].insert(0, r);
                                  if (r[1] == 0) {
                                    await getBusinessRename();
                                  }
                                  else if(r[1] == 1){
                                    await getMyReference();
                                  }
                                  else if(r[1] == 2){
                                    await getMyCelRashod();
                                  }
                                  else if(r[1] == 3){
                                    await getMyPosition();
                                    listSendPos['business']!.clear();
                                    listSendPos['istocniki']!.clear();
                                    listSendPos['celi']!.clear();
                                  }
                                  else if(r[1] == 4){
                                    // await getMyPosition();
                                  }
                                  setState(() {
                                    myIndex = r[1];
                                  });
                                },
                                child: Row(
                                  children: [
                                    if (index == 0)
                                      Icon(
                                        Icons.check,
                                        color: MyColors().greenDark,
                                        size: 20,
                                      ),
                                    SizedBox(width: 10),
                                    Text(
                                      '${listFilter[0][index][0]}',
                                      style: TextStyle(
                                        color: MyColors().greenDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                ///=============================================
                ///Бизнесы
                if (myIndex == 0)
                  Business(),
                ///=============================================
                ///Источники прихода
                if (myIndex == 1)
                  IstochPrihod(),
                ///=============================================
                ///Справочники
                if (myIndex == 2)
                  CelRashod(),
                ///=============================================
                ///Справочники
                if (myIndex == 3)
                  Position(),
                ///=============================================
                ///ПОЛЬЗОВАТЕЛИ
                if (myIndex == 4)
                  BooksUsers(),
                ///=============================================
              ],
            ),
          ),
        ),
      ),
    );
  }
}



