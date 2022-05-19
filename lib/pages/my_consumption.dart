import 'package:counting_room/components/my_button_lite.dart';
import 'package:counting_room/components/scroll_list.dart';
import 'package:counting_room/resurs/global.dart';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global_list.dart';
import 'package:flutter/material.dart';
import '../components/add_business.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../resurs/global_function.dart';

///РАСХОД

class MyConsumption extends StatefulWidget {
  const MyConsumption({Key? key}) : super(key: key);

  @override
  _MyConsumptionState createState() => _MyConsumptionState();
}

///Функция Расхода добавление цель
addCell(String newCell) async {
  var response = await http.post(Uri.parse("http://$adress:$myPort/add_cel"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'businesses': myScrollList[0],
          'cel': newCell,
        },
      ));
  var vovas = jsonDecode(response.body);
  source = vovas;
  print(source);
}

///Функция Расхода добавление позиции
addPos(String newPosl) async {
  var response = await http.post(Uri.parse("http://$adress:$myPort/add_position_cel"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'businesses': myScrollList[0],
          'cel_rashoda': myScrollList[1],
          'position': newPosl,
        },
      ));
  var vovas = jsonDecode(response.body);
  position = vovas;
  print(position);
}

class _MyConsumptionState extends State<MyConsumption> {
  TextEditingController _sum = TextEditingController();

  consumptionMyPosition() async {
    var response = await http.post(Uri.parse("http://$adress:$myPort/rashod_position"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: json.encode(
          {
            'businesses': myScrollList[0],
            'cel_rashoda': myScrollList[1],
          },
        ));
    var vovasTwo = jsonDecode(response.body);
    position = vovasTwo;
    print(position);
  }

  consumptionMySum() async {
    var response = await http.post(Uri.parse("http://$adress:$myPort/rashod_enter"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: json.encode(
          {
            'id': '${myId['id']}',
            'sum': int.parse(_sum.text),
            'time': '${DateTime.now()}',
            'businesses': myScrollList[0],
            'cel_rashoda': myScrollList[1],
            'position': myScrollList[2],
          },
        ));
    var vov = jsonDecode(response.body);
    myId = vov[0];
    myGet = vov[1];
    print(myGet);
  }

  nextButton(List list) {
    if (_sum.text.isNotEmpty && list[1].contains(true)) {
      listIndex += 1;
      if (listIndex == 1) {
        nameButton = 'Цель Расхода';
      } else if (listIndex == 2) {
        nameButton = 'Позицию';
      }
      return true;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Заполните, и выберите все поля!')));
      return false;
    }
  }

  ///===================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(113, 35),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    primary: MyColors().myBeige,
                    onPrimary: MyColors().myWhite,
                  ),
                  onPressed: () {
                    setState(() {
                      if (listIndex != 0) {
                        listIndex -= 1;
                      } else {
                        Navigator.pop(context);
                        myScrollList.clear();
                      }
                      if (listIndex == 0) {
                        nameButton = 'Бизнес';
                      } else if (listIndex == 1) {
                        nameButton = 'Цель расхода';
                      }
                    });
                    // Navigator.pop(context);
                  },
                  child: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chevron_left_sharp),
                        Text(
                          'Назад',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Внести расход',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700, color: MyColors().greenDark),
                ),
                SizedBox(height: 8),
                Text(
                  'Сумма',
                  style: TextStyle(color: MyColors().greenDark),
                ),
                SizedBox(height: 4),
                TextField(
                  controller: _sum,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    suffixIcon: Image.asset('assets/1.png'),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                if (myScrollList.isNotEmpty)
                  Container(
                    height: 34,
                    child: ListView.builder(
                        itemCount: myScrollList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ScrollList(
                            myListText: myScrollList[index],
                            myIcons: Icons.check,
                          );
                        }),
                  ),

                SizedBox(height: 14),
                Row(
                  children: [
                    ///Бизнес
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                          border: listIndex == 0
                              ? Border(
                                  bottom: BorderSide(
                                  color: MyColors().greenDark,
                                  width: 1.5,
                                ))
                              : null),
                      child: Text(
                        'Бизнес',
                        style: TextStyle(color: listIndex == 0 ? MyColors().greenDark : Colors.grey),
                      ),
                    ),
                    SizedBox(width: 35),

