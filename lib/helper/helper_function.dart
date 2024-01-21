import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  //save searched user name
  saveLastSearchUserName( String user)  async{
    SharedPreferences  data = await SharedPreferences.getInstance();
    List<String> userNameList = data.getStringList('lastUserNameList') ?? [];
    userNameList.add(user);
    userNameList = userNameList.toSet().toList();
    data.setStringList('lastUserNameList', userNameList);
  }

  //get searched user name
  Future<List<String>> getLastSearchUserNames() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    List<String>? lastUserNames = data.getStringList('lastUserNameList');
    return lastUserNames ?? [];
  }

  //remove item from index
  removeItemFromIndex(String user)async{
    SharedPreferences data = await SharedPreferences.getInstance();
    List<String>? lastUserJCode = data.getStringList('lastUserNameList');
    lastUserJCode?.remove(user);
    data.setStringList('lastUserNameList', lastUserJCode!);
  }


  //--------------------------------------------------------------------------

  //save Theme Mode from sh
  saveThemeMode(bool valueTheme) async {
    SharedPreferences data = await SharedPreferences.getInstance();
    data.setBool('themeStatus', valueTheme);
  }

  //get Theme Mode from sh
  getThemeMode() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    bool? valueTheme = data.getBool('themeStatus');
    return valueTheme;
  }

}