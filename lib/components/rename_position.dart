import 'dart:convert';
import 'package:counting_room/pages/filter_page.dart';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global.dart';
import 'package:counting_room/resurs/global_function.dart';
import 'package:counting_room/resurs/global_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../my_icon_icons.dart';
import 'my_button_lite.dart';
import 'package:http/http.dart' as http;

class RenamePosition extends StatefulWidget {
  RenamePosition({Key? key, required this.status, required this.nameBis, required this.namePos})
      : super(key: key);

  String status;
  String nameBis;
  String namePos;

  @override
  State<RenamePosition> createState() => _RenamePositionState();
}

TextEditingController myPos = TextEditingController();



class _RenamePositionState extends State<RenamePosition> {
  renamePosition(String nameBis, String myType, var typeName, var newTypeName, String namePos,
      String newNamePos, String status) async {
    var response = await http.post(Uri.parse("http://$adress:$myPort/position_rename"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: json.encode(
          {
            'bussinesses_name': nameBis,
            'type': myType,
            "type_name": typeName,
            "new_type_name": newTypeName,
            'name': namePos,
            'new_name': newNamePos,
            'status': status,
          },
        ));
    var vovas = jsonDecode(response.body);
    positionSpra = vovas;
    print(positionSpra);
  }

  var renamePosTypeMap = {
    'ist': [],
    'cel': [],
  };
  var renamePosCel = [];
  var renamePosIst = [];

  ///Чек бокс позиций бизнес
  var checkBoxBis = false;
  ///Чек бокс позиций источник
  var checkBoxIst = false;
  ///Чек бокс позиций источник не привязывать
  var checkBoxIstNo = false;
  ///Чек бокс позиций цель
  var checkBoxCel = false;
  ///Чек бокс позиций цель не привязывать
  var checkBoxCelNo = false;

  // bool onPressType = true;

  @override
  void initState() {
    // addListRename();
    // TODO: implement initState
    super.initState();
  }

  addListRename() {
    for (var i = 0; i < getPostCelIst[0].length; i++) {
      if (getPostCelIst[0][i]['ist_status'] == 'true') {
        renamePosIst.add(getPostCelIst[0][i]['istochnik']);
      }
    }
    print(renamePosIst);
    for (var j = 0; j < getPostCelIst[1].length; j++) {
      if (getPostCelIst[1][j]['cel_status'] == 'true') {
        renamePosCel.add(getPostCelIst[1][j]['cel']);
      }
    }
  }

  int indexRename = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            height: MediaQuery.of(context).size.height * 0.88,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Редактировать позицию',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  ),
                  Text(
                    'Название',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp("[/|:\\\\]")),
                    ],
                    controller: myPos,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10), border: OutlineInputBorder()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(widget.status == 'false' ? MyIcon.circle_empty : Icons.circle,
                              size: 14, color: MyColors().greenDark),
                          SizedBox(width: 10),
                          widget.status == 'false'
                              ? Text('Не активно',
                                  style: TextStyle(
                                      color: MyColors().greenDark, fontWeight: FontWeight.bold))
                              : Text(
                                  'Активно',
                                  style: TextStyle(
                                      color: MyColors().greenDark, fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                      Spacer(),
                      Switch(
                        activeColor: MyColors().myBeige,
                        value: widget.status == 'true' ? true : false,
                        onChanged: (val) {
                          setState(() {
                            widget.status = val.toString();
                          });
                        },
                      ),
                    ],
                  ),
                  Row(children: [
                    Container(
                      decoration: BoxDecoration(
                        border: indexRename == 0
                            ? Border(
                                bottom: BorderSide(
                                color: MyColors().greenDark,
                                width: 1.5,
                              ))
                            : null,
                      ),
                      child: TextButton(
                        onPressed: (){
                          indexRename = 0;
                          setState(() {});
                        },child: Text('Бизнес',
                          style: TextStyle(
                              color: MyColors().greenDark))),
                    ),
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        border: indexRename == 1
                            ? Border(
                                bottom: BorderSide(
                                color: MyColors().greenDark,
                                width: 1.5,
                              ))
                            : null,
                      ),
                      child: TextButton(onPressed:listIstochPrihod.isNotEmpty ? ()async{
                        await positionCelIst(widget.namePos, listIstochPrihod);
                        indexRename = 1;

                        setState(() {});
                      }: null,
                          child:  Text('Источник',
                          style: TextStyle(
                              color: listIstochPrihod.isNotEmpty ? MyColors().greenDark : Colors.grey)))
                    ),
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        border: indexRename == 2
                            ? Border(
                                bottom: BorderSide(
                                color: MyColors().greenDark,
                                width: 1.5,
                              ))
                            : null,
                      ),
                      child: TextButton(
                        onPressed: renamePosTypeMap['ist']!.isNotEmpty || checkBoxIstNo == true? (){
                          indexRename = 2;
                          setState(() {});
                        }: null,
                        child: Text('Цель',
                          style: TextStyle(
                              color: renamePosTypeMap['ist']!.isNotEmpty || checkBoxIstNo == true ? MyColors().greenDark : Colors.grey)),
                      ),
                    ),
                  ]),
                  if (indexRename == 0)
                    Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.all(MyColors().greenDark),
                                shape: CircleBorder(),
                                value: checkBoxBis,
                                onChanged: (newValue) {
                                  setState(() {
                                    checkBoxBis = !checkBoxBis;
                                  });
                                  listIstochPrihod.clear();
                                  for (var i = 0; i < businesses[0].length; i++) {
                                    businesses[1][i] = checkBoxBis;
                                    if (businesses[1][i] == false) {
                                      checkCount--;
                                      listIstochPrihod.remove(businesses[0][i]);
                                    } else if (businesses[1][i] == true) {
                                      checkCount++;
                                      listIstochPrihod.add(businesses[0][i]);
                                    }
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'выбрать все',
                              style: TextStyle(color: MyColors().greenDark),
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
                                      businesses[1][index] = !businesses[1][index];
                                      if (businesses[1][index] == false) {
                                        listIstochPrihod.remove(businesses[0][index]);
                                      } else if (businesses[1][index] == true) {
                                        listIstochPrihod.add(businesses[0][index]);
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
                            ? Text('Выбирите один или несколько бизнесов', style: TextStyle(color: MyColors().greenDark),)
                            : Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: MyColors().myBeige,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      )),
                                  child: Text(
                                    'Далее >',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        letterSpacing: 1),
                                  ),
                                  onPressed: () async {
                                    await positionCelIst(widget.namePos, listIstochPrihod);
                                    indexRename = 1;
                                    setState(() {});
                                  },
                                ),
                              ),
                      ],
                    ),
                  if (indexRename == 1)
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
                                    fillColor: MaterialStateProperty.all(MyColors().greenDark),
                                    shape: CircleBorder(),
                                    value: checkBoxIst,
                                    onChanged: (newValue) {
                                      setState(() {
                                        checkBoxIst = !checkBoxIst;
                                      });
                                      renamePosTypeMap['ist']!.clear();
                                      for (var i = 0; i < getPostCelIst.length; i++) {
                                        for (var j = 0;
                                            j <
                                                getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                        ['istochnik_prihoda']
                                                    .length;
                                            j++) {
                                          getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                          ['istochnik_prihoda'][j]['ist_status'] = checkBoxIst.toString();
                                          if (getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                  ['istochnik_prihoda'][j]['ist_status'] ==
                                              'false') {
                                            checkCount--;
                                            renamePosTypeMap['ist']!.remove(
                                                getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                    ['istochnik_prihoda'][j]['istochnik']);
                                          } else if (getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                  ['istochnik_prihoda'][j]['ist_status'] ==
                                              'true') {
                                            checkCount++;
                                            renamePosTypeMap['ist']!.add(
                                                getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                    ['istochnik_prihoda'][j]['istochnik']);
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'выбрать все',
                                  style: TextStyle(color: MyColors().greenDark),
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
                                    fillColor: MaterialStateProperty.all(MyColors().greenDark),
                                    shape: CircleBorder(),
                                    value: checkBoxIstNo,
                                    onChanged: (newValue) {
                                      setState(() {
                                        checkBoxIstNo = !checkBoxIstNo;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Не привязывать',
                                  style: TextStyle(color: MyColors().greenDark),
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
                                  for (var i = 0; i < getPostCelIst.length; i++)
                                    for (var j = 0;
                                        j < getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                    ['istochnik_prihoda'].length; j++)
                                      ButtonBisnes(
                                        press: () async {
                                          setState(() {
                                            if (renamePosIst.contains(
                                                getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                    ['istochnik_prihoda'][j]['istochnik'])) {
                                              print('vova');
                                            } else {
                                              getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                      ['istochnik_prihoda'][j]['ist_status'] =
                                                  (getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                              ['istochnik_prihoda'][j]['ist_status'] !=
                                                          'true')
                                                      .toString();
                                              if (getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                      ['istochnik_prihoda'][j]['ist_status'] ==
                                                  'false') {
                                                checkCount--;
                                                renamePosTypeMap['ist']!.remove(
                                                    getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                        ['istochnik_prihoda'][j]['istochnik']);
                                              } else if (getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                      ['istochnik_prihoda'][j]['ist_status'] ==
                                                  'true') {
                                                checkCount++;
                                                renamePosTypeMap['ist']!.add(
                                                    getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                        ['istochnik_prihoda'][j]['istochnik']);
                                              }
                                              print(renamePosTypeMap['ist']);
                                            }
                                          });
                                        },
                                        title: getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                            ['istochnik_prihoda'][j]['istochnik'],
                                        onColor: getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                ['istochnik_prihoda'][j]['ist_status'] ==
                                            'true',
                                      ),
                                ],
                              ),
                            )),
                        SizedBox(height: 15),
                        checkBoxIstNo == false
                            ? Text('Привяжите источник ', style: TextStyle(color: MyColors().greenDark, fontSize: 13),)
                            : Align(
                          alignment: Alignment.centerRight,
                          child: indexRename != 2
                              ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: MyColors().myBeige,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            child: Text(
                              'Далее >',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1),
                            ),
                            onPressed: () async {
                              await positionCelIst(widget.namePos, listIstochPrihod);
                              indexRename = 2;
                              setState(() {});
                            },
                          )
                              : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: MyColors().myBeige,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            child: Text(
                              '< Назад',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1),
                            ),
                            onPressed: () async {
                              await positionCelIst(widget.namePos, listIstochPrihod);
                              indexRename = 1;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  if (indexRename == 2)
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
                                    fillColor: MaterialStateProperty.all(MyColors().greenDark),
                                    shape: CircleBorder(),
                                    value: checkBoxCel,
                                    onChanged: (newValue) {
                                      setState(() {
                                        checkBoxCel = !checkBoxCel;
                                      });
                                      renamePosTypeMap['cel']!.clear();
                                      for (var i = 0; i < getPostCelIst.length; i++) {
                                        for (var j = 0;
                                        j <
                                            getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                            ['cel_rashoda']
                                                .length;
                                        j++) {
                                          getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                          ['cel_rashoda'][j]['cel_status'] = checkBoxCel.toString();
                                          if (getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                          ['cel_rashoda'][j]['cel_status'] ==
                                              'false') {
                                            checkCount--;
                                            renamePosTypeMap['cel']!.remove(
                                                getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                ['cel_rashoda'][j]['cel']);
                                          } else if (getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                          ['cel_rashoda'][j]['cel_status'] ==
                                              'true') {
                                            checkCount++;
                                            renamePosTypeMap['cel']!.add(
                                                getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                ['cel_rashoda'][j]['cel']);
                                          }
                                        }
                                      }
                                      print(renamePosTypeMap['cel']);
                                      setState(() {

                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'выбрать все',
                                  style: TextStyle(color: MyColors().greenDark),
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
                                    fillColor: MaterialStateProperty.all(checkBoxIstNo == false ? MyColors().greenDark : Colors.grey),
                                    shape: CircleBorder(),
                                    value: checkBoxCelNo,
                                    onChanged: checkBoxIstNo == false ? (newValue) {
                                      setState(() {
                                        checkBoxCelNo = !checkBoxCelNo;
                                      });
                                    } : null,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Не привязывать',
                                  style: TextStyle(color: checkBoxIstNo == false ? MyColors().greenDark : Colors.grey),
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
                                  for (var i = 0; i < getPostCelIst.length; i++)
                                    for (var j = 0;
                                        j <
                                            getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                    ['cel_rashoda']
                                                .length;
                                        j++)
                                      ButtonBisnes(
                                        press: () async {
                                          setState(() {
                                            if (renamePosIst.contains(
                                                getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                    ['cel_rashoda'][j]['cel'])) {
                                            } else {
                                              getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                      ['cel_rashoda'][j]['cel_status'] =
                                                  (getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                              ['cel_rashoda'][j]['cel_status'] !=
                                                          'true')
                                                      .toString();
                                              if (getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                      ['cel_rashoda'][j]['cel_status'] ==
                                                  'false') {
                                                checkCount--;
                                                renamePosTypeMap['cel']!.remove(
                                                    getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                        ['cel_rashoda'][j]['cel']);
                                              } else if (getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                      ['cel_rashoda'][j]['cel_status'] ==
                                                  'true') {
                                                checkCount++;
                                                renamePosTypeMap['cel']!.add(
                                                    getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                        ['cel_rashoda'][j]['cel']);
                                              }
                                              print(renamePosTypeMap['cel']);
                                            }
                                          });
                                        },
                                        title: getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                            ['cel_rashoda'][j]['cel'],
                                        onColor: getPostCelIst[getPostCelIst.keys.elementAt(i)]
                                                ['cel_rashoda'][j]['cel_status'] ==
                                            'true',
                                      ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  if ((renamePosTypeMap['ist']!.isNotEmpty || renamePosTypeMap['cel']!.isNotEmpty) && indexRename == 2)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: MyColors().myBeige,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
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
    );
  }
}
