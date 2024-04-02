
class MyUser{
  static String collectionName="users";
  static MyUser? currentUser;
  late String id;
  late String username ;
  late String email ;

  MyUser({
    required this.id ,
    required this.username ,
    required this.email ,
  });
  MyUser.fromJson(Map json){
    id=json["id"];
    email=json["email"];
    username=json["username"];
  }
  //convert from object to map
  Map<String ,Object> toJson(){
    return{ "id": id,
    "email": email,
    "username": username,};
  }
}