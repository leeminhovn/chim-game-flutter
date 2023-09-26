part of 'rank_cubit.dart';

abstract class RankState {
  copy(RankState state) {}
}

class RankInitial extends RankState {}

class RankLoading extends RankState {
  RankLoading(RankState state) {
    super.copy(state);
  }
}
class RankSuccessLoad extends RankState {
  RankSuccessLoad(RankState state) {
    super.copy(state);
  }
}
