import 'package:counting_room/components/my_button.dart';
import 'package:counting_room/components/my_button_big.dart';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:flutter/material.dart';
import 'resurs/global_function.dart';
import 'test1.dart';

///Страница Внести

class MySubmit extends StatefulWidget {
  var callback;

  MySubmit({Key? key, required this.callback}) : super(key: key);

  @override
  _MySubmitState createState() => _MySubmitState();
}





class _MySubmitState extends State<MySubmit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Внести',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5),
                  ),
                  SizedBox(height: 20),
                  MyButtonBig(
                    myIcon: Icons.account_balance_wallet_outlined,
                    title: 'Приход',
                    press: () async{
                      await myTranslation();
                      Navigator.of(context)
                          .pushNamed('translation')
                          .then((value) => setState(() {}));
                    },
                  ),
                  MyButtonBig(
                    myIcon: Icons.remove_rounded,
                    title: 'Расход',
                    press: () async{
                      await getMyBusiness();
                      Navigator.pushNamed(context, 'MyConsumption');
                    },
                  ),
                  MyButtonBig(
                    myIcon: Icons.person_outline_outlined,
                    title: 'Собственные',
                    press: () {
                      setState(() {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                          ),
                          context: context, builder: (BuildContext ctx) => Stack(
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
                                    Text('Выбор операции для собственный\nсредтсв', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, letterSpacing: 0.5),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyButton(myIcon: Icons.add, title: 'Добавить',press: (){
                                          Navigator.of(context).pushNamed('Own');
                                        },),
                                        MyButton(myIcon: Icons.remove, title: 'Удалить',press: (){},),
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: MyColors().myBeige,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          )
                                      ),
                                      child: Text(
                                        'Выбрать',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing: 1),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          // Navigator.pop(context);
                                        });
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
                              child: IconButton(onPressed: (){
                                Navigator.pop(context);
                              }, icon: Icon(Icons.clear_outlined),),),
                          ],
                        ),);
                      });
                    },
                  ),
                  MyButtonBig(
                    myIcon: Icons.arrow_forward_rounded,
                    title: 'Перевод',
                    press: ()async {
                      await myTranslation();
                      Navigator.of(context).pushNamed('translation');
                    },
                  ),
                  MyButtonBig(
                    myIcon: Icons.list_alt,
                    title: 'Справочник',
                    press: () {
                      Navigator.of(context).pushNamed('MyReference');
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () {
                widget.callback(0);
              },
              icon: Icon(Icons.highlight_remove),
            ),
          ),
        ],
      ),
    );
  }
}
