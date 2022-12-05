import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/presentation/router/app_routers_names.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/find_fuel_station_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/verify_phone_number_screen.dart';

import '../screens/shared/home_screen.dart';
import '../screens/shared/find_workshop_screen.dart';
import '../screens/shared/login_screen.dart';
import '../screens/shared/notifications_screen.dart';
import '../screens/shared/orders_history.dart';
import '../screens/shared/payment_method_screen.dart';
import '../screens/shared/profile_settings.dart';
import '../screens/shared/resend_password_screen.dart';
import '../screens/shared/send_OTP_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.rLogin:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());
      case AppRouterNames.rHome:
        return MaterialPageRoute(builder: (_) =>  HomeScreen());
      case AppRouterNames.rProfile:
        return MaterialPageRoute(builder: (_) => ProfileSettingsScreen());
      case AppRouterNames.rVerifyPhoneNumber:
        return MaterialPageRoute(builder: (_) => VerifyPhoneNumberScreen());
      case AppRouterNames.rSendOtp:
        return MaterialPageRoute(builder: (_) => const SendOtpScreen());
      case AppRouterNames.rFindFuelStationScreen:
        return MaterialPageRoute(builder: (_) =>  FindFuelStationScren());
      case AppRouterNames.rResetPasswordScreen:
        return MaterialPageRoute(builder: (_) =>  ResetPasswordScreen());
      default:
        return null;
    }
  }
}