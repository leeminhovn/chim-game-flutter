import 'package:json_annotation/json_annotation.dart';
part 'rank_users.g.dart';
@JsonSerializable()

class RankUsersDto {
  final List<UserRankDto> data;
  RankUsersDto(this.data);
  factory RankUsersDto.fromJson(Map<String, dynamic> json) => 
 _$RankUsersDtoFromJson(json);
 Map<String, dynamic> toJson() => _$RankUsersDtoToJson(this);
}
@JsonSerializable()

class UserRankDto {
  @JsonKey(defaultValue: 'Player')
  final String name;
  @JsonKey(defaultValue: 0)

  final int record;
  @JsonKey(defaultValue: 0)

  final int totalPoints;
UserRankDto(this.name, this.record, this.totalPoints);
factory UserRankDto.fromJson(Map<String, dynamic> json) => 
 _$UserRankDtoFromJson(json);
 Map<String, dynamic> toJson() => _$UserRankDtoToJson(this);
}