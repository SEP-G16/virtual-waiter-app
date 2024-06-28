import 'package:get/get.dart';
import 'package:virtual_waiter/enums/add_on_icon_animation_status.dart';

class AddOnIconAnimationController extends GetxController{
  RxBool _isAddIcon = true.obs;
  Rx<AddOnIconAnimationStatus> _animationStatus = AddOnIconAnimationStatus.addIconDisplayed.obs;
  AddOnIconAnimationStatus get animationStatus => _animationStatus.value;
  bool get isAddIcon => _isAddIcon.value;
  set isAddIcon(bool value){
    if(value){
     _animationStatus.value = AddOnIconAnimationStatus.addIconDisplayed;
    }
    else
      {
        _animationStatus.value = AddOnIconAnimationStatus.removeIconDisplayed;
      }
    _isAddIcon.value = value;
    update();
  }


}