class RoadCuttingWorkModel {
  String dft_dtl_road_cut_work_id = '';
  String conn_type = '';
  String pur_of_road_cutting = '';
  String signif_landmark = '';
  String approx_length_road_cutt = '';
  String loc_of_road = '';
  String days_req_to_impl_work = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  RoadCuttingWorkModel(
      {required this.dft_dtl_road_cut_work_id,
        required this.conn_type,
        required this.pur_of_road_cutting,
        required this.signif_landmark,
        required this.approx_length_road_cutt,
        required this.loc_of_road,
        required this.days_req_to_impl_work,
        required this.crt_date,
        required this.crt_user,
        required this.crt_ip,
        required this.lst_upd_ip,
        required this.lst_upd_date,
        required this.lst_upd_user,
        required this.status});

  RoadCuttingWorkModel.fromJson(Map<String, dynamic> json) {
   // dft_dtl_road_cut_work_id = json['dft_dtl_road_cut_work_id'];
    conn_type = json['conn_type'];
    pur_of_road_cutting = json['pur_of_road_cutting'];
    signif_landmark = json['signif_landmark'];
    approx_length_road_cutt = json['approx_length_road_cutt'];
    loc_of_road = json['loc_of_road'];
    days_req_to_impl_work = json['days_req_to_impl_work'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   // data['dft_dtl_road_cut_work_id'] = this.dft_dtl_road_cut_work_id;
    data['conn_type'] = this.conn_type;
    data['pur_of_road_cutting'] = this.pur_of_road_cutting;
    data['signif_landmark'] = this.signif_landmark;
    data['approx_length_road_cutt'] = this.approx_length_road_cutt;
    data['loc_of_road'] = this.loc_of_road;
    data['days_req_to_impl_work'] = this.days_req_to_impl_work;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
