import 'package:counting_room/resurs/colors_app.dart';
import 'package:flutter/material.dart';

import '../resurs/global.dart';

class MyBottomSheet extends StatelessWidget {
  MyBottomSheet({Key? key,this.press, this.value}) : super(key: key);

  var press;
  var value;

  TextEditingController myBiss = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StatefulBuilder(
        builder: (BuildContext context, setState) => Stack(
          children: [
            Padding(
              padding:  MediaQuery.of(context).viewInsets,
              child: Container(
                width: double.infinity,
                height: 300,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Редактировать',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5),
                      ),
                      Text(
                        'Название',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextField(
                        controller: myBiss,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.circle, size: 12, color: MyColors().greenDark,),
                          SizedBox(width: 10),
                          Text('Активно'),
                          Spacer(),
                          Switch(
                            activeColor:
                            MyColors().myBeige,
                            value: value == 'true' ? true : false,
                            //mySwitchTwo,
                            onChanged:
                                (val) {
                              setState(() {
                                value = val.toString();
                                //mySwitchTwo = value;
                              });
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: MyColors().myBeige,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  20),
                            )),
                        child: Text(
                          'Сохранить изменения',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1),
                        ),
                        onPressed: press,
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.highlight_remove),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

