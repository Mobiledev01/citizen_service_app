import 'NocEscomsApplicant.dart';
import 'NocEscomsDoc.dart';
import 'NocEscomsProperty.dart';

class NocEscomsModel {
  NocEscomsApplicant? nocEscomsApplicant;
  NocEcomsProperty? nocEcomsProperty;
  NocEcomsDoc? nocEcomsDoc;

  NocEscomsModel(
      this.nocEscomsApplicant, this.nocEcomsProperty, this.nocEcomsDoc);

  NocEscomsModel.fromJson(Map<String, dynamic> json) {
    nocEscomsApplicant = NocEscomsApplicant.fromJson(json['1']);
    nocEcomsProperty = NocEcomsProperty.fromJson(json['2']);
    nocEcomsDoc = NocEcomsDoc.fromJson(json['3']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.nocEscomsApplicant;
    data['2'] = this.nocEcomsProperty;
    data['3'] = this.nocEcomsDoc;
    return data;
  }
}
