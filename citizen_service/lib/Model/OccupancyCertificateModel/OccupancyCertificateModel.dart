import 'OccupancyCertificateApplicantDetailModel.dart';
import 'OccupancyCertificateDocumentDetail.dart';
import 'OccupancyCertificateLicenseDetail.dart';
import 'OccupancyCertificatePropertyDetail.dart';

class OccupancyCertificateModel {
  OccupancyCertificateApplicantDetail? occupancyCertificateApplicantDetail;
  OccupancyCertificatePropertyDetail? occupancyCertificatePropertyDetail;
  OccupancyCertificateLicenseDetail? occupancyCertificateLicenseDetail;
  OccupancyCertificateDocumentDetail? occupancyCertificateDocumentDetail;


  OccupancyCertificateModel(
      this.occupancyCertificateApplicantDetail,
      this.occupancyCertificatePropertyDetail,
      this.occupancyCertificateLicenseDetail,
      this.occupancyCertificateDocumentDetail);

  OccupancyCertificateModel.fromJson(Map<String, dynamic> json) {
    occupancyCertificateApplicantDetail =
        OccupancyCertificateApplicantDetail.fromJson(json['1']);
    occupancyCertificatePropertyDetail =
        OccupancyCertificatePropertyDetail.fromJson(json['2']);
    occupancyCertificateLicenseDetail =
        OccupancyCertificateLicenseDetail.fromJson(json['3']);
    occupancyCertificateDocumentDetail =
        OccupancyCertificateDocumentDetail.fromJson(json['4']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.occupancyCertificateApplicantDetail;
    data['2'] = this.occupancyCertificatePropertyDetail;
    data['3'] = this.occupancyCertificateLicenseDetail;
    data['4'] = this.occupancyCertificateDocumentDetail;
    return data;
  }
}
