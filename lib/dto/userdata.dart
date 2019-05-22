class userData{
  String name = '';
  String email = '';
  String status = '';
  setUserData(
    String name,
    String email
  ){
    this.name = name;
    this.email = email;
  }
  setStatus(
    String status
    ){
    this.status = status;
  }
  getName(){
    return name;
  }
  getEmail(){
    return email;
  }
  getStatus(){
    return status;
  }
}