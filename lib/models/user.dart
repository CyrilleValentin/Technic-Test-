class UserModel {
  late String gender;
  late String title;
  late String firstName;
  late String lastName;
  late String streetNumber;
  late String streetName;
  late String city;
  late String state;
  late String country;
  late String postcode;
  late double latitude;
  late double longitude;
  late String email;
  late String uuid;
  late String username;
  late String password;
  late String salt;
  late String md5;
  late String sha1;
  late String sha256;
  late DateTime dob;
  late DateTime registered;
  late String phone;
  late String cell;
  late String idName;
  late String idValue;
  late String pictureLarge;
  late String pictureMedium;
  late String pictureThumbnail;


  UserModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    title = json['name']['title'];
    firstName = json['name']['first'];
    lastName = json['name']['last'];
    streetNumber = json['location']['street']['number'].toString();
    streetName = json['location']['street']['name'];
    city = json['location']['city'];
    state = json['location']['state'];
    country = json['location']['country'];
    postcode = json['location']['postcode'].toString();
    latitude = double.parse(json['location']['coordinates']['latitude']);
    longitude = double.parse(json['location']['coordinates']['longitude']);
    email = json['email'];
    uuid = json['login']['uuid'].toString();
    username = json['login']['username'];
    password = json['login']['password'];
    salt = json['login']['salt'];
    md5 = json['login']['md5'];
    sha1 = json['login']['sha1'];
    sha256 = json['login']['sha256'];
    dob = DateTime.parse(json['dob']['date']);
    registered = DateTime.parse(json['registered']['date']);
     phone = json['phone'].toString();
    cell = json['cell'].toString();
    idName = json['id']['name'];
    idValue = json['id']['value'].toString();
    pictureLarge = json['picture']['large'];
    pictureMedium = json['picture']['medium'];
    pictureThumbnail = json['picture']['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'streetNumber': streetNumber,
      'streetName': streetName,
      'city': city,
      'state': state,
      'country': country,
      'postcode': postcode,
      'latitude': latitude,
      'longitude': longitude,
      'email': email,
      'uuid': uuid,
      'username': username,
      'password': password,
      'salt': salt,
      'md5': md5,
      'sha1': sha1,
      'sha256': sha256,
      'dob': dob.toIso8601String(),
      'registered': registered.toIso8601String(),
      'phone': phone,
      'cell': cell,
      'idName': idName,
      'idValue': idValue,
      'pictureLarge': pictureLarge,
      'pictureMedium': pictureMedium,
      'pictureThumbnail': pictureThumbnail,
    };
  }
}
