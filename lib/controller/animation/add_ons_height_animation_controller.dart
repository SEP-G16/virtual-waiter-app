import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../enums/height_animation_status.dart';

class AddOnsHeightAnimationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  AddOnsHeightAnimationController({
    this.beginHeight = 0,
    this.endHeight = 100,
  });

  double beginHeight;
  double endHeight;

  final Rxn<AnimationController> _heightAnimationController =
      Rxn<AnimationController>();
  AnimationController? get heightAnimationController =>
      _heightAnimationController.value;

  final Rxn<Animation<double?>> _heightAnimationValue =
      Rxn<Animation<double?>>();
  Animation<double?>? get heightAnimationValue => _heightAnimationValue.value;

  final Rx<HeightAnimateStatus> _heightAnimateStatus =
      HeightAnimateStatus.collapsed.obs;
  HeightAnimateStatus get heightAnimateStatus => _heightAnimateStatus.value;
  set heightAnimateStatus(HeightAnimateStatus value) {
    _heightAnimateStatus.value = value;
    update();
  }

  final Rx<AnimationStatus> _animationStatus = AnimationStatus.dismissed.obs;
  AnimationStatus get animationStatus => _animationStatus.value;

  AnimationController? get pickedOutfitAnimationController =>
      _heightAnimationController.value;

  Animation<double?>? get outfitDeselectAnimation =>
      _heightAnimationValue.value;

  void _initHeightAnimationController() {
    Duration duration = Duration(milliseconds: 300);
    _heightAnimationController.value = AnimationController(
      vsync: this,
      duration: duration,
    );

    _heightAnimationValue.value = (Tween(
      begin: beginHeight,
      end: endHeight,
    ).chain(
      CurveTween(
        curve: Curves.ease,
      ),
    )).animate(
      _heightAnimationController.value!,
    );

    _heightAnimationController.value?.addListener(() {
      print(_heightAnimationValue.value?.value);
      update();
    });

    _heightAnimationController.value?.addStatusListener((status) {
      print(status);
      _animationStatus.value = status;
    });
  }

  void _disposeControllers() {
    _heightAnimationController.value?.dispose();
  }

  void heightForwardAnimation() {
    _heightAnimationController.value?.forward(from: 0);
    _heightAnimateStatus.value = HeightAnimateStatus.extended;
    // update();
  }

  void heightBackwardAnimation() {
    _heightAnimateStatus.value = HeightAnimateStatus.collapsed;
    _heightAnimationController.value?.reverse(from: 1);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initHeightAnimationController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _disposeControllers();
  }
}
