import 'dart:developer';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_events.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/foundation.dart';
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
    if (kDebugMode) {
      _login.text = 'test_collector_1';
      _password.text = 'testcollector1';
    }
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
          ;
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
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Это что, сообщение об ошибке?')));
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
    final _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _theme.scaffoldBackgroundColor,
      body: Center(
        child: ListView(
          primary: false,
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            left: 16,
            bottom: 40,
            right: 16,
            // top: 32,
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 24.0, top: 40),
              child: SizedBox(
                height: 48,
                child: Text(
                  'Форма входа',
                  style: _theme.textTheme.headlineLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: loginField(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: passwordField(),
            ),
            isError
                ? Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text('Введите правильный логин и пароль',
                        style: _theme.textTheme.caption))
                : SizedBox.shrink(),
            enterButton(isItCompleted()),
          ],
        ),
      ),
    );
  }

  SizedBox enterButton(bool isItComplete) {
    final _cs = Theme.of(context).colorScheme;
    return SizedBox(
        height: 56,
        width: 382,
        child: TapDebouncer(
          cooldown: const Duration(milliseconds: 1000),
          onTap: isItComplete ? loginFarmer : null,
          waitBuilder: (BuildContext context, Widget child) {
            return Center(
                child: CircularProgressIndicator(color: _cs.secondary));
          },
          builder: (context, _onTap) {
            return ElevatedButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Color(0xff4a7683)),
                backgroundColor: MaterialStateProperty.all<Color>(isItComplete
                    ? _cs.primary
                    : Theme.of(context).disabledColor),
              ),
              onPressed: _onTap,
              child: Text('Войти',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: !isItComplete ? Color(0xffA9C7D0) : Colors.white)),
            );
          },
        ));
  }

  Widget passwordField() {
    return TextField(
      controller: _password,
      style: Theme.of(context).textTheme.headline2,
      obscureText: visible,
      obscuringCharacter: '*',
      decoration: InputDecoration(
          hintText: 'Пароль',
          suffixIcon: IconButton(
            splashColor: null,
            icon: Icon(CommunityMaterialIcons.eye_outline),
            iconSize: 35,
            color: Color(0xff363B3F),
            onPressed: visibleIcon,
          )),
    );
  }

  TextField loginField() {
    return TextField(
        cursorColor: Theme.of(context).colorScheme.primary,
        controller: _login,
        obscureText: false,
        style: Theme.of(context).textTheme.headline2,
        decoration: InputDecoration(hintText: 'Логин'));
  }
}
