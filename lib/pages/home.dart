import 'dart:io';

import 'package:finance/colors/colors.dart';
import 'package:finance/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:finance/models/finance_model.dart';
import 'package:finance/pages/add.dart';
import 'package:finance/pages/see_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FetchDataCubit>(context).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('darkModeBox').listenable(),
        builder: (context, box, child) {
          var darkMode = box.get('darkMode', defaultValue: false);

          return Scaffold(
            appBar: AppBar(
              title: const Text("Welcome, Nabil"),
              actions: [
                IconButton(
                    onPressed: () {
                      box.put('darkMode', !darkMode);
                    },
                    icon: Icon(!darkMode
                        ? Icons.brightness_2
                        : Icons.brightness_5_rounded))
              ],
            ),
            drawer: Drawer(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DrawerHeader(
                      child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Text("N"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Nabil AL Amawi"),
                    ],
                  )),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          title: Text("Dark Mode"),
                          trailing: Switch(
                            value: darkMode,
                            onChanged: (value) {
                              box.put('darkMode', !darkMode);
                            },
                          ),
                        ),
                        Divider(),
                        ListTile(
                            title: Text("All Activites"),
                            trailing: Icon(Icons.local_activity),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SeeAll(),
                                  ));
                            }),
                        ListTile(
                            title: Text("Close Drawer"),
                            trailing: Icon(Icons.close),
                            onTap: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                  ListTile(
                      title: Text("Exit App"),
                      trailing: Icon(Icons.exit_to_app),
                      onTap: () {
                        SystemNavigator.pop();
                      }),
                ],
              ),
            )),
            body: BlocBuilder<FetchDataCubit, FetchDataState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: state is FetchDataLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 120,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 20),
                                      decoration: BoxDecoration(
                                        color: kBlackColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "My Balance",
                                            style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            NumberFormat.compactCurrency(
                                                    decimalDigits: 2,
                                                    symbol: "")
                                                .format(BlocProvider.of<
                                                        FetchDataCubit>(context)
                                                    .sum)
                                                .toString(),
                                            style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 32),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: kSeconderyPurble,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(12))),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 120,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 20),
                                      decoration: BoxDecoration(
                                        color: kBlackColor,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(12)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Today Balance",
                                            style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            BlocProvider.of<FetchDataCubit>(
                                                    context)
                                                .todaySum
                                                .toString(),
                                            style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 32),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: kSeconderyBlue,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12))),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddPage(isPlus: true),
                                        )),
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: kSeconderyGreen,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Row(children: [
                                        Icon(
                                          Icons.add,
                                          color: kPrimaryGreen,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Plus",
                                          style:
                                              TextStyle(color: kPrimaryGreen),
                                        )
                                      ]),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddPage(isPlus: false),
                                      )),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: kSeconderyRed,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(children: [
                                      Icon(
                                        Icons.remove,
                                        color: kPrimaryRed,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Minus",
                                        style: TextStyle(color: kPrimaryRed),
                                      )
                                    ]),
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Activity",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Spacer(),
                                GestureDetector(
                                  child: Text(
                                    "See All",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SeeAll(),
                                        ));
                                  },
                                )
                              ],
                            ),
                            Expanded(
                                child: ListView.builder(
                              itemCount:
                                  BlocProvider.of<FetchDataCubit>(context)
                                      .todayFinanceList
                                      .length,
                              itemBuilder: (context, index) {
                                List<FinanceModel> myList =
                                    BlocProvider.of<FetchDataCubit>(context)
                                        .todayFinanceList
                                        .reversed
                                        .toList();
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Dismissible(
                                    background: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Align(
                                        child: Icon(
                                          Icons.edit,
                                          color: kPrimaryGreen,
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      decoration:
                                          BoxDecoration(color: kSeconderyGreen),
                                    ),
                                    secondaryBackground: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Align(
                                        child: Icon(
                                          Icons.delete,
                                          color: kPrimaryRed,
                                        ),
                                        alignment: Alignment.centerRight,
                                      ),
                                      decoration:
                                          BoxDecoration(color: kSeconderyRed),
                                    ),
                                    onDismissed: (direction) {
                                      if (direction ==
                                          DismissDirection.startToEnd) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddPage(
                                                isPlus:
                                                    myList[index].financeValue <
                                                            0
                                                        ? false
                                                        : true,
                                                financeModel: myList[index],
                                              ),
                                            ));
                                      } else if (direction ==
                                          DismissDirection.endToStart) {
                                        myList[index].delete();
                                        BlocProvider.of<FetchDataCubit>(context)
                                            .fetchData();
                                      }
                                    },
                                    key: UniqueKey(),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: Row(children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              myList[index].financeValue > 0
                                                  ? kSeconderyGreen
                                                  : kSeconderyRed,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(myList[index]
                                                .details
                                                .toString()),
                                            Text(DateFormat.yMMMEd()
                                                .format(myList[index].date)),
                                          ],
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Text(myList[index].financeValue > 0
                                                ? "+"
                                                : ""),
                                            Text(myList[index]
                                                .financeValue
                                                .toString()),
                                          ],
                                        )
                                      ]),
                                    ),
                                  ),
                                );
                              },
                            ))
                          ],
                        ),
                );
              },
            ),
          );
        });
  }
}
