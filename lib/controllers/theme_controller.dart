import 'package:get/get.dart';
import 'package:number_game/models/theme_model.dart';
import 'package:number_game/services/theme_db.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.put(ThemeController());
  RxBool theme = true.obs;

  @override
  void onInit() {
    loadTheme();
    super.onInit();
  }

  loadTheme() async {
    var dbResponse = await ThemeDb.getTheme();
    if (dbResponse[0].isLight == 1)
      theme.value = true;
    else
      theme.value = false;
    print(dbResponse[0].isLight);
  }

  changeTheme(bool isLight) {
    ThemeModel themeModel = ThemeModel(id: 1, isLight: isLight ? 0 : 1);
    ThemeDb.changeTheme(themeModel);
    theme.value = !isLight;
    print(!isLight);
    theme.refresh();
  }
}
