import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:practical_test_iml/utils/common_colors.dart';
import 'package:practical_test_iml/view/dashboard/dashbaord_view_model.dart';
import 'package:practical_test_iml/view/dashboard/dashboard_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DashboardViewModel()),
  ], child: const MyApp()));
}

GlobalKey<NavigatorState> mainNavKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: CommonColors.primaryColor),
        useMaterial3: true,
      ),
      home: const DashboardView(),
    );
  }
}
