class ProData {
  ProData(
      {this.name,
        this.surname,
        this.mail,
        this.phone,
        this.sex,
        this.notification,
        this.picture,
        });

  final String name;
  final String surname;
  final String mail;
  final String phone;
  final bool sex;
  final bool notification;
  final String picture;


  Map<String,dynamic> getDataMap(){
    return {
      "name":name,
      "surname":surname,
      "mail":mail,
      "phone":phone,
      "sex":sex,
      "notification":notification,
      "picture":picture,
    };
  }
}