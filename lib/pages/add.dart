import 'package:finance/colors/colors.dart';
import 'package:finance/cubit/addcubit/add_data_cubit.dart';
import 'package:finance/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:finance/models/finance_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPage extends StatefulWidget {
  FinanceModel? financeModel;
  final bool isPlus;
  AddPage({super.key, required this.isPlus, this.financeModel});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController detailsCon = TextEditingController();
  String num = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.financeModel != null) {
      setState(() {
        detailsCon.text = widget.financeModel!.details;

        num = widget.financeModel!.financeValue < 0
            ? (widget.financeModel!.financeValue * -1).toString()
            : (widget.financeModel!.financeValue).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.isPlus ? "Plus" : "Minus"),
      ),
      body: BlocProvider(
        create: (context) => AddDataCubit(),
        child: BlocBuilder<AddDataCubit, AddDataState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: kPrimaryPurble,
                            borderRadius: BorderRadius.circular(12)),
                        child: TextField(
                          controller: detailsCon,
                          style: TextStyle(color: kSeconderyPurble),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(12),
                              hintText: "Details ...",
                              hintStyle: TextStyle(color: kSeconderyPurble)),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: widget.isPlus
                                  ? kSeconderyGreen
                                  : kSeconderyRed,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              widget.isPlus
                                  ? (num == "" ? "+ 0.0" : "+ " + num)
                                  : (num == "" ? "- 0.0" : "- " + num),
                              style: TextStyle(
                                  color: widget.isPlus
                                      ? kPrimaryGreen
                                      : kPrimaryRed,
                                  fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                keyPadItem(
                                  text: "7",
                                  onTap: () {
                                    setState(() {
                                      num = num + "7";
                                    });
                                  },
                                ),
                                keyPadItem(
                                  text: "8",
                                  onTap: () {
                                    setState(() {
                                      num = num + "8";
                                    });
                                  },
                                ),
                                keyPadItem(
                                  text: "9",
                                  onTap: () {
                                    setState(() {
                                      num = num + "9";
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                keyPadItem(
                                  text: "4",
                                  onTap: () {
                                    setState(() {
                                      num = num + "4";
                                    });
                                  },
                                ),
                                keyPadItem(
                                  text: "5",
                                  onTap: () {
                                    setState(() {
                                      num = num + "5";
                                    });
                                  },
                                ),
                                keyPadItem(
                                  text: "6",
                                  onTap: () {
                                    setState(() {
                                      num = num + "6";
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                keyPadItem(
                                  text: "1",
                                  onTap: () {
                                    setState(() {
                                      num = num + "1";
                                    });
                                  },
                                ),
                                keyPadItem(
                                  text: "2",
                                  onTap: () {
                                    setState(() {
                                      num = num + "2";
                                    });
                                  },
                                ),
                                keyPadItem(
                                  text: "3",
                                  onTap: () {
                                    setState(() {
                                      num = num + "3";
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                keyPadItem(
                                  text: ".",
                                  onTap: () {
                                    setState(() {
                                      num.contains(".")
                                          ? null
                                          : num = num + ".";
                                    });
                                  },
                                ),
                                keyPadItem(
                                  text: "0",
                                  onTap: () {
                                    setState(() {
                                      num = num + "0";
                                    });
                                  },
                                ),
                                keyPadItem(
                                  text: "<",
                                  onTap: () {
                                    setState(() {
                                      num == ""
                                          ? null
                                          : num =
                                              num.substring(0, num.length - 1);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: kSeconderyBlue,
                            foregroundColor: kPrimaryBlue,
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () {
                            try {
                              if (widget.financeModel != null) {
                                widget.financeModel!.details = detailsCon.text;
                                widget.financeModel!.financeValue =
                                    widget.isPlus
                                        ? double.parse(num)
                                        : double.parse(num) < 0
                                            ? double.parse(num)
                                            : double.parse(num) * -1;
                                widget.financeModel!.save();
                              } else {
                                BlocProvider.of<AddDataCubit>(context)
                                    .addData(FinanceModel(
                                  details: detailsCon.text,
                                  financeValue: widget.isPlus
                                      ? double.parse(num)
                                      : double.parse(num) * -1,
                                  date: DateTime.now(),
                                ));
                              }
                              BlocProvider.of<FetchDataCubit>(context)
                                  .fetchData();
                              // BlocProvider.of<FetchDataCubit>(context)
                              //     .fetchDateData(
                              //         dateTime: BlocProvider.of<FetchDataCubit>(
                              //                 context)
                              //             .sel);
                              Navigator.pop(context);
                            } on Exception catch (e) {
                              // TODO
                            }
                          },
                          child: Text(
                              widget.financeModel != null ? "SAVE" : "ADD"),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: kSeconderyRed,
                            foregroundColor: kPrimaryRed,
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("CANCEL"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class keyPadItem extends StatelessWidget {
  final String text;
  final Function() onTap;
  const keyPadItem({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: kBlackColor, borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: kWhiteColor, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
