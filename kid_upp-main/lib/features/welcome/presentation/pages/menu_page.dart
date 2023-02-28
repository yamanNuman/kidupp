import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kid_upp/constants/colors.dart';
import 'package:kid_upp/core/date_getter.dart';
import 'package:kid_upp/features/welcome/domain/entities/user/user_entity.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/class/get_class_info_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/pages/splash_page.dart';
import 'package:kid_upp/features/welcome/presentation/widgets/general_app_bottom_bar.dart';

import '../../../../constants/pages_constant.dart';

class MenuPage extends StatefulWidget {
  final UserEntity currentUser;
  String? classId;
  

  MenuPage({super.key, required this.currentUser});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  String? selectedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = "${dateNow.day}/${dateNow.month}/${dateNow.year}";
    widget.classId = widget.currentUser.childrenName!.elementAt(0)["classId"];
    BlocProvider.of<GetClassInfoCubit>(context)
        .getClassInfo(classId: widget.classId!);
  }

  DateTime dateNow = DateTime.now();

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
                                              "assets/images/mealmenu.png")),
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
                                    IconButton(
                                        onPressed: () async {
                                          DateTime? selectedDate =
                                              await DateTimeGetter.selectDate(
                                                  context);
                                          setState(() {
                                            selectedDay =
                                              "${selectedDate!.day}/${selectedDate.month}/${selectedDate.year}";
                                          });
                                          
                                        },
                                        icon: const Icon(Icons.calendar_month)),
                                    Text(
                                      selectedDay!,
                                      style: const TextStyle(fontSize: 16),
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
                                  builder: (blocContext, getClassInfostate) {
                                    if (getClassInfostate
                                        is GetClassInfoLoading) {
                                      return SplashPage();
                                    }
                                    if (getClassInfostate
                                        is GetClassInfoLoaded) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: MenuTable(
                                            mealMenu: getClassInfostate
                                                .classInfo.mealMenu,
                                            selectedDay: selectedDay!),
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
                        "Yemek Menüsü",
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

class MenuTable extends StatelessWidget {
  final String selectedDay;
  final List? mealMenu;

  const MenuTable({Key? key, required this.selectedDay, required this.mealMenu})
      : super(key: key);

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
                  "Saat",
                  style: TextStyle(fontSize: 18),
                )),
                DataColumn(label: Text("Öğün", style: TextStyle(fontSize: 18))),
                DataColumn(label: Text("Liste", style: TextStyle(fontSize: 18)))
              ],
              rows: rows())),
    );
  }

  List<DataRow> rows() {
    List<DataRow> dataRow = [];
    for (var element in mealMenu!) {
      if (element["day"] == selectedDay) {
        dataRow.add(DataRow(cells: [
          DataCell(
            Text(element["hour"], style: const TextStyle(fontSize: 18)),
          ),
          DataCell(
            Text(element["meal"], style: const TextStyle(fontSize: 18)),
          ),
          DataCell(
            Tooltip(
                message:
                    "Eğer yemek listesinin tamamı görünmüyorsa kaydırarak bakabilirsiniz.",
                triggerMode: TooltipTriggerMode.tap,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(element["content"],
                        style: const TextStyle(fontSize: 18)))),
          ),
        ]));
      }
    }

    return dataRow;
  }
}
