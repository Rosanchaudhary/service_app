import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/auth.dart';
import 'package:flutter_project/providers/customer.dart';
import 'package:flutter_project/providers/jobs_provider.dart';
import 'package:flutter_project/screens/artist_applied_jobs_screen.dart';
import 'package:flutter_project/screens/artist_bookings_screen.dart';
import 'package:flutter_project/screens/artist_change_password_screen.dart';
import 'package:flutter_project/screens/artist_current_bookings_screen.dart';
import 'package:flutter_project/screens/artist_profile_screen.dart';
import 'package:flutter_project/screens/chats_screen.dart';
import 'package:flutter_project/screens/choose_user_screen.dart';
import 'package:flutter_project/screens/edit_artist_profile_screen.dart';
import 'package:flutter_project/screens/forget_password_screen.dart';
import 'package:flutter_project/screens/home_screen.dart';
import 'package:flutter_project/screens/my_booking_screen.dart';
import 'package:flutter_project/screens/my_earnings_screen.dart';
import 'package:flutter_project/screens/my_wallet_screen.dart';
import 'package:flutter_project/screens/near_by_screen.dart';
import 'package:flutter_project/screens/notifications_screen.dart';
import 'package:flutter_project/screens/customer_profile_screen.dart';
import 'package:flutter_project/screens/payment_screen.dart';
import 'package:flutter_project/screens/phone_auth_screen.dart';
import 'package:flutter_project/screens/post_job_screen.dart';
import 'package:flutter_project/screens/receipt_details_screen.dart';
import 'package:flutter_project/screens/receipt_screen.dart';
import 'package:flutter_project/screens/search_jobs_screen.dart';
import 'package:flutter_project/screens/set_location_screen.dart';
import 'package:flutter_project/screens/splash_screen.dart';
import 'package:flutter_project/screens/terms_screen.dart';
import 'package:flutter_project/screens/tickets_screen.dart';
import 'package:flutter_project/screens/update_job_screen.dart';
import 'package:flutter_project/screens/widgets/custom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
    const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isInit = true;
  //late FirebaseMessaging _firebaseMessaging;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
       FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    var initializationSettingsAndroid =
         const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS =  const IOSInitializationSettings();
    var initializationSettings =  InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: onSelectNotification);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      showNotification(
        message.data.isNotEmpty
            ? message.data['title'] ?? 'Service App'
            : 'Service App',
        message.data.isNotEmpty
            ? message.data['body'] ?? 'Service App'
            : 'Service App',
      );
    });

    // _firebaseMessaging.configure(
    //   onMessage: (message) async {
    //     print('onMessage: $message');
    //     showNotification(
    //       message['data'] != null
    //           ? message['data']['title'] ?? 'Service App'
    //           : 'Service App',
    //       message['data'] != null
    //           ? message['data']['body'] ?? 'Service App'
    //           : 'Service App',
    //     );
    //   },
    //   onResume: (message) async {
    //     print('onResume: $message');
    //   },
    //   onLaunch: (message) async {
    //     print('onLaunch: $message');
    //   },
    // );
  }

  Future onSelectNotification(String text) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Mark"),
          content: Text("Mark : $text"),
        );
      },
    );
  }

  void showNotification(String title, String body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    var androidPlatformChannelSpecifics =
        const AndroidNotificationDetails('channel_ID', 'channel name',
            // 'channel description',
            importance: Importance.max,
            playSound: true,
            showProgress: true,
            priority: Priority.high,
            ticker: 'test ticker');

    var iOSChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      SharedPreferences.getInstance().then((prefs) {
        if (prefs.containsKey('token')) {
          isInit = false;
          return;
        }
        // _firebaseMessaging.getToken().then((value) async {
        //   prefs.setString('token', value!);
        //   print('Token: $value');
        //   isInit = false;
        // });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, JobProvider>(
          create: (_) => JobProvider(),
          update: (_, auth, previousProvider) {
            previousProvider
              .userId =
                  // ignore: prefer_null_aware_operators
                  (auth.currentUser != null ? auth.currentUser!.id : null)!;
            return previousProvider;
          },
        ),
        ChangeNotifierProxyProvider<Auth, Customer>(
          create: (_) => Customer(),
          update: (_, auth, previousCustomer) {
            previousCustomer
              .userId =
                  // ignore: prefer_null_aware_operators, unnecessary_null_comparison
                  (auth.currentUser != null ? auth.currentUser!.id : null)!;
            return previousCustomer;
          },
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Service App',
          theme: ThemeData( 
            errorColor: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Poppins',
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                  button: const TextStyle(color: Colors.white),
                ),
            appBarTheme: AppBarTheme(
              toolbarTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                    headline6: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                    ),
                  )
                  .bodyText2,
              titleTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                    headline6: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                    ),
                  )
                  .headline6,
            ),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
                .copyWith(secondary: Colors.amber),
          ),
          routes: {
            CustomerProfileScreen.routeName: (ctx) => const CustomerProfileScreen(),
            ChatsScreen.routeName: (ctx) => const ChatsScreen(),
            MyBookingScreen.routeName: (ctx) => const MyBookingScreen(),
            ReceiptScreen.routeName: (ctx) => ReceiptScreen(),
            SearchJobsScreen.routeName: (ctx) => SearchJobsScreen(),
            MyWalletScreen.routeName: (ctx) => MyWalletScreen(),
            NotificationsScreen.routeName: (ctx) => NotificationsScreen(),
            SetLocationScreen.routeName: (ctx) => const SetLocationScreen(),
            PostJobScreen.routeName: (ctx) => const PostJobScreen(),
            NearByScreen.routeName: (ctx) => NearByScreen(),
            ReceiptDetailsScreen.routeName: (ctx) => ReceiptDetailsScreen(),
            PaymentScreen.routeName: (ctx) => PaymentScreen(),
            UpdateJobScreen.routeName: (ctx) => UpdateJobScreen(),
            ForgetPasswordScreen.routeName: (ctx) => ForgetPasswordScreen(),
            TermsScreen.routeName: (ctx) => const TermsScreen(),
            ArtistAppliedJobsScreen.routeName: (ctx) =>
                ArtistAppliedJobsScreen(),
            ArtistCurrentBookingsScreen.routeName: (ctx) =>
                const ArtistCurrentBookingsScreen(),
            ArtistBookingsScreen.routeName: (ctx) => ArtistBookingsScreen(),
            ArtistProfileScreen.routeName: (ctx) => ArtistProfileScreen(),
            ArtistChangePasswordScreen.routeName: (ctx) =>
                const ArtistChangePasswordScreen(),
            EditArtistProfileScreen.routeName: (ctx) => const EditArtistProfileScreen(
                categoryId: '',
                categoryName: '',
                bio: '',
                city: '',
                country: '',
                description: '',
                longi: 0.0,
                lati: 0.0,
                name: '',
                rate: '',
                location: ''),
            MyEarningsScreen.routeName: (ctx) => MyEarningsScreen(),
            TicketsScreen.routeName: (ctx) => TicketsScreen(),
            PhoneAuthScreen.routeName: (ctx) => const PhoneAuthScreen(),
          },
          home: auth.isAuth
              ? CustomDrawer(child: HomeScreen())
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : const ChooseUserScreen(),
                ),
        ),
      ),
    );
  }
}
