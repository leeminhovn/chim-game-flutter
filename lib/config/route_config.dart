import 'package:chim_kha/config/router_name.dart';
import 'package:chim_kha/modules/game/cubit/game_cubit.dart';
import 'package:chim_kha/modules/game/screens/game.dart';
import 'package:chim_kha/modules/game/screens/my_dashboard_game.dart';
import 'package:chim_kha/modules/game/screens/play_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter routerConfig = GoRouter(
    initialLocation: ApplicationRouteName.dashboard,
    routes: <RouteBase>[
      GoRoute(
          path: ApplicationRouteName.dashboard,
          name: ApplicationRouteName.dashboard,
          builder: (BuildContext context, GoRouterState state) {
            return const Game();
          }),
      GoRoute(
          path: ApplicationRouteName.gamePlaySingle,
          name: ApplicationRouteName.gamePlaySingle,
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider<GameCubit>.value(
                value: BlocProvider.of(context),
                child: PlayGame(
                  gameState: context.read<GameCubit>().state,
                ));
          }),
    ]);
