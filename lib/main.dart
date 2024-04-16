import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_module.dart';
import 'app_widget.dart';
import 'core/notifications/notifications_manager.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationsManager().initNotification();
  await Firebase.initializeApp();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
