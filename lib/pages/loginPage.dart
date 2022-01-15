import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_events.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:agrohub_collector_flutter/pages/collectingOrderPage.dart';
import 'package:agrohub_collector_flutter/repositories/auth_rep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

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
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isLoading = false;
  bool visible = true;

  // Future<void> _initCollectingOrder(int id) async {
  //   await ordersBloc.add(InitCollectingOrder(collectingOrderId: id));
  // }
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
              // print('it comes here');
              ordersBloc.add(InitCollectingOrder(
                  collectingOrderId: currentCollectingOrderId,
                  context: context));

              // if (ordersBloc.state.currentOrder != null) {
              // } else {
              //   Navigator.pushReplacement<void, void>(
              //       context,
              //       MaterialPageRoute<void>(
              //         builder: (BuildContext context) => const AllOrdersPage(),
              //       ));
              // }
            } else {
              // print('it drops here');
              Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const AllOrdersPage(),
                  ));
            }

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
            print('he was a farmer');
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
    TextStyle _style = const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        color: Color(0xff363B3F),
        fontSize: 16);
    InputDecoration inDec = const InputDecoration(
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
      labelText: 'Логин',
      prefixIcon: Icon(
        Icons.perm_identity_outlined,
        color: Color(0xffCACED0),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(color: Color(0xffE14D43))
            : ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                  left: 16,
                  bottom: 40,
                  right: 16,
                  top: 64,
                ),
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 32.0),
                    child: Text(
                      'Форма входа',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xff363B3F),
                        fontSize: 42,
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
                  enterButton(),
                ],
              ),
      ),
    );
  }

  SizedBox enterButton() {
    return SizedBox(
      height: 56,
      width: 382,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              // isVisibleBtn
              //     ? const Color(0xff1890ff)
              //     :

              const Color(0xff69A8BB)),
        ),
        onPressed: loginFarmer,
        child: const Text(
          'Войти',
          style: TextStyle(
            // color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 16,
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
          labelText: 'Пароль',
          prefixIcon: const Icon(
            Icons.lock_outlined,
            color: Color(0xffCACED0),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye_outlined),
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
