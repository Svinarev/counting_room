import 'dart:convert';

import 'package:counting_room/components/my_button_lite.dart';
import 'package:counting_room/components/scroll_list.dart';
import 'package:counting_room/resurs/global.dart';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global_list.dart';
import 'package:flutter/material.dart';
import '../components/add_business.dart';
import 'package:http/http.dart' as http;


///Перевод

class Translation extends StatefulWidget {
  const Translation({Key? key}) : super(key: key);

  @override
  _TranslationState createState() => _TranslationState();
}


class _TranslationState extends State<Translation> {
  TextEditingController _sum = TextEditingController();

  postTranslation() async {
    var response =
    await http.post(Uri.parse("http://$adress:$myPort/perevod_enter"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: json.encode(
          {
            "id": '${myId['id']}',
            'send_id': '2',
            'sum': int.parse(_sum.text),
            'data':'${DateTime.now()}',
            'send_user':'2',
          },
        ));
    var vov = jsonDecode(response.body);
    myGet = vov[1];
    myId = vov[0];
    print(myGet);
  }

  nextButton(List list) {
    if (_sum.text.isNotEmpty && list[1].contains(true)) {
      listIndex += 1;
      if (listIndex == 1) {
        nameButton = 'Источник Прихода';
      } else if (listIndex == 2) {
        nameButton = 'Позицию';
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Заполните, и выберите все поля!')));
      }
    }
  }

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
                        myScrollList.clear();
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
                  'Внести перевод',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: MyColors().greenDark),
                ),
                SizedBox(height: 8),
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
                    'Кому перевести',
                    style: TextStyle(
                        color:
                            listIndex == 0 ? MyColors().greenDark : Colors.grey),
                  ),
                ),
                // SizedBox(height: 18),
                ///Список Бизнесов
                if (listIndex == 0)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 260,
                    child: ListView.builder(
                        itemCount: userName[0].length,
                        itemBuilder: (context, index) {
                          return ButtonBisnes(
                            press: () async {
                              if (userName[1].contains(true)) {
                                userName[1][userName[1].indexOf(true)] = false;
                              }
                              setState(() {
                                if (myScrollList.length > 0) {
                                  myScrollList[0] = userName[0][index][1];
                                } else {
                                  myScrollList.add(userName[0][index][1]);
                                }
                                userName[1][index] = true;
                              });
                            },
                            title: userName[0][index][1],
                            onColor: userName[1][index],
                          );
                        }),
                  ),
              ],
            ),
          ),
        ),
        bottomSheet: _sum.text.isNotEmpty? BottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
                      'Внести перевод ${_sum.text} р.',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1),
                    ),
                    onPressed: () async{
                     await postTranslation();
                     balance = myId['balance'].toString();
                     money = myId['money'].toString();
                     myMoney = myId['my_money'].toString();
                      setState(() {
                        if(userName[1].contains(true)){
                          Navigator.pop(context);
                          myBoolGet = true;
                          myScrollList.clear();
                        }
                      });
                    },
                  ),
                )):null,
      ),
    );
  }
}
