class userData{
  String name = '';
  String email = '';

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