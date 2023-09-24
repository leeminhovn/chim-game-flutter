import 'package:bloc/bloc.dart';
import 'package:chim_kha/component/untils/handle_image_to_draw.dart';
import 'package:chim_kha/src/data/data_source/local/user_local_storge.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as UI;
import '../../../component/general/constant/app_constant.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(double safeWidth, double safeHeight) : super(GameInitial()) {
    initEvent(safeWidth, safeHeight);
  }

  initEvent(double safeWidth, double safeHeight) async {
    // ListLoadAssets.fromJson(AppConstant.listLoad);
    await UserLocalStorge().load();
    await Future.delayed(const Duration(seconds: 1));
    emit(GameLoading(state));

    for (var i in AppConstant.listLoad) {
      final String path = i['path'];

      if (i['type'] == 'array') {
        final String nameArray = i['nameArray'];
        List<String> listImgLink = [];
        for (var image in i['images']) {
          listImgLink.add('assets/$path/${image['image']}');
        }
        List<UI.Image> listImg = await Future.wait(listImgLink.map(
          (e) => HandleImage.loadUiImage(e),
        ));

        state.loadList[nameArray] = listImg;
        // state.loadList[nameArray] = ;
      } else if (i['type'] == 'normal') {
        List<Map<String, dynamic>> listImg = [];

        for (var image in i['images']) {
          listImg.add({
            'name': image['name'],
            'image': 'assets/${i['path']}/${image['image']}'
          });
          // state.loadList[image['name']] = image['image'];
          // state.loadList.addAll(4);
        }
        Map<String, dynamic> convertData = {};

        listImg = await Future.wait(
          listImg.map((e) => handleSaveImage(e['name'], e['image'])),
        );
        for (Map<String, dynamic> i in listImg) {
          convertData.addAll(i);
        }
        state.loadList.addAll(convertData);
        await callFuture(300, '300 milisecond');

        state.configGame['safeWidth'] = safeWidth;
        state.configGame['safeHeight'] = safeHeight;

        emit(GameLoaded(state)
          ..loadList = state.loadList
          ..configGame = state.configGame);
      }
    }
  }

  Future<Map<String, dynamic>> handleSaveImage(String key, String value) async {
    UI.Image imageChange = await HandleImage.loadUiImage(value);
    return {key: imageChange};
  }

  Future<String> callFuture(int time, String message) {
    return Future.delayed(Duration(milliseconds: time), () => message);
  }
}
