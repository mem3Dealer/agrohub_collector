import 'dart:developer';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_events.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:agrohub_collector_flutter/shared/myWidgets.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/loginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void initState() {
    loadFirstPage();
    super.initState();
    _login.addListener(() {
      if (_login.text.isNotEmpty) {
        isItCompleted();
        // setState(() {
        // });
      }
    });
    _password.addListener(() {
      isItCompleted();
      setState(() {});
    });
    // loadFirstPage();
  }

  @override
  void dispose() {
    _login.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LoginPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  final authBloc = GetIt.I.get<AuthenticationBloc>();
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  bool isLoading = false;
  bool visible = true;
  bool isItComplete = false;
  bool isError = false;

  // Future<void> _initCollectingOrder(int id) async {
  //   await ordersBloc.add(InitCollectingOrder(collectingOrderId: id));
  // }
  bool isItCompleted() {
    if (_login.text.isNotEmpty && _password.text.isNotEmpty) {
      return isItComplete = true;
    } else {
      return false;
    }
  }

  void hideErrorText() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {
        isError = false;
      });
    });
  }

  visibleIcon() {
    setState(() {
      visible = !visible;
    });
  }

  loadFirstPage() {
    setState(() {
      isLoading = true;
    });

    authBloc.add(
      AuthenticationInit(
        onError: () {
          setState(() {
            isLoading = false;
          });
        },
        onSuccess: (String role, int currentCollectingOrderId) {
          if (role == 'collector') {
            if (currentCollectingOrderId != 0) {
              ordersBloc.add(InitCollectingOrder(
                  collectingOrderId: currentCollectingOrderId,
                  context: context));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const AllOrdersPage(),
                  ));
            }
          } else {
            print('he was a farmer');
          }
        },
      ),
    );
  }

  Future<void> loginFarmer() async {
    setState(() {
      isLoading = true;
    });
    authBloc.add(
      await AuthenticationLogIn(
        login: _login.text,
        password: _password.text,
        onError: (dynamic e) {
          inspect(e);

          // errorToast(
          //   message: e.message,
          //   context: context,
          // );
          setState(() {
            isLoading = false;
            isError = true;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          });
          hideErrorText();
        },
        onSuccess: () {
          loadFirstPage();
        },
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    TextStyle _style = const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        color: Color(0xff363B3F),
        fontSize: 16);
    InputDecoration inDec = const InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(16, 16, 0, 16),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff69A8BB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffCACED0)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff69A8BB),
        ),
      ),
      labelStyle: TextStyle(color: Color(0xffCACED0)),
      fillColor: Colors.white,
      filled: true,
      hintText: 'Логин',
    );

    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            left: 16,
            bottom: 40,
            right: 16,
            // top: 32,
          ),
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 24.0, top: 40),
              child: SizedBox(
                height: 48,
                child: Text(
                  'Форма входа',
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xff363B3F),
                    fontSize: 32,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: loginField(_style, inDec),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: passwordField(_style, inDec),
            ),
            isError
                ? Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Введите правильный логин и пароль',
                      style: _style.copyWith(color: Colors.red),
                    ))
                : SizedBox.shrink(),
            enterButton(isItCompleted()),
          ],
        ),
      ),
    );
  }

  SizedBox enterButton(bool isItComplete) {
    return SizedBox(
      height: 56,
      width: 382,
      // child: TapDebouncer(
      //   cooldown: const Duration(milliseconds: 1000),
      //   onTap: isItComplete ? loginFarmer : null,
      //   waitBuilder: (BuildContext context, Widget child) {
      //     return Center(
      //         child: CircularProgressIndicator(
      //       color: Color(0xffE14D43),
      //     ));
      //   },
      //   builder: (context, _onTap) {
      //     return ElevatedButton(
      //       style: ButtonStyle(
      //         backgroundColor: MaterialStateProperty.all<Color>(isItComplete
      //             ? const Color(0xff69A8BB)
      //             : const Color(0xffE1EBEE)),
      //       ),
      //       onPressed: _onTap,
      //       child: Text(
      //         'Войти',
      //         style: TextStyle(
      //           color: isItComplete ? Colors.white : Color(0xffA9C7D0),
      //           fontFamily: "Roboto",
      //           fontWeight: FontWeight.w400,
      //           fontSize: 18,
      //         ),
      //       ),
      //     );
      //   },
      // )
      // ? Center(
      //     child: CircularProgressIndicator(
      //     color: Color(0xffE14D43),
      //   ))
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              isItComplete ? const Color(0xff69A8BB) : const Color(0xffE1EBEE)),
        ),
        onPressed: isItComplete ? loginFarmer : null,
        child: Text(
          'Войдите',
          style: TextStyle(
            color: isItComplete ? Colors.white : Color(0xffA9C7D0),
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget passwordField(TextStyle style, InputDecoration dec) {
    return TextField(
      controller: _password,
      // onChanged: checkFormFields,
      obscureText: visible,
      obscuringCharacter: '*',
      decoration: dec.copyWith(
          hintText: 'Пароль',
          suffixIcon: IconButton(
            splashColor: null,
            icon: Icon(CommunityMaterialIcons.eye_outline),
            iconSize: 35,
            color: Color(0xff363B3F),
            onPressed: visibleIcon,
          )),
      style: style.copyWith(),
    );
  }

  TextField loginField(TextStyle style, InputDecoration dec) {
    return TextField(
      controller: _login,
      obscureText: false,
      decoration: dec,
      style: style,
    );
  }
}
