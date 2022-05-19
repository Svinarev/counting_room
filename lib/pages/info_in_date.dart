import 'package:counting_room/my_class/class_istoch_prichod.dart';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../test1.dart';
import 'my_calendar.dart';

class InfoInDate extends StatefulWidget {
  const InfoInDate({Key? key}) : super(key: key);

  @override
  State<InfoInDate> createState() => _InfoInDateState();
}

class _InfoInDateState extends State<InfoInDate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 35),
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
                      style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Операции по дате',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: MyColors().greenDark),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Дата календаря
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
                            Navigator.pop(context);
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
                    width: 270,
                    child: Center(
                      child: Text(
                        myDate,
                        style: TextStyle(fontSize: 17, letterSpacing: 1),
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_down, size: 30,)),
                ///Колокольчик
                Container(
                  width: 45,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                            onPressed: bellText > 0
                                ? () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context, setState) =>
                                          AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            content: Container(
                                              height: 400,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(Icons.highlight_remove),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        '23.05.21',
                                                        style:
                                                        TextStyle(color: Colors.grey[700]),
                                                      ),
                                                      Text(
                                                        '8:45',
                                                        style:
                                                        TextStyle(color: Colors.grey[700]),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 20,
                                                        child: Checkbox(
                                                          fillColor: MaterialStateProperty.all(
                                                            MyColors().greenDark,
                                                          ),
                                                          value: singleCheckBox,
                                                          onChanged: (newValue) {
                                                            setState(() {
                                                              singleCheckBox = !singleCheckBox;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text('Перевод'),
                                                      Spacer(),
                                                      Icon(Icons.arrow_forward),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        '2500',
                                                        style: TextStyle(
                                                            color: MyColors().whiteGreen,
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Подробнее',
                                                        style: TextStyle(color: Colors.grey),
                                                      ),
                                                      IconButton(
                                                        onPressed: () async {
                                                          if (myGet.isNotEmpty)
                                                            myBellGet = !myBellGet;
                                                          setState(() {});
                                                        },
                                                        icon: Icon(
                                                          myBellGet == false
                                                              ? Icons.keyboard_arrow_down
                                                              : Icons.keyboard_arrow_up,
                                                          size: 30,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        'От кого',
                                                        style: TextStyle(
                                                            color: MyColors().greenDark),
                                                      ),
                                                      Text(
                                                        'ФИО',
                                                        style: TextStyle(
                                                            color: MyColors().greenDark),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Spacer(),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      minimumSize: Size(254, 40),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(25)),
                                                      primary: MyColors().myBeige,
                                                      onPrimary: MyColors().myWhite,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Принять перевод',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                    );
                                  });
                            }
                                : null,
                            icon: Icon(
                              Icons.add_alert,
                              size: 33,
                              color: Colors.grey,
                            )),
                      ),

                      ///Цифра над колокольчиком
                      Positioned(
                        top: 6,
                        right: 0,
                        child: Container(
                          width: 19,
                          height: 19,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: bellText > 0 ? Colors.orange : Colors.grey[600],
                          ),
                          child: Center(
                            child: Text(
                              '$bellText',
                              style: TextStyle(
                                  color: MyColors().myWhite, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    insetPadding: EdgeInsets.symmetric(horizontal: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    content: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.highlight_remove),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '23.05.21',
                                      style:
                                      TextStyle(color: Colors.grey[700]),
                                    ),
                                    Text(
                                      '8:45',
                                      style:
                                      TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text('Перевод'),
                                    Spacer(),
                                    Icon(Icons.arrow_forward),
                                    SizedBox(width: 5),
                                    Text(
                                      '2500',
                                      style: TextStyle(
                                          color: MyColors().whiteGreen,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Подробнее',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        if (myGet.isNotEmpty)
                                          myBellGet = !myBellGet;
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        myBellGet == false
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_up,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'От кого',
                                      style: TextStyle(
                                          color: MyColors().greenDark),
                                    ),
                                    Text(
                                      'ФИО',
                                      style: TextStyle(
                                          color: MyColors().greenDark),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  );
                });
              },
              child: Container(
                color: Colors.white,
                height: 40,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Перевод',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: MyColors().greenDark),
                      ),
                      Text('ФИО'),
                      Row(
                        children: [
                          Icon(Icons.arrow_forward, size: 20,),
                          SizedBox(width: 10),
                          Text('10 000', style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: (){},
              child: Container(
                color: Colors.white,
                height: 40,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Приход',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: MyColors().greenDark),
                      ),
                      Text('автосолон'),
                      Row(
                        children: [
                          Icon(Icons.add, size: 20,),
                          SizedBox(width: 10),
                          Text('80 000', style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: (){},
              child: Container(
                color: Colors.white,
                height: 40,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Расход',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: MyColors().greenDark),
                      ),
                      Text('строительство'),
                      Row(
                        children: [
                          Icon(Icons.remove, size: 20,),
                          SizedBox(width: 10),
                          Text('160 000', style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: (){},
              child: Container(
                color: Colors.white,
                height: 40,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Собственные',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: MyColors().greenDark),
                      ),
                      Text(''),
                      Row(
                        children: [
                          Icon(Icons.person_outline, size: 20,),
                          SizedBox(width: 10),
                          Text('50 000', style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
