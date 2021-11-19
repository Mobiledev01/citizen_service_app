class TradeLicenseTypeAppModel {
  String dtl_trade_lic_type_id = '';
  String lic_service_type_id = '';
  String sub_service_type = '';
  String trade_name = '';
  String land_area_sq_meet = '';
  String building_area_sq_meet = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  TradeLicenseTypeAppModel(
      {required this.dtl_trade_lic_type_id,
        required this.lic_service_type_id,
        required this.sub_service_type,
        required this.trade_name,
        required this.land_area_sq_meet,
        required this.building_area_sq_meet,
        required this.crt_date,
        required this.crt_user,
        required this.crt_ip,
        required this.lst_upd_ip,
        required this.lst_upd_date,
        required this.lst_upd_user,
        required this.status});

  TradeLicenseTypeAppModel.fromJson(Map<String, dynamic> json) {
   // dtl_trade_lic_type_id = json['dtl_trade_lic_type_id'];
    lic_service_type_id = json['lic_service_type_id'];
    sub_service_type = json['sub_service_type'];
    trade_name = json['trade_name'];
    land_area_sq_meet = json['land_area_sq_meet'];
    building_area_sq_meet = json['building_area_sq_meet'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   // data['dtl_trade_lic_type_id'] = this.dtl_trade_lic_type_id;
    data['lic_service_type_id'] = this.lic_service_type_id;
    data['sub_service_type'] = this.sub_service_type;
    data['trade_name'] = this.trade_name;
    data['land_area_sq_meet'] = this.land_area_sq_meet;
    data['building_area_sq_meet'] = this.building_area_sq_meet;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
