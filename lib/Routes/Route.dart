import 'package:billapp/Screens/AddSubAgentScreen.dart';
import 'package:billapp/Screens/CarInsuranceScreen.dart';
import 'package:billapp/Screens/ComCastScreen.dart';
import 'package:billapp/Screens/DomesticMobileRecharge.dart';
import 'package:billapp/Screens/EzpassScreen.dart';
import 'package:billapp/Screens/GiftCardTopupScreen.dart';
import 'package:billapp/Screens/IntlLongDistanceScreen.dart';
import 'package:billapp/Screens/IntlMobileTopUpScreen.dart';
import 'package:billapp/Screens/MobileDataScreen.dart';
import 'package:billapp/Screens/MobileTopUpCheckout.dart';
import 'package:billapp/Screens/MotorbikeTaxScreen.dart';
import 'package:billapp/Screens/NewActivationScreen.dart';
import 'package:billapp/Screens/ParkingTicketScreen.dart';
import 'package:billapp/Screens/PortInScreen.dart';
import 'package:billapp/Screens/PrepaidXfinityScreen.dart';
import 'package:billapp/Screens/ProductCheckoutScreen.dart';
import 'package:billapp/Screens/SewerageScreen.dart';
import 'package:billapp/Screens/SubAgentTransactionScreen.dart';
import 'package:billapp/Screens/UserPaymentScreen.dart';
import 'package:billapp/Screens/UtitlitiesScreen.dart';
import 'package:billapp/Screens/VehicleTaxScreen.dart';
import 'package:billapp/Screens/VideoCallScreen.dart';
import 'package:flutter/material.dart';
import 'package:billapp/Screens/ChangePasswordScreen.dart';
import 'package:billapp/Screens/EditProfileScreen.dart';
import 'package:billapp/Screens/InfoScreen.dart';
import 'package:billapp/Screens/NotificationScreen.dart';
import 'package:billapp/Screens/DashboardScreen.dart';
import 'package:billapp/Screens/LoginScreen.dart';
import 'package:billapp/Screens/ProfileScreen.dart';
import 'package:billapp/Screens/SelectUserTypeScreen.dart';
import 'package:billapp/Screens/SettingsScreen.dart';
import 'package:billapp/Screens/SubAgentScreen.dart';
import 'package:billapp/Screens/AdsScreen.dart';
import 'package:billapp/Screens/TransactionScreen.dart';
import 'package:billapp/Screens/UserHomeScreen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  LoginScreen.routName: (_) => LoginScreen(),
  SelectUserTypeScreen.routName: (_) => SelectUserTypeScreen(),
  DashboardScreen.routName: (_) => DashboardScreen(),
  ProfileScreen.routName: (_) => ProfileScreen(),
  NotificationScreen.routName: (_) => NotificationScreen(),
  EditProfileScreen.routName: (_) => EditProfileScreen(),
  SettingsScreen.routName: (_) => SettingsScreen(),
  ChangePasswordScreen.routName: (_) => ChangePasswordScreen(),
  TransactionScreen.routName: (_) => TransactionScreen(),
  InfoScreen.routName: (_) => InfoScreen(),
  AdsScreen.routName: (_) => AdsScreen(),
  UserHomeScreen.routName: (_) => UserHomeScreen(),
  SubAgentScreen.routName: (_) => SubAgentScreen(),
  AddSubAgentScreen.routName: (_) => AddSubAgentScreen(),
  // VideoCallScreen.routName: (_) => VideoCallScreen(),
  DomesticMobileRecharge.routName: (_) => DomesticMobileRecharge(),
  IntlMobileTopupScreen.routName: (_) => IntlMobileTopupScreen(),
  IntlLongDistanceScreen.routName: (_) => IntlLongDistanceScreen(),
  MobileDataScreen.routName: (_) => MobileDataScreen(),
  ComCastScreen.routName: (_) => ComCastScreen(),
  UtilitiesScreen.routName: (_) => UtilitiesScreen(),
  PrepaidXfinityScreen.routName: (_) => PrepaidXfinityScreen(),
  SewerageScreen.routName: (_) => SewerageScreen(),
  CarInsuranceScreen.routName: (_) => CarInsuranceScreen(),
  GifCardTopupScreen.routName: (_) => GifCardTopupScreen(),
  NewActivationScreen.routName: (_) => NewActivationScreen(),
  PortInScreen.routName: (_) => PortInScreen(),
  ProductCheckoutScreen.routName: (_) => ProductCheckoutScreen(),
  MobileTopupCheckout.routName: (_) => MobileTopupCheckout(),
  UserPaymentScreen.routName: (_) => UserPaymentScreen(),
  SubAgentTransactionScreen.routName: (_) => SubAgentTransactionScreen(),
  VehicleTaxScreen.routName: (_) => VehicleTaxScreen(),
  EzpassScreen.routName: (_) => EzpassScreen(),
  MotorbikeTaxScreen.routName: (_) => MotorbikeTaxScreen(),
  ParkingTicketScreen.routName: (_) => ParkingTicketScreen(),
};
