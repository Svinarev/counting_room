import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:counting_room/components/my_button.dart';
import 'package:counting_room/components/my_button_lite.dart';
import 'package:counting_room/my_icon_icons.dart';
import 'package:counting_room/pages/my_calendar.dart';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global_function.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'resurs/global.dart';
import 'package:http/http.dart' as http;

///Главная Test1

class Test1 extends StatefulWidget {
  Test1({Key? key, required this.callback}) : super(key: key);

  @override
  State<Test1> createState() => _Test1State();

  var callback;
}

DateTime now = DateTime.now();
String myDate = DateFormat('dd.MM.yyyy').format(now);
String myDateReport = DateFormat('dd.MM.yyyy').format(now);


myTranslation() async {
  var response = await http.post(Uri.parse("http://$adress:$myPort/perevod_info"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          "id": "1",
        },
      ));
  var vova = jsonDecode(response.body);
  userName = vova;
  print(userName);
}



DateRangePickerController myCalendar = DateRangePickerController();

class _Test1State extends State<Test1> {
  bool colorBalance = true;

  var singleCheckBox = false;
  var _numberBell = 0;

  myCheck() {
    if (myId['balance'] > 0) {
      balance = '+ ${myId['balance']}';
      colorBalance = true;
    } else if (myId['balance'] < 0) {
      balance = '${myId['balance']}';
      colorBalance = false;
    } else {
      balance = '${myId['balance']}';
    }
    if (myId['money'] > 0) {
      money = '+ ${myId['money']}';
    } else if (myId['money'] < 0) {
      money = '${myId['money']}';
    } else {
      money = '${myId['money']}';
    }
    if (myId['my_money'] > 0) {
      myMoney = '+ ${myId['my_money']}';
    } else if (myId['my_money'] < 0) {
      myMoney = '${myId['my_money']}';
    } else {
      myMoney = '${myId['my_money']}';
    }
  }

