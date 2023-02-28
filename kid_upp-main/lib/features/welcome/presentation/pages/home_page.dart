import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kid_upp/constants/colors.dart';
import 'package:kid_upp/constants/home_page_menu_items.dart';
import 'package:kid_upp/constants/pages_constant.dart';
import 'package:kid_upp/features/welcome/domain/entities/user/user_entity.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/pages/lesson_plan_page.dart';
import 'package:kid_upp/features/welcome/presentation/pages/splash_page.dart';

import '../widgets/general_app_bottom_bar.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homePageItems = HomePageMenuItems.homePageMenuItems();
    return MaterialApp(
      home: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (blocContext, getSingleUserState) {
          if (getSingleUserState is GetSingleUserLoading) {
            return SplashPage();
          }
          if (getSingleUserState is GetSingleUserLoaded) {
            final currentUser = getSingleUserState.user;          
            return Scaffold(
                body: PageView(
                  homePageItems: homePageItems,
                  currentUser: currentUser,
                  homePageContext: context,
                ),
                bottomNavigationBar: GeneralAppBottomBar(
                  uid: currentUser.uid!,
                  currentUser: currentUser,
                  generalContext: context,
                  requestPage: PageConst.homePage,
                ));
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class PageView extends StatelessWidget {
  const PageView({
    Key? key,
    required this.homePageItems,
    required this.currentUser,
    required this.homePageContext,
  }) : super(key: key);

  final List homePageItems;
  final UserEntity currentUser;
  final BuildContext homePageContext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            padding: const EdgeInsets.only(top: 180),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Image.asset(
                                      "assets/images/instagram.png")),
                              Container(
                                width: 110,
                                height: 110,
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
                                      scale: 1,
                                      image: AssetImage(
                                          "assets/images/profile_photo.png")),
                                  border: Border.all(
                                    color: AppColors.themeColor,
                                    width: 3,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Image.asset(
                                      "assets/images/announcement.png")),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "${currentUser.childrenName!.elementAt(0)["childName"]}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Sınıf: ${currentUser.childrenName!.elementAt(0)["className"]}",
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Container(
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    -3.0,
                                  ),
                                )
                              ],
                              color: Colors.white,
                              border: Border.all(width: 3, color: Colors.grey)),
                          child: ListView.builder(
                              itemCount: homePageItems.length,
                              itemBuilder: (listViewContext, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 7.5,
                                      left: 15,
                                      right: 15,
                                      bottom: 7.5),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(homePageContext,
                                          homePageItems[index][2],
                                          arguments: [currentUser]);
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              width: double.infinity,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  color: AppColors.themeColor,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  border: Border.all(
                                                    width: 3,
                                                    color: AppColors
                                                        .borderColorFromThemeColor,
                                                  )),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 100),
                                                    child: Text(
                                                      homePageItems[index][1],
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                              color: AppColors.themeColor,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: AppColors
                                                      .borderColorFromThemeColor,
                                                  width: 3),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    homePageItems[index][0]),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
