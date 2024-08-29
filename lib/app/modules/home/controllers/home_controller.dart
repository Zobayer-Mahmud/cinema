import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;
  void changeIndex(int value) {
    selectedIndex = value;
    update();}
}
