import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

class Notifications {
  int _rndId = DateTime.now().millisecondsSinceEpoch.remainder(100000);

  void subcscribeForNotesOfNewOrders() async {
    var authBloc = GetIt.I.get<AuthenticationBloc>();
    await FirebaseMessaging.instance
        // .subscribeToTopic("order_notifications_${authBloc.state.storeId}_test")
        .subscribeToTopic("testTopic")
        .then((value) => print('Subscribed!'));
    String? token = await FirebaseMessaging.instance.getToken();
    print('TOKEN IS: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("for: THIS IS MSG DATA: ${message.data}, THIS IS note ${message.notification}");

      AwesomeNotifications().createNotification(
          content: NotificationContent(
              wakeUpScreen: true,
              id: _rndId,
              channelKey: 'new_order',
              title: 'Новый заказ №${message.notification?.title}' +
                  Emojis.transport_air_rocket,
              body: 'Срочно возьми его в сборку' +
                  Emojis.time_hourglass_not_done));
    });
  }

  Future<void> onBackGroundNotification(RemoteMessage message) async {
    await Firebase.initializeApp();
    log("back: THIS IS MSG DATA: ${message.data}, THIS IS note ${message.notification?.android.toString()}");
    log(message.toString());
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      print('I DON`T EVOKE!');
    });
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            // fullScreenIntent: true,
            icon: null,
            wakeUpScreen: true,
            id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
            channelKey: 'new_order',
            title: 'О БОЖЕ ЧТО ЭТО ЗА №${message.notification?.title}' +
                Emojis.transport_air_rocket,
            body:
                'Срочно возьми его в сборку' + Emojis.time_hourglass_not_done));
  }
}
