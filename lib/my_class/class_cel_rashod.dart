import 'dart:async';
import 'dart:convert';
import 'package:counting_room/components/my_button_lite.dart';
import 'package:counting_room/resurs/colors_app.dart';
import 'package:counting_room/resurs/global.dart';
import 'package:counting_room/resurs/global_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../my_icon_icons.dart';
import 'package:http/http.dart' as http;

import '../pages/reference.dart';

///Цели Расхода

class CelRashod extends StatefulWidget {
  const CelRashod({Key? key}) : super(key: key);

  @override
  _CelRashodState createState() => _CelRashodState();
}

///Добовление новой цели расхода в список

addCelPrihod(String newNameIst, String status,List idIstochnik) async {
  var response = await http.post(Uri.parse("http://$adress:$myPort/spravochniki/cel/add_confirm"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'cel': newNameIst,
          'status': status,
          'id_business':idIstochnik,
        },
      ));
  var vova = jsonDecode(response.body);
  istochnic = vova;
  print(istochnic);
}

///Получение списка цель расхода
getMyCelRashod() async {
  await Future(() async {
    final res = await http.get(
      Uri.parse("http://$adress:$myPort/spravochniki/cely"),
    );
    var vova = jsonDecode(res.body);
    celRashod = vova;
    print(celRashod);
    myIndex = 2;
  });
}

///Функция отправить редоктированную цель расхода
celRashodRename(List idBisnesse, List idBisnesseDel, int celId, String nameCel,
    String nameNew, String status) async {
  var response = await http.post(
      Uri.parse("http://$adress:$myPort/spravochniki/cel/edit_confirm"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          'id_businesses': idBisnesse,
          'id_businesses_del': idBisnesseDel,
          'cel_id': celId,
          'name': nameCel,
          'new_name': nameNew,
          'status': status,
        },
      ));
  var vovas = jsonDecode(response.body);
  celRashod = vovas;
  print(celRashod);
}

///Функция Редоктировать Цель
celRashodBisRename(int name) async {
  var response =
      await http.post(Uri.parse("http://$adress:$myPort/spravochniki/cel/edit"),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: json.encode(
            {
              'cel_id': name,
            },
          ));
  var vovas = jsonDecode(response.body);
  istRename = vovas;
  print(istRename);
}

///Функция удалить цель расхода
celRashodDelete(int idCel) async {
  var response = await http.post(Uri.parse("http://$adress:$myPort/spravochniki/cel/del"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {

          'cel_id': idCel,
        },
      ));
  var vovas = jsonDecode(response.body);
  celRashod = vovas;
  print(celRashod);
}

///Функция Фильтр цель расхода по бизнесу
celRashodFilterBusiness(var filterBiss) async {
  var response =
      await http.post(Uri.parse("http://$adress:$myPort/spravochniki/cely/filtr"),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: json.encode(
            {
              'id_businesses': filterBiss,
            },
          ));
  var vovas = jsonDecode(response.body);
  celRashod = vovas;
  print(celRashod);
}

///=========================================================

class _CelRashodState extends State<CelRashod> {
  TextEditingController celRas = TextEditingController();

  var selectedCell = -1;
  List keysCell = [];
  List keysCellRas = [];
  Size? oldSizeCell;

