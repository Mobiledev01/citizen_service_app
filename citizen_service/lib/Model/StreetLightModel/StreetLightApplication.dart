class StreetLightApplication {
  String dtl_street_light_id = '';
  String applicant_name = '';
  String mob_no = '';
  String district_id = '';
  String taluka_id = '';
  String panchayat_id = '';
  String village_id = '';
  String landmark_location = '';
  String problem_description_id = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  StreetLightApplication(
      this.dtl_street_light_id,
      this.applicant_name,
      this.mob_no,
      this.district_id,
      this.taluka_id,
      this.panchayat_id,
      this.village_id,
      this.landmark_location,
      this.problem_description_id,
      this.crt_date,
      this.crt_user,
      this.crt_ip,
      this.lst_upd_ip,
      this.lst_upd_date,
      this.lst_upd_user,
      this.status);

  StreetLightApplication.fromJson(Map<String, dynamic> json) {
   // dtl_street_light_id = json['dtl_street_light_id'];
    applicant_name = json['applicant_name'];
    mob_no = json['mob_no'];
    district_id = json['district_id'];
    taluka_id = json['tp_id'];
    panchayat_id = json['gp_id'];
    village_id = json['village_id'];
    landmark_location = json['landmark_location'];
    problem_description_id = json['prob_dtl_id'];
    // crt_date = json['crt_date'];
    // crt_user = json['crt_user'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   // data['dtl_street_light_id'] = this.dtl_street_light_id;
    data['applicant_name'] = this.applicant_name;
    data['mob_no'] = this.mob_no;
    data['district_id'] = this.district_id;
    data['tp_id'] = this.taluka_id;
    data['gp_id'] = this.panchayat_id;
    data['village_id'] = this.village_id;
    data['landmark_location'] = this.landmark_location;
    data['prob_dtl_id'] = this.problem_description_id;
    data['village_id'] = this.village_id;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['crt_user'] = this.crt_user;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
