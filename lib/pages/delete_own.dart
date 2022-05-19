import 'dart:convert';

import 'package:counting_room/resurs/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../resurs/global.dart';
import 'package:http/http.dart' as http;


///Окно Удалить Собственные

class DeleteOwn extends StatefulWidget {
  const DeleteOwn({Key? key}) : super(key: key);

  @override
  _DeleteOwnState createState() => _DeleteOwnState();
}

TextEditingController _sum = TextEditingController();

class _DeleteOwnState extends State<DeleteOwn> {

  myMakeDelete() async {
    var response = await http.post(Uri.parse("http://$adress:$myPort/sobstv_vivod"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: json.encode(
          {
            "id": myId['id'].toString(),
            "sum": int.parse(_sum.text),
            "time": DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now()).toString(),
          },
        ));
    var vova = jsonDecode(response.body);
    myId = vova[0];
    myGet = vova[1];
    print(myId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      var count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                      _sum.clear();
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
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Удалить собственные',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: MyColors().greenDark),
              ),
              SizedBox(height: 16),
              Text(
                'Сумма',
                style: TextStyle(color: MyColors().greenDark),
              ),
              SizedBox(height: 4),
              TextField(
                onChanged: (value){
                  setState(() {});
                },
                controller: _sum,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  suffixIcon: Image.asset('assets/1.png'),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: _sum.text.isNotEmpty ? BottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
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
                  'Удалить собственные ${_sum.text} р.',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 1),
                ),
                onPressed: () async {
                  await myMakeDelete();
                  setState(() {
                    ///Обновление цифр
                    balance = myId['balance'].toString();
                    money = myId['money'].toString();
                    myMoney = myId['my_money'].toString();
                    ///=============================================
                    var count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });
                    _sum.clear();
                  });
                },
              ),
            )): null,
      ),
    );
  }
}
