class LoginModel {
  //"card_number":"12345678","card_expiry":"12345678","card_cvc":"12345678"
  LoginModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.token,
    this.profile_image,
    this.phone,
    this.google_id,
    this.password,
    this.referralCode,
    this.address,
    this.latitute,
    this.longitude,
    this.wallet,
    this.card_number,
    this.card_expiry,
    this.card_cvc,
  });

  dynamic id;
  dynamic name;
  dynamic email;
  dynamic emailVerifiedAt;

  dynamic token;
  dynamic profile_image;
  dynamic phone;
  dynamic google_id;
  dynamic password;
  dynamic referralCode;
  dynamic address;
  dynamic latitute;
  dynamic longitude;
  dynamic wallet;
  dynamic card_number;
  dynamic card_expiry;
  dynamic card_cvc;

  factory LoginModel.fromMap(Map<String, dynamic> map) => LoginModel(
        id: map["id"] ?? 0,
        name: map["name"] ?? '',
        email: map["email"] ?? '',
        phone: map["phone"] ?? '',
        profile_image: map["profile_image"] ?? '',
        token: map["token"] ?? '',
        google_id: map["google_id"] ?? '',
        password: map["password"] ?? '',
        referralCode: map["referral_code"] ?? '',
        address: map["address"] ?? '',
        latitute: map["latitute"] ?? '',
        longitude: map["longitude"] ?? '',
        wallet: map["wallet"] ?? '0',
        card_number: map["card_number"] ?? '',
        card_expiry: map["card_expiry"] ?? '',
        card_cvc: map["card_cvc"] ?? '',
      );

  Map toJson() => {
        "name": name ?? '',
        "email": email ?? '',
        "phone": phone ?? 0,
        "password": password ?? '',
        "user_type": 'user',
        "profile_image": profile_image ?? '',
        "referral_code": referralCode ?? '',
        "address": address ?? '',
        "latitute": latitute ?? '',
        "longitude": longitude ?? '',
        "wallet": wallet ?? '0',
        "card_number": referralCode ?? '',
        "card_expiry": referralCode ?? '',
        "card_cvc": referralCode ?? '',
      };
}
