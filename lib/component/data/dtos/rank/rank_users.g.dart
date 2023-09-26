// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankUsersDto _$RankUsersDtoFromJson(Map<String, dynamic> json) => RankUsersDto(
      (json['data'] as List<dynamic>)
          .map((e) => UserRankDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RankUsersDtoToJson(RankUsersDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

UserRankDto _$UserRankDtoFromJson(Map<String, dynamic> json) => UserRankDto(
      json['name'] as String? ?? 'Player',
      json['record'] as int? ?? 0,
      json['totalPoints'] as int,
      json['date'] as String? ?? '',
    );

Map<String, dynamic> _$UserRankDtoToJson(UserRankDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'record': instance.record,
      'date': instance.date,
      'totalPoints': instance.totalPoints,
    };
