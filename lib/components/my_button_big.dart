import 'package:counting_room/resurs/colors_app.dart';
import 'package:flutter/material.dart';

class MyButtonBig extends StatelessWidget {
  MyButtonBig({
    Key? key,
    this.title,
    this.myIcon,
    this.press,
  }) : super(key: key);

  String? title;
  IconData? myIcon;
  var press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0.5, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Icon(myIcon),
                SizedBox(width: 10),
                Text(title!, style: TextStyle(color: MyColors().greenDark),),
                Spacer(),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
