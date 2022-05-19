import 'package:counting_room/pages/filter_page.dart';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global.dart';
import 'package:counting_room/resurs/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../my_icon_icons.dart';

///Справочники Бизнес

bool activeBiss = false;

class Business extends StatefulWidget {
  const Business({Key? key}) : super(key: key);

  @override
  _BusinessState createState() => _BusinessState();
}

TextEditingController _myBiss = TextEditingController();

class _BusinessState extends State<Business> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Бизнесы',
              style: TextStyle(color: MyColors().greenDark, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.height,
              color: MyColors().greenDark,
              size: 16,
            ),
          ],
        ),
        Container(
          color: MyColors().myWhite,
          height: 350,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.separated(
              itemCount: businessesRename.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                            businessesRename[index]['status'] == 'false'
                                ? MyIcon.circle_empty
                                : Icons.circle,
                            size: 14,
                            color: MyColors().greenDark),
                        SizedBox(width: 10),
                        Expanded(child: Text('${businessesRename[index]['business']}')),
                        Spacer(),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              color: MyColors().myWhite, borderRadius: BorderRadius.circular(10)),
                          child: IconButton(
                            onPressed: () async {
                              _myBiss.text = '${businessesRename[index]['business']}';
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                                ),
                                context: context,
                                builder: (BuildContext ctx) => StatefulBuilder(
                                  builder: (BuildContext context, setState) => Stack(
                                    children: [
                                      Padding(
                                        padding: MediaQuery.of(context).viewInsets,
                                        child: Container(
                                          width: double.infinity,
                                          height: 300,
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 30),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(height: 10),
                                                Text(
                                                  'Редактировать бизнес',
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
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.deny(
                                                        RegExp("[/|:\\\\]")),
                                                  ],
                                                  controller: _myBiss,
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.all(10),
                                                    border: OutlineInputBorder(),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          businessesRename[index]['status'] ==
                                                                  'true'
                                                              ? Icons.circle
                                                              : MyIcon.circle_empty,
                                                          color: MyColors().greenDark,
                                                          size: 20,
                                                        ),
                                                        Text(
                                                          businessesRename[index]['status'] ==
                                                                  'true'
                                                              ? 'Активно'
                                                              : 'Не активно',
                                                          style: TextStyle(
                                                              color: MyColors().greenDark,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Switch(
                                                      activeColor: MyColors().myBeige,
                                                      value: businessesRename[index]['status'] ==
                                                              'true'
                                                          ? true
                                                          : false,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          businessesRename[index]['status'] =
                                                              val.toString();
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
                                                        borderRadius: BorderRadius.circular(20),
                                                      )),
                                                  child: Text(
                                                    'Сохранить изменения',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        letterSpacing: 1),
                                                  ),
                                                  onPressed: () async {
                                                    ///Работаем тут
                                                    await businessRename(
                                                        businessesRename[index]['id_business'],
                                                        _myBiss.text,
                                                        businessesRename[index]['status']);
                                                    Navigator.pop(context);
                                                  },
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
                              ).then((value) => setState(() {}));
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 20,
                              color: MyColors().greenDark,
                            ),
                          ),
                        ),
                        SizedBox(width: 14),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              color: MyColors().myWhite, borderRadius: BorderRadius.circular(10)),
                          child: IconButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Container(
                                        height: 120,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('Удалить бизнес:'),
                                            Text('"${businessesRename[index]['business']}"',
                                                style: TextStyle(
                                                    fontSize: 17, fontWeight: FontWeight.bold)),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                TextButton(
                                                    onPressed: () async {
                                                      await businessDelete(
                                                          businessesRename[index]['id_business']);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Удалить',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Отмена',
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.delete_rounded,
                              size: 20,
                              color: MyColors().greenDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  thickness: 1,
                );
              },
            ),
          ),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            _myBiss.clear();
            showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              ),
              context: context,
              builder: (BuildContext ctx) => StatefulBuilder(
                builder: (BuildContext context, setState) => Stack(
                  children: [
                    Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        width: double.infinity,
                        height: 300,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Добавить бизнес список',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                              ),
                              Text(
                                'название',
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(RegExp("[/|:\\\\]")),
                                ],
                                controller: _myBiss,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(activeBiss == false ? MyIcon.circle_empty : Icons.circle,
                                          size: 14, color: MyColors().greenDark),
                                      SizedBox(width: 10),
                                      activeBiss == false
                                          ? Text('Не активно',
                                              style: TextStyle(
                                                  color: MyColors().greenDark,
                                                  fontWeight: FontWeight.bold))
                                          : Text(
                                              'Активно',
                                              style: TextStyle(
                                                  color: MyColors().greenDark,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    ],
                                  ),
                                  Spacer(),
                                  Switch(
                                    activeColor: MyColors().myBeige,
                                    value: activeBiss,
                                    onChanged: (val) {
                                      setState(() {
                                        activeBiss = !activeBiss;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: MyColors().myBeige,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                child: Text(
                                  'Добавить бизнес',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 1),
                                ),
                                onPressed: () async {
                                  await addBusinessesReference(_myBiss.text, activeBiss.toString());

                                  Navigator.pop(context);
                                },
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
            ).then((value) => setState(() {}));
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
                Text('Бизнес'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
