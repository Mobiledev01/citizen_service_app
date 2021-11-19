class NewWaterConnectionWaterConnectionModel {
  String dft_new_water_conn_water_dtl_id = '';
  String ppsd_of_water_conn = '';
  String water_teriff = '';
  String no_of_family_mem = '';
  String east = '';
  String south = '';
  String west = '';
  String north = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  NewWaterConnectionWaterConnectionModel(
      this.dft_new_water_conn_water_dtl_id,
      this.ppsd_of_water_conn,
      this.water_teriff,
      this.no_of_family_mem,
      this.east,
      this.south,
      this.west,
      this.north,
      this.crt_date,
      this.crt_user,
      this.crt_ip,
      this.lst_upd_ip,
      this.lst_upd_date,
      this.lst_upd_user,
      this.status);

  NewWaterConnectionWaterConnectionModel.fromJson(Map<String, dynamic> json) {
    //dft_new_water_conn_water_dtl_id = json['dft_new_water_conn_water_dtl_id'];
    ppsd_of_water_conn = json['ppsd_of_water_conn'];
    water_teriff = json['water_teriff'];
    no_of_family_mem = json['no_of_family_mem'];
    east = json['east'];
    south = json['south'];
    west = json['west'];
    north = json['north'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   // data['dft_new_water_conn_water_dtl_id'] =this.dft_new_water_conn_water_dtl_id;
    data['ppsd_of_water_conn'] = this.ppsd_of_water_conn;
    data['water_teriff'] = this.water_teriff;
    data['no_of_family_mem'] = this.no_of_family_mem;
    data['east'] = this.east;
    data['south'] = this.south;
    data['west'] = this.west;
    data['north'] = this.north;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
