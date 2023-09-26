import 'package:chim_kha/config/route_config.dart';
import 'package:chim_kha/modules/game/cubit/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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

   theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          fontFamily: 'Quicksand',
          backgroundColor: Color(0xffd2aa4f),
          appBarTheme: const AppBarTheme(
            // color: AppColor.backGround,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          tabBarTheme: const TabBarTheme(
            labelColor: const Color(0xff523747),
            unselectedLabelColor: Color(0xff828282),
            labelStyle: TextStyle(
              color: const Color(0xff523747),
              fontWeight: FontWeight.w700,
              fontFamily: 'Quicksand',
              fontSize: 16,
            ), // color for text
            indicator: UnderlineTabIndicator(
              // color for indicator (underline)
              borderSide: BorderSide(color: Color.fromARGB(255, 255, 200, 0), width: 2),
            ),
          ),
        ),

            title: 'Game chim bay',
          ));
    }));
  }
}
