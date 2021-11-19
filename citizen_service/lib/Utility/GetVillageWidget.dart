import 'package:citizen_service/Model/DTGVModel/DistrictModel.dart';
import 'package:citizen_service/Model/DTGVModel/PanchayatModel.dart';
import 'package:citizen_service/Model/DTGVModel/TalukaModel.dart';
import 'package:citizen_service/Model/DTGVModel/VillageModel.dart';
import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:flutter/material.dart';

class GetVillageWidget extends StatefulWidget {
  String? selectedDistId;
  String? selectedTalukaId;
  String? selectedPanchayatId;
  String? selectedVillageId;
  Function selectValue;

  GetVillageWidget(
      {required this.selectedDistId,
      required this.selectedTalukaId,
      required this.selectedPanchayatId,
      required this.selectedVillageId,
      required this.selectValue});

  @override
  _GetVillageWidgetState createState() => _GetVillageWidgetState();
}

class _GetVillageWidgetState extends State<GetVillageWidget> {
  List<DistrictModel> districtModelList = [];
  List<TalukaModel> talutaModelList = [];
  List<PanchayatModel> panchayatModelList = [];
  List<VillageModel> villageModelList = [];

  @override
  void initState() {
    super.initState();

    getAllDistrict();

    if (widget.selectedDistId != null && widget.selectedDistId!.isNotEmpty) {
      getAllTaluka(widget.selectedDistId);
    }

    if (widget.selectedDistId != null &&
        widget.selectedDistId!.isNotEmpty &&
        widget.selectedTalukaId != null &&
        widget.selectedTalukaId!.isNotEmpty) {
      getAllPanchayat(widget.selectedDistId!, widget.selectedTalukaId);
    }

    if (widget.selectedDistId != null &&
        widget.selectedDistId!.isNotEmpty &&
        widget.selectedTalukaId != null &&
        widget.selectedTalukaId!.isNotEmpty &&
        widget.selectedPanchayatId != null &&
        widget.selectedPanchayatId!.isNotEmpty) {
      getAllVillage(widget.selectedDistId!, widget.selectedTalukaId!,
          widget.selectedPanchayatId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelField(getTranslated(context,'Building_License','district'),),
          DropdownButtonFormField<String>(
            hint: Text('Select District'),
            isExpanded: true,
            items: districtModelList.map((DistrictModel user) {
              return DropdownMenuItem<String>(
                  value: user.district_id,
                  child: Text(
                    user.district_name! + ' (' + user.district_id! + ')',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ));
            }).toList(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) =>
                value == null ? 'Please select district' : null,
            onChanged: (String? value) async {
              if (widget.selectedDistId == '' ||
                  (value != widget.selectedDistId)) {
                setState(() {
                  widget.selectedDistId = value;
                  widget.selectedTalukaId = null;
                  widget.selectedPanchayatId = null;
                  widget.selectedVillageId = null;
                });

                getAllTaluka(value);
              }
            },
            value: widget.selectedDistId != '' ? widget.selectedDistId : null,
          ),
          EmptyWidget(),
          labelField(getTranslated(context,'Building_License','taluka'),),
          DropdownButtonFormField<String>(
            hint: Text('Select Taluka'),
            isDense: true,
            value:
                widget.selectedTalukaId != '' ? widget.selectedTalukaId : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value == null ? 'Please select taluka' : null,
            onChanged: (String? value) async {
              if (widget.selectedTalukaId == '' ||
                  (value! != widget.selectedTalukaId)) {
                setState(() {
                  widget.selectedTalukaId = value;
                  widget.selectedPanchayatId = '';
                  widget.selectedVillageId = '';
                });

                getAllPanchayat(widget.selectedDistId!, value);
              }
            },
            isExpanded: true,
            items: talutaModelList.map((TalukaModel user) {
              return DropdownMenuItem<String>(
                  value: user.taluka_id,
                  child: Text(
                    user.taluka_name! + ' (' + user.taluka_id! + ')',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ));
            }).toList(),

          ),
          EmptyWidget(),
          labelField(getTranslated(context,'Building_License','panchayat'), ),
          DropdownButtonFormField<String>(
            hint: Text('Select Panchayat'),
            isDense: true,
            value: widget.selectedPanchayatId != ''
                ? widget.selectedPanchayatId
                : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) =>
                value == null ? 'Please select panchayat' : null,
            onChanged: (String? value) async {
              if (widget.selectedPanchayatId == '' ||
                  (value != widget.selectedPanchayatId)) {
                setState(() {
                  widget.selectedPanchayatId = value;
                  widget.selectedVillageId = '';
                });

                getAllVillage(
                    widget.selectedDistId!, widget.selectedTalukaId!, value);
              }
            },
            isExpanded: true,
            items: panchayatModelList.map((PanchayatModel user) {
              return DropdownMenuItem<String>(
                  value: user.panchayat_id,
                  child: Text(
                    user.panchayat_name! + ' (' + user.panchayat_id! + ')',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ));
            }).toList(),
          ),
          EmptyWidget(),
          labelField(getTranslated(context,'Building_License','village'),),
          DropdownButtonFormField<String>(
            hint: Text('Select Village'),
            isDense: true,
            value: widget.selectedVillageId != ''
                ? widget.selectedVillageId
                : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) =>
                value == null ? 'Please select village' : null,
            onChanged: (String? value) async {
              if (widget.selectedVillageId == '' ||
                  (value != widget.selectedVillageId)) {
                setState(() {
                  widget.selectedVillageId = value;
                });
                widget.selectValue(
                    widget.selectedDistId,
                    widget.selectedTalukaId,
                    widget.selectedPanchayatId,
                    widget.selectedVillageId);
              }
            },
            isExpanded: true,
            items: villageModelList.map((VillageModel user) {
              return DropdownMenuItem<String>(
                  value: user.village_id,
                  child: Text(
                    user.village_name! + ' (' + user.village_id! + ')',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ));
            }).toList(),
          ),
        ],
      ),
    );
  }
  void getAllDistrict() async {
    districtModelList.clear();
    districtModelList = await DatabaseOperation.instance.getAllDistrict();
    setState(() {});
  }

  void getAllTaluka(String? value) async {
    talutaModelList.clear();
    if (value!.isNotEmpty) {
      talutaModelList = await DatabaseOperation.instance.getAllTaluka(value);
    }

    setState(() {});
  }

  void getAllPanchayat(String distId, String? value) async {
    panchayatModelList.clear();
    if (value!.isNotEmpty) {
      panchayatModelList =
          await DatabaseOperation.instance.getAllPanchayat(distId, value);
    }

    setState(() {});
  }

  void getAllVillage(String distId, String tpId, String? value) async {
    villageModelList.clear();
    if (value!.isNotEmpty) {
      villageModelList =
          await DatabaseOperation.instance.getAllVillage(distId, tpId, value);
    }

    setState(() {});
  }
}
