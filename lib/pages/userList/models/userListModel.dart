// To parse this JSON data, do

class UserListModel {
  UserListModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.userDataList,
  });

  int page;
  int perPage;
  int total;
  int totalPages;
  List<UserDataList> userDataList = [];

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        userDataList: List<UserDataList>.from(
            json["data"].map((x) => UserDataList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(userDataList.map((x) => x.toJson())),
      };
}

class UserDataList {
  UserDataList({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory UserDataList.fromJson(Map<String, dynamic> json) => UserDataList(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}
