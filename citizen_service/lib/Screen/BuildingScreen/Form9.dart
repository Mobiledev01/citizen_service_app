import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/DatePicker.dart';
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/GetVillageWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/UploadDocumentWidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Form9 extends StatefulWidget {

  final String categoryId, serviceId, title, applicationId,servieName;

  const Form9({Key? key,
    required this.title,
    required this.categoryId,
    required this.serviceId,
    required this.applicationId, required this.servieName})
      : super(key: key);

  @override
  _Form9State createState() => _Form9State();
}

class _Form9State extends State<Form9> {
  final formKeyApplicantDetails = GlobalKey<FormState>();

  final _documentId = TextEditingController();
  final _propertytId = TextEditingController();
  final _assestNo = TextEditingController();
  final _propertyClass = TextEditingController();
  final _propertyType = TextEditingController();
  final _site = TextEditingController();
  final _building = TextEditingController();
  final _eastWest = TextEditingController();
  final _northSouth = TextEditingController();
  final _roofType = TextEditingController();
  final _checkbandiNorth = TextEditingController();
  final _checkbandiEast = TextEditingController();
  final _checkbandiSouth = TextEditingController();
  final _checkbandiWest = TextEditingController();
  final _resolutionNum = TextEditingController();
  final _mutationNum = TextEditingController();
  final _surveyNum = TextEditingController();
  final _propertyCategory = TextEditingController();
  final _acquistionType = TextEditingController();
  final _propertyDocDet = TextEditingController();
  final _totalDemand = TextEditingController();
  final _taxCollected = TextEditingController();
  final _balance = TextEditingController();
  final _ownerDetails = TextEditingController();
  final _ownerName = TextEditingController();
  final _identifierType = TextEditingController();
  final _address = TextEditingController();
  final _ownerIden = TextEditingController();
  final _area = TextEditingController();
  final _rights = TextEditingController();
  final _liabilities = TextEditingController();
  final _roofDetails = TextEditingController();
  final _floorDetail = TextEditingController();
  final _formPrintCost = TextEditingController();
  final _reciptNo = TextEditingController();
  final _issuedBy = TextEditingController();
  final _issuerPlace = TextEditingController();
  final _issuerName = TextEditingController();

  final _documentIdFocusNode = FocusNode();
  final _propertytIdFocusNode = FocusNode();
  final _assestNoFocusNode = FocusNode();
  final _propertyClassFocusNode = FocusNode();
  final _propertyTypeFocusNode = FocusNode();
  final _siteFocusNode = FocusNode();
  final _buildingFocusNode = FocusNode();
  final _areaFocusNode = FocusNode();
  final _eastWestFocusNode = FocusNode();
  final _northSouthFocusNode = FocusNode();
  final _roofTypeFocusNode = FocusNode();
  final _checkbandiNorthFocusNode = FocusNode();
  final _checkbandiEastFocusNode = FocusNode();
  final _checkbandiSouthFocusNode = FocusNode();
  final _checkbandiWestFocusNode = FocusNode();
  final _resolutionNumFocusNode = FocusNode();
  final _mutationNumFocusNode = FocusNode();
  final _surveyNumFocusNode = FocusNode();
  final _propertyCategoryFocusNode = FocusNode();
  final _acquistionTypeFocusNode = FocusNode();
  final _propertyDocDetFocusNode = FocusNode();
  final _totalDemandFocusNode = FocusNode();
  final _taxCollectedFocusNode = FocusNode();
  final _balanceFocusNode = FocusNode();
  final _ownerDetailsFocusNode = FocusNode();
  final _ownerNameFocusNode = FocusNode();
  final _identifierTypeFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _ownerIdenFocusNode = FocusNode();
  final _rightsFocusNode = FocusNode();
  final _liabilitiesFocusNode = FocusNode();
  final _roofDetailsFocusNode = FocusNode();
  final _floorDetailFocusNode = FocusNode();
  final _formPrintCostFocusNode = FocusNode();
  final _reciptNoFocusNode = FocusNode();
  final _issuedByFocusNode = FocusNode();
  final _issuerPlaceFocusNode = FocusNode();
  final _issuerNameFocusNode = FocusNode();

