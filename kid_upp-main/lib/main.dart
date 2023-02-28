import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/auth/auth_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/child/cubit/add_medicine_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/child/get_child_info/get_child_info_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/class/get_class_info_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/credential/credential_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/pages/lesson_plan_page.dart';
import 'package:kid_upp/features/welcome/presentation/pages/sign_in_page.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'features/welcome/presentation/pages/home_page.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'on_generate_route.dart';
import 'injection_container.dart' as di;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    //getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
        BlocProvider(create: (_) => di.sl<GetClassInfoCubit>()),
        BlocProvider(create: (_) => di.sl<GetChildInfoCubit>()),
        BlocProvider(create: (_) => di.sl<AddMedicineCubit>())
        
      ],
      child: MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, widget!),
            breakpoints: const [
              ResponsiveBreakpoint.resize(350, name: MOBILE),
              ResponsiveBreakpoint.autoScale(600, name: TABLET),
              ResponsiveBreakpoint.resize(800, name: DESKTOP),
              ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
            ]),
        debugShowCheckedModeBanner: false,
        supportedLocales: L10n.all,
        locale: _locale, //all properties in L10n class
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: "/",
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (BuildContext context, authState) {
                if (authState is Authenticated) {                
                  return HomePage(uid: authState.uid);
                } else {
                  return const SignInPage();
                }
              },
            );
          },
      
        },
      ),
    );
  }
}
