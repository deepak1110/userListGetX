import 'package:dio/dio.dart';
import 'package:infosridetask/pages/userList/models/userListModel.dart';

class UserListSC {
  Future<UserListModel> getUserList(
    int index,
  ) async {
    try {
      var response = await Dio().get("https://reqres.in/api/users?page=$index");
      UserListModel userListModel = UserListModel.fromJson(response.data);
      return userListModel;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
