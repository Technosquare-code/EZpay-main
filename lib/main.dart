import 'package:billapp/Providers/AuthProvider.dart';
import 'package:billapp/Providers/CategoriesProvider.dart';
import 'package:billapp/Providers/HomeProvider.dart';
import 'package:billapp/Providers/MobileTopUpProvider.dart';
import 'package:billapp/Providers/NotificationProvider.dart';
import 'package:billapp/Providers/PaymentProvider.dart';
import 'package:billapp/Providers/SubAgentProvider.dart';
import 'package:billapp/Providers/SubCategoryProvider.dart';
import 'package:billapp/Providers/TransactionProvider.dart';
import 'package:billapp/Providers/VideoProvider.dart';
import 'package:billapp/Routes/Route.dart';
import 'package:billapp/Screens/DashboardScreen.dart';
import 'package:billapp/Screens/LoginScreen.dart';
import 'package:billapp/Screens/NetworkErrorScreen.dart';
import 'package:billapp/Screens/SelectUserTypeScreen.dart';
import 'package:billapp/Screens/SplashScreen.dart';
import 'package:billapp/Screens/UserHomeScreen.dart';
import 'package:billapp/locale/locale.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Providers/CheckoutProvider.dart';
import 'Screens/AdsScreen.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "High_Importance_channel",
  "Notification",
  playSound: true,
  importance: Importance.high,
  showBadge: true,
);

final AndroidFlutterLocalNotificationsPlugin notificationsPlugin =
    AndroidFlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool routeDone = false;
  late RestartableTimer _timer;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final TranslatorGenerator translator = TranslatorGenerator.instance;
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  void initState() {
    translator.init(
      initCountryCode: "US",
      initLanguageCode: 'en',
      mapLocales: [
        MapLocale('en', AppLocale.EN, countryCode: "US"),
        MapLocale('es', AppLocale.ES, countryCode: "ES"),
      ],
    );
    translator.onTranslatedLanguage = _onTranslatedLanguage;
    _timer = RestartableTimer(
      const Duration(seconds: 30),
      () {
        SharedPreferences.getInstance().then((value) {
          if (value.getString("type") == "user") {
            setState(() {
              routeDone = true;
            });
            navigatorKey.currentState!.pushNamed(AdsScreen.routName);
          }
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => SubCategoryProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => SubAgentProvider()),
        ChangeNotifierProvider(create: (_) => VideoProvider()),
        ChangeNotifierProvider(create: (_) => MobileTopupProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),
      ],
      child: Listener(
        onPointerUp: (_) {
          if (routeDone == true) {
            _timer.cancel();
          }
        },
        onPointerDown: (_) {
          SharedPreferences.getInstance().then((value) {
            if (value.getString("type") == "user") {
              if (routeDone == true) {
                setState(() {
                  routeDone = false;
                });
                navigatorKey.currentState!.pop();
                _timer.cancel();
                _timer.reset();
              } else {
                _timer.cancel();
                _timer.reset();
              }
            }
          });
        },
        child: Consumer<AuthProvider>(builder: (context, value, child) {
          return MaterialApp(
            title: 'Billyo',
            navigatorKey: navigatorKey,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            supportedLocales: translator.supportedLocales,
            localizationsDelegates: translator.localizationsDelegates,
            // home: SplashScreen(),
            home: value.isTryAutoLogin != true
                ? value.type == "agent"
                    ? DashboardScreen()
                    : UserHomeScreen()
                : FutureBuilder(
                    future: value.tryAutoLogin(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SplashScreen();
                      }
                      if (snapshot.data == "0") {
                        return SelectUserTypeScreen();
                      } else if (snapshot.data == "2") {
                        return UserHomeScreen();
                      } else if (snapshot.data == "3") {
                        return DashboardScreen();
                      } else if (snapshot.data == "4") {
                        return NetworkErrorScreen();
                      } else {
                        return LoginScreen();
                      }
                    },
                  ),
            routes: routes,
          );
        }),
      ),
    );
  }
}
