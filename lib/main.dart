import 'dart:ui' as ui;
import 'package:chim_kha/config/route_config.dart';
import 'package:chim_kha/modules/game/cubit/game_cubit.dart';
import 'package:chim_kha/src/data/data_source/local/user_local_storge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'component/untils/app_router.dart';

import 'modules/game/screens/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final double safeWidth = constraints.maxWidth;
      final double safeHeight = constraints.maxHeight;
      return MultiBlocProvider(
          providers: [
            BlocProvider(create: (ctx) => GameCubit(safeWidth, safeHeight)),
          ],
          child: MaterialApp.router(
            routerConfig: routerConfig,
            debugShowCheckedModeBanner: false,
            title: 'Game chim bay',
          ));
    }));
  }
}
