import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_app/configs/routes/route.dart';
import 'package:test_app/database/db.dart';
import 'package:test_app/pages/home_page.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
await dotenv.load(fileName: ".env");
 DatabaseService databaseHelper = DatabaseService();
  await databaseHelper.initDatabase();
  await databaseHelper.displayTableStructure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor:  const Color(0xFF8CACD3)),
          useMaterial3: true,
        ),
         debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const HomePage(),
      ),
    );
  }
}

