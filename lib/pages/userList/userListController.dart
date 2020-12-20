// controlling all the state management of user list
import 'package:get/get.dart';
import 'models/userListModel.dart';
import 'serviceCaller/userListSC.dart';

class UserListController extends GetxController {
  // storing current page index value
  int pageIndex = 1;

  // storing user data to user list view
  var userListModel = UserListModel().obs;
  userList(UserListModel data) => this.userListModel.value = data;
  UserListModel get userData => userListModel.value;

  // checking maximum number of pages available if no next pages available then return false then true
  bool get onLoad =>
      pageIndex != null &&
      this.userListModel.value.page != this.userListModel.value.totalPages;

  /// fetch user data from api [fetch function is used for both while refreshing the page and loading the next page]
  fetch({bool isPull = true}) async {
    // used to increase the page index when next page is called
    if (pageIndex != null && pageIndex >= 1 && onLoad) {
      pageIndex++;
    }

    // changing page index to 1 when user refresh the page
    if (isPull == true) pageIndex = 1;

    var datas = await UserListSC().getUserList(pageIndex);
    pageIndex = datas.page;
    userDataAdd(datas);
  }

  // adding user data according to pagination
  userDataAdd(UserListModel datas) {
    print(pageIndex);
    if (pageIndex != null && pageIndex <= 1) {
      userList(datas);
    } else {
      UserListModel userListModelNew = UserListModel();
      userListModelNew.totalPages = datas.totalPages;
      userListModelNew.page = datas.page;
      userListModelNew.userDataList = this.userListModel.value.userDataList;
      userListModelNew.userDataList.addAll(datas.userDataList);
      userList(userListModelNew);
    }
  }
}
