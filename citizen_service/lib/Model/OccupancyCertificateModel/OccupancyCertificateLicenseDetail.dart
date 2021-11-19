class OccupancyCertificateLicenseDetail {
  String dft_occp_certi_lic_dtl_id = '';
  String bldg_lic_num = '';
  String trn_cs_appl_id = '';
  String service_id = '';
  String sub_service_id = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  OccupancyCertificateLicenseDetail(
      this.dft_occp_certi_lic_dtl_id,
      this.bldg_lic_num,
      this.trn_cs_appl_id,
      this.service_id,
      this.sub_service_id,
      this.crt_date,
      this.crt_user,
      this.crt_ip,
      this.lst_upd_ip,
      this.lst_upd_date,
      this.lst_upd_user,
      this.status);

  OccupancyCertificateLicenseDetail.fromJson(Map<String, dynamic> json) {
  //  dft_occp_certi_lic_dtl_id = json['dft_occp_certi_lic_dtl_id'];
    bldg_lic_num = json['bldg_lic_num'];
    //trn_cs_appl_id = json['trn_cs_appl_id'];
    // service_id = json['service_id'];
    // sub_service_id = json['sub_service_id'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   // data['dft_occp_certi_lic_dtl_id'] = this.dft_occp_certi_lic_dtl_id;
    data['bldg_lic_num'] = this.bldg_lic_num;
    // data['trn_cs_appl_id'] = this.trn_cs_appl_id;
    // data['service_id'] = this.service_id;
    // data['sub_service_id'] = this.sub_service_id;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
