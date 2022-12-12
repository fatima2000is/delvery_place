
import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {

RxInt pageSelectionIndex = 0.obs;


  RxInt get fetchCurrentScreenIndex {
    return pageSelectionIndex;
  }

  void updateScreenIndex(int index) {
    pageSelectionIndex.value = index ;
  
  }
}
