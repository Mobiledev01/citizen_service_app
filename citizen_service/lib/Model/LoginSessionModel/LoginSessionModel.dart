class LoginSessionModel {
  int? id;
  String? csLoginId;
  String? citizenRegistrationId;
  String? mobileNo;
  String? password;
  String? emailId;

  LoginSessionModel(
      {required this.csLoginId,
      required this.citizenRegistrationId,
      required this.mobileNo,
      required this.password,
      required this.emailId});

  LoginSessionModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    csLoginId = json.containsKey('cs_login_id') ? json['cs_login_id'] : json['CS_LOGIN_ID'];
    citizenRegistrationId = json.containsKey('citizen_registration_id') ? json['citizen_registration_id'] : json['CITIZEN_REGISTRATION_ID'];
    mobileNo = json.containsKey('mobile_no') ? json['mobile_no'] : json['MOBILE_NO'];
    password = json.containsKey('password') ? json['password'] : json['PASSWORD'];
    emailId = json.containsKey('email_id') ? json['email_id'] : json['EMAIL_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data.containsKey('cs_login_id') ? data['cs_login_id'] : data['CS_LOGIN_ID'] = this.csLoginId;
    data.containsKey('citizen_registration_id') ? data['citizen_registration_id'] : data['CITIZEN_REGISTRATION_ID'] = this.citizenRegistrationId;
    data.containsKey('mobile_no') ? data['mobile_no'] : data['MOBILE_NO'] = this.mobileNo;
    data.containsKey('password') ? data['password'] : data['PASSWORD'] = this.password;
    data.containsKey('email_id') ? data['email_id'] : data['EMAIL_ID']= this.emailId;
    return data;
  }
}
