import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({
    Key? key,
    required this.title,
    required this.myIcon,
    required this.press,
  }) : super(key: key);

  String title;
  IconData myIcon;
  var press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: 155,
        height: 58,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            SizedBox(width: 10),
            Icon(myIcon),
          ],
        ),
      ),
    );
  }
}
