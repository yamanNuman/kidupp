import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kid_upp/constants/colors.dart';
import 'package:kid_upp/constants/dropdown_items.dart';
import 'package:kid_upp/features/welcome/domain/entities/user/user_entity.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/auth/auth_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/class/get_class_info_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/pages/splash_page.dart';
import 'package:kid_upp/features/welcome/presentation/widgets/general_app_bottom_bar.dart';

import '../../../../constants/pages_constant.dart';

class LessonPlan extends StatefulWidget {
  final UserEntity currentUser;
  String? classId;

  LessonPlan({super.key, required this.currentUser});

  @override
  State<LessonPlan> createState() => _LessonPlanState();
}

class _LessonPlanState extends State<LessonPlan> {
  @override
  void initState() {
    super.initState();
    widget.classId = widget.currentUser.childrenName!.elementAt(0)["classId"];
    BlocProvider.of<GetClassInfoCubit>(context).getClassInfo(classId: widget.classId!);
  }

  String? selectedDay = "Pazartesi";

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
                                              "assets/images/schedule.png")),
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
                                    const Text(
                                      "Gün:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      items: DropDownItems.dropdownDays,
                                      value: selectedDay,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedDay = newValue!;
                                        });
                                      },
                                    )
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
                              child: BlocBuilder<GetClassInfoCubit,
                                  GetClassInfoState>(
                                builder: (blocContext, getClassInfoState) {
                                  if (getClassInfoState
                                      is GetClassInfoLoading) {
                                    return SplashPage();
                                  }
                                  if (getClassInfoState is GetClassInfoLoaded) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: LessonPlanTable(
                                        lessonPlan: getClassInfoState
                                            .classInfo.lessonPlan,
                                        selectedDay: selectedDay!,
                                      ),
                                    );
                                  }

                                  return const SizedBox();
                                },
                              ),
                            ))
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
                        "Ders Programı",
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
}

class LessonPlanTable extends StatelessWidget {
  final List? lessonPlan;
  final String selectedDay;

  const LessonPlanTable({
    Key? key,
    required this.lessonPlan,
    required this.selectedDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Card(
          elevation: 7,         
          child: DataTable(
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
                  "Saat",
                  style: TextStyle(fontSize: 18),
                )),
                DataColumn(label: Text("Ders", style: TextStyle(fontSize: 18)))
              ],
              rows: rows())),
    );
  }

  List<DataRow> rows() {
    List<DataRow> dataRow = [];
    /* For Cell Color
    int counter = 0;
    Color evenBackColor = AppColors.tableCellBackColor; */
    for (var element in lessonPlan!) {
      if (element["day"] == selectedDay) {
        dataRow.add(
          DataRow(
            cells: [
              DataCell(
                Text(element["hour"], style: const TextStyle(fontSize: 18)),
              ),
              DataCell(
                  Text(element["lesson"], style: const TextStyle(fontSize: 18)))
            ],
          ),
        );
      }
    }

    return dataRow;
  }
}
