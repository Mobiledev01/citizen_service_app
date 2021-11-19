class AdvtLicenseAdvertiseDetailsModel {
  String dft_advt_lic_advt_dtl_id = '';
  String type_of_advt = '';
  String size_of_advt = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';


  AdvtLicenseAdvertiseDetailsModel(
      {required this.dft_advt_lic_advt_dtl_id,
      required this.type_of_advt,
      required this.size_of_advt,
      required this.crt_date,
      required this.crt_user,
      required this.crt_ip,
      required this.lst_upd_ip,
      required this.lst_upd_date,
      required this.lst_upd_user,
      required this.status});

  AdvtLicenseAdvertiseDetailsModel.fromJson(Map<String, dynamic> json) {
    type_of_advt = json['type_of_advt'];
    size_of_advt = json['size_of_advt'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_of_advt'] = this.type_of_advt;
    data['size_of_advt'] = this.size_of_advt;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
