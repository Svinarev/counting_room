import 'dart:convert';
import 'package:counting_room/components/my_button_big.dart';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:flutter/material.dart';
import '../resurs/global.dart';
import '../resurs/global_function.dart';
import 'package:http/http.dart' as http;

import '../my_class/class_cel_rashod.dart';

///СПРАВОЧНИКИ

class MyReference extends StatefulWidget {
  const MyReference({Key? key}) : super(key: key);

  @override
  State<MyReference> createState() => _MyReferenceState();
}

///Получение списка бизнесов в Справочники Бизнесы
getBusinessRename() async {
  await Future(() async {
    final res = await http.get(
      Uri.parse("http://$adress:$myPort/spravochniki/business"),
    );
    var vova = jsonDecode(res.body);
    businessesRename = vova;
    print(businessesRename);
    myIndex = 0;
  });
}

class _MyReferenceState extends State<MyReference> {
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
              'Справочники',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: MyColors().greenDark),
            ),
            SizedBox(height: 16),
            Column(
              children: [
                MyButtonBig(
                  title: 'БИЗНЕСЫ',
                  press: () async {
                    await getBusinessRename();
                    Navigator.pushNamed(context, 'FilterPage');
                  },
                ),
                MyButtonBig(
                  title: 'ИСТОЧНИКИ ПРИХОДА',
                  press: () async{
                    await getMyReference();
                    myIndex = 1;
                    Navigator.pushNamed(context, 'FilterPage');
                  },
                ),
                MyButtonBig(
                  title: 'ЦЕЛИ РАСХОДА',
                  press: () async{
                   await getMyCelRashod();
                    myIndex = 2;
                    Navigator.pushNamed(context, 'FilterPage');
                  },
                ),
                MyButtonBig(
                  title: 'ПОЗИЦИИ',
                  press: () async{
                    await getMyPosition();
                    myIndex = 3;
                    Navigator.pushNamed(context, 'FilterPage');
                  },
                ),
                MyButtonBig(
                  title: 'ПОЛЬЗОВАТЕЛИ',
                  press: () {
                    myIndex = 4;
                    Navigator.pushNamed(context, 'FilterPage');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
