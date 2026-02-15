import 'package:get/get.dart';
import 'package:smart_converter/view/converter_screen.dart';
import 'package:smart_converter/view/home_screen.dart';
import 'package:smart_converter/view/settings_screen.dart';
import 'package:smart_converter/view/splash_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const converter = '/converter';
  static const settings = '/settings';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: converter, page: () => const ConverterScreen()),
    GetPage(name: settings, page: () => const SettingsScreen()),
  ];
}
