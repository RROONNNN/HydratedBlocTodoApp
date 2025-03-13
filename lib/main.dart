import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ronfltapp/core/configs/theme/app_theme.dart';
import 'package:ronfltapp/presentation/choose_mode/pages/choose_mode.dart';
import 'package:ronfltapp/presentation/intro/pages/get_started.dart';
import 'package:ronfltapp/presentation/splash/bloc/theme_cubit.dart';
import 'package:ronfltapp/presentation/splash/pages/splash.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ronfltapp/service_locator.dart';

import 'firebase_options.dart';


// void main() {
//
//   runApp(const MyApp());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initilizeDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      child: BlocBuilder<ThemeCubit,ThemeMode>(
        builder: (context,mode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TODO Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode:mode,
            home: const SplashPage(),
          );
        }
      ),
      providers: [
      BlocProvider(create: (_)=>ThemeCubit()),
      ],);
  }
}
