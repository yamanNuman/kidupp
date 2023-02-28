import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kid_upp/constants/pages_constant.dart';
import 'package:kid_upp/features/welcome/presentation/pages/lesson_plan_page.dart';
import 'package:kid_upp/features/welcome/presentation/pages/medicine_page.dart';
import 'package:kid_upp/features/welcome/presentation/pages/menu_page.dart';
import 'package:kid_upp/features/welcome/presentation/pages/profile_page.dart';
import 'package:kid_upp/features/welcome/presentation/pages/sign_in_page.dart';

import 'features/welcome/presentation/pages/home_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments as List;
    switch (settings.name) {
      case PageConst.lessonPlan:
        {
          return routeBuilder(LessonPlan(currentUser: args[0]));
        }
      case PageConst.menuPage:
        {
          return routeBuilder(MenuPage(currentUser: args[0]));
        }
      case PageConst.signInPage:
        {
          return routeBuilder(const SignInPage());
        }
      case PageConst.profilePage:
        {
          return routeBuilder(ProfilePage(currentUser: args[0]));
        }
      case PageConst.homePage:
        {
          return routeBuilder(HomePage(uid: args[0]));
        }

      case PageConst.medicinePage:
        {
          return routeBuilder(MedicinePage(currentUser: args[0]));
        }

      default:
        const NoPageFound();
    }
    return null;
  }

  static dynamic routeBuilder(Widget child) {
    return MaterialPageRoute(builder: (context) => child);
  }
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(AppLocalizations.of(context)!.pageNotFound)),
    );
  }
}
