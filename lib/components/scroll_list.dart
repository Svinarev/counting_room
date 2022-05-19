import 'package:flutter/material.dart';

class ScrollList extends StatelessWidget {
  ScrollList({Key? key, required this.myListText, required this.myIcons})
      : super(key: key);

  String myListText;
  IconData myIcons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 11),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                myIcons,
                color: Colors.grey.shade600,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                myListText,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}