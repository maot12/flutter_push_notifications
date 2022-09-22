import 'package:flutter/material.dart';
import 'package:push_notifications/screens/screens.dart';
import 'package:push_notifications/services/push_notifications_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await PushNotificationsService.initializeApp();

  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Context
    PushNotificationsService.messagesStream.listen((message) { 
      
      //print('MyApp: $message');
      navigatorKey.currentState?.pushNamed(MessageScreen.route, arguments: message);

      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
      //Navigator.pushNamed(context, MessageScreen.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: HomeScreen.route,
      navigatorKey: navigatorKey,//Navegar
      scaffoldMessengerKey: messengerKey,//Snacks
      routes: {
        HomeScreen.route   : (_) => const HomeScreen(),
        MessageScreen.route: (_) => const MessageScreen(),
      },

    );
  }
}
