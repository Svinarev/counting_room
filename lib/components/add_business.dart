import 'dart:convert';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global.dart';
import 'package:counting_room/resurs/global_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///Кнопки Добавить

class AddBusiness extends StatefulWidget {
  AddBusiness({required this.text, required this.textTwo, required this.myList, required this.clickSwitch,required this.addFunction});

  String text;
  String textTwo;
  List myList;
  bool clickSwitch = true;
  var addFunction;

  @override
  _AddBusinessState createState() => _AddBusinessState();
}

///Добавление позиции в приходе
addPositionPrihod(String posit) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/add_position"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {

          'businesses': myScrollList[0],
          'istochnik_prihoda': myScrollList[1],
          'position': posit,
        },
      ));
  var vov = jsonDecode(response.body);
  position = vov;
  print(vov);
}

TextEditingController nameBusiness = TextEditingController();

class _AddBusinessState extends State<AddBusiness> {

  bool mySwitch = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Spacer(),
                IconButton(
                  onPressed: () {
                    nameBusiness.clear();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                      Icons.highlight_remove),
                ),
              ],
            ),
            Text(
              widget.text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: MyColors().greenDark),
            ),
            SizedBox(height: 14),
            Text(
              'Название',
              style: TextStyle(
                  color: MyColors().greenDark),
            ),
            SizedBox(height: 4),
            TextField(
              controller: nameBusiness,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            if(widget.clickSwitch == true)
              Row(
                children: [
                  Text('Привязка ко всем бизнесам', style: TextStyle(fontSize: 14),),
                  Spacer(),
                  Switch(
                    activeColor: MyColors().myBeige,
                    value: mySwitch, onChanged: (value){
                    setState(() {
                      mySwitch = value;
                    });
                  },
                  ),
                ],
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(370, 51),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                primary: MyColors().myBeige,
                onPrimary: MyColors().myWhite,
              ),
              onPressed: () async {
                if(nameBusiness.text.isNotEmpty){
                  await widget.addFunction(nameBusiness.text);
                  nameBusiness.clear();
                  //addPositionPrihod(nameBusiness.text);
                  // widget.myList[0].add(nameBusiness.text);
                  // widget.myList[1].add(false);
                  Navigator.pop(context);
                }
              },
              child: Text(widget.textTwo, style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 16),),
            ),
          ],
        ),
      ),
    );
  }
}


///Добавление юзера если не нужно то удалить
class AddUser extends StatefulWidget {
  AddUser({required this.text, required this.textTwo, required this.myList, required this.clickSwitch});

  String text;
  String textTwo;
  List myList;
  bool clickSwitch = true;

  @override
  _AddUserState createState() => _AddUserState();
}

TextEditingController nameUser = TextEditingController();

class _AddUserState extends State<AddUser> {

  bool mySwitch = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 58),
            Text(
              widget.text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: MyColors().greenDark),
            ),
            SizedBox(height: 14),
            Text(
              'Название',
              style: TextStyle(
                  color: MyColors().greenDark),
            ),
            SizedBox(height: 4),
            TextField(
              controller: nameUser,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            if(widget.clickSwitch == true)
              Row(
                children: [
                  Text('Привязка ко всем бизнесам', style: TextStyle(fontSize: 14),),
                  Spacer(),
                  Switch(
                    activeColor: MyColors().myBeige,
                    value: mySwitch, onChanged: (value){
                    setState(() {
                      mySwitch = value;
                    });
                  },
                  ),
                ],
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(335, 51),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                primary: MyColors().myBeige,
                onPrimary: MyColors().myWhite,
              ),
              onPressed: () {
                if(nameUser.text.isNotEmpty){
                  widget.myList[0].add([0,nameUser.text]);
                  widget.myList[1].add(false);
                  Navigator.pop(context);
                }
              },
              child: Text(widget.textTwo, style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 16),),
            ),
          ],
        ),
      ),
    );
  }
}
///======= не забыть =======================