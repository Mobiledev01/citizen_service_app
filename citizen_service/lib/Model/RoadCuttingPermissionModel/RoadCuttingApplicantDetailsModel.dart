class RoadCuttingApplicantDetailsModel {
  String dft_dtl_road_cut_appl = '';
  String appl_name = '';
  String address = '';
  String email_id = '';
  String mob_no = '';
   String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  RoadCuttingApplicantDetailsModel(
      {required this.dft_dtl_road_cut_appl,
      required this.appl_name,
      required this.address,
      required this.email_id,
      required this.mob_no,
      required this.crt_date,
      required this.crt_user,
      required this.crt_ip,
      required this.lst_upd_ip,
      required this.lst_upd_date,
      required this.lst_upd_user,
      required this.status});

  RoadCuttingApplicantDetailsModel.fromJson(Map<String, dynamic> json) {
   // dft_dtl_road_cut_appl = json['dft_dtl_road_cut_appl'];
    appl_name = json['appl_name'];
    address = json['address'];
    email_id = json['email_id'];
     mob_no = json['mob_no'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['dft_dtl_road_cut_appl'] = this.dft_dtl_road_cut_appl;
    data['appl_name'] = this.appl_name;
    data['address'] = this.address;
    data['email_id'] = this.email_id;
    data['mob_no'] = this.mob_no;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
