// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************



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
