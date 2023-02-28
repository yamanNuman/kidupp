import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kid_upp/constants/colors.dart';
import 'package:kid_upp/features/welcome/domain/entities/user/user_entity.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/auth/auth_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/widgets/general_app_bottom_bar.dart';

import '../../../../constants/pages_constant.dart';

class ProfilePage extends StatelessWidget {
  
  final UserEntity currentUser;
  
  const ProfilePage({super.key, required this.currentUser});
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
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: AppColors.themeColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                      color:
                                          AppColors.borderColorFromThemeColor,
                                      width: 3)),
                              child: const Center(
                                  child: Text(
                                "Profil Ayarları",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: AppColors.themeColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                      color:
                                          AppColors.borderColorFromThemeColor,
                                      width: 3)),
                              child: const Center(
                                  child: Text(
                                "Hesap Ayarları",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<AuthCubit>(context).loggedOut();
                              Navigator.pushNamedAndRemoveUntil(context,
                                  PageConst.signInPage, (route) => false);
                            },
                            child: Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: AppColors.exitButtonColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.all(
                                        color:
                                            AppColors.borderColorFromThemeColor,
                                        width: 3)),
                                child: const Center(
                                    child: Text(
                                  "Çıkış Yap",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 175),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 40,
                    width: 170,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Profil",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    )),
                  ),
                )),
          ],
        )),
        bottomNavigationBar: GeneralAppBottomBar(
          uid: currentUser.uid!,
          generalContext: context,
          currentUser: currentUser,
          requestPage: PageConst.profilePage,
        ),
      ),
    );
  }
}
