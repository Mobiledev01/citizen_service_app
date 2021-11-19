class BusinessLicenseBuildingDetailsModel {
  String dft_bldg_lic_bldg_dtl = '';
  String constr_type = '';
  String purpose_id = '';
  String prop_type_id = '';
  String est_of_bldg = '';
  String ppsd_plinth_area = '';
  String type_of_bldg_constr_id = '';
  String total_area = '';
  String built_area = '';
  String east_west = '';
  String north_south = '';
  String east = '';
  String south = '';
  String west = '';
  String north = '';
  String drctn_of_door_id = '';
  String no_of_room_ppsd = '';
  String no_of_floors_ppsd = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  BusinessLicenseBuildingDetailsModel(
      {required this.dft_bldg_lic_bldg_dtl,
      required this.constr_type,
      required this.purpose_id,
      required this.prop_type_id,
      required this.est_of_bldg,
      required this.ppsd_plinth_area,
      required this.type_of_bldg_constr_id,
      required this.total_area,
      required this.built_area,
      required this.east_west,
      required this.north_south,
      required this.east,
      required this.south,
      required this.west,
      required this.north,
      required this.drctn_of_door_id,
      required this.no_of_room_ppsd,
      required this.no_of_floors_ppsd,
      required this.crt_date,
      required this.crt_user,
      required this.crt_ip,
      required this.lst_upd_ip,
      required this.lst_upd_date,
      required this.lst_upd_user,
      required this.status});

  BusinessLicenseBuildingDetailsModel.fromJson(Map<String, dynamic> json) {
  //  dft_bldg_lic_bldg_dtl = json['dft_bldg_lic_bldg_dtl'];
    constr_type = json['constr_type'];
    purpose_id = json['purpose_id'];
    prop_type_id = json['prop_type_id'];
    est_of_bldg = json['est_of_bldg'];
    ppsd_plinth_area = json['ppsd_plinth_area'];
    type_of_bldg_constr_id = json['type_of_bldg_constr_id'];
    total_area = json['total_area'];
    built_area = json['built_area'];
    east_west = json['east_west'];
    north_south = json['north_south'];
    east = json['east'];
    south = json['south'];
    west = json['west'];
    north = json['north'];
    drctn_of_door_id = json['drctn_of_door_id'];
    no_of_room_ppsd = json['no_of_room_ppsd'];
    no_of_floors_ppsd = json['no_of_floors_ppsd'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  //  data['dft_bldg_lic_bldg_dtl'] = this.dft_bldg_lic_bldg_dtl;
    data['constr_type'] = this.constr_type;
    data['purpose_id'] = this.purpose_id;
    data['prop_type_id'] = this.prop_type_id;
    data['est_of_bldg'] = this.est_of_bldg;
    data['ppsd_plinth_area'] = this.ppsd_plinth_area;
    data['type_of_bldg_constr_id'] = this.type_of_bldg_constr_id;
    data['total_area'] = this.total_area;
    data['built_area'] = this.built_area;
    data['east_west'] = this.east_west;
    data['north_south'] = this.north_south;
    data['east'] = this.east;
    data['south'] = this.south;
    data['west'] = this.west;
    data['north'] = this.north;
    data['drctn_of_door_id'] = this.drctn_of_door_id;
    data['no_of_room_ppsd'] = this.no_of_room_ppsd;
    data['no_of_floors_ppsd'] = this.no_of_floors_ppsd;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
