import 'package:flutter/material.dart';
import 'package:kid_upp/features/welcome/domain/entities/user/user_entity.dart';

import '../../../../constants/pages_constant.dart';

class GeneralAppBottomBar extends StatelessWidget {
  final BuildContext generalContext;
  final String requestPage;
  final String uid;
  final UserEntity currentUser;

  const GeneralAppBottomBar({
    Key? key,
    required this.generalContext,
    required this.requestPage,
    required this.uid,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: SizedBox(
        height: 40,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/images/newmessage.png"),
                height: 30,
                width: 30,
              ),
              GestureDetector(
                onTap: () => requestPage == PageConst.homePage
                    ? null
                    : Navigator.pushNamed(generalContext, PageConst.homePage,
                        arguments: [uid]),
                child: const Image(
                  image: AssetImage("assets/images/home.png"),
                  height: 30,
                  width: 30,
                ),
              ),
              GestureDetector(
                onTap: () => requestPage == PageConst.profilePage
                    ? null
                    : Navigator.pushNamed(generalContext, PageConst.profilePage,
                        arguments: [currentUser]),
                child: const Image(
                  image: AssetImage("assets/images/customer.png"),
                  height: 30,
                  width: 30,
                ),
              )
            ]),
      ),
    );
  }
}
