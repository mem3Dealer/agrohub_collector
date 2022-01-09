import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_events.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:agrohub_collector_flutter/repositories/auth_rep.dart';
import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

//TODO по-хорошему, требует доработки. Неработающая кнопка пока не заполнятся поля и всякое такое.
class _LoginPageState extends State<LoginPage> {
  bool isTextFieldEmpty = true;
  Color blue = const Color(0xff1890ff);

  @override
  void initState() {
    super.initState();
    loadFirstPage();
    _password.addListener(() {
      final isTextFieldEmpty = _login.text.isEmpty || _password.text.isEmpty;
      setState(() => this.isTextFieldEmpty = isTextFieldEmpty);
    });
    _login.addListener(() {
      final isTextFieldEmpty = _login.text.isEmpty || _password.text.isEmpty;
      setState(() => this.isTextFieldEmpty = isTextFieldEmpty);
    });
  }

  //TODO:  я бы добавил dispose метод, чтобы закрыть все контроллеры после работы
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
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isLoading = false;

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
        onSuccess: (String role) {
          if (role == 'collector') {
            Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AllOrdersPage(),
                ));
            // ordersBloc.add(
            //   OrdersGetFirstOrder(
            //     onError: (dynamic e) {
            //       // errorToast(message: e.toString(), context: context);
            //       ordersBloc.add(const OrdersLoading(loading: false));
            //       Navigator.pushNamed(context, PageRoutes.collector);
            //     },
            //     onSuccess: () {
            //       Navigator.pushNamed(context, PageRoutes.collector);
            //     },
            //   ),
            // );
          } else {
            // productsBloc.add(
            //   ProductsSetFilterParams(
            //     onError: (dynamic e) {
            //       print(e);
            //       errorToast(message: e.message, context: context);
            //       setState(() {
            //         isLoading = false;
            //       });
            //     },
            //     onSuccess: () {
            //       Navigator.pushNamed(context, PageRoutes.products);
            //     },
            //     page: 1,
            //     idCategoryLevel2: null,
            //     idCategoryLevel3: null,
            //     productName: '',
            //     productType: '',
            //   ),
            // );
          }
        },
      ),
    );
  }

  loginFarmer() {
    setState(() {
      isLoading = true;
    });

    authBloc.add(
      AuthenticationLogIn(
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
          });
        },
        onSuccess: () {
          loadFirstPage();
        },
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = const EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 20,
    );
    return MyScaffold(
      false,
      title: '',
      //backgroundColor: const Color(0xff2d3a4b), //0xffF1F1F1
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 40),
                      child: Text(
                        'Форма входа',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    loginField(padding),
                    passwordField(padding),
                    enterButton(padding),
                  ],
                ),
              ),
      ),
    );
  }

  Padding enterButton(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // backgroundColor: MaterialStateProperty.all<Color>(
            //   blue,
            // ),
            onSurface: const Color(0xff4d4d4d),
          ),
          onPressed: isTextFieldEmpty ? null : loginFarmer,
          child: const Text('Войти'),
        ),
      ),
    );
  }

  Padding passwordField(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: Fields(
        controller: _password,
        color: Colors.blue,
        icon: const Icon(
          Icons.lock_outline,
          color: Colors.blue,
        ),
        title: 'Пароль',
      ),
    );
  }

  Padding loginField(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: Fields(
        controller: _login,
        color: Colors.blue,
        icon: const Icon(
          Icons.perm_identity_outlined,
          color: Colors.blue,
        ),
        title: 'Логин',
        obscuring: true,
      ),
    );
  }
}

class Fields extends StatelessWidget {
  final TextEditingController controller;
  final Color color;
  final String title;
  final Icon icon;
  final bool? obscuring;

  const Fields({
    Key? key,
    required this.controller,
    required this.color,
    required this.title,
    required this.icon,
    this.obscuring,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
          ),
        ),
        labelText: title,
        labelStyle: const TextStyle(color: Colors.blue),
        fillColor: const Color.fromRGBO(0, 0, 0, 0.1),
        filled: true,
        prefixIcon: icon,
      ),
      style: TextStyle(color: color),
    );
  }
}
