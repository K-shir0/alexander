// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HomePageState _$_$_HomePageStateFromJson(Map<String, dynamic> json) {
  return _$_HomePageState(
    spaces: (json['spaces'] as List<dynamic>?)
            ?.map((e) => SpaceMetadata.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    ideas: (json['ideas'] as List<dynamic>?)
            ?.map((e) => Idea.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_HomePageStateToJson(_$_HomePageState instance) =>
    <String, dynamic>{
      'spaces': instance.spaces,
      'ideas': instance.ideas,
    };
