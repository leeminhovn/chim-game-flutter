// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_assets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadAssets _$LoadAssetsFromJson(Map<String, dynamic> json) => LoadAssets(
      path: json['path'] as String?,
      type: json['type'] as String?,
      nameArray: json['nameArray'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ItemImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LoadAssetsToJson(LoadAssets instance) =>
    <String, dynamic>{
      'path': instance.path,
      'type': instance.type,
      'nameArray': instance.nameArray,
      'images': instance.images,
    };

ItemImage _$ItemImageFromJson(Map<String, dynamic> json) => ItemImage(
      name: json['name'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ItemImageToJson(ItemImage instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
    };
