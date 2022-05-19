import 'dart:async';
import 'dart:convert';
import 'package:counting_room/components/my_button_lite.dart';
import 'package:counting_room/pages/filter_page.dart';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global.dart';
import 'package:counting_room/resurs/global_function.dart';
import 'package:counting_room/resurs/global_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../my_icon_icons.dart';
import '../pages/reference.dart';
import 'class_cel_rashod.dart';

///Класс Позиции

class Position extends StatefulWidget {
  const Position({Key? key}) : super(key: key);

  @override
  _PositionState createState() => _PositionState();
}

TextEditingController _myNewNameBiss = TextEditingController();


class _PositionState extends State<Position> {
  ///Все что касаеться добовление бизнеса в позиции==================
  int indexAddPos = 0;

  bool mySwitch = false;

  ///Чек бокс добавление позиций бизнес
  var addCheckBoxBis = false;

  ///Чек бокс добавление позиций источник
  var addCheckBoxIst = false;

  ///Чек бокс добавление позиций источник не привязывать
  var addCheckBoxIstNo = false;

  ///Чек бокс позиций цель
  var addCheckBoxCel = false;

  ///Чек бокс добавление позиций цель не привязывать
  var addCheckBoxCelNo = false;

  var addPosTypeMap = {
    'ist': [],
    'cel': [],
  };
  var addPosCel = [];
  var addPosIst = [];

  ///===============конец============================================

  ///Список для ключей ==1==
  List keysPos = [];
  List keysPosTwo = [];

  ///Для размера ячейки ==1==
  Size? oldSizePos;
///===========================

  ///Для анимации контейнера
  int selectedPos = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keysPos = [for (var i = 0; i < positionSpra.length; i++) GlobalKey()];
    keysPosTwo = [for (var i = 0; i < positionSpra.length; i++) GlobalKey()];
  }

  ///Удалить Позицию
  deletePosition(String nameBisDel, String myTypeDel, var typeNameDel,
      String namePosDel) async {
    var response =
        await http.post(Uri.parse("http://$adress:$myPort/position_del"),
            headers: {
              "Content-Type": "application/json; charset=utf-8",
            },
            body: json.encode(
              {
                'bussinesses_name': nameBisDel,
                'type': myTypeDel,
                'type_name': typeNameDel,
                'name': namePosDel,
              },
            ));
    var vovas = jsonDecode(response.body);
    positionSpra = vovas;
    print(positionSpra);
  }

  ///Функция определения ключа
  myKey(int index, int id){
    if(id == 1){
      if (positionSpra[index]['cel'] == null) {
        return positionSpra[index]['istochnik'].length >=
            positionSpra[index]['business'].length;
      } else {
        return positionSpra[index]['istochnik'].length >=
                positionSpra[index]['business'].length &&
            positionSpra[index]['istochnik'].length >= positionSpra[index]['cel'].length;
      }
    } else if(id == 2){
      if(positionSpra[index]['istochnik'] == null){
        return positionSpra[index]['cel'].length >= positionSpra[index]['business'].length;
      }else{
        return positionSpra[index]['cel'].length >= positionSpra[index]['business'].length &&
            positionSpra[index]['cel'].length > positionSpra[index]['istochnik'].length;
      }
    }else if(id == 3){
      if(positionSpra[index]['istochnik'] == null){
        return positionSpra[index]['business'].length > positionSpra[index]['cel'].length;
      }else if(positionSpra[index]['cel'] == null){
        return positionSpra[index]['business'].length > positionSpra[index]['istochnik'].length;
      }else {
        return positionSpra[index]['business'].length > positionSpra[index]['cel'].length &&
            positionSpra[index]['business'].length > positionSpra[index]['istochnik'].length;
      }
    }
  }
