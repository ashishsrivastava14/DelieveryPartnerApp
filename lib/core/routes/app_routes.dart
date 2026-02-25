import 'package:get/get.dart';
import 'package:delivery_partner_app/modules/auth/splash_screen.dart';
import 'package:delivery_partner_app/modules/auth/role_selection_screen.dart';
import 'package:delivery_partner_app/modules/auth/login_screen.dart';
import 'package:delivery_partner_app/modules/auth/register_screen.dart';

import 'package:delivery_partner_app/modules/customer/customer_shell.dart';
import 'package:delivery_partner_app/modules/customer/store_detail_screen.dart';
import 'package:delivery_partner_app/modules/customer/cart_screen.dart';
import 'package:delivery_partner_app/modules/customer/checkout_screen.dart';
import 'package:delivery_partner_app/modules/customer/order_tracking_screen.dart';

import 'package:delivery_partner_app/modules/rider/rider_shell.dart';
import 'package:delivery_partner_app/modules/rider/active_delivery_screen.dart';

import 'package:delivery_partner_app/modules/merchant/merchant_shell.dart';

import 'package:delivery_partner_app/modules/admin/admin_shell.dart';
import 'package:delivery_partner_app/modules/admin/user_detail_screen.dart';
import 'package:delivery_partner_app/modules/admin/order_detail_screen.dart';
import 'package:delivery_partner_app/modules/admin/ticket_detail_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const roleSelection = '/role-selection';
  static const login = '/login';
  static const register = '/register';

  // Customer
  static const customerShell = '/customer';
  static const storeDetail = '/customer/store';
  static const cart = '/customer/cart';
  static const checkout = '/customer/checkout';
  static const orderTracking = '/customer/order-tracking';

  // Rider
  static const riderShell = '/rider';
  static const activeDelivery = '/rider/active-delivery';

  // Merchant
  static const merchantShell = '/merchant';

  // Admin
  static const adminShell = '/admin';
  static const userDetail = '/admin/user-detail';
  static const orderDetail = '/admin/order-detail';
  static const ticketDetail = '/admin/ticket-detail';

  static final pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: roleSelection, page: () => const RoleSelectionScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),

    // Customer
    GetPage(name: customerShell, page: () => const CustomerShell()),
    GetPage(name: storeDetail, page: () => const StoreDetailScreen()),
    GetPage(name: cart, page: () => const CartScreen()),
    GetPage(name: checkout, page: () => const CheckoutScreen()),
    GetPage(name: orderTracking, page: () => const OrderTrackingScreen()),

    // Rider
    GetPage(name: riderShell, page: () => const RiderShell()),
    GetPage(name: activeDelivery, page: () => const ActiveDeliveryScreen()),

    // Merchant
    GetPage(name: merchantShell, page: () => const MerchantShell()),

    // Admin
    GetPage(name: adminShell, page: () => const AdminShell()),
    GetPage(name: userDetail, page: () => const UserDetailScreen()),
    GetPage(name: orderDetail, page: () => const OrderDetailScreen()),
    GetPage(name: ticketDetail, page: () => const TicketDetailScreen()),
  ];
}
