import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:kid_upp/constants/toast_message.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/auth/auth_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/cubit/credential/credential_cubit.dart';
import 'package:kid_upp/features/welcome/presentation/pages/home_page.dart';
import 'package:kid_upp/features/welcome/presentation/pages/splash_page.dart';
import 'package:kid_upp/main.dart';
import '../../../../constants/languages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isSigningUser = false;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (BuildContext context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            toast(AppLocalizations.of(context)!.invalidMailPassword);
          }
        },
        builder: (BuildContext context, credentialState) {
          if (credentialState is CredentialSuccess) {
            
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {             
              if (authState is Authenticated) {
                return HomePage(uid: authState.uid);
              } else {
                return _bodyWidget();
              }
            });
          }
          return SplashPage();
        },
      ),
      bottomNavigationBar: const SelectLanguage(),
    );
  }

  _bodyWidget() {
    return SafeArea(
      child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/wallpaper.jpg"),
                fit: BoxFit.cover),
          ),
          child: KeyboardVisibilityBuilder(
            builder: (BuildContext context, bool isKeyboardVisible) {
              return Column(
                children: [
                  Expanded(flex: 3, child: Row()),
                  if (!isKeyboardVisible) const AppEmblem(),
                  const Expanded(flex: 1, child: AppName()),
                  _isSigningUser == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Please wait",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xff370099)))
                          ],
                        )
                      : const SizedBox(
                          width: 0,
                          height: 0,
                        ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        //username
                        controller: _emailcontroller,
                        autofocus: true,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: AppLocalizations.of(context)!.username,
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        //password
                        controller: _passwordcontroller,
                        autofocus: true,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: AppLocalizations.of(context)!.password,
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(AppLocalizations.of(context)!.forgotPassword,
                            style: const TextStyle(
                                color: Color(0xFF4163DE),
                                fontSize: 14,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              backgroundColor: const Color(0xFFFDDA42),
                              side: const BorderSide(color: Color(0xFFD4B425))),
                          onPressed: () {
                            _signUser();
                          },
                          child: Text(
                            AppLocalizations.of(context)!.logIn,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }

  void _signUser() {
    setState(() {
      _isSigningUser = true;
    });

    BlocProvider.of<CredentialCubit>(context)
        .signInUser(
            email: _emailcontroller.text, password: _passwordcontroller.text)
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _emailcontroller.clear();
      _passwordcontroller.clear();
      _isSigningUser = false;
    });
  }
}

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xfffecfb5),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          DropdownButton<Language>(
            hint: Text(AppLocalizations.of(context)!.language),
            underline: const SizedBox(),
            icon: const Icon(
              Icons.language,
              color: Colors.black,
            ),
            onChanged: (Language? language) async {
              if (language != null) {
                Locale locale = await setLocale(language.languageCode);
                MyApp.setLocale(context, locale);
              }
            },
            items: Language.languageList()
                .map<DropdownMenuItem<Language>>(
                  (e) => DropdownMenuItem<Language>(
                    value: e,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          e.flag,
                          style: const TextStyle(fontSize: 30),
                        ),
                        Text(e.name)
                      ],
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}

class AppEmblem extends StatelessWidget {
  const AppEmblem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 150,
        height: 150,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage("assets/images/amblem.jpg"),
                fit: BoxFit.cover)),
      ),
    );
  }
}

class AppName extends StatelessWidget {
  const AppName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            "KidUpp",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Inter"),
          ),
        ),
      ),
    );
  }
}
