import 'package:json_annotation/json_annotation.dart';

part 'load_assets.g.dart';

@JsonSerializable()
class LoadAssets {
  LoadAssets({this.path, this.type, this.nameArray, this.images}) : super();
  @JsonKey(name: 'path')
  final String? path;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'nameArray')
  final String? nameArray;
  @JsonKey(name: 'images')
  final List<ItemImage>? images;
  factory LoadAssets.fromJson(Map<String, dynamic> json) =>
      _$LoadAssetsFromJson(json);
}

@JsonSerializable()
class ItemImage {
  ItemImage({
    this.name,
    this.image,
  }) : super();
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'image')
  final String? image;
  factory ItemImage.fromJson(Map<String, dynamic> json) =>
      _$ItemImageFromJson(json);
}
