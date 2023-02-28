import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kid_upp/constants/colors.dart';
import 'package:kid_upp/features/welcome/domain/entities/user/user_entity.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/child/cubit/add_medicine_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/class/get_class_info_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/pages/splash_page.dart';
import 'package:kid_upp/features/welcome/presentation/widgets/general_app_bottom_bar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../constants/pages_constant.dart';
import '../../../../core/date_getter.dart';
import '../cubit/child/get_child_info/get_child_info_cubit.dart';

class MedicinePage extends StatefulWidget {
  final UserEntity currentUser;
  String? childId;

  MedicinePage({super.key, required this.currentUser});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  @override
  void initState() {
    super.initState();
    widget.childId = widget.currentUser.childrenName!.elementAt(0)["childId"];
    BlocProvider.of<GetChildInfoCubit>(context)
        .getChildInfo(childId: widget.childId!);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/wallpaper2.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 7.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(
                                            5.0,
                                            5.0,
                                          ),
                                        )
                                      ],
                                      color: Colors.white,
                                      image: const DecorationImage(
                                          scale: 3,
                                          image: AssetImage(
                                              "assets/images/medicine.png")),
                                      border: Border.all(
                                        color: AppColors.themeColor,
                                        width: 3,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        buildShowDialog(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.themeColor,
                                        side: const BorderSide(
                                            color: AppColors
                                                .borderColorFromThemeColor,
                                            width: 2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15), // <-- Radius
                                        ),
                                      ),
                                      child: const Text(
                                        "İlaç Ekle",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<GetChildInfoCubit,
                                    GetChildInfoState>(
                                  builder: (blocContext, getChildInfostate) {
                                    if (getChildInfostate
                                        is GetChildInfoLoading) {
                                      return SplashPage();
                                    }
                                    if (getChildInfostate
                                        is GetChildInfoLoaded) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: MedicineTable(
                                              medicineList: getChildInfostate
                                                  .childInfo.medicineList),
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                )))
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 175),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 80,
                    width: 170,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "İlaçlar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )),
          ],
        )),
        bottomNavigationBar: GeneralAppBottomBar(
          uid: widget.currentUser.uid!,
          generalContext: context,
          currentUser: widget.currentUser,
          requestPage: PageConst.lessonPlan,
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertWidget(
            childId: widget.childId!,
          );
        });
  }
}

class AlertWidget extends StatefulWidget {
  final String? childId;
  const AlertWidget({
    Key? key,
    required this.childId,
  }) : super(key: key);

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  final TextEditingController _medicineName = TextEditingController();
  final TextEditingController _medicineHour = TextEditingController();
  final TextEditingController _medicineDetails = TextEditingController();

  String? selectedDay;
  DateTime dateNow = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDay = "${dateNow.day}/${dateNow.month}/${dateNow.year}";
  }

  @override
  void dispose() {
    _medicineName.dispose();
    _medicineHour.dispose();
    _medicineDetails.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.alertDialogBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          side: BorderSide(width: 4, color: AppColors.alertDialogBorderColor)),
      content: Stack(
        children: <Widget>[
          Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text("İlaç Adı",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: _medicineName,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    ),
                  ),
                ),
                const Text("Tarih",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      DateTime? selectedDate =
                          await DateTimeGetter.selectDate(context);
                      setState(() {
                        selectedDay =
                            "${selectedDate!.day}/${selectedDate.month}/${selectedDate.year}";
                      });
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedDay!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18)),
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
                const Text("Saat",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: _medicineHour,
                    inputFormatters: [
                      MaskTextInputFormatter(
                          mask: '##:##',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy)
                    ],
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '00:00',
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    ),
                  ),
                ),
                const Text("Detaylı Bilgi",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: _medicineDetails,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonBackgroundColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        side: const BorderSide(
                            width: 2, color: AppColors.buttonBorderColor)),
                    child: const Text(
                      "İlaç Ekle",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    onPressed: () {
                      Map<String, dynamic> medicineList = {
                        "Details": _medicineDetails.text,
                        "date": selectedDay,
                        "hour": _medicineHour.text,
                        "medicineName": _medicineName.text,
                        "isGiven": false
                      };

                      BlocProvider.of<AddMedicineCubit>(context).addMedicine(
                          medicineList: medicineList, childId: widget.childId!);

                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MedicineTable extends StatelessWidget {
  final List? medicineList;
  const MedicineTable({Key? key, required this.medicineList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Card(
          elevation: 7,
          child: DataTable(
              dataRowHeight: 75,
              border: const TableBorder(
                horizontalInside: BorderSide(color: Colors.grey, width: 0.7),
                verticalInside: BorderSide(color: Colors.grey, width: 0.7),
                bottom: BorderSide(color: Colors.grey, width: 0.7),
                top: BorderSide(color: Colors.grey, width: 0.7),
                left: BorderSide(color: Colors.grey, width: 0.7),
                right: BorderSide(color: Colors.grey, width: 0.7),
              ),
              columns: const [
                DataColumn(
                    label: Text(
                  "İlaç Adı",
                  style: TextStyle(fontSize: 18),
                )),
                DataColumn(
                    label: Text("Tarih", style: TextStyle(fontSize: 18))),
                DataColumn(label: Text("Saat", style: TextStyle(fontSize: 18))),
                DataColumn(
                    label: Text("Ek Bilgiler", style: TextStyle(fontSize: 18))),
                DataColumn(
                    label: Text("Verildi", style: TextStyle(fontSize: 18)))
              ],
              rows: rows())),
    );
  }

  List<DataRow> rows() {
    List<DataRow> dataRow = [];

    for (var element in medicineList!) {
      dataRow.add(
        DataRow(
          cells: [
            DataCell(
              Text(element["medicineName"],
                  style: const TextStyle(fontSize: 18)),
            ),
            DataCell(
              Text(element["date"], style: const TextStyle(fontSize: 18)),
            ),
            DataCell(
              Text(element["hour"], style: const TextStyle(fontSize: 18)),
            ),
            DataCell(
              Text(element["Details"], style: const TextStyle(fontSize: 18)),
            ),
            DataCell(
              Checkbox(
                onChanged: (bool? value) => null,
                value: element["isGiven"],
              ),
            ),
          ],
        ),
      );
    }
    return dataRow;
  }
}
