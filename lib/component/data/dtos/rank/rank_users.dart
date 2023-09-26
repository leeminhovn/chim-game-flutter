import 'package:json_annotation/json_annotation.dart';
part 'rank_users.g.dart';



@JsonSerializable()
class UserRankDto {
  @JsonKey(defaultValue: 'Player')
  final String name;

  @JsonKey(defaultValue: 0)
  final int record;

  @JsonKey(defaultValue: '')
  final String date;

  final int totalPoints;
  UserRankDto(this.name, this.record, this.totalPoints, this.date);
  factory UserRankDto.fromJson(Map<String, dynamic> json) =>
      _$UserRankDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserRankDtoToJson(this);
}
