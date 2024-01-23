class UserModel {

  //Items of user
  final String userName;
  final String email;
  final String password;
  final String userUID;
  final String profilePhoto;
  final String JCode;
  final List<String> notfList;
  final List<String> connectList;


  //Instructor
  UserModel({
    required this.userName,
    required this.email,
    required this.password,
    required this.userUID,
    required this.profilePhoto,
    required this.JCode,
    required this.notfList,
    required this.connectList,

  });

  //Convrt to Json file
  Map<String, dynamic> toJson(){
    return {
      'userName': userName,
      'email': email,
      'password': password,
      'userUID': userUID,
      'profilePhoto': profilePhoto,
      'JCode': JCode,
      'notfList': notfList,
      'connectList': connectList,
    };
  }




}
