import 'dart:convert';
import 'package:counting_room/components/my_button_lite.dart';
import 'package:counting_room/components/scroll_list.dart';
import 'package:counting_room/resurs/global.dart';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global_function.dart';
import 'package:counting_room/resurs/global_list.dart';
import 'package:flutter/material.dart';
import '../components/add_business.dart';
import 'package:http/http.dart' as http;

///ПРИХОД

class MyComing extends StatefulWidget {
  const MyComing({Key? key}) : super(key: key);

  @override
  _MyComingState createState() => _MyComingState();
}

class _MyComingState extends State<MyComing> {
  TextEditingController _sum = TextEditingController();

  ///Функции Прихода
  createSource(String businesses) async {
    var response = await http.post(Uri.parse("http://$adress:$myPort/prihod_istochnik"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: json.encode(
          {
            'businesses': businesses,
          },
        ));
    var vovas = jsonDecode(response.body);
    source = vovas;
    print(source);
  }



  ///Функция Прихода добавление источника
  addIstochnik(String newIstochnik) async {
    var response = await http.post(Uri.parse("http://$adress:$myPort/add_istochnik"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: json.encode(
          {
            'businesses': myScrollList[0],
            'istochnik': newIstochnik,
          },
        ));
    var vovas = jsonDecode(response.body);
    source = vovas;
    print(source);
  }

  createPosition(String businesses, String istochnik_prihoda) async {
    var response = await http.post(Uri.parse("http://$adress:$myPort/prihod_position"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: json.encode(
          {
            'businesses': businesses,
            'istochnik_prihoda': istochnik_prihoda,
          },
        ));
    var vovasTwo = jsonDecode(response.body);
    position = vovasTwo;
    print(position);
  }

  createSum() async {
    var response = await http.post(Uri.parse("http://$adress:$myPort/prihod_enter"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: json.encode(
          {
            'id': '${myId['id']}',
            'sum': int.parse(_sum.text),
            'time': '${DateTime.now()}',
            'businesses': myScrollList[0], //${myScrollList[0]}'
            'istochnik_prihoda': myScrollList[1], //${myScrollList[1]}'
            'position': '${myScrollList[2]}',
          },
        ));
    var vov = jsonDecode(response.body);
    myId = vov[0];
    myGet = vov[1];
  }

  nextButton(List list) {
    if (_sum.text.isNotEmpty && list[1].contains(true)) {
      listIndex += 1;
      if (listIndex == 1) {
        nameButton = 'Источник Прихода';
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

  ///====================================

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
                        nameButton = 'Источник Прихода';
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
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Внести приход',
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

                    ///Источник
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
                        'Источник',
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
                // SizedBox(height: 18),
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
                            text: 'Добавить источник прихода в список',
                            textTwo: 'Добавить источник прихода',
                            myList: source,
                            clickSwitch: true,
                            addFunction: addIstochnik,
                          );
                        } else {
                          return AddBusiness(
                            text: 'Добавить позицию в список',
                            textTwo: 'Добавить позицию',
                            myList: position,
                            clickSwitch: true,
                            addFunction: addPositionPrihod,
                          );
                        }
                      },
                    ).then((value) => setState(() {}));
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
                              await createSource(myScrollList[0]);
                            }
                          } else if (listIndex == 1) {
                            if (nextButton(source)) {
                              await createPosition(myScrollList[0], myScrollList[1]);
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
                          'Внести приход ${_sum.text} р.',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1),
                        ),
                        onPressed: () async {
                          if (_sum.text.isNotEmpty && position[1].contains(true)) {
                            await createSum();
                            balance = myId['balance'].toString();
                            money = myId['money'].toString();
                            myMoney = myId['my_money'].toString();
                            listIndex = 0;
                            Navigator.pop(context, myBoolGet = true);
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
