import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/strings_app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../resurs/global.dart';
import '../resurs/global_function.dart';

///ВХОД РЕГИСТРАЦИЯ

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}
var sale;

class _AuthState extends State<Auth> {

  create() async {
    var response = await http.post(
        Uri.parse("http://$adress:$myPort/autorization"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: json.encode(
          {
            'loggin': _login.text,
            'password': _password.text,
          },
        ));
        var vovas = jsonDecode(response.body);
    myId = vovas;
    print(myId);
  }

  final _login = TextEditingController();
  final _password = TextEditingController();

  void _auth() {
    if (myId is! String) {
      Navigator.of(context).pushNamed('HomePage');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Неверный логин или пароль'),));
    }
  }

  var singleCheckBox = false;
  bool _openPassword = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: MyColors().greenDark,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 100, left: 60, right: 60, bottom: 150),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      MyTitle().authTitleOne,
                      style: TextStyle(color: MyColors().myWhite),
                    ),
                    Text(
                      MyTitle().authTitleTwo,
                      style: TextStyle(color: MyColors().myWhite),
                    ),
                    Text(
                      MyTitle().authTitleThree,
                      style: TextStyle(color: MyColors().myWhite),
                    ),
                  ],
                ),
                SizedBox(height: 90),
                Text(
                  MyTitle().toComeIn,
                  style: TextStyle(
                      color: MyColors().myWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 45),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _login,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person_outline, size: 25,color: MyColors().myWhite.withOpacity(0.5),),
                        filled: true,
                        fillColor: MyColors().whiteGreen,
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: MyTitle().myUserName,
                        hintStyle:
                            TextStyle(color: Color(0xffF6F6F6), fontSize: 13),
                      ),
                    ),
                    SizedBox(height: 13),
                    TextField(
                      obscureText: _openPassword,
                      style: TextStyle(color: Colors.white),
                      controller: _password,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            _openPassword = !_openPassword;
                          });
                        }, icon: Icon(_openPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined,size: 25,color: MyColors().myWhite.withOpacity(0.5),),),
                        filled: true,
                        fillColor: MyColors().whiteGreen,
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: MyTitle().myPass,
                        hintStyle:
                            TextStyle(color: Color(0xffF6F6F6), fontSize: 13),
                      ),
                    ),
                    SizedBox(height: 29),
                    Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              checkColor: MyColors().greenDark,
                              value: singleCheckBox,
                              onChanged: (newValue) {
                                setState(() {
                                  singleCheckBox = !singleCheckBox;
                                });
                              },
                            ),
                            Text(
                              MyTitle().myRemember,
                              style: TextStyle(color: MyColors().myWhite),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            MyTitle().forgetPass,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                                color: MyColors().myWhite),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(254, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        primary: MyColors().myBeige,
                        onPrimary: MyColors().myWhite,
                      ),
                      onPressed: () async{
                        await create();
                        _auth();
                      },
                      child: Text(
                        MyTitle().toComeIn,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
