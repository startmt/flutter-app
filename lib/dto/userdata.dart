class UserData{
  String name = '';
  String email = '';
  UserData();
  UserData.formNameEmail(String name, String email){
    this.name = name;
    this.email = email;
  }
  setUserData(
    String name,
    String email
  ){
    this.name = name;
    this.email = email;
  }
  getName(){
    return name;
  }
  getEmail(){
    return email;
  }
}