  DateTime date = DateTime.now();
  String printdate = 'mm/dd/yyyy';
  String enddate = 'mm/dd/yyyy';
  String? selectedDistId;
  String? selectedTalukaId;
  String? selectedPanchayatId;
  String? selectedVillageId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(form_9),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKeyApplicantDetails,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 15),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 15, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetVillageWidget(
                        selectedDistId: selectedDistId,
                        selectedTalukaId: selectedTalukaId,
                        selectedPanchayatId: selectedPanchayatId,
                        selectedVillageId: selectedVillageId,
                        selectValue: (district, taluka, panchayat, village) {
                          setState(() {
                            selectedDistId = district;
                            selectedTalukaId = taluka;
                            selectedPanchayatId = panchayat;
                            selectedVillageId = village;
                          });
                        }),
                    EmptyWidget(),
                    TextFormField(
                      controller: _documentId,
                      focusNode: _documentIdFocusNode,
                      keyboardType: TextInputType.phone,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter document id';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: document_id,
                      ),
                    ),
                    TextFormField(
                      controller: _propertytId,
                      focusNode: _propertytIdFocusNode,
                      keyboardType: TextInputType.name,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter property id';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: property_id,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _assestNo,
                      focusNode: _assestNoFocusNode,
                      keyboardType: TextInputType.phone,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter asset no ';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: asset_no,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _propertyClass,
                      focusNode: _propertyClassFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter property classification';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: pro_classification,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _propertyType,
                      focusNode: _propertyTypeFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter property type';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: property_type,
                      ),
                    ),
                    EmptyWidget(),
                    EmptyWidget(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        Area,
                        style: grayNormalText16,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _site,
                      focusNode: _siteFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter site details';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: site,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _building,
                      focusNode: _buildingFocusNode,
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter building details';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: building,
                      ),
                    ),
                    EmptyWidget(),
                    EmptyWidget(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        measurement,
                        style: grayNormalText16,
                      ),
                    ),
                    EmptyWidget(),
                    EmptyWidget(),
                    TextFormField(
                      controller: _eastWest,
                      focusNode: _eastWestFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter east west details';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: east_west,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _northSouth,
                      focusNode: _northSouthFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter north south details';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        hintText: north_south,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _roofType,
                      focusNode: _roofTypeFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter roof type ';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: roofe_type,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _checkbandiNorth,
                      focusNode: _checkbandiNorthFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter checkbandi north';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: check_bandi_north,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _checkbandiEast,
                      focusNode: _checkbandiEastFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter checkbandi east';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: check_bandi_east,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _checkbandiSouth,
                      focusNode: _checkbandiSouthFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter checkbandi south';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: check_bandi_south,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _checkbandiWest,
                      focusNode: _checkbandiWestFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter checkbandi west';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: check_bandi_west,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _resolutionNum,
                      focusNode: _resolutionNumFocusNode,
                      keyboardType: TextInputType.multiline,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter resolution num';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: resolution_num,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _mutationNum,
                      focusNode: _mutationNumFocusNode,
                      keyboardType: TextInputType.multiline,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter mutation transaction details';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: mutation_transaction,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _surveyNum,
                      focusNode: _surveyNumFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter survey no';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: survey_no,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _propertyCategory,
                      focusNode: _propertyCategoryFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter property category';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: property_category,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _acquistionType,
                      focusNode: _acquistionTypeFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter acquisition type';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: acquisition_type,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _propertyDocDet,
                      focusNode: _propertyDocDetFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter property details';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: pro_doc_de,
                      ),
                    ),
                    EmptyWidget(),
                    Text(
                      pro_photo,
                      style: grayNormalText14,
                    ),

                    UploadDocumentWidget(
                        flag: 'P',
                        lable: fineName + ' ( .jpg .png .jpeg )',
                        selectValue: (value, flag) {
                          if (flag == 'C') {
                            XFile file = value;
                            print(file.path + ',' + file.name);
                          } else {
                            PlatformFile file = value;
                            print(file.path! + ',' + file.name);
                          }
                        }),
                    EmptyWidget(),
                    TextFormField(
                      controller: _totalDemand,
                      focusNode: _totalDemandFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter total demand';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: total_demand,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _taxCollected,
                      focusNode: _taxCollectedFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter tax collected';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: tax_coll,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _balance,
                      focusNode: _balanceFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter balance';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: balance,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _ownerDetails,
                      focusNode: _ownerDetailsFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter owner details';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: owner_details,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _ownerName,
                      focusNode: _ownerNameFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter owner name';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: owner_name,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _identifierType,
                      focusNode: _identifierTypeFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter identifier';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: identifier,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _address,
                      focusNode: _addressFocusNode,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter address';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: address,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _ownerIden,
                      focusNode: _ownerIdenFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter identification';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: owner_ident,
                      ),
                    ),
                    EmptyWidget(),
                    Text(
                      owner_photo,
                      style: grayNormalText14,
                    ),
                    UploadDocumentWidget(
                        flag: 'P',
                        lable: fineName + ' ( .jpg .png .jpeg )',
                        selectValue: (value, flag) {
                          if (flag == 'C') {
                            XFile file = value;
                            print(file.path + ',' + file.name);
                          } else {
                            PlatformFile file = value;
                            print(file.path! + ',' + file.name);
                          }
                        }),
                    EmptyWidget(),
                    TextFormField(
                      controller: _rights,
                      focusNode: _rightsFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter rights';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: rights,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _liabilities,
                      focusNode: _liabilitiesFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter liabilities';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: liabilities,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _roofDetails,
                      focusNode: _roofDetailsFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter roof detail';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: roof_detail,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _floorDetail,
                      focusNode: _floorDetailFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter floor';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: floor,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _area,
                      focusNode: _areaFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter Area';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: Area,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _floorDetail,
                      focusNode: _floorDetailFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter floor detail';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: floor_detail,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _formPrintCost,
                      focusNode: _formPrintCostFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter form cost';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: form_cost,
                      ),
                    ),
                    EmptyWidget(),
                    Text(
                      print_date,
                      style: grayNormalText14,
                    ),
                    EmptyWidget(),
                    DateChoser(date, (value) {
                      print(value);
                    }, printdate.toString()),
                    EmptyWidget(),
                    TextFormField(
                      controller: _reciptNo,
                      focusNode: _reciptNoFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter receipt no';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: receipt_no,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _issuedBy,
                      focusNode: _issuedByFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter issued by';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: issued_by,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _issuerPlace,
                      focusNode: _issuerPlaceFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter issuer place';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: issuer_place,
                      ),
                    ),
                    EmptyWidget(),
                    TextFormField(
                      controller: _issuerName,
                      focusNode: _issuerNameFocusNode,
                      keyboardType: TextInputType.text,
                      style: blackNormalText16,
                      validator: (value) {
                        if (value.toString().isEmpty)
                          return 'Enter issuer name';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        hintText: issuer_name,
                      ),
                    ),
                    EmptyWidget(),
                    Text(
                      end_date,
                      style: grayNormalText14,
                    ),
                    EmptyWidget(),
                    DateChoser(date, (value) {
                      print(value);
                    }, enddate.toString()),
                    EmptyWidget(),
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        style: submitButtonBlueStyle,
                        onPressed: () {},
                        child: Text(
                          submit.toUpperCase(),
                          style: whiteNormalText16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
