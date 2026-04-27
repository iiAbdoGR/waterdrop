import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterdrop/verify_email.dart';
import 'package:waterdrop/referesh.dart';
import 'splash_screen.dart';
import 'sign_in.dart';
import 'sign_up.dart';
import 'forgot_password.dart';
import 'preparing_sensors.dart';
import 'connect_device.dart';
import 'scan_devices.dart';
import 'analyzing_water.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'sensors_screen.dart';
import 'settings_screen.dart';
import 'sensor_detail_screen.dart';
import 'personal_info_screen.dart';
import 'reset_account_screen.dart';
import 'region_language_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();

  final user = FirebaseAuth.instance.currentUser;
  String? loginType = prefs.getString('loginType');
  bool remember = prefs.getBool('rememberMe') ?? false;

  Widget startScreen;

  if (user != null) {
    if (loginType == 'google') {
      startScreen = const ConnectDeviceScreen();
    } else if (loginType == 'email' && remember) {
      startScreen = const ConnectDeviceScreen();
    } else {
      await FirebaseAuth.instance.signOut();
      startScreen = const SplashScreen();
    }
  } else {
    startScreen = const SplashScreen();
  }

  runApp(PureDropApp(startScreen: startScreen));
  runApp(PureDropApp(startScreen: startScreen));
}

class PureDropApp extends StatefulWidget {
  final Widget startScreen;

  const PureDropApp({super.key, required this.startScreen});

  @override
  State<PureDropApp> createState() => _PureDropAppState();
}

class _PureDropAppState extends State<PureDropApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pure Drop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0A5C71),
        fontFamily: 'Georgia', // Using a serif font to match the design
        scaffoldBackgroundColor: const Color(0xFFBCE6F4),
      ),
      home: widget.startScreen,
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/verify': (context) => const EmailVerificationScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/preparing_sensors': (context) => const PreparingSensorsScreen(),
        '/connect_device': (context) => const ConnectDeviceScreen(),
        '/scan_devices': (context) => const ScanDevicesScreen(),
        '/analyzing_water': (context) => const AnalyzingWaterScreen(),
        '/home': (context) => const HomeScreen(),
        '/history': (context) => const HistoryScreen(),
        '/sensors': (context) => const SensorsScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/sensor_detail': (context) => const SensorDetailScreen(),
        '/personal_info': (context) => const PersonalInfoScreen(),
        '/reset_account': (context) => const ResetAccountScreen(),
        '/region_language': (context) => const RegionLanguageScreen(),
        '/refresh': (context) => const RefreshScreen(),
      },
    );
  }
}
