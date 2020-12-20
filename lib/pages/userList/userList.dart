// displaying the user list

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'userListController.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  // storing value in getx controller
  UserListController controller = Get.put(UserListController());

  // refresh controller for pull to refresh and pagingation
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    controller.fetch();
    super.initState();
  }

  // this function call when user refresh the screen while pull down
  void _onRefresh() async {
    await controller.fetch(isPull: true);
    _refreshController.refreshCompleted();
  }

  // this function is used for the next page , when user pull up the list to load more data
  void _onLoading() async {
    await controller.fetch(isPull: false);
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Obx(
        () {
          // show the loader when user data is null otherwise show user data
          if (controller.userData != null &&
              controller.userData.userDataList != null)
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: controller.onLoad,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                itemCount: controller.userData.userDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        controller.userData.userDataList[index].avatar,
                      ),
                    ),
                    title: Text(
                      controller.userData.userDataList[index].firstName +
                          ' ' +
                          controller.userData.userDataList[index].lastName,
                    ),
                    subtitle: Text(
                      controller.userData.userDataList[index].email,
                    ),
                  );
                },
              ),
            );
          return SizedBox(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
