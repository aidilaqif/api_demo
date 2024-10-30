class Employee{
  // "id": 7,
  // "email": "michael.lawson@reqres.in",
  // "first_name": "Michael",
  // "last_name": "Lawson",
  // "avatar": "https://reqres.in/img/faces/7-image.jpg"

  // Declaring variables
  // Variables must use small letter on 1st word then capital letter for 2nd word
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Employee({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });
  // Map because the data is in JSON
  Employee.fromJson(Map<String, dynamic> json){ // dynamic because there are different data type
    id = json['id'];
    email = json['email'];
    firstName = json['first_name']; // variable in json parameter must match variable name in json file
    lastName = json['last_name'];
    avatar = json['avatar'];
  }
}