///==================================================================
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors().myWhite,
              borderRadius: BorderRadius.circular(0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              ///Фильтры
              child: Column(
                children: [
                  ///Фильтр бизнес
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Бизнес',
                        style: TextStyle(color: MyColors().greenDark),
                      ),
                      TextButton(
                        onPressed: () async {
                          await getBusinessRename();
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25)),
                            ),
                            context: context,
                            builder: (BuildContext ctx) => StatefulBuilder(
                              builder: (BuildContext context, setState) =>
                                  Stack(
                                children: [
                                  Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      width: double.infinity,
                                      height: 400,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(height: 30),
                                            Text(
                                              'Фильтр по бизнесу',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.5),
                                            ),
                                            Container(
                                              height: 210,
                                              child: ListView.builder(
                                                  itemCount: businessesRename.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ButtonBisnes(
                                                      press: () async {
                                                        if(listSendPos['business']!.contains(businessesRename[index]['id_business'])){
                                                            listSendPos['business']!.remove(
                                                                businessesRename[index]['id_business']);
                                                        }else{
                                                          listSendPos['business']!.add(
                                                              businessesRename[index]['id_business']);
                                                        }
                                                        setState((){});
                                                        print(listSendPos['business']);
                                                      },
                                                      title:
                                                      businessesRename[index]['business'],
                                                      onColor: listSendPos['business']!.contains(businessesRename[index]['id_business'])
                                                    );
                                                  }),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: MyColors().myBeige,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              child: Text(
                                                'Применить фильтр',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                              onPressed: () async {
                                                await filterCase();
                                                Navigator.pop(context);
                                              },
                                            ),
                                            SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: IconButton(
                                      onPressed: () {
                                        listSendPos['business']!.clear();
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.highlight_remove),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          setState(() {});
                        },
                        child: Text(
                          'Выбрать',
                          style: TextStyle(
                              color: MyColors().greenDark,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  if (listSendPos['business']!.isNotEmpty)
                    Container(
                        height: 27,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listSendPos['business']!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 7.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: 12,
                                      ),
                                      SizedBox(width: 5),
                                      Text(listSendPos['business']![index].toString()),
                                    ],
                                  ),
                                ),
                              );
                            })),

                  ///Фильтр Источник
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Источник',
                        style: TextStyle(color: MyColors().greenDark),
                      ),
                      TextButton(
                        onPressed: () async {
                          // await getMyPosIst();
                          await getMyReference();
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25)),
                            ),
                            context: context,
                            builder: (BuildContext ctx) => StatefulBuilder(
                              builder: (BuildContext context, setState) =>
                                  Stack(
                                children: [
                                  Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      width: double.infinity,
                                      height: 400,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(height: 30),
                                            Text(
                                              'Фильтр по источникам',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.5),
                                            ),
                                            Container(
                                              height: 210,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    for (var index = 0; index < istochnic.length; index++)
                                                        ButtonBisnes(
                                                          press: () async {
                                                            if(listSendPos['istocniki']!.contains(istochnic[index]['id_istochnik_cel'])){
                                                              listSendPos['istocniki']!.remove(
                                                                  istochnic[index]['id_istochnik_cel']);
                                                            }else{
                                                              listSendPos['istocniki']!.add(
                                                                  istochnic[index]['id_istochnik_cel']);
                                                            }
                                                            setState((){});
                                                            print(listSendPos['istocniki']);
                                                          },
                                                          title:
                                                          istochnic[index]['istochnik'],
                                                          onColor: listSendPos['istocniki']!.contains(istochnic[index]['id_istochnik_cel']),
                                                        ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: MyColors().myBeige,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              child: Text(
                                                'Применить фильтр',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                              onPressed: () async {
                                                await filterCase();
                                                Navigator.pop(context);
                                              },
                                            ),
                                            SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: IconButton(
                                      onPressed: () {
                                        //businessFalse();
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.highlight_remove),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          setState(() {});
                        },
                        child: Text(
                          'Выбрать',
                          style: TextStyle(
                              color: MyColors().greenDark,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  if (listSendPos['istocniki']!.isNotEmpty)
                    Container(
                        height: 27,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listSendPos['istocniki']!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 7.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: 12,
                                      ),
                                      SizedBox(width: 5),
                                      Text(listSendPos['istocniki']![index].toString()),
                                    ],
                                  ),
                                ),
                              );
                            })),

                  ///Фильтр Цель
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Цель',
                        style: TextStyle(color: MyColors().greenDark),
                      ),
                      TextButton(
                        onPressed: () async {
                          // await getMyPosCel();
                          await getMyCelRashod();
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25)),
                            ),
                            context: context,
                            builder: (BuildContext ctx) => StatefulBuilder(
                              builder: (BuildContext context, setState) =>
                                  Stack(
                                children: [
                                  Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      width: double.infinity,
                                      height: 400,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(height: 30),
                                            Text('Фильтр по целям',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0.5)),
                                            Container(
                                              height: 210,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    for (var index = 0; index < celRashod.length; index++)
                                                        ButtonBisnes(
                                                          press: () async {
                                                            if(listSendPos['celi']!.contains(celRashod[index]['id_istochnik_cel'])){
                                                              listSendPos['celi']!.remove(
                                                                  celRashod[index]['id_istochnik_cel']);
                                                            }else{
                                                              listSendPos['celi']!.add(
                                                                  celRashod[index]['id_istochnik_cel']);
                                                            }
                                                            setState((){});
                                                            print(listSendPos['celi']);
                                                          },
                                                          title: celRashod[index]['cel'],
                                                          onColor: listSendPos['celi']!.contains(celRashod[index]['id_istochnik_cel']),
                                                        ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: MyColors().myBeige,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              child: Text(
                                                'Применить фильтр',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                              onPressed: () async {
                                                await filterCase();
                                                Navigator.pop(context);
                                              },
                                            ),
                                            SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: IconButton(
                                      onPressed: () {
                                        //businessFalse();
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.highlight_remove),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          setState(() {});
                        },
                        child: Text(
                          'Выбрать',
                          style: TextStyle(
                              color: MyColors().greenDark,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  if (listSendPos['celi']!.isNotEmpty)
                    Container(
                        height: 27,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listSendPos['celi']!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 7.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: 12,
                                      ),
                                      SizedBox(width: 5),
                                      Text(listSendPos['celi']![index].toString()),
                                    ],
                                  ),
                                ),
                              );
                            })),
                  ///=================
                ],
              ),
              ///==================================================
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: MyColors().myWhite,
            height: MediaQuery.of(context).size.height*0.5,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ///Начало Таблици Позиций ===================================
                        Table(
                          defaultColumnWidth: FixedColumnWidth(
                              MediaQuery.of(context).size.width / 2),
                          border: TableBorder(
                            horizontalInside: BorderSide(
                              width: 1.5,
                              color: Colors.grey,
                            ),
                          ),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            for (var e = 0; e < positionSpra.length; e++)
                              TableRow(
                                  children: [
                                TableCell(
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          selectedPos = selectedPos == e ? -1 : e;
                                        });

                                        Timer(Duration(milliseconds: 250), () {
                                          var context = keysPos[e].currentContext;
                                          if (context == null) return;
                                          var newSize = context.size;

                                          var contextIst = keysPosTwo[e].currentContext;
                                          if (contextIst == null) return;
                                          var newSizeIst = contextIst.size;

                                          setState(() {
                                            oldSizePos = newSize.height > newSizeIst.height ? newSize : newSizeIst;
                                            // oldSize = oldSize!.height > 40.0 ? oldSize : null;
                                          });
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                              positionSpra[e]['status'] == 'false'
                                                  ? MyIcon.circle_empty
                                                  : Icons.circle,
                                              size: 14,
                                              color: MyColors().greenDark),
                                          SizedBox(width: 10),
                                          Container(
                                              key: keysPosTwo[e],
                                              height: selectedPos == e ? null : 40.0,
                                              width: MediaQuery.of(context).size.width/3,
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text('${positionSpra[e]['position']}', overflow: selectedPos == e? null : TextOverflow.ellipsis,))),
                                        ],
                                      ),
                                    )),
                                TableCell(
                                    child: positionSpra[e]['istochnik'] == null
                                        ? Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('-')),
                                        )
                                        : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                      onTap: (){
                                          setState(() {
                                            selectedPos = selectedPos == e ? -1 : e;
                                          });
                                          Timer(Duration(milliseconds: 300), () {
                                            var context = keysPos[e].currentContext;
                                            if (context == null) return;
                                            var newSize = context.size;

                                            setState(() {
                                              oldSizePos = newSize;
                                            });
                                            print(oldSizePos);
                                          });
                                      },
                                            child: AnimatedContainer(
                                              key: myKey(e, 1) ? keysPos[e] : null,
                                              constraints: BoxConstraints(maxHeight: 100),
                                              duration:
                                                  Duration(milliseconds: 200),
                                              height:  selectedPos == e ? null : 40,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    if (selectedPos == e)
                                                      for (var i = 0;
                                                      i <
                                                          positionSpra[e]['istochnik']
                                                              .length;
                                                      i++)
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                              bottom: 5.0),
                                                          child: Text(
                                                            '${positionSpra[e]['istochnik'][i]}',
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      if(selectedPos != e)
                                                      Text(
                                                          positionSpra[e]['istochnik'].length > 1
                                                              ? '${positionSpra[e]['istochnik'][0]} ...'
                                                              : '${positionSpra[e]['istochnik'][0]}',
                                                          ),
                                                    if(positionSpra[e]['istochnik'].length > 1)
                                                    Icon(selectedPos == e
                                                        ? Icons.keyboard_arrow_up
                                                        : Icons.keyboard_arrow_down),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                TableCell(
                                    child: positionSpra[e]['cel'] == null
                                        ? Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Align(
                                      alignment: Alignment.centerLeft,
                                          child: Text('-')),
                                        )
                                        : InkWell(
                                      onTap: (){
                                        setState(() {
                                          selectedPos = selectedPos == e ? -1 : e;
                                        });
                                        Timer(Duration(milliseconds: 300), () {
                                          var context = keysPos[e].currentContext;
                                          if (context == null) return;
                                          var newSize = context.size;

                                          setState(() {
                                            oldSizePos = newSize;
                                            print(oldSizePos);
                                          });
                                        });
                                      },
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: AnimatedContainer(
                                                key: myKey(e, 2) ? keysPos[e] : null,
                                                //key: positionSpra[e]['cel'].length > positionSpra[e]['istochnik'].length && positionSpra[e]['cel'].length > positionSpra[e]['business'].length ? keysPos[e] : null,
                                                constraints: BoxConstraints(maxHeight: 100),
                                                duration:
                                                Duration(milliseconds: 200),
                                                height:  selectedPos == e ? null : 40,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      if (selectedPos == e)
                                                        for (var i = 0;
                                                        i <
                                                            positionSpra[e]['cel']
                                                                .length;
                                                        i++)
                                                          Padding(
                                                            padding: const EdgeInsets.only(
                                                                bottom: 5.0),
                                                            child: Text(
                                                              '${positionSpra[e]['cel'][i]}',
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                      if(selectedPos != e)
                                                        Text(
                                                          positionSpra[e]['cel'].length > 1
                                                              ? '${positionSpra[e]['cel'][0]} ...'
                                                              : '${positionSpra[e]['cel'][0]}',
                                                        ),
                                                      if(positionSpra[e]['cel'].length > 1)
                                                      Icon(selectedPos == e
                                                          ? Icons.keyboard_arrow_up
                                                          : Icons.keyboard_arrow_down),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                        )),
                                TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: (){
                                          setState(() {
                                            selectedPos = selectedPos == e ? -1 : e;
                                          });
                                          Timer(Duration(milliseconds: 300), () {
                                            var context = keysPos[e].currentContext;
                                            if (context == null) return;
                                            var newSize = context.size;

                                            setState(() {
                                              oldSizePos = newSize;
                                            });
                                            print(oldSizePos);
                                          });
                                        },
                                        child: AnimatedContainer(
                                          key: myKey(e, 3) ? keysPos[e] : null,
                                        //  key: positionSpra[e]['business'].length > positionSpra[e]['istochnik'].length && positionSpra[e]['business'].length > positionSpra[e]['cel'].length ? keysPos[e] : null,

                                          constraints: BoxConstraints(maxHeight: 100),
                                          duration:
                                          Duration(milliseconds: 200),
                                          height:  selectedPos == e ? null : 40,
                                          child: SingleChildScrollView(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              if (selectedPos == e)
                                                for (var i = 0;
                                                    i <
                                                        positionSpra[e]['business']
                                                            .length;
                                                    i++)
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 5.0),
                                                    child: Text(
                                                      '${positionSpra[e]['business'][i]}',
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                              if (selectedPos != e)
                                                Text(
                                                  positionSpra[e]['business'].length > 1
                                                      ? '${positionSpra[e]['business'][0]} ...'
                                                      : '${positionSpra[e]['business'][0]}',
                                                ),
                                                  if(positionSpra[e]['business'].length > 1)
                                              Icon(selectedPos == e
                                                  ? Icons.keyboard_arrow_up
                                                  : Icons.keyboard_arrow_down),
                                            ]
                                                // children: [
                                                //   for (var i = 0;
                                                //       i < positionSpra[e]['business']!.length;
                                                //       i++)
                                                //     Text('${positionSpra[e]['business'][i]}'),
                                                // ],
                                                ),
                                          ),
                                        ),
                                      ),
                                    )),
                              ]),
                          ],
                        ),
                        ///Конец Таблици====================================
                        SizedBox(width: 120),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ///Иконки удаления и ренейм
                  Positioned(
                    right: 0.0,
                    child: Container(
                      color: Colors.grey.withOpacity(0.5),
                      child: Table(
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        defaultColumnWidth: FixedColumnWidth(120.0),
                        children: [
                          for (var e = 0; e < positionSpra.length; e++)
                            TableRow(children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 100),
                                    height:
                                        oldSizePos != null && selectedPos == e
                                            ? oldSizePos!.height
                                            : 40.0,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: IconButton(
                                                  onPressed: () async{
                                                    _myNewNameBiss.text = positionSpra[e]['position'];
                                                    await posRename(positionSpra[e]['position_id']);
                                                    ///Редоктирование
                                                    showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(25),
                                                            topRight: Radius.circular(25)),
                                                      ),
                                                      context: context,
                                                      builder: (BuildContext ctx) => StatefulBuilder(
                                                        builder: (BuildContext context, setState) => Stack(
                                                          children: [
                                                            SingleChildScrollView(
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors.grey[100],
                                                                    borderRadius: BorderRadius.only(
                                                                      topLeft: Radius.circular(25),
                                                                      topRight: Radius.circular(25),
                                                                    ),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors.grey.withOpacity(0.5),
                                                                          spreadRadius: 5,
                                                                          blurRadius: 7,
                                                                          offset: Offset(0, 3)),
                                                                    ]),
                                                                width: double.infinity,
                                                                height: MediaQuery.of(context).size.height * 0.95,
                                                                alignment: Alignment.center,
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      SizedBox(height: 30),
                                                                      Text(
                                                                        'Изменить позицию',
                                                                        style: TextStyle(
                                                                            fontSize: 15,
                                                                            fontWeight: FontWeight.bold,
                                                                            letterSpacing: 0.5),
                                                                      ),
                                                                      SizedBox(height: 10),
                                                                      Text(
                                                                        'Название',
                                                                        style: TextStyle(color: Colors.grey),
                                                                      ),
                                                                      SizedBox(height: 10),
                                                                      TextField(
                                                                        inputFormatters: [
                                                                          FilteringTextInputFormatter.deny(
                                                                              RegExp("[/|:\\\\]")),
                                                                        ],
                                                                        controller: _myNewNameBiss,
                                                                        decoration: InputDecoration(
                                                                            contentPadding: EdgeInsets.all(10),
                                                                            border: OutlineInputBorder()),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Icon(
                                                                                  mySwitch == false
                                                                                      ? MyIcon.circle_empty
                                                                                      : Icons.circle,
                                                                                  size: 14,
                                                                                  color: MyColors().greenDark),
                                                                              SizedBox(width: 10),
                                                                              mySwitch == false
                                                                                  ? Text('Не активно',
                                                                                  style: TextStyle(
                                                                                      color: MyColors().greenDark,
                                                                                      fontWeight:
                                                                                      FontWeight.bold))
                                                                                  : Text(
                                                                                'Активно',
                                                                                style: TextStyle(
                                                                                    color: MyColors().greenDark,
                                                                                    fontWeight:
                                                                                    FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Spacer(),
                                                                          Switch(
                                                                            activeColor: MyColors().myBeige,
                                                                            value: mySwitch == true ? true : false,
                                                                            onChanged: (val) {
                                                                              // setState(() {
                                                                              //   mySwitch = val.toString();
                                                                              // });
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(children: [
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                            border: indexAddPos == 0
                                                                                ? Border(
                                                                                bottom: BorderSide(
                                                                                  color: MyColors().greenDark,
                                                                                  width: 1.5,
                                                                                ))
                                                                                : null,
                                                                          ),
                                                                          child: TextButton(
                                                                              onPressed: () {
                                                                                indexAddPos = 0;
                                                                                setState(() {});
                                                                              },
                                                                              child: Text('Бизнес',
                                                                                  style: TextStyle(
                                                                                      color: MyColors().greenDark))),
                                                                        ),
                                                                        SizedBox(width: 20),
                                                                        Container(
                                                                            decoration: BoxDecoration(
                                                                              border: indexAddPos == 1
                                                                                  ? Border(
                                                                                  bottom: BorderSide(
                                                                                    color: MyColors().greenDark,
                                                                                    width: 1.5,
                                                                                  ))
                                                                                  : null,
                                                                            ),
                                                                            child: TextButton(
                                                                                onPressed: listIstochPrihod.isNotEmpty
                                                                                    ? () async {
                                                                                  // await positionCelIst(widget.namePos, listIstochPrihod);
                                                                                  indexAddPos = 1;
                                                                                  setState(() {});
                                                                                }
                                                                                    : null,
                                                                                child: Text('Источник',
                                                                                    style: TextStyle(
                                                                                        color: listIstochPrihod
                                                                                            .isNotEmpty
                                                                                            ? MyColors().greenDark
                                                                                            : Colors.grey)))),
                                                                        SizedBox(width: 20),
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                            border: indexAddPos == 2
                                                                                ? Border(
                                                                                bottom: BorderSide(
                                                                                  color: MyColors().greenDark,
                                                                                  width: 1.5,
                                                                                ))
                                                                                : null,
                                                                          ),
                                                                          child: TextButton(
                                                                            onPressed:
                                                                            addPosTypeMap['ist']!.isNotEmpty ||
                                                                                addCheckBoxIstNo == true
                                                                                ? () {
                                                                              indexAddPos = 2;
                                                                              setState(() {});
                                                                            }
                                                                                : null,
                                                                            child: Text('Цель',
                                                                                style: TextStyle(
                                                                                    color: addPosTypeMap['ist']!
                                                                                        .isNotEmpty ||
                                                                                        addCheckBoxIstNo == true
                                                                                        ? MyColors().greenDark
                                                                                        : Colors.grey)),
                                                                          ),
                                                                        ),
                                                                      ]),
                                                                      if (indexAddPos == 0)
                                                                        Column(
                                                                          children: [
                                                                            SizedBox(height: 10),
                                                                            Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 24,
                                                                                  height: 24,
                                                                                  child: Checkbox(
                                                                                    fillColor:
                                                                                    MaterialStateProperty.all(
                                                                                        MyColors().greenDark),
                                                                                    shape: CircleBorder(),
                                                                                    value: addCheckBoxBis,
                                                                                    onChanged: (newValue) {
                                                                                      setState(() {
                                                                                        addCheckBoxBis =
                                                                                        !addCheckBoxBis;
                                                                                      });
                                                                                      listIstochPrihod.clear();
                                                                                      for (var i = 0;
                                                                                      i < businesses[0].length;
                                                                                      i++) {
                                                                                        businesses[1][i] =
                                                                                            addCheckBoxBis;
                                                                                        if (businesses[1][i] ==
                                                                                            false) {
                                                                                          checkCount--;
                                                                                          listIstochPrihod.remove(
                                                                                              businesses[0][i]);
                                                                                        } else if (businesses[1][i] ==
                                                                                            true) {
                                                                                          checkCount++;
                                                                                          listIstochPrihod
                                                                                              .add(businesses[0][i]);
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                SizedBox(width: 10),
                                                                                Text(
                                                                                  'выбрать все',
                                                                                  style: TextStyle(
                                                                                      color: MyColors().greenDark),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(height: 10),
                                                                            Container(
                                                                              height: 260,
                                                                              child: ListView.builder(
                                                                                  itemCount: businesses.length,
                                                                                  itemBuilder: (context, index) {
                                                                                    return ButtonBisnes(
                                                                                      press: () async {
                                                                                        setState(() {
                                                                                          businesses[index]['posit_status'] =
                                                                                          !businesses[index]['posit_status'];
                                                                                          if (businesses[index]['posit_status'] ==
                                                                                              false) {
                                                                                            listIstochPrihod.remove(
                                                                                                businesses[index]['posit_status']);
                                                                                          } else if (businesses
                                                                                          [index] ==
                                                                                              true) {
                                                                                            listIstochPrihod.add(
                                                                                                businesses[index]['posit_status']);
                                                                                          }
                                                                                          print(listIstochPrihod);
                                                                                        });
                                                                                      },
                                                                                      title: businesses[index]['business'],
                                                                                      onColor: businesses[index]['posit_status'] ?? false,
                                                                                    );
                                                                                  }),
                                                                            ),
                                                                            SizedBox(height: 10.0),
                                                                            listIstochPrihod.isEmpty
                                                                                ? Text(
                                                                              'Выбирите один или несколько бизнесов',
                                                                              style: TextStyle(
                                                                                  color: MyColors().greenDark),
                                                                            )
                                                                                : Align(
                                                                              alignment: Alignment.centerRight,
                                                                              child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                    primary: MyColors().myBeige,
                                                                                    shape:
                                                                                    RoundedRectangleBorder(
                                                                                      borderRadius:
                                                                                      BorderRadius.circular(
                                                                                          20),
                                                                                    )),
                                                                                child: Text(
                                                                                  'Далее >',
                                                                                  style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight:
                                                                                      FontWeight.bold,
                                                                                      fontSize: 16,
                                                                                      letterSpacing: 1),
                                                                                ),
                                                                                onPressed: () async {
                                                                                  // await positionCelIst(widget.namePos, listIstochPrihod);
                                                                                  indexAddPos = 1;
                                                                                  setState(() {});
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      if (indexAddPos == 1)
                                                                        Column(
                                                                          children: [
                                                                            SizedBox(height: 10),
                                                                            Row(
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 24,
                                                                                      height: 24,
                                                                                      child: Checkbox(
                                                                                        fillColor:
                                                                                        MaterialStateProperty.all(
                                                                                            MyColors().greenDark),
                                                                                        shape: CircleBorder(),
                                                                                        value: addCheckBoxIst,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            addCheckBoxIst =
                                                                                            !addCheckBoxIst;
                                                                                          });
                                                                                          addPosTypeMap['ist']!
                                                                                              .clear();
                                                                                          for (var i = 0;
                                                                                          i <
                                                                                              getPostCelIst
                                                                                                  .length;
                                                                                          i++) {
                                                                                            for (var j = 0;
                                                                                            j <
                                                                                                getPostCelIst[getPostCelIst
                                                                                                    .keys
                                                                                                    .elementAt(
                                                                                                    i)]
                                                                                                [
                                                                                                'istochnik_prihoda']
                                                                                                    .length;
                                                                                            j++) {
                                                                                              getPostCelIst[getPostCelIst
                                                                                                  .keys
                                                                                                  .elementAt(
                                                                                                  i)][
                                                                                              'istochnik_prihoda']
                                                                                              [
                                                                                              j]['ist_status'] =
                                                                                                  addCheckBoxIst
                                                                                                      .toString();
                                                                                              if (getPostCelIst[getPostCelIst
                                                                                                  .keys
                                                                                                  .elementAt(
                                                                                                  i)][
                                                                                              'istochnik_prihoda'][j]
                                                                                              [
                                                                                              'ist_status'] ==
                                                                                                  'false') {
                                                                                                checkCount--;
                                                                                                addPosTypeMap['ist']!.remove(
                                                                                                    getPostCelIst[getPostCelIst
                                                                                                        .keys
                                                                                                        .elementAt(
                                                                                                        i)]
                                                                                                    [
                                                                                                    'istochnik_prihoda'][j]
                                                                                                    [
                                                                                                    'istochnik']);
                                                                                              } else if (getPostCelIst[
                                                                                              getPostCelIst
                                                                                                  .keys
                                                                                                  .elementAt(
                                                                                                  i)]['istochnik_prihoda'][j]
                                                                                              [
                                                                                              'ist_status'] ==
                                                                                                  'true') {
                                                                                                checkCount++;
                                                                                                addPosTypeMap['ist']!.add(
                                                                                                    getPostCelIst[getPostCelIst
                                                                                                        .keys
                                                                                                        .elementAt(
                                                                                                        i)]
                                                                                                    [
                                                                                                    'istochnik_prihoda'][j]
                                                                                                    [
                                                                                                    'istochnik']);
                                                                                              }
                                                                                            }
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 10),
                                                                                    Text(
                                                                                      'выбрать все',
                                                                                      style: TextStyle(
                                                                                          color:
                                                                                          MyColors().greenDark),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(width: 30),
                                                                                Row(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 24,
                                                                                      height: 24,
                                                                                      child: Checkbox(
                                                                                        fillColor:
                                                                                        MaterialStateProperty.all(
                                                                                            MyColors().greenDark),
                                                                                        shape: CircleBorder(),
                                                                                        value: addCheckBoxIstNo,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            addCheckBoxIstNo =
                                                                                            !addCheckBoxIstNo;
                                                                                          });
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 10),
                                                                                    Text(
                                                                                      'Не привязывать',
                                                                                      style: TextStyle(
                                                                                          color:
                                                                                          MyColors().greenDark),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(height: 10),
                                                                            Container(
                                                                                height: 260,
                                                                                child: SingleChildScrollView(
                                                                                  child: Column(
                                                                                    children: [
                                                                                      for (var i = 0;
                                                                                      i < getPostCelIst.length;
                                                                                      i++)
                                                                                        for (var j = 0;
                                                                                        j <
                                                                                            getPostCelIst[getPostCelIst
                                                                                                .keys
                                                                                                .elementAt(
                                                                                                i)][
                                                                                            'istochnik_prihoda']
                                                                                                .length;
                                                                                        j++)
                                                                                          ButtonBisnes(
                                                                                            press: () async {
                                                                                              setState(() {
                                                                                                if (addPosIst.contains(getPostCelIst[
                                                                                                getPostCelIst
                                                                                                    .keys
                                                                                                    .elementAt(
                                                                                                    i)]
                                                                                                [
                                                                                                'istochnik_prihoda']
                                                                                                [
                                                                                                j]['istochnik'])) {
                                                                                                  print('vova');
                                                                                                } else {
                                                                                                  getPostCelIst[getPostCelIst
                                                                                                      .keys
                                                                                                      .elementAt(
                                                                                                      i)]
                                                                                                  ['istochnik_prihoda'][j]
                                                                                                  ['ist_status'] = (getPostCelIst[getPostCelIst
                                                                                                      .keys
                                                                                                      .elementAt(
                                                                                                      i)]['istochnik_prihoda'][j]['ist_status'] !=
                                                                                                      'true')
                                                                                                      .toString();
                                                                                                  if (getPostCelIst[getPostCelIst
                                                                                                      .keys
                                                                                                      .elementAt(
                                                                                                      i)]['istochnik_prihoda'][j]
                                                                                                  [
                                                                                                  'ist_status'] ==
                                                                                                      'false') {
                                                                                                    checkCount--;
                                                                                                    addPosTypeMap[
                                                                                                    'ist']!
                                                                                                        .remove(getPostCelIst[getPostCelIst
                                                                                                        .keys
                                                                                                        .elementAt(
                                                                                                        i)]['istochnik_prihoda'][j]
                                                                                                    [
                                                                                                    'istochnik']);
                                                                                                  } else if (getPostCelIst[getPostCelIst
                                                                                                      .keys
                                                                                                      .elementAt(
                                                                                                      i)]['istochnik_prihoda'][j]
                                                                                                  [
                                                                                                  'ist_status'] ==
                                                                                                      'true') {
                                                                                                    checkCount++;
                                                                                                    addPosTypeMap[
                                                                                                    'ist']!
                                                                                                        .add(getPostCelIst[getPostCelIst
                                                                                                        .keys
                                                                                                        .elementAt(
                                                                                                        i)]['istochnik_prihoda'][j]
                                                                                                    [
                                                                                                    'istochnik']);
                                                                                                  }
                                                                                                  print(addPosTypeMap[
                                                                                                  'ist']);
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                            title: getPostCelIst[
                                                                                            getPostCelIst
                                                                                                .keys
                                                                                                .elementAt(
                                                                                                i)]
                                                                                            [
                                                                                            'istochnik_prihoda']
                                                                                            [j]['istochnik'],
                                                                                            onColor: getPostCelIst[
                                                                                            getPostCelIst
                                                                                                .keys
                                                                                                .elementAt(
                                                                                                i)]
                                                                                            [
                                                                                            'istochnik_prihoda']
                                                                                            [
                                                                                            j]['ist_status'] ==
                                                                                                'true',
                                                                                          ),
                                                                                    ],
                                                                                  ),
                                                                                )),
                                                                            SizedBox(height: 15),
                                                                            addCheckBoxIstNo == false
                                                                                ? Text(
                                                                              'Привяжите источник ',
                                                                              style: TextStyle(
                                                                                  color: MyColors().greenDark,
                                                                                  fontSize: 13),
                                                                            )
                                                                                : Align(
                                                                              alignment: Alignment.centerRight,
                                                                              child: indexAddPos != 2
                                                                                  ? ElevatedButton(
                                                                                style: ElevatedButton
                                                                                    .styleFrom(
                                                                                    primary:
                                                                                    MyColors()
                                                                                        .myBeige,
                                                                                    shape:
                                                                                    RoundedRectangleBorder(
                                                                                      borderRadius:
                                                                                      BorderRadius
                                                                                          .circular(
                                                                                          20),
                                                                                    )),
                                                                                child: Text(
                                                                                  'Далее >',
                                                                                  style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight:
                                                                                      FontWeight.bold,
                                                                                      fontSize: 16,
                                                                                      letterSpacing: 1),
                                                                                ),
                                                                                onPressed: () async {
                                                                                  // await positionCelIst(widget.namePos, listIstochPrihod);
                                                                                  indexAddPos = 2;
                                                                                  setState(() {});
                                                                                },
                                                                              )
                                                                                  : ElevatedButton(
                                                                                style: ElevatedButton
                                                                                    .styleFrom(
                                                                                    primary:
                                                                                    MyColors()
                                                                                        .myBeige,
                                                                                    shape:
                                                                                    RoundedRectangleBorder(
                                                                                      borderRadius:
                                                                                      BorderRadius
                                                                                          .circular(
                                                                                          20),
                                                                                    )),
                                                                                child: Text(
                                                                                  '< Назад',
                                                                                  style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight:
                                                                                      FontWeight.bold,
                                                                                      fontSize: 16,
                                                                                      letterSpacing: 1),
                                                                                ),
                                                                                onPressed: () async {
                                                                                  // await positionCelIst(widget.namePos, listIstochPrihod);
                                                                                  indexAddPos = 1;
                                                                                  setState(() {});
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      if (indexAddPos == 2)
                                                                        Column(
                                                                          children: [
                                                                            SizedBox(height: 10),
                                                                            Row(
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 24,
                                                                                      height: 24,
                                                                                      child: Checkbox(
                                                                                        fillColor:
                                                                                        MaterialStateProperty.all(
                                                                                            MyColors().greenDark),
                                                                                        shape: CircleBorder(),
                                                                                        value: addCheckBoxCel,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            addCheckBoxCel =
                                                                                            !addCheckBoxCel;
                                                                                          });
                                                                                          addPosTypeMap['cel']!
                                                                                              .clear();
                                                                                          for (var i = 0;
                                                                                          i <
                                                                                              getPostCelIst
                                                                                                  .length;
                                                                                          i++) {
                                                                                            for (var j = 0;
                                                                                            j <
                                                                                                getPostCelIst[getPostCelIst
                                                                                                    .keys
                                                                                                    .elementAt(
                                                                                                    i)]
                                                                                                [
                                                                                                'cel_rashoda']
                                                                                                    .length;
                                                                                            j++) {
                                                                                              getPostCelIst[getPostCelIst
                                                                                                  .keys
                                                                                                  .elementAt(
                                                                                                  i)][
                                                                                              'cel_rashoda']
                                                                                              [
                                                                                              j]['cel_status'] =
                                                                                                  addCheckBoxCel
                                                                                                      .toString();
                                                                                              if (getPostCelIst[getPostCelIst
                                                                                                  .keys
                                                                                                  .elementAt(
                                                                                                  i)][
                                                                                              'cel_rashoda'][j]
                                                                                              [
                                                                                              'cel_status'] ==
                                                                                                  'false') {
                                                                                                checkCount--;
                                                                                                addPosTypeMap['cel']!
                                                                                                    .remove(getPostCelIst[
                                                                                                getPostCelIst
                                                                                                    .keys
                                                                                                    .elementAt(
                                                                                                    i)]
                                                                                                [
                                                                                                'cel_rashoda'][j]['cel']);
                                                                                              } else if (getPostCelIst[
                                                                                              getPostCelIst
                                                                                                  .keys
                                                                                                  .elementAt(
                                                                                                  i)]['cel_rashoda'][j]
                                                                                              [
                                                                                              'cel_status'] ==
                                                                                                  'true') {
                                                                                                checkCount++;
                                                                                                addPosTypeMap['cel']!
                                                                                                    .add(getPostCelIst[
                                                                                                getPostCelIst
                                                                                                    .keys
                                                                                                    .elementAt(
                                                                                                    i)]
                                                                                                [
                                                                                                'cel_rashoda'][j]['cel']);
                                                                                              }
                                                                                            }
                                                                                          }
                                                                                          print(addPosTypeMap['cel']);
                                                                                          setState(() {});
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 10),
                                                                                    Text(
                                                                                      'выбрать все',
                                                                                      style: TextStyle(
                                                                                          color:
                                                                                          MyColors().greenDark),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(width: 30),
                                                                                Row(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 24,
                                                                                      height: 24,
                                                                                      child: Checkbox(
                                                                                        fillColor:
                                                                                        MaterialStateProperty.all(
                                                                                            addCheckBoxIstNo ==
                                                                                                false
                                                                                                ? MyColors()
                                                                                                .greenDark
                                                                                                : Colors.grey),
                                                                                        shape: CircleBorder(),
                                                                                        value: addCheckBoxCelNo,
                                                                                        onChanged:
                                                                                        addCheckBoxIstNo == false
                                                                                            ? (newValue) {
                                                                                          setState(() {
                                                                                            addCheckBoxCelNo =
                                                                                            !addCheckBoxCelNo;
                                                                                          });
                                                                                        }
                                                                                            : null,
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 10),
                                                                                    Text(
                                                                                      'Не привязывать',
                                                                                      style: TextStyle(
                                                                                          color: addCheckBoxIstNo ==
                                                                                              false
                                                                                              ? MyColors().greenDark
                                                                                              : Colors.grey),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(height: 10),
                                                                            Container(
                                                                                height: 260,
                                                                                child: SingleChildScrollView(
                                                                                  child: Column(
                                                                                    children: [
                                                                                      for (var i = 0;
                                                                                      i < getPostCelIst.length;
                                                                                      i++)
                                                                                        for (var j = 0;
                                                                                        j <
                                                                                            getPostCelIst[getPostCelIst
                                                                                                .keys
                                                                                                .elementAt(
                                                                                                i)][
                                                                                            'cel_rashoda']
                                                                                                .length;
                                                                                        j++)
                                                                                          ButtonBisnes(
                                                                                            press: () async {
                                                                                              setState(() {
                                                                                                if (addPosIst.contains(
                                                                                                    getPostCelIst[getPostCelIst
                                                                                                        .keys
                                                                                                        .elementAt(
                                                                                                        i)]
                                                                                                    [
                                                                                                    'cel_rashoda']
                                                                                                    [j]['cel'])) {
                                                                                                } else {
                                                                                                  getPostCelIst[getPostCelIst
                                                                                                      .keys
                                                                                                      .elementAt(
                                                                                                      i)]
                                                                                                  ['cel_rashoda'][j]
                                                                                                  ['cel_status'] = (getPostCelIst[getPostCelIst
                                                                                                      .keys
                                                                                                      .elementAt(
                                                                                                      i)]['cel_rashoda'][j]['cel_status'] !=
                                                                                                      'true')
                                                                                                      .toString();
                                                                                                  if (getPostCelIst[getPostCelIst
                                                                                                      .keys
                                                                                                      .elementAt(
                                                                                                      i)]['cel_rashoda'][j]
                                                                                                  [
                                                                                                  'cel_status'] ==
                                                                                                      'false') {
                                                                                                    checkCount--;
                                                                                                    addPosTypeMap[
                                                                                                    'cel']!
                                                                                                        .remove(getPostCelIst[getPostCelIst
                                                                                                        .keys
                                                                                                        .elementAt(
                                                                                                        i)]['cel_rashoda']
                                                                                                    [
                                                                                                    j]['cel']);
                                                                                                  } else if (getPostCelIst[getPostCelIst
                                                                                                      .keys
                                                                                                      .elementAt(
                                                                                                      i)]['cel_rashoda'][j]
                                                                                                  [
                                                                                                  'cel_status'] ==
                                                                                                      'true') {
                                                                                                    checkCount++;
                                                                                                    addPosTypeMap[
                                                                                                    'cel']!
                                                                                                        .add(getPostCelIst[getPostCelIst
                                                                                                        .keys
                                                                                                        .elementAt(
                                                                                                        i)]['cel_rashoda']
                                                                                                    [
                                                                                                    j]['cel']);
                                                                                                  }
                                                                                                  print(addPosTypeMap[
                                                                                                  'cel']);
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                            title: getPostCelIst[
                                                                                            getPostCelIst
                                                                                                .keys
                                                                                                .elementAt(
                                                                                                i)]
                                                                                            ['cel_rashoda'][j]
                                                                                            ['cel'],
                                                                                            onColor: getPostCelIst[
                                                                                            getPostCelIst
                                                                                                .keys
                                                                                                .elementAt(
                                                                                                i)]
                                                                                            [
                                                                                            'cel_rashoda']
                                                                                            [
                                                                                            j]['cel_status'] ==
                                                                                                'true',
                                                                                          ),
                                                                                    ],
                                                                                  ),
                                                                                )),
                                                                          ],
                                                                        ),
                                                                      if ((addPosTypeMap['ist']!.isNotEmpty ||
                                                                          addPosTypeMap['cel']!.isNotEmpty) &&
                                                                          indexAddPos == 2)
                                                                        ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                              primary: MyColors().myBeige,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius:
                                                                                BorderRadius.circular(20),
                                                                              )),
                                                                          child: Text(
                                                                            'Сохранить изменения',
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 16,
                                                                                letterSpacing: 1),
                                                                          ),
                                                                          onPressed: () async {
                                                                            // await renamePosition(
                                                                            //     widget.nameBis,
                                                                            //     prihodRashod,
                                                                            //     prihodRashod == 'prihod' ? renamePosIst : renamePosCel,
                                                                            //     renamePosType,
                                                                            //     widget.namePos,
                                                                            //     myPos.text,
                                                                            //     widget.status);
                                                                            Navigator.pop(context);
                                                                          },
                                                                        ),
                                                                      SizedBox(height: 20),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top: 5,
                                                              right: 5,
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  //businessFalse();
                                                                  Navigator.pop(context);
                                                                  listIstochPrihod.clear();
                                                                },
                                                                icon: Icon(Icons.highlight_remove),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  icon: Icon(Icons.edit,
                                                      color: MyColors()
                                                          .greenDark))),
                                          Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: IconButton(
                                                onPressed: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Container(
                                                            height: 120,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.spaceAround,
                                                              children: [
                                                                Text('Удалить позицию:'),
                                                                Text(
                                                                    '"${positionSpra[0]['positions_istochniky'][e]['positions_prihod']['istochnik_position']}"',
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold)),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.spaceAround,
                                                                  children: [
                                                                    TextButton(
                                                                        onPressed: () async {
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child: Text(
                                                                          'Удалить',
                                                                          style: TextStyle(
                                                                            color: Colors.red,
                                                                            fontSize: 17,
                                                                            fontWeight:
                                                                            FontWeight.bold,
                                                                          ),
                                                                        )),
                                                                    TextButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child: Text(
                                                                          'Отмена',
                                                                          style: TextStyle(
                                                                            color: Colors.green,
                                                                            fontSize: 17,
                                                                            fontWeight:
                                                                            FontWeight.bold,
                                                                          ),
                                                                        )),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.delete_rounded,
                                                  size: 20,
                                                  color: MyColors().greenDark,
                                                ),
                                              ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        ],
                      ),
                    ),
                  ),
                  ///========================
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          ///Кнопка добавить позицию
          InkWell(
            onTap: () {
              _myNewNameBiss.clear();
              showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                context: context,
                builder: (BuildContext ctx) => StatefulBuilder(
                  builder: (BuildContext context, setState) => Stack(
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3)),
                              ]),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.95,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(height: 30),
                                Text(
                                  'Добавить позицию',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Название',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp("[/|:\\\\]")),
                                  ],
                                  controller: _myNewNameBiss,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      border: OutlineInputBorder()),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                            mySwitch == false
                                                ? MyIcon.circle_empty
                                                : Icons.circle,
                                            size: 14,
                                            color: MyColors().greenDark),
                                        SizedBox(width: 10),
                                        mySwitch == false
                                            ? Text('Не активно',
                                                style: TextStyle(
                                                    color: MyColors().greenDark,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            : Text(
                                                'Активно',
                                                style: TextStyle(
                                                    color: MyColors().greenDark,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ],
                                    ),
                                    Spacer(),
                                    Switch(
                                      activeColor: MyColors().myBeige,
                                      value: mySwitch == true ? true : false,
                                      onChanged: (val) {
                                        // setState(() {
                                        //   mySwitch = val.toString();
                                        // });
                                      },
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: indexAddPos == 0
                                          ? Border(
                                              bottom: BorderSide(
                                              color: MyColors().greenDark,
                                              width: 1.5,
                                            ))
                                          : null,
                                    ),
                                    child: TextButton(
                                        onPressed: () {
                                          indexAddPos = 0;
                                          setState(() {});
                                        },
                                        child: Text('Бизнес',
                                            style: TextStyle(
                                                color: MyColors().greenDark))),
                                  ),
                                  SizedBox(width: 20),
                                  Container(
                                      decoration: BoxDecoration(
                                        border: indexAddPos == 1
                                            ? Border(
                                                bottom: BorderSide(
                                                color: MyColors().greenDark,
                                                width: 1.5,
                                              ))
                                            : null,
                                      ),
                                      child: TextButton(
                                          onPressed: listIstochPrihod.isNotEmpty
                                              ? () async {
                                                  // await positionCelIst(widget.namePos, listIstochPrihod);
                                                  indexAddPos = 1;
                                                  setState(() {});
                                                }
                                              : null,
                                          child: Text('Источник',
                                              style: TextStyle(
                                                  color: listIstochPrihod
                                                          .isNotEmpty
                                                      ? MyColors().greenDark
                                                      : Colors.grey)))),
                                  SizedBox(width: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: indexAddPos == 2
                                          ? Border(
                                              bottom: BorderSide(
                                              color: MyColors().greenDark,
                                              width: 1.5,
                                            ))
                                          : null,
                                    ),
                                    child: TextButton(
                                      onPressed:
                                          addPosTypeMap['ist']!.isNotEmpty ||
                                                  addCheckBoxIstNo == true
                                              ? () {
                                                  indexAddPos = 2;
                                                  setState(() {});
                                                }
                                              : null,
                                      child: Text('Цель',
                                          style: TextStyle(
                                              color: addPosTypeMap['ist']!
                                                          .isNotEmpty ||
                                                      addCheckBoxIstNo == true
                                                  ? MyColors().greenDark
                                                  : Colors.grey)),
                                    ),
                                  ),
                                ]),
                                if (indexAddPos == 0)
                                  Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Checkbox(
                                              fillColor:
                                                  MaterialStateProperty.all(
                                                      MyColors().greenDark),
                                              shape: CircleBorder(),
                                              value: addCheckBoxBis,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  addCheckBoxBis =
                                                      !addCheckBoxBis;
                                                });
                                                listIstochPrihod.clear();
                                                for (var i = 0;
                                                    i < businesses[0].length;
                                                    i++) {
                                                  businesses[1][i] =
                                                      addCheckBoxBis;
                                                  if (businesses[1][i] ==
                                                      false) {
                                                    checkCount--;
                                                    listIstochPrihod.remove(
                                                        businesses[0][i]);
                                                  } else if (businesses[1][i] ==
                                                      true) {
                                                    checkCount++;
                                                    listIstochPrihod
                                                        .add(businesses[0][i]);
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'выбрать все',
                                            style: TextStyle(
                                                color: MyColors().greenDark),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 260,
                                        child: ListView.builder(
                                            itemCount: businesses[0].length,
                                            itemBuilder: (context, index) {
                                              return ButtonBisnes(
                                                press: () async {
                                                  setState(() {
                                                    businesses[1][index] =
                                                        !businesses[1][index];
                                                    if (businesses[1][index] ==
                                                        false) {
                                                      listIstochPrihod.remove(
                                                          businesses[0][index]);
                                                    } else if (businesses[1]
                                                            [index] ==
                                                        true) {
                                                      listIstochPrihod.add(
                                                          businesses[0][index]);
                                                    }
                                                    print(listIstochPrihod);
                                                  });
                                                },
                                                title: businesses[0][index],
                                                onColor: businesses[1][index],
                                              );
                                            }),
                                      ),
                                      SizedBox(height: 10.0),
                                      listIstochPrihod.isEmpty
                                          ? Text(
                                              'Выбирите один или несколько бизнесов',
                                              style: TextStyle(
                                                  color: MyColors().greenDark),
                                            )
                                          : Align(
                                              alignment: Alignment.centerRight,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: MyColors().myBeige,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    )),
                                                child: Text(
                                                  'Далее >',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      letterSpacing: 1),
                                                ),
                                                onPressed: () async {
                                                  // await positionCelIst(widget.namePos, listIstochPrihod);
                                                  indexAddPos = 1;
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                    ],
                                  ),
                                if (indexAddPos == 1)
                                  Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: Checkbox(
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          MyColors().greenDark),
                                                  shape: CircleBorder(),
                                                  value: addCheckBoxIst,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      addCheckBoxIst =
                                                          !addCheckBoxIst;
                                                    });
                                                    addPosTypeMap['ist']!
                                                        .clear();
                                                    for (var i = 0;
                                                        i <
                                                            getPostCelIst
                                                                .length;
                                                        i++) {
                                                      for (var j = 0;
                                                          j <
                                                              getPostCelIst[getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]
                                                                      [
                                                                      'istochnik_prihoda']
                                                                  .length;
                                                          j++) {
                                                        getPostCelIst[getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)][
                                                                    'istochnik_prihoda']
                                                                [
                                                                j]['ist_status'] =
                                                            addCheckBoxIst
                                                                .toString();
                                                        if (getPostCelIst[getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)][
                                                                    'istochnik_prihoda'][j]
                                                                [
                                                                'ist_status'] ==
                                                            'false') {
                                                          checkCount--;
                                                          addPosTypeMap['ist']!.remove(
                                                              getPostCelIst[getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]
                                                                      [
                                                                      'istochnik_prihoda'][j]
                                                                  [
                                                                  'istochnik']);
                                                        } else if (getPostCelIst[
                                                                    getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]['istochnik_prihoda'][j]
                                                                [
                                                                'ist_status'] ==
                                                            'true') {
                                                          checkCount++;
                                                          addPosTypeMap['ist']!.add(
                                                              getPostCelIst[getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]
                                                                      [
                                                                      'istochnik_prihoda'][j]
                                                                  [
                                                                  'istochnik']);
                                                        }
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'выбрать все',
                                                style: TextStyle(
                                                    color:
                                                        MyColors().greenDark),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 30),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: Checkbox(
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          MyColors().greenDark),
                                                  shape: CircleBorder(),
                                                  value: addCheckBoxIstNo,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      addCheckBoxIstNo =
                                                          !addCheckBoxIstNo;
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Не привязывать',
                                                style: TextStyle(
                                                    color:
                                                        MyColors().greenDark),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          height: 260,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                for (var i = 0;
                                                    i < getPostCelIst.length;
                                                    i++)
                                                  for (var j = 0;
                                                      j <
                                                          getPostCelIst[getPostCelIst
                                                                      .keys
                                                                      .elementAt(
                                                                          i)][
                                                                  'istochnik_prihoda']
                                                              .length;
                                                      j++)
                                                    ButtonBisnes(
                                                      press: () async {
                                                        setState(() {
                                                          if (addPosIst.contains(getPostCelIst[
                                                                      getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]
                                                                  [
                                                                  'istochnik_prihoda']
                                                              [
                                                              j]['istochnik'])) {
                                                            print('vova');
                                                          } else {
                                                            getPostCelIst[getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]
                                                                    ['istochnik_prihoda'][j]
                                                                ['ist_status'] = (getPostCelIst[getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]['istochnik_prihoda'][j]['ist_status'] !=
                                                                    'true')
                                                                .toString();
                                                            if (getPostCelIst[getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]['istochnik_prihoda'][j]
                                                                    [
                                                                    'ist_status'] ==
                                                                'false') {
                                                              checkCount--;
                                                              addPosTypeMap[
                                                                      'ist']!
                                                                  .remove(getPostCelIst[getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]['istochnik_prihoda'][j]
                                                                      [
                                                                      'istochnik']);
                                                            } else if (getPostCelIst[getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]['istochnik_prihoda'][j]
                                                                    [
                                                                    'ist_status'] ==
                                                                'true') {
                                                              checkCount++;
                                                              addPosTypeMap[
                                                                      'ist']!
                                                                  .add(getPostCelIst[getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]['istochnik_prihoda'][j]
                                                                      [
                                                                      'istochnik']);
                                                            }
                                                            print(addPosTypeMap[
                                                                'ist']);
                                                          }
                                                        });
                                                      },
                                                      title: getPostCelIst[
                                                                  getPostCelIst
                                                                      .keys
                                                                      .elementAt(
                                                                          i)]
                                                              [
                                                              'istochnik_prihoda']
                                                          [j]['istochnik'],
                                                      onColor: getPostCelIst[
                                                                      getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]
                                                                  [
                                                                  'istochnik_prihoda']
                                                              [
                                                              j]['ist_status'] ==
                                                          'true',
                                                    ),
                                              ],
                                            ),
                                          )),
                                      SizedBox(height: 15),
                                      addCheckBoxIstNo == false
                                          ? Text(
                                              'Привяжите источник ',
                                              style: TextStyle(
                                                  color: MyColors().greenDark,
                                                  fontSize: 13),
                                            )
                                          : Align(
                                              alignment: Alignment.centerRight,
                                              child: indexAddPos != 2
                                                  ? ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  MyColors()
                                                                      .myBeige,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              )),
                                                      child: Text(
                                                        'Далее >',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            letterSpacing: 1),
                                                      ),
                                                      onPressed: () async {
                                                        // await positionCelIst(widget.namePos, listIstochPrihod);
                                                        indexAddPos = 2;
                                                        setState(() {});
                                                      },
                                                    )
                                                  : ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  MyColors()
                                                                      .myBeige,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              )),
                                                      child: Text(
                                                        '< Назад',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            letterSpacing: 1),
                                                      ),
                                                      onPressed: () async {
                                                        // await positionCelIst(widget.namePos, listIstochPrihod);
                                                        indexAddPos = 1;
                                                        setState(() {});
                                                      },
                                                    ),
                                            ),
                                    ],
                                  ),
                                if (indexAddPos == 2)
                                  Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: Checkbox(
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          MyColors().greenDark),
                                                  shape: CircleBorder(),
                                                  value: addCheckBoxCel,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      addCheckBoxCel =
                                                          !addCheckBoxCel;
                                                    });
                                                    addPosTypeMap['cel']!
                                                        .clear();
                                                    for (var i = 0;
                                                        i <
                                                            getPostCelIst
                                                                .length;
                                                        i++) {
                                                      for (var j = 0;
                                                          j <
                                                              getPostCelIst[getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]
                                                                      [
                                                                      'cel_rashoda']
                                                                  .length;
                                                          j++) {
                                                        getPostCelIst[getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)][
                                                                    'cel_rashoda']
                                                                [
                                                                j]['cel_status'] =
                                                            addCheckBoxCel
                                                                .toString();
                                                        if (getPostCelIst[getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)][
                                                                    'cel_rashoda'][j]
                                                                [
                                                                'cel_status'] ==
                                                            'false') {
                                                          checkCount--;
                                                          addPosTypeMap['cel']!
                                                              .remove(getPostCelIst[
                                                                      getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]
                                                                  [
                                                                  'cel_rashoda'][j]['cel']);
                                                        } else if (getPostCelIst[
                                                                    getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]['cel_rashoda'][j]
                                                                [
                                                                'cel_status'] ==
                                                            'true') {
                                                          checkCount++;
                                                          addPosTypeMap['cel']!
                                                              .add(getPostCelIst[
                                                                      getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]
                                                                  [
                                                                  'cel_rashoda'][j]['cel']);
                                                        }
                                                      }
                                                    }
                                                    print(addPosTypeMap['cel']);
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'выбрать все',
                                                style: TextStyle(
                                                    color:
                                                        MyColors().greenDark),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 30),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: Checkbox(
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          addCheckBoxIstNo ==
                                                                  false
                                                              ? MyColors()
                                                                  .greenDark
                                                              : Colors.grey),
                                                  shape: CircleBorder(),
                                                  value: addCheckBoxCelNo,
                                                  onChanged:
                                                      addCheckBoxIstNo == false
                                                          ? (newValue) {
                                                              setState(() {
                                                                addCheckBoxCelNo =
                                                                    !addCheckBoxCelNo;
                                                              });
                                                            }
                                                          : null,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Не привязывать',
                                                style: TextStyle(
                                                    color: addCheckBoxIstNo ==
                                                            false
                                                        ? MyColors().greenDark
                                                        : Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          height: 260,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                for (var i = 0;
                                                    i < getPostCelIst.length;
                                                    i++)
                                                  for (var j = 0;
                                                      j <
                                                          getPostCelIst[getPostCelIst
                                                                      .keys
                                                                      .elementAt(
                                                                          i)][
                                                                  'cel_rashoda']
                                                              .length;
                                                      j++)
                                                    ButtonBisnes(
                                                      press: () async {
                                                        setState(() {
                                                          if (addPosIst.contains(
                                                              getPostCelIst[getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]
                                                                      [
                                                                      'cel_rashoda']
                                                                  [j]['cel'])) {
                                                          } else {
                                                            getPostCelIst[getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]
                                                                    ['cel_rashoda'][j]
                                                                ['cel_status'] = (getPostCelIst[getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]['cel_rashoda'][j]['cel_status'] !=
                                                                    'true')
                                                                .toString();
                                                            if (getPostCelIst[getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]['cel_rashoda'][j]
                                                                    [
                                                                    'cel_status'] ==
                                                                'false') {
                                                              checkCount--;
                                                              addPosTypeMap[
                                                                      'cel']!
                                                                  .remove(getPostCelIst[getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]['cel_rashoda']
                                                                      [
                                                                      j]['cel']);
                                                            } else if (getPostCelIst[getPostCelIst
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]['cel_rashoda'][j]
                                                                    [
                                                                    'cel_status'] ==
                                                                'true') {
                                                              checkCount++;
                                                              addPosTypeMap[
                                                                      'cel']!
                                                                  .add(getPostCelIst[getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]['cel_rashoda']
                                                                      [
                                                                      j]['cel']);
                                                            }
                                                            print(addPosTypeMap[
                                                                'cel']);
                                                          }
                                                        });
                                                      },
                                                      title: getPostCelIst[
                                                                  getPostCelIst
                                                                      .keys
                                                                      .elementAt(
                                                                          i)]
                                                              ['cel_rashoda'][j]
                                                          ['cel'],
                                                      onColor: getPostCelIst[
                                                                      getPostCelIst
                                                                          .keys
                                                                          .elementAt(
                                                                              i)]
                                                                  [
                                                                  'cel_rashoda']
                                                              [
                                                              j]['cel_status'] ==
                                                          'true',
                                                    ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                if ((addPosTypeMap['ist']!.isNotEmpty ||
                                        addPosTypeMap['cel']!.isNotEmpty) &&
                                    indexAddPos == 2)
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: MyColors().myBeige,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        )),
                                    child: Text(
                                      'Сохранить изменения',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 1),
                                    ),
                                    onPressed: () async {
                                      // await renamePosition(
                                      //     widget.nameBis,
                                      //     prihodRashod,
                                      //     prihodRashod == 'prihod' ? renamePosIst : renamePosCel,
                                      //     renamePosType,
                                      //     widget.namePos,
                                      //     myPos.text,
                                      //     widget.status);
                                      Navigator.pop(context);
                                    },
                                  ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: IconButton(
                          onPressed: () {
                            //businessFalse();
                            Navigator.pop(context);
                            listIstochPrihod.clear();
                          },
                          icon: Icon(Icons.highlight_remove),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0.5, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.library_add,
                    color: MyColors().greenDark,
                  ),
                  SizedBox(width: 10),
                  Text('Позицию'),
                ],
              ),
            ),
          ),
          ///========================
        ],
      ),
    );
  }
}
