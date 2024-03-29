import 'package:ecom_3/app/utils/constants.dart';
import 'package:ecom_3/app/utils/memory.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Memory.init();
  var token = Memory.getToken();
  var role = Memory.getRole();
  var isHospital = role == 'hospital';
  var isAdmin = role == 'admin';
  runApp(
    KhaltiScope(
      publicKey: "test_public_key_dde0878862604f24b2475a9806c833d2",
      builder: (context, navigatorKey) => GetMaterialApp(
        navigatorKey: navigatorKey,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ne', 'NP'),
        ],
        localizationsDelegates: const [
          KhaltiLocalizations.delegate,
        ],
        theme: ThemeData(
          primarySwatch: primaryColor,
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
        title: "Mero Doctor",
        initialRoute: token == null
            ? Routes.LOGIN
            : isHospital
                ? Routes.HOSPITAL_MAIN
                : isAdmin
                    ? Routes.ADMIN_MAIN
                    : Routes.MAIN,
        getPages: AppPages.routes,
        defaultTransition: Transition.cupertino,
      ),
    ),
  );
}
