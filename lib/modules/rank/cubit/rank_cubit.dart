import 'package:flutter_bloc/flutter_bloc.dart';
part 'rank_state.dart';

class RankCubit extends Cubit<RankState> {
  RankCubit() : super(RankInitial()) {
    init();
  }
  init() async {
    emit(RankLoading(state));
    await Future.delayed(const Duration(seconds: 1));
    emit(RankSuccessLoad(state));
  }
}
