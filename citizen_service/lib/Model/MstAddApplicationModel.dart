class MstAddApplicationModel {
  int? id;
  String cATEGORYID = '';
  String sERVICEID = '';
  String aPPLICATIONNAME = '';
  String service_name = '';
  String gENERATEDAPPLICATIONID = '';
  String aPPLICATIONAPPLYDATE = '';
  String aPPLICATIONDATA = '';
  String aPPLICATIONSYNCSTATUS = '';
  String aPPLICATIONSYNCDATE = '';
  String crt_user = '';
  String crt_date = '';
  String lst_upd_user = '';
  String lst_upd_date = '';
  String current_tab = '';
  String sync_tab = '';
  String sync_message = '';
  String final_submit_flag = '';
  String from_web = '';
  String aPPVERSION = '';
  String draft_id = '';

  MstAddApplicationModel(
      {required this.id,
      required this.cATEGORYID,
      required this.sERVICEID,
        required this.aPPLICATIONNAME,
        required this.service_name,
      required this.gENERATEDAPPLICATIONID,
      required this.aPPLICATIONAPPLYDATE,
      required this.aPPLICATIONDATA,
      required this.aPPLICATIONSYNCSTATUS,
      required this.aPPLICATIONSYNCDATE,
      required this.crt_user,
      required this.crt_date,
      required this.lst_upd_user,
      required this.lst_upd_date,
      required this.current_tab,
        required this.from_web,
        required this.draft_id,
      required this.aPPVERSION});

  MstAddApplicationModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    cATEGORYID = json['CATEGORY_ID'];
    sERVICEID = json['SERVICE_ID'];
    aPPLICATIONNAME = json['APPLICATION_NAME'];
    service_name = json['SERVICE_NAME'];
    gENERATEDAPPLICATIONID = json['GENERATED_APPLICATION_ID'];
    aPPLICATIONAPPLYDATE = json['APPLICATION_APPLY_DATE'];
    aPPLICATIONDATA = json['APPLICATION_DATA'];
    aPPLICATIONSYNCSTATUS = json['APPLICATION_SYNC_STATUS'];
    aPPLICATIONSYNCDATE = json['APPLICATION_SYNC_DATE'];
    crt_user = json['CRT_USER'];
    crt_date = json['CRT_DATE'];
    lst_upd_user = json['LST_UPD_USER'];
    lst_upd_date = json['LST_UPD_DATE'];
    current_tab = json['CURRENT_TAB'];
    sync_tab = json['SYNC_TAB'];
    sync_message = json['SYNC_MESSAGE'];
    final_submit_flag = json['FINAL_SUBMIT_FLAG'];
    from_web = json['FROM_WEB'];
    draft_id = json['DRAFT_ID'];
    aPPVERSION = json['APP_VERSION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['CATEGORY_ID'] = this.cATEGORYID;
    data['SERVICE_ID'] = this.sERVICEID;
    data['APPLICATION_NAME'] = this.aPPLICATIONNAME;
    data['SERVICE_NAME'] = this.service_name;
    data['GENERATED_APPLICATION_ID'] = this.gENERATEDAPPLICATIONID;
    data['APPLICATION_APPLY_DATE'] = this.aPPLICATIONAPPLYDATE;
    data['APPLICATION_DATA'] = this.aPPLICATIONDATA;
    data['APPLICATION_SYNC_STATUS'] = this.aPPLICATIONSYNCSTATUS;
    data['APPLICATION_SYNC_DATE'] = this.aPPLICATIONSYNCDATE;
    data['CRT_USER'] = this.crt_user;
    data['CRT_DATE'] = this.crt_date;
    data['LST_UPD_USER'] = this.lst_upd_user;
    data['LST_UPD_DATE'] = this.lst_upd_date;
    data['CURRENT_TAB'] = this.current_tab;
    data['SYNC_TAB'] = this.sync_tab;
    data['SYNC_MESSAGE'] = this.sync_message;
    data['FINAL_SUBMIT_FLAG'] = this.final_submit_flag;
    data['FROM_WEB'] = this.from_web;
    data['DRAFT_ID'] = this.draft_id;
    data['APP_VERSION'] = this.aPPVERSION;
    return data;
  }
}
