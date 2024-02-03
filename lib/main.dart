import 'package:finance/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:finance/models/finance_model.dart';
import 'package:finance/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Hive.initFlutter();
  Hive.registerAdapter(FinanceModelAdapter());
  await Hive.openBox("darkModeBox");
  await Hive.openBox<FinanceModel>("financeBox");
  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchDataCubit(),
      child: ValueListenableBuilder(
          valueListenable: Hive.box('darkModeBox').listenable(),
          builder: (context, box, child) {
            var darkMode = box.get('darkMode', defaultValue: false);

            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Finance',
                darkTheme: ThemeData.dark(useMaterial3: true),
                themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
                theme: ThemeData(
                  useMaterial3: true,
                ),
                home: SplashScreen());
          }),
    );
  }
}
