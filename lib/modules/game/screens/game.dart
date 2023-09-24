import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/game_cubit.dart';
import 'my_dashboard_game.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 146, 145, 145)),
        child: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            if (state is GameInitial || state is GameLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GameLoaded) {
              return MyDashboardGame(
                gameState: state,
              );
            }
            return const SizedBox.expand();
          },
        ),
      ),
    );
  }
}
