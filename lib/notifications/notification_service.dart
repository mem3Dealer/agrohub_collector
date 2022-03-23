import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

class Notifications {
  final authBloc = GetIt.I.get<AuthenticationBloc>();
  void subcscribeForNotesOfNewOrders() async {
    await FirebaseMessaging.instance
        .subscribeToTopic("order_notifications_${authBloc.state.storeId}_test")
        .then((value) => print('Subscribed!'));

    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      print('OnMessage evoked: ${msg.notification}');
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              wakeUpScreen: true,
              id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
              channelKey: 'new_order',
              title: 'Новый заказ №${msg.notification?.title}' +
                  Emojis.transport_air_rocket,
              body: 'Срочно возьми его в сборку' +
                  Emojis.time_hourglass_not_done));
    });
  }
}