  @override
  void initState() {
    myCheck();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    myCheck();
    print('работает');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return MyCalendar(press: () {
                              if (myCalendar.selectedRange!.startDate != null &&
                                  myCalendar.selectedRange!.endDate != null) {
                                myDate =
                                    "${DateFormat('dd.MM.yyyy').format(DateTime.parse(myCalendar.selectedRange!.startDate.toString()))} - ${DateFormat('dd.MM.yyyy').format(DateTime.parse(myCalendar.selectedRange!.endDate.toString()))}";
                              } else if (myCalendar.selectedRange!.startDate != null) {
                                myDate =
                                    "${DateFormat('dd.MM.yyyy').format(DateTime.parse(myCalendar.selectedRange!.startDate.toString()))}";
                              } else {
                                myDate = DateFormat('dd.MM.yyyy').format(now);
                              }
                              Navigator.pushNamed(context, 'InfoInDate').then((value) {
                                Navigator.pop(context);
                              });
                              print(myCalendar.selectedRange);
                            });
                          });
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.5),
                        color: MyColors().myWhite,
                      ),
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Center(
                        child: Text(
                          myDate,
                          style: TextStyle(fontSize: 17, letterSpacing: 1),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      )),

                  ///Колокольчик
                  // Container(
                  //   width: 45,
                  //   child: Stack(
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(right: 10),
                  //         child: IconButton(
                  //           onPressed: bellText > 0
                  //               ? () {
                  //                   showDialog(
                  //                       context: context,
                  //                       builder: (context) {
                  //                         return StatefulBuilder(
                  //                           builder: (BuildContext context, setState) =>
                  //                               AlertDialog(
                  //                             shape: RoundedRectangleBorder(
                  //                               borderRadius: BorderRadius.circular(25),
                  //                             ),
                  //                             content: Container(
                  //                               height: 400,
                  //                               child: Column(
                  //                                 crossAxisAlignment: CrossAxisAlignment.end,
                  //                                 children: [
                  //                                   IconButton(
                  //                                     onPressed: () {
                  //                                       Navigator.pop(context);
                  //                                     },
                  //                                     icon: Icon(Icons.highlight_remove),
                  //                                   ),
                  //                                   SizedBox(height: 10),
                  //                                   Row(
                  //                                     mainAxisAlignment:
                  //                                         MainAxisAlignment.spaceBetween,
                  //                                     children: [
                  //                                       Text(
                  //                                         '23.05.21',
                  //                                         style: TextStyle(color: Colors.grey[700]),
                  //                                       ),
                  //                                       Text(
                  //                                         '8:45',
                  //                                         style: TextStyle(color: Colors.grey[700]),
                  //                                       ),
                  //                                     ],
                  //                                   ),
                  //                                   Row(
                  //                                     children: [
                  //                                       SizedBox(
                  //                                         width: 20,
                  //                                         child: Checkbox(
                  //                                           fillColor: MaterialStateProperty.all(
                  //                                             MyColors().greenDark,
                  //                                           ),
                  //                                           value: singleCheckBox,
                  //                                           onChanged: (newValue) {
                  //                                             setState(() {
                  //                                               singleCheckBox = !singleCheckBox;
                  //                                             });
                  //                                           },
                  //                                         ),
                  //                                       ),
                  //                                       SizedBox(width: 5),
                  //                                       Text('Перевод'),
                  //                                       Spacer(),
                  //                                       Icon(Icons.arrow_forward),
                  //                                       SizedBox(width: 5),
                  //                                       Text(
                  //                                         '2500',
                  //                                         style: TextStyle(
                  //                                             color: MyColors().whiteGreen,
                  //                                             fontSize: 20,
                  //                                             fontWeight: FontWeight.w500),
                  //                                       ),
                  //                                     ],
                  //                                   ),
                  //                                   Row(
                  //                                     mainAxisAlignment:
                  //                                         MainAxisAlignment.spaceBetween,
                  //                                     children: [
                  //                                       Text(
                  //                                         'Подробнее',
                  //                                         style: TextStyle(color: Colors.grey),
                  //                                       ),
                  //                                       IconButton(
                  //                                         onPressed: () async {
                  //                                           if (myGet.isNotEmpty)
                  //                                             myBellGet = !myBellGet;
                  //                                           setState(() {});
                  //                                         },
                  //                                         icon: Icon(
                  //                                           myBellGet == false
                  //                                               ? Icons.keyboard_arrow_down
                  //                                               : Icons.keyboard_arrow_up,
                  //                                           size: 30,
                  //                                           color: Colors.grey,
                  //                                         ),
                  //                                       ),
                  //                                     ],
                  //                                   ),
                  //                                   Row(
                  //                                     mainAxisAlignment:
                  //                                         MainAxisAlignment.spaceBetween,
                  //                                     children: [
                  //                                       Text(
                  //                                         'От кого',
                  //                                         style: TextStyle(
                  //                                             color: MyColors().greenDark),
                  //                                       ),
                  //                                       Text(
                  //                                         'ФИО',
                  //                                         style: TextStyle(
                  //                                             color: MyColors().greenDark),
                  //                                       ),
                  //                                     ],
                  //                                   ),
                  //                                   Divider(),
                  //                                   Spacer(),
                  //                                   ElevatedButton(
                  //                                     style: ElevatedButton.styleFrom(
                  //                                       minimumSize: Size(254, 40),
                  //                                       shape: RoundedRectangleBorder(
                  //                                           borderRadius:
                  //                                               BorderRadius.circular(25)),
                  //                                       primary: MyColors().myBeige,
                  //                                       onPrimary: MyColors().myWhite,
                  //                                     ),
                  //                                     onPressed: () {
                  //                                       Navigator.pop(context);
                  //                                     },
                  //                                     child: Text(
                  //                                       'Принять перевод',
                  //                                       style: TextStyle(
                  //                                           fontSize: 16,
                  //                                           fontWeight: FontWeight.w700),
                  //                                     ),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         );
                  //                       });
                  //                 }
                  //               : null,
                  //           icon: Icon(
                  //             MyIcon.bell,
                  //             size: 25,
                  //             color: Colors.grey,
                  //           ),
                  //         ),
                  //       ),
                  //
                  //       ///Цифра над колокольчиком
                  //       Positioned(
                  //         top: 6,
                  //         right: 8,
                  //         child: Container(
                  //           width: 17,
                  //           height: 17,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(25),
                  //             color: bellText > 0 ? Colors.orange : Colors.grey[600],
                  //           ),
                  //           child: Center(
                  //             child: Text(
                  //               '$bellText',
                  //               style: TextStyle(
                  //                   color: MyColors().myWhite, fontWeight: FontWeight.bold),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  ///==============
                  ///Новый колокол
                  Badge(
                    position: BadgePosition.bottomStart(bottom: 10, start: 15),
                    badgeContent: Text('$_numberBell', style: TextStyle(color: Colors.white),),
                    child: Icon(Icons.notifications,size: 30,color: Colors.grey,),
                    badgeColor: MyColors().myBeige,
                    animationType: BadgeAnimationType.fade,
                    // showBadge: _numberBell > 0 ? true : false,
                  ),
                ],
              ),
              SizedBox(height: 10),
              if (myBoolGet == true)

                ///Окно Приход Автосалон Сумма
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              content: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 270,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 50),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${DateFormat('dd.MM.yyyy').format(DateTime.parse(myGet[1]['time']))}'),
                                        Text(
                                            '${DateFormat('HH:mm').format(DateTime.parse(myGet[1]['time']))}'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${myGet[1]['operation_type']}'),
                                        Text('${myGet[1]['sum']}'),
                                      ],
                                    ),
                                    Text(
                                      'Подробнее',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Бизнес'),
                                        Text('${myGet[1]['businesses']}'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Источник'),
                                        Text('${myGet[1]['istochnik_prihoda']}'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Позиция'),
                                        Text('${myGet[1]['position']}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.highlight_remove),
                                ),
                              )
                            ],
                          ));
                        });
                  },
                  child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0.5, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${myGet['operation_type']}',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text('${myGet['businesses']}'),
                            Text('${myGet['sum']}'),
                          ],
                        ),
                      )),
                ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: MyColors().myWhite,
                  borderRadius: BorderRadius.circular(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0.5, 1),
                    ),
                  ],
                ),
                height: 77,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '$balance',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: colorBalance ? Colors.green : Colors.red),
                    ),
                    VerticalDivider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$money',
                          style: TextStyle(color: MyColors().greenDark),
                        ),
                        Container(width: 100, child: Divider()),
                        Text(
                          '$myMoney',
                          style: TextStyle(color: MyColors().greenDark),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Денежные операции',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700, color: MyColors().greenDark),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyButton(
                          title: 'ПРИХОД ',
                          myIcon: Icons.add,
                          press: () async {
                            // await getMyBusiness();
                            Navigator.pushNamed(context, "MyComing")
                                .then((value) => setState(() {}));
                          }),
                      MyButton(
                          title: 'РАСХОД',
                          myIcon: Icons.remove,
                          press: () async {
                            await getMyBusiness();
                            setState(() {});
                            Navigator.pushNamed(context, 'MyConsumption')
                                .then((value) => setState(() {}));
                          }),
                    ],
                  ),
                  Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyButton(
                          title: 'СОБСТВЕННЫЕ',
                          myIcon: Icons.person_outline_outlined,
                          press: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                              ),
                              context: context,
                              builder: (BuildContext ctx) => StatefulBuilder(
                                builder: (BuildContext context, setState) => Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 250,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 30),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(height: 10),
                                            Text(
                                              'Выбор операции для собственных\nсредтсв',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.5),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                OutlinedButton(
                                                  style: OutlinedButton.styleFrom(
                                                    side: addOperation
                                                        ? BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5,
                                                          )
                                                        : null,
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 20, vertical: 15),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      addOperation = true;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                      ),
                                                      Text(
                                                        'Добавить',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                OutlinedButton(
                                                  style: OutlinedButton.styleFrom(
                                                    side: addOperation
                                                        ? null
                                                        : BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5,
                                                          ),
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      addOperation = false;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.remove,
                                                        color: Colors.black,
                                                      ),
                                                      Text(
                                                        'Удалить',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: MyColors().myBeige,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  )),
                                              child: Text(
                                                'Выбрать',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    letterSpacing: 1),
                                              ),
                                              onPressed: () async {
                                                if (addOperation == true) {
                                                  Navigator.of(context).pushNamed('Own');
                                                  //     .then((value) {
                                                  //   setState(() {});
                                                  // });

                                                } else {
                                                  Navigator.of(context).pushNamed('DeleteOwn');
                                                }
                                                setState(() {});
                                              },
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.highlight_remove),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ).then((value) => setState(() {}));
                          }),
                      MyButton(
                        title: 'ПЕРЕВОД',
                        myIcon: Icons.arrow_forward_rounded,
                        press: () async {
                          await myTranslation();
                          Navigator.of(context)
                              .pushNamed('translation')
                              .then((value) => setState(() {}));
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 23),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Управление',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700, color: MyColors().greenDark),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyButtonLite(
                          title: 'CПРАВОЧНИКИ',
                          press: () {
                            Navigator.of(context).pushNamed('MyReference');
                          }),
                      MyButtonLite(title: 'ОТЧЕТЫ', press: () {
                        widget.callback(2);
                        //Navigator.pushNamed(context, 'MyReport');
                      }),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
