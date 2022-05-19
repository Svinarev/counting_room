import 'package:counting_room/resurs/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Справочники Пользователи

String? valueChoose;
List listItem = [
  'admin',
  'user',
];

class BooksUsers extends StatelessWidget {
  const BooksUsers({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: 350,
        ),
        SizedBox(height: 10),
        ///Кнопка добавить пользователя
        InkWell(
          onTap: (){
            showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              context: context,
              builder: (BuildContext ctx) => StatefulBuilder(
                builder: (BuildContext context, setState) => Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.9,
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
                            SizedBox(height: 50),
                            Text(
                              'Добавить пользователя',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            ),
                            Text(
                              'ФИО',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp("[/|:\\\\]")),
                              ],
                              // controller: _myBiss,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButton(
                                  hint: Text('Статус'),
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 30,
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  style: TextStyle(fontSize: 18, color: Colors.black54),
                                  value: valueChoose,
                                  onChanged: (newValue) async {
                                    setState(() {
                                      valueChoose = newValue as String?;
                                    });
                                  },
                                  items: listItem.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Text(
                              'Номер телефона',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp("[/|:\\\\]")),
                              ],
                              // controller: _myBiss,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                            Text(
                              'E-mail',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp("[/|:\\\\]")),
                              ],
                              // controller: _myBiss,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceAround,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed:
                                          () {},
                                      icon: Icon(
                                        Icons.circle,
                                        color: MyColors()
                                            .greenDark,
                                        size: 20,
                                      ),
                                    ),
                                    Text(
                                      'Активно',
                                      style: TextStyle(
                                          color: MyColors()
                                              .greenDark,
                                          fontWeight:
                                          FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Switch(
                                  activeColor:
                                  MyColors().myBeige,
                                  value: false,
                                  //mySwitchTwo,
                                  onChanged:
                                      (val) {
                                    setState(() {
                                      // businessesRename[index]['businesses_status'] = val.toString();
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
                                'Добавить пользователя',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    letterSpacing: 1),
                              ),
                              onPressed: () async {

                              },
                            ),
                            SizedBox(height: 30),
                          ],
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

          },
          child: Container(
            height: 44,
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
                Icon(
                  Icons.library_add,
                  color: MyColors().greenDark,
                ),
                SizedBox(width: 10),
                Text('Добавить пользователя'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
