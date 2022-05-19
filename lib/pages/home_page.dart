import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global_function.dart';
import 'package:counting_room/test1.dart';
import 'package:counting_room/test2.dart';
import 'package:counting_room/pages/report.dart';
import 'package:flutter/material.dart';

///Главная

int currentIndex = 0;

bool my = true;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  refresh(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    getMyBusiness();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      Test1(callback: refresh),
      MySubmit(callback: refresh,),
      MyReport(callback: refresh,),
    ];


    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: MyColors().myFon,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: MyColors().myBeige,
          title: InkWell(
            onTap: (){
              Navigator.pushNamed(context, 'UserCabinet');
            },
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: MyColors().myWhite,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(Icons.person_outline_outlined, color: MyColors().myBeige,size: 30,),
                ),
                SizedBox(width: 12),
                Text('Семен Стороженко', style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 2),),
              ],
            ),
          ),
          // title: const Text('Семен Стороженко', style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 2),),
        ),
        body:  screens[currentIndex],
        bottomNavigationBar:BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: MyColors().greenDark,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          iconSize: 30,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: 'Внести',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_rounded),
              label: 'Отчеты',
            ),
          ],
        ),
      ),
    );
  }
}
