import 'package:counting_room/resurs/colors_app.dart';
import 'package:flutter/material.dart';

class UserCabinet extends StatelessWidget {
  const UserCabinet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.21,
              color: MyColors().myBeige,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.keyboard_arrow_left_outlined, color: Colors.white,size: 30,)),
                  SizedBox(height: 10),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: MyColors().myWhite,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.person_outline_outlined, color: MyColors().myBeige,size: 30,),
                  ),
                  SizedBox(height: 20),
                  Text('Семен Стороженко', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white,fontSize: 18),),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('admin',style: TextStyle(color: MyColors().greenDark),),
                    ],
                  ),
                  Divider(thickness: 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('+7 918 252-76-77',style: TextStyle(color: MyColors().greenDark),),
                      IconButton(onPressed: (){}, icon: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: MyColors().myWhite,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(Icons.edit, color: MyColors().greenDark,size: 20,),
                      ),),
                    ],
                  ),
                  Divider(thickness: 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('semen_storogenko@mail.ru',style: TextStyle(color: MyColors().greenDark),),
                      IconButton(onPressed: (){}, icon: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: MyColors().myWhite,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(Icons.edit, color: MyColors().greenDark,size: 20,),
                      ),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
