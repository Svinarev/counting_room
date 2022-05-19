import 'dart:convert';

import 'package:counting_room/pages/my_calendar.dart';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global_list.dart';
import 'package:counting_room/test1.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/diagramma.dart';
import '../resurs/global.dart';
import 'package:http/http.dart' as http;

///Отчеты

class MyReport extends StatefulWidget {
  var callback;
  MyReport({Key? key, required this.callback}) : super(key: key);

  @override
  State<MyReport> createState() => _MyReportState();
}

///Функции Получения диаграммы
diagramaPost(String id, var date) async {
  grafikInfo.clear();
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/otchety_balacne"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'id': id,
          'date': date,
        },
      ));
  Map vovas = jsonDecode(response.body);
  diagramaList = vovas;
  vovas.keys.forEach((element) {
    print(element);
    print(vovas[element]);
  });


  diagramaList.forEach((key, val){
    if(key == 'итог'){
      
    }
    //else if(key){}
  });



  diagramaList['операции'].forEach((val){
    print(val['data'].split(' ').take(1).join());
    var r = val['data'].split(' ').take(1).join();
    print(grafikInfo.containsKey(r));
    if(grafikInfo.containsKey(r)){
      if(val['operation_type'] == 'приход' || val['operation_type'] == 'Собственные внесено') {
        grafikInfo[r] +=
            val['summa'];
      }
    else if (val['operation_type'] == 'расход'){
      grafikInfo[r] -= val['summa'];
    }
    }else{
      if(val['operation_type'] == 'приход' || val['operation_type'] == 'Собственные внесено') {
        grafikInfo.addAll({r: val['summa']});

      }
      else if (val['operation_type'] == 'расход'){
        grafikInfo.addAll({r : -val['summa']});

      }
    }
  });
  print(grafikInfo);
}

class _MyReportState extends State<MyReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(113, 35),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  primary: MyColors().myBeige,
                  onPrimary: MyColors().myWhite,
                ),
                onPressed: () {
                  widget.callback(0);
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
              SizedBox(height: 16),
              Text(
                'Отчеты',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: MyColors().greenDark),
              ),
              SizedBox(height: 8),
              Text(
                'Выбрать период',
                style: TextStyle(color: MyColors().greenDark),
              ),
              SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.5),
                  color: MyColors().myWhite,
                ),
                height: 45,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InkWell(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return MyCalendar(
                                  press: ()async{
                                    if (myCalendar.selectedRange!.startDate != null && myCalendar.selectedRange!.endDate != null)
                                    { myDate =
                                    "${DateFormat('dd.MM.yyyy').format(DateTime.parse(myCalendar.selectedRange!.startDate.toString()))} - ${DateFormat('dd.MM.yyyy').format(DateTime.parse(myCalendar.selectedRange!.endDate.toString()))}";}
                                    else if(myCalendar.selectedRange!.startDate != null){
                                      myDate = "${DateFormat('dd.MM.yyyy').format(DateTime.parse(myCalendar.selectedRange!.startDate.toString()))}";
                                    }else {myDate = DateFormat('dd.MM.yyyy').format(now);}
                                    ///=====================
                                    await diagramaPost(myId['id'].toString() ,[DateFormat('yyyy.MM.dd').format(DateTime.parse(myCalendar.selectedRange!.startDate.toString())).toString(),
                                    DateFormat('yyyy.MM.dd').format(DateTime.parse(myCalendar.selectedRange!.endDate.toString())).toString()]);
                                    ///=====================
                                    Navigator.pop(context);
                                    print(myCalendar.selectedRange);
                                  }
                                );
                              });
                          setState(() {});
                        },
                        child: Text(
                          myDate,
                          style: TextStyle(fontSize: 17, letterSpacing: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Общий',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: MyColors().greenDark),
              ),
              Text(
                'Показать',
                style: TextStyle(color: Colors.grey),
              ),
              Container(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listReport.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: OutlinedButton(
                              onPressed: () async {
                                var r = listReport.removeAt(index);
                                listReport.insert(0, r);
                                setState(() {
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
                                    '${listReport[index][0]}',
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
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Итог'),
                        Text(
                          '$balance',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text('Приход'),
                            Text(
                              '$money',
                              style: TextStyle(color: MyColors().greenDark, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        Container(width: 100, child: Divider()),
                        Column(
                          children: [
                            Text('Расход'),
                            Text(
                              '$myMoney',
                              style: TextStyle(color: MyColors().greenDark, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'График',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: MyColors().greenDark),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Баланс за выбранный период:'),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(myDate,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                height: 300,
                child: MyDiagramma(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
