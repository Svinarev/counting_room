import 'package:flutter/material.dart';

class MyButtonLite extends StatelessWidget {
  MyButtonLite({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  String title;
  var press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: 155,
        height: 58,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0.5, 1),
              ),
            ],
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Center(child: Text(title),),
      ),
    );
  }
}


class ButtonBisnes extends StatelessWidget {
  ButtonBisnes({
    Key? key,
    required this.title,
    required this.press,
    required this.onColor,
  }) : super(key: key);

  var title;
  var press;
  var onColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
              color: onColor? Colors.grey: Colors.white,
            border: Border.all(),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0.5, 1),
                ),
              ],
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              title,
            ),
          ),
        ),
      ),
    );
  }
}