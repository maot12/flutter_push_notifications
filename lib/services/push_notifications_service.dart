/*
* Variant: debugAndroidTest
* Config: debug
* Store: C:\Users\shima\.android\debug.keystore
* Alias: AndroidDebugKey
* MD5: B1:90:B7:1A:29:F3:CE:31:45:D5:C9:8F:A7:16:1E:27
* SHA1: 4A:4E:7A:57:83:AB:34:47:26:48:20:3E:E1:B3:BF:FD:72:E1:CB:BD
* SHA-256: 9A:3E:3E:24:7C:E8:6C:47:24:29:3C:82:C6:33:C5:E5:23:2E:64:C4:4C:3D:D9:B2:0A:43:51:9F:87:7F:2E:61
* Token: czBN64cFRaCNyC38FNqnr5:APA91bFSKiFu7bT44I0OrO9ElscQEY7H35xmd8nQTbYVaN2QC2T0U3RBl66YTSsU8qjmsOrTn16i0VnuWTUVC6dJkNLz-JI-nSGopnRY94ZgSVRC9AfNwDjEYrKg3eYacEd6t2AHNu2x
* */

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async{
    //print('onBackground Handler ${message.messageId}');
    print(message.data);
    //_messageStream.add(message.notification?.title ?? 'No title');
    //_messageStream.add(message.notification?.body ?? 'No description');
    _messageStream.add(message.data['product'] ?? 'No Data');
  }

  static Future _onMessageHandler(RemoteMessage message) async{
    //print('onMessage Handler ${message.messageId}');
    print(message.data);
    //_messageStream.add(message.notification?.title ?? 'No title');
    //_messageStream.add(message.notification?.body ?? 'No description');
    _messageStream.add(message.data['product'] ?? 'No Data');
  }

  static Future _onOpenMessageOpenApp(RemoteMessage message) async{
    //print('onMessageOpenApp Handler ${message.messageId}');
    print(message.data);
    //_messageStream.add(message.notification?.title ?? 'No title');
    //_messageStream.add(message.notification?.body ?? 'No description');
    _messageStream.add(message.data['product'] ?? 'No Data');
  }

  static Future initializeApp() async {
    //Push Notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');
    
    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenMessageOpenApp);

    //Local Notifications
  }

  static closeStreams() {
    _messageStream.close();
  }
}