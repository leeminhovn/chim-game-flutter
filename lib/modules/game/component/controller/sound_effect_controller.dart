import 'package:chim_kha/component/general/constant/app_constant.dart';
import 'package:chim_kha/component/untils/sound_effect.dart';

class SoundEffectController {
  final AudioPlay wingPlayAudio =
      AudioPlay(assetsFile: AppConstant.audiosLoad['wing']);
  final AudioPlay hitPlayAudio =
      AudioPlay(assetsFile: AppConstant.audiosLoad['hit']);
  final AudioPlay diePlayAudio =
      AudioPlay(assetsFile: AppConstant.audiosLoad['die']);
  final AudioPlay pointPlayAudio =
      AudioPlay(assetsFile: AppConstant.audiosLoad['point']);
}
