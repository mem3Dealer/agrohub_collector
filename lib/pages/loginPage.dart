import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_events.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:agrohub_collector_flutter/repositories/auth_rep.dart';
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
  @override
  void initState() {
    super.initState();
    loadFirstPage();
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
    return Scaffold(
      backgroundColor: const Color(0xff2d3a4b),
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
                          color: Colors.white,
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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              // isVisibleBtn
              //     ? const Color(0xff1890ff)
              //     :

              const Color(0xff1890ff).withOpacity(0.5),
            ),
          ),
          onPressed: loginFarmer,
          child: const Text('Войти'),
        ),
      ),
    );
  }

  Padding passwordField(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: TextField(
        controller: _password,
        // onChanged: checkFormFields,
        // obscureText: visible ? false : true,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xB3FFFFFF),
            ),
          ),
          labelText: 'Пароль',
          labelStyle: TextStyle(color: Colors.white70),
          fillColor: Color.fromRGBO(0, 0, 0, 0.1),
          filled: true,
          prefixIcon: Icon(
            Icons.lock_outlined,
            color: Colors.white70,
          ),
          // suffixIcon: InkWell(
          //   onTap: visibleIcon,
          //   child: visible
          //       ? const Icon(
          //           Icons.visibility_outlined,
          //           color: Colors.white70,
          //         )
          //       : const Icon(
          //           Icons.visibility_off_outlined,
          //           color: Colors.white70,
          //         ),
          // ),
        ),
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }

  Padding loginField(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: TextField(
        controller: _login,
        // onChanged: checkFormFields,
        obscureText: false,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xB3FFFFFF),
            ),
          ),
          labelStyle: TextStyle(color: Colors.white70),
          fillColor: Color.fromRGBO(0, 0, 0, 0.1),
          filled: true,
          labelText: 'Логин',
          prefixIcon: Icon(
            Icons.perm_identity_outlined,
            color: Colors.white70,
          ),
        ),
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}
