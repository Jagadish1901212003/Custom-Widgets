//this user modelis for after login from Azure

class UserInfoModel {
  String? employeeId;
  String? displayName;
  String? mail;

  UserInfoModel({this.employeeId, this.displayName, this.mail});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    displayName = json['displayName'];
    mail = json['mail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['employeeId'] = employeeId;
    data['displayName'] = displayName;
    data['mail'] = mail;
    return data;
  }
}