                    ///Цель
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                          border: listIndex == 1
                              ? Border(
                                  bottom: BorderSide(
                                  color: MyColors().greenDark,
                                  width: 1.5,
                                ))
                              : null),
                      child: Text(
                        'Цель',
                        style: TextStyle(color: listIndex == 1 ? MyColors().greenDark : Colors.grey),
                      ),
                    ),
                    SizedBox(width: 35),

                    ///позиция
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                          border: listIndex == 2
                              ? Border(
                                  bottom: BorderSide(
                                  color: MyColors().greenDark,
                                  width: 1.5,
                                ))
                              : null),
                      child: Text(
                        'Позиция',
                        style: TextStyle(color: listIndex == 2 ? MyColors().greenDark : Colors.grey),
                      ),
                    ),
                  ],
                ),

                ///Список Бизнесов
                if (listIndex == 0)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 260,
                    child: ListView.builder(
                        itemCount: businesses[0].length,
                        itemBuilder: (context, index) {
                          return ButtonBisnes(
                            press: () async {
                              if (businesses[1].contains(true)) {
                                businesses[1][businesses[1].indexOf(true)] = false;
                              }
                              setState(() {
                                if (myScrollList.length > 0) {
                                  myScrollList[0] = businesses[0][index];
                                } else {
                                  myScrollList.add(businesses[0][index]);
                                }
                                businesses[1][index] = true;
                              });
                            },
                            title: businesses[0][index],
                            onColor: businesses[1][index],
                          );
                        }),
                  ),
                if (listIndex == 1)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 260,
                    child: ListView.builder(
                        itemCount: source[0].length,
                        itemBuilder: (context, index) {
                          return ButtonBisnes(
                            press: () {
                              if (source[1].contains(true)) {
                                source[1][source[1].indexOf(true)] = false;
                              }
                              setState(() {
                                if (myScrollList.length > 1) {
                                  myScrollList[1] = source[0][index];
                                } else {
                                  myScrollList.add(source[0][index]);
                                }
                                source[1][index] = true;
                              });
                            },
                            title: source[0][index],
                            onColor: source[1][index],
                          );
                        }),
                  ),
                if (listIndex == 2)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 260,
                    child: ListView.builder(
                        itemCount: position[0].length,
                        itemBuilder: (context, index) {
                          return ButtonBisnes(
                            press: () {
                              if (position[1].contains(true)) {
                                position[1][position[1].indexOf(true)] = false;
                              }
                              setState(() {
                                if (myScrollList.length > 2) {
                                  myScrollList[2] = position[0][index];
                                } else {
                                  myScrollList.add(position[0][index]);
                                }
                                position[1][index] = true;
                              });
                            },
                            title: position[0][index],
                            onColor: position[1][index],
                          );
                        }),
                  ),
                SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                        ),
                        context: context,
                        builder: (BuildContext ctx) {
                          if (listIndex == 0) {
                            return AddBusiness(
                              text: 'Добавить бизнес в список',
                              textTwo: 'Добавить бизнес',
                              myList: businesses,
                              clickSwitch: false,
                              addFunction: addBusinesses,
                            );
                          } else if (listIndex == 1) {
                            return AddBusiness(
                              text: 'Добавить цель расхода в список',
                              textTwo: 'Добавить цель расхода',
                              myList: purpose,
                              clickSwitch: true,
                              addFunction: addCell,
                            );
                          } else {
                            return AddBusiness(
                              text: 'Добавить позицию в список',
                              textTwo: 'Добавить позицию',
                              myList: position,
                              clickSwitch: true,
                              addFunction: addPos,
                            );
                          }
                        }).then((value) => setState(() {}));
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
                        Text(nameButton),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                if (listIndex != 2)
                  Row(
                    children: [
                      Spacer(),

                      ///Кнопка Далее
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(113, 35),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          primary: MyColors().myBeige,
                          onPrimary: MyColors().myWhite,
                        ),
                        onPressed: () async {
                          if (listIndex == 0) {
                            if (nextButton(businesses)) {
                              await consumptionMySource(myScrollList[0]);
                            }
                          } else if (listIndex == 1) {
                            if (nextButton(source)) {
                              await consumptionMyPosition();
                            }
                          }
                          setState(() {});
                        },
                        child: Container(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Далее',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              Icon(Icons.chevron_right_sharp),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        bottomSheet: listIndex == 2
            ? BottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ),
                backgroundColor: MyColors().myBeige,
                onClosing: () {
                  // Do something
                },
                builder: (BuildContext ctx) => Container(
                      width: double.infinity,
                      height: 48,
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Text(
                          'Внести расход ${_sum.text} р.',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1),
                        ),
                        onPressed: () async {
                          if (_sum.text.isNotEmpty && position[1].contains(true)) {
                            await consumptionMySum();
                            balance = myId['balance'].toString();
                            money = myId['money'].toString();
                            myMoney = myId['my_money'].toString();
                            listIndex = 0;
                            myBoolGet = true;
                            Navigator.pop(context);
                            myScrollList.clear();
                          }
                          setState(() {});
                        },
                      ),
                    ))
            : null,
      ),
    );
  }
}