  bool switchBoxCel = false;
  bool addCheckBoxCel = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keysCell = [for (var i = 0; i < celRashod.length; i++) GlobalKey()];
    keysCellRas = [for (var i = 0; i < celRashod.length; i++) GlobalKey()];
  }

  bool singleCheckBoxCell = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: MyColors().myWhite,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бизнес',
                  style: TextStyle(color: MyColors().greenDark),
                ),
                TextButton(
                  onPressed: () async {
                    await showModalBottomSheet(
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
                            Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Container(
                                width: double.infinity,
                                height: 400,
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
                                      SizedBox(height: 30),
                                      Text(
                                        'Фильтр по бизнесу',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      Container(
                                        height: 210,
                                        child: ListView.builder(
                                            itemCount: businessesRename.length,
                                            itemBuilder: (context, index) {
                                              return ButtonBisnes(
                                                  press: () async {
                                                    if(listFilterBuiss.contains(businessesRename[index]['id_business'])){
                                                      listFilterBuiss.remove(
                                                          businessesRename[index]['id_business']);
                                                    }else{
                                                      listFilterBuiss.add(
                                                          businessesRename[index]['id_business']);
                                                    }
                                                    setState((){});
                                                    print(listFilterBuiss);
                                                  },
                                                  title:
                                                  businessesRename[index]['business'],
                                                  onColor: listFilterBuiss.contains(businessesRename[index]['id_business'])
                                              );
                                            }),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: MyColors().myBeige,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        child: Text(
                                          'Применить фильтр',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        onPressed: () async {
                                          await celRashodFilterBusiness(
                                              listFilterBuiss);
                                          listFilterBuiss.clear();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      SizedBox(height: 20),
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
                                  //businessFalse();
                                  listFilterBuiss.clear();
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.highlight_remove),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    setState(() {});
                  },
                  child: Text(
                    'Выбрать',
                    style: TextStyle(
                        color: MyColors().greenDark,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          color: MyColors().myWhite,
          height: 300,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ///Начало таблицы ==========================================================
                      Table(
                        border: TableBorder(
                            horizontalInside:
                                BorderSide(color: Colors.grey, width: 1.5)),
                        defaultColumnWidth: FixedColumnWidth(
                            MediaQuery.of(context).size.width / 2),
                        children: [
                          for (var e = 0; e < celRashod.length; e++)
                            TableRow(
                              children: [
                                TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedCell =
                                              selectedCell == e ? -1 : e;
                                        });

                                        Timer(Duration(milliseconds: 250), () {
                                          var context =
                                              keysCell[e].currentContext;
                                          if (context == null) return;
                                          var newSize = context.size;

                                          var contextIst =
                                              keysCellRas[e].currentContext;
                                          if (contextIst == null) return;
                                          var newSizeIst = contextIst.size;

                                          setState(() {
                                            oldSizeCell = newSize.height >
                                                    newSizeIst.height
                                                ? newSize
                                                : newSizeIst;
                                            // oldSize = oldSize!.height > 40.0 ? oldSize : null;
                                          });
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                                celRashod[e]['status'] ==
                                                        'false'
                                                    ? MyIcon.circle_empty
                                                    : Icons.circle,
                                                size: 14,
                                                color: MyColors().greenDark),
                                            SizedBox(width: 10),
                                            Container(
                                                key: keysCellRas[e],
                                                height: selectedCell == e
                                                    ? null
                                                    : 40.0,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    '${celRashod[e]['cel']}',
                                                    overflow: selectedCell == e
                                                        ? null
                                                        : TextOverflow.ellipsis,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    )),
                                TableCell(
                                    child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedCell = selectedCell == e ? -1 : e;
                                    });

                                    Timer(Duration(milliseconds: 250), () {
                                      var context = keysCell[e].currentContext;
                                      if (context == null) return;
                                      var newSize = context.size;

                                      var contextIst =
                                          keysCellRas[e].currentContext;
                                      if (contextIst == null) return;
                                      var newSizeIst = contextIst.size;

                                      setState(() {
                                        oldSizeCell =
                                            newSize.height > newSizeIst.height
                                                ? newSize
                                                : newSizeIst;
                                        // oldSize = oldSize!.height > 40.0 ? oldSize : null;
                                      });
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AnimatedContainer(
                                      key: keysCell[e],
                                      constraints: BoxConstraints(
                                        maxHeight: 100,
                                      ),
                                      duration: Duration(milliseconds: 200),
                                      height: selectedCell == e &&
                                              oldSizeCell != null
                                          ? null
                                          : 40,
                                      curve: Curves.linear,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (selectedCell == e)
                                              for (var i = 0;
                                                  i <
                                                      celRashod[e]['business']
                                                          .length;
                                                  i++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                  child: Text(
                                                    '${celRashod[e]['business'][i]}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                            if (selectedCell != e)
                                              Text(
                                                celRashod[e]['business']
                                                            .length >
                                                        1
                                                    ? '${celRashod[e]['business'][0]} ...'
                                                    : '${celRashod[e]['business'][0]}',
                                              ),
                                            if (celRashod[e]['business']
                                                    .length >
                                                1)
                                              Icon(selectedCell == e
                                                  ? Icons.keyboard_arrow_up
                                                  : Icons.keyboard_arrow_down),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                        ],
                      ),

                      ///Конец таблицы ===========================================================
                      SizedBox(width: 120),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Positioned(
                  right: 0.0,
                  child: Container(
                    color: Colors.grey.withOpacity(0.5),
                    child: Table(
                      border: TableBorder(
                        horizontalInside: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      defaultColumnWidth: FixedColumnWidth(120.0),
                      children: [
                        for (var e = 0; e < celRashod.length; e++)
                          TableRow(children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 100),
                                  height:
                                      oldSizeCell != null && selectedCell == e
                                          ? oldSizeCell!.height
                                          : 40.0,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: IconButton(
                                                onPressed: () async {
                                                  await celRashodBisRename(
                                                      celRashod[e]
                                                          ['id_istochnik_cel']);
                                                  celRas.text =
                                                      celRashod[e]['cel'];
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(25),
                                                              topRight: Radius
                                                                  .circular(
                                                                      25)),
                                                    ),
                                                    context: context,
                                                    builder:
                                                        (BuildContext ctx) =>
                                                            StatefulBuilder(
                                                      builder:
                                                          (BuildContext context,
                                                                  setState) =>
                                                              Stack(
                                                        children: [
                                                          SingleChildScrollView(
                                                            child: Container(
                                                              height:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        30),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .stretch,
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            50),
                                                                    Text(
                                                                      'Редактировать цель росхода',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          letterSpacing:
                                                                              0.5),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            20),
                                                                    Text(
                                                                      'Название',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    TextField(
                                                                      inputFormatters: [
                                                                        FilteringTextInputFormatter.deny(
                                                                            RegExp("[/|:\\\\]")),
                                                                      ],
                                                                      controller:
                                                                          celRas,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding:
                                                                            EdgeInsets.all(10),
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Icon(celRashod[e]['status'] == 'false' ? MyIcon.circle_empty : Icons.circle,
                                                                                size: 14,
                                                                                color: MyColors().greenDark),
                                                                            SizedBox(width: 10),
                                                                            celRashod[e]['status'] == 'false'
                                                                                ? Text('Не активно', style: TextStyle(color: MyColors().greenDark, fontWeight: FontWeight.bold))
                                                                                : Text(
                                                                                    'Активно',
                                                                                    style: TextStyle(color: MyColors().greenDark, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                          ],
                                                                        ),
                                                                        Spacer(),
                                                                        Switch(
                                                                          activeColor:
                                                                              MyColors().myBeige,
                                                                          value: celRashod[e]['status'] == 'true'
                                                                              ? true
                                                                              : false,
                                                                          //mySwitchTwo,
                                                                          onChanged:
                                                                              (val) {
                                                                            setState(() {
                                                                              celRashod[e]['status'] = val.toString();
                                                                            });
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            15),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          'Бизнес',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                MyColors().greenDark,
                                                                            fontSize:
                                                                                15,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                3),
                                                                        Divider(
                                                                          color:
                                                                              MyColors().greenDark,
                                                                          thickness:
                                                                              1,
                                                                          endIndent:
                                                                              280,
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            20),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              24,
                                                                          height:
                                                                              24,
                                                                          child:
                                                                              Checkbox(
                                                                            fillColor:
                                                                                MaterialStateProperty.all(MyColors().greenDark),
                                                                            shape:
                                                                                CircleBorder(),
                                                                            value:
                                                                                singleCheckBoxCell,
                                                                            onChanged:
                                                                                (newValue) {
                                                                              setState(() {
                                                                                singleCheckBoxCell = !singleCheckBoxCell;
                                                                              });
                                                                              if (singleCheckBoxCell) {
                                                                                for (var i = 0; i < istRename.length; i++) {
                                                                                  if (istRename[i]['cel_status'] == null || istRename[i]['cel_status'] == false) {
                                                                                    listIstochPrihod.add(istRename[i]['id_business']);
                                                                                    istRename[i]['cel_status'] = true;
                                                                                  }
                                                                                }
                                                                              } else {
                                                                                for (var i = 0; i < istRename.length; i++) {
                                                                                  if (listIstochPrihod.contains(istRename[i]['id_business'])) {
                                                                                    listIstochPrihod.remove(istRename[i]['id_business']);
                                                                                    istRename[i]['cel_status'] = false;
                                                                                  }
                                                                                }
                                                                              }
                                                                              print(listIstochPrihod);
                                                                            },
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                10),
                                                                        Text(
                                                                          'выбрать все',
                                                                          style:
                                                                              TextStyle(color: MyColors().greenDark),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Container(
                                                                      height:
                                                                          260,
                                                                      child: ListView.builder(
                                                                          itemCount: istRename.length,
                                                                          itemBuilder: (context, index) {
                                                                            return ButtonBisnes(
                                                                              press: () async {
                                                                                setState(() {
                                                                                  istRename[index]['cel_status'] = istRename[index]['cel_status'] != null ? !istRename[index]['cel_status'] : true;
                                                                                });
                                                                                if (istRename[index]['cel_status'] && !listIstochPrihod.contains(istRename[index]['id_business']) && !listIstochPrihodDel.contains(istRename[index]['id_business'])) {
                                                                                  listIstochPrihod.add(istRename[index]['id_business']);
                                                                                } else if (istRename[index]['cel_status'] && listIstochPrihodDel.contains(istRename[index]['id_business'])) {
                                                                                  listIstochPrihodDel.remove(istRename[index]['id_business']);
                                                                                } else if (!listIstochPrihod.contains(istRename[index]['id_business'])) {
                                                                                  listIstochPrihodDel.add(istRename[index]['id_business']);
                                                                                } else {
                                                                                  listIstochPrihod.remove(istRename[index]['id_business']);
                                                                                }
                                                                                print(listIstochPrihod);
                                                                                print(listIstochPrihodDel);
                                                                              },
                                                                              title: istRename[index]['business'],
                                                                              onColor: istRename[index]['cel_status'] ?? false,
                                                                            );
                                                                          }),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          primary: MyColors().myBeige,
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                          )),
                                                                      child:
                                                                          Text(
                                                                        'Сохранить изменения',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                16,
                                                                            letterSpacing:
                                                                                1),
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        await celRashodRename(
                                                                          listIstochPrihod,
                                                                          listIstochPrihodDel,
                                                                          celRashod[e]
                                                                              [
                                                                              'id_istochnik_cel'],
                                                                          celRashod[e]
                                                                              [
                                                                              'cel'],
                                                                          celRas
                                                                              .text,
                                                                          singleCheckBoxCell
                                                                              .toString(),
                                                                        );
                                                                        listIstochPrihod
                                                                            .clear();
                                                                        listIstochPrihodDel
                                                                            .clear();
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            20),
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
                                                                //businessFalse();
                                                                Navigator.pop(
                                                                    context);
                                                                listIstochPrihod
                                                                    .clear();
                                                                listIstochPrihodDel
                                                                    .clear();
                                                              },
                                                              icon: Icon(Icons
                                                                  .highlight_remove),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                  setState(() {});
                                                },
                                                icon: Icon(Icons.edit,
                                                    color:
                                                        MyColors().greenDark))),
                                        Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: IconButton(
                                                onPressed: () async {
                                                  ///Удаление==============
                                                  await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Container(
                                                            height: 130,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                    'Удалить источник прихода:'),
                                                                Text(
                                                                    '"${celRashod[e]['cel']}"',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                             await celRashodDelete(
                                                                               celRashod[e]['id_istochnik_cel']
                                                                             );
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Удалить',
                                                                          style: TextStyle(
                                                                              color: Colors.red,
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Text(
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
                                                icon: Icon(Icons.delete,
                                                    color:
                                                        MyColors().greenDark))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () async {
            await getBusinessRename();
            celRas.clear();
            showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              context: context,
              builder: (BuildContext ctx) => StatefulBuilder(
                builder: (BuildContext context, setState) =>
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              listIstochPrihod.clear();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.highlight_remove),
                          ),
                          Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.9,
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      'Добавить цель расхода в список',
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
                                      controller: celRas,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),

                                    ///Switch
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              switchBoxCel
                                                  ? Icons.circle
                                                  : MyIcon.circle_empty,
                                              color: MyColors().greenDark,
                                              size: 20,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              switchBoxCel
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
                                          value: switchBoxCel,
                                          onChanged: (val) {
                                            setState(() {
                                              switchBoxCel = val;
                                              //mySwitchTwo = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Container(
                                          height: 25.0,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                    color: MyColors().greenDark,
                                                    width: 1.5,
                                                  ))),
                                          child: Text(
                                            'Бизнеc',
                                            style: TextStyle(
                                                color: MyColors().greenDark),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Checkbox(
                                            fillColor: MaterialStateProperty.all(
                                                MyColors().greenDark),
                                            shape: CircleBorder(),
                                            value: addCheckBoxCel,
                                            onChanged: (newValue) {
                                              setState(() {
                                                addCheckBoxCel = !addCheckBoxCel;
                                              });
                                              if(addCheckBoxCel){
                                                for(var i = 0;i< businessesRename.length; i++){
                                                  if(!listIstochPrihod.contains(businessesRename[i]['id_business'])) {
                                                    listIstochPrihod.add(businessesRename[i]['id_business']);
                                                  }
                                                }
                                              }else{
                                                for(var i = 0;i< businessesRename.length; i++){
                                                  listIstochPrihod.remove(businessesRename[i]['id_business']);
                                                }
                                              }
                                              print(listIstochPrihod);
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'выбрать все',
                                          style: TextStyle(
                                              color: MyColors().greenDark),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 260,
                                      child: ListView.builder(
                                          itemCount: businessesRename.length,
                                          itemBuilder: (context, index) {
                                            return ButtonBisnes(
                                                press: () async {
                                                  setState(() {
                                                    if (listIstochPrihod.contains(
                                                        businessesRename[index]['id_business'])) {
                                                      listIstochPrihod.remove(
                                                          businessesRename[index]['id_business']);
                                                    } else if (listIstochPrihod
                                                        .contains(businessesRename[
                                                    index]['id_business']) !=
                                                        true) {
                                                      listIstochPrihod.add(
                                                          businessesRename[index]['id_business']);
                                                    }
                                                    print(listIstochPrihod);
                                                  });
                                                },
                                                title: businessesRename[index]['business'],
                                                onColor: listIstochPrihod.contains(businessesRename[index]['id_business'])
                                            );
                                          }),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: MyColors().myBeige,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          )),
                                      child: Text(
                                        'Добавить цель расхода',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing: 1),
                                      ),
                                      onPressed: () async {
                                        await addCelPrihod(
                                          celRas.text,
                                          switchBoxCel.toString(),
                                          listIstochPrihod,
                                        );
                                        keysCell.add(GlobalKey());
                                        keysCellRas.add(GlobalKey());
                                        listIstochPrihod.clear();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                Text('Цель расхода'),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
