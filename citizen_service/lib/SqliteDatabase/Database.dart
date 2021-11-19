import 'dart:convert';

import 'package:citizen_service/Model/DTGVModel/DistrictModel.dart';
import 'package:citizen_service/Model/DTGVModel/PanchayatModel.dart';
import 'package:citizen_service/Model/DTGVModel/TalukaModel.dart';
import 'package:citizen_service/Model/DTGVModel/VillageModel.dart';
import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/DropDownModel/DropDownModel.dart';
import 'package:citizen_service/Model/LoginSessionModel/LoginSessionModel.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/MstAppCategoryModel.dart';
import 'package:citizen_service/Model/MstAppDocumentModel.dart';
import 'package:citizen_service/SqliteDatabase/DataBaseString.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseOperation {
  static final DatabaseOperation instance = DatabaseOperation._init();
  static Database? _database;

  DatabaseOperation._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, database_name),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE `$mst_cs_login` (`$id` INTEGER PRIMARY KEY AUTOINCREMENT , `$cs_login_id` VARCHAR ,`$citizen_registration_id` VARCHAR , `$mobile_no` VARCHAR , `$password` VARCHAR , `$email_id` VARCHAR )",
        );

        await database.execute(
          "CREATE TABLE `$mst_add_application` (`$id` INTEGER PRIMARY KEY AUTOINCREMENT , `$category_id` VARCHAR , `$service_id` VARCHAR , `$application_name` VARCHAR , `$service_name` VARCHAR , "
          " `$generated_application_id` VARCHAR ,`$draft_id` VARCHAR , `$application_apply_date` VARCHAR , `$application_data` VARCHAR , `$application_sync_status` VARCHAR , "
          "`$application_sync_date` VARCHAR , `$crt_user` VARCHAR ,`$crt_date` VARCHAR ,`$lst_upd_user` VARCHAR ,`$lst_upd_date` VARCHAR , `$current_tab` VARCHAR , `$sync_tab` VARCHAR , `$sync_message` VARCHAR ,"
          " `$final_submit_flag` VARCHAR , `$from_web` VARCHAR  ,`$app_version` VARCHAR)",
        );

        await database.execute(
          "CREATE TABLE `$mst_application_category` (`$id` INTEGER PRIMARY KEY AUTOINCREMENT , `$category_id` VARCHAR ,`$application_name` VARCHAR , `$service_data_json` VARCHAR )",
        );

        await database.execute(
          "CREATE TABLE `$mst_all_dropdown` (`$id` INTEGER PRIMARY KEY AUTOINCREMENT , `$category_id` VARCHAR , `$service_id` VARCHAR ,`$service_name` VARCHAR , `$item_id` VARCHAR , `$item_title` VARCHAR , `$item_title_kn` VARCHAR , `$status` VARCHAR )",
        );

        await database.execute(
          "CREATE TABLE `$mst_district` (`$id` INTEGER PRIMARY KEY AUTOINCREMENT , `$district_id` VARCHAR , `$district_name` VARCHAR ,`$district_name_kn` VARCHAR , `$status` VARCHAR )",
        );

        await database.execute(
          "CREATE TABLE `$mst_taluka` (`$id` INTEGER PRIMARY KEY AUTOINCREMENT , `$taluka_id` VARCHAR , `$taluka_name` VARCHAR ,`$district_id` VARCHAR , `$status` VARCHAR )",
        );

        await database.execute(
          "CREATE TABLE `$mst_panchayat` (`$id` INTEGER PRIMARY KEY AUTOINCREMENT , `$panchayat_id` VARCHAR , `$panchayat_name` VARCHAR ,`$district_id` ,`$taluka_id` VARCHAR , `$status` VARCHAR )",
        );

        await database.execute(
          "CREATE TABLE `$mst_village` (`$id` INTEGER PRIMARY KEY AUTOINCREMENT , `$village_id` VARCHAR , `$village_name` VARCHAR ,`$district_id` ,`$taluka_id` VARCHAR ,`$panchayat_id` VARCHAR , `$status` VARCHAR )",
        );

        await database.execute(
          "CREATE TABLE `$mst_application_document` (`$id` INTEGER PRIMARY KEY AUTOINCREMENT , `$document_id` VARCHAR , `$document_type` VARCHAR ,`$document_description` VARCHAR, `$document_name` VARCHAR ,`$document_path` ,`$app_trn_id` VARCHAR ,`$sync_status` VARCHAR)",
        );

        // await database.execute(
        //   "CREATE TABLE `$syncStudentDb` (`id` INTEGER PRIMARY KEY AUTOINCREMENT , `aca_year` VARCHAR ,`admission_date` VARCHAR ,`child_enroll_no` VARCHAR ,	`father_lname` VARCHAR , `father_mname` VARCHAR ,`is_active` VARCHAR , `mother_lname` VARCHAR , `mother_mname` VARCHAR ,`school_id` VARCHAR , `semester` VARCHAR ,`standard` VARCHAR ,`stu_Pincode` VARCHAR ,`stu_add_line1` VARCHAR ,`stu_age` VARCHAR ,`stu_caste` VARCHAR , `stu_caste_other` VARCHAR ,`stu_city` VARCHAR ,`stu_district` VARCHAR ,`stu_dob` VARCHAR ,`stu_ffname` VARCHAR ,`stu_fname` VARCHAR , `stu_gender` VARCHAR ,`stu_isdead` VARCHAR ,`stu_mfname` VARCHAR ,`stu_mname` VARCHAR ,`stu_mother_tongue` VARCHAR ,`stu_pmobile` VARCHAR , `stu_relegion` VARCHAR ,`stu_schoolmedium` VARCHAR ,`stu_state` VARCHAR ,`stu_subcaste` VARCHAR ,`stu_village` VARCHAR ,`student_id` VARCHAR ,`stu_section` VARCHAR )",
        // );
        // await database.execute(
        //   "CREATE TABLE `$syncTeacherDb` (`id` INTEGER PRIMARY KEY AUTOINCREMENT , `caste` VARCHAR , `dob` VARCHAR ,'dsgn_id' VARCHAR, `first_name` VARCHAR , `gender` VARCHAR , `islocked` VARCHAR , `last_name` VARCHAR , `mobile1` VARCHAR , `school_id` VARCHAR , `status` VARCHAR , `sts_teacher_id` VARCHAR , `teacher_type` VARCHAR , `user_id` VARCHAR )",
        // );
        // await database.execute(
        //   "CREATE TABLE `$studentAttenDb` (`aca_year` VARCHAR , `attendance_by` VARCHAR , `attendance_date` VARCHAR , `attendance_id` VARCHAR , `crt_ip` VARCHAR ,`crt_usr` VARCHAR , `division_id` VARCHAR , `id` INTEGER PRIMARY KEY AUTOINCREMENT , `isSyncComplete` SMALLINT , `school_id` VARCHAR , `shift_id` VARCHAR , `standard` VARCHAR , `studentListJson` VARCHAR , `tableType` VARCHAR  )",
        // );
        // await database.execute(
        //   "CREATE TABLE `$teacherAttenDb` (`aca_year` VARCHAR , `attendance_by` VARCHAR , `attendance_date` VARCHAR , `attendance_id` VARCHAR , `crt_ip` VARCHAR ,`crt_usr` VARCHAR , `division_id` VARCHAR , `id` INTEGER PRIMARY KEY AUTOINCREMENT , `isSyncComplete` SMALLINT , `school_id` VARCHAR , `shift_id` VARCHAR , `standard` VARCHAR , `studentListJson` VARCHAR , `tableType` VARCHAR  )",
        // );
        // await database.execute(
        //   "CREATE TABLE `$sessionDb` (`dsgn_id` VARCHAR , `emp_no` VARCHAR , `first_name` VARCHAR , `latitude` VARCHAR  , `longitude` VARCHAR ,`login_name` VARCHAR , `login_password` VARCHAR ,`msg` VARCHAR , `post_city` VARCHAR , `school_name` VARCHAR , `school_id` VARCHAR )",
        // );
      },
      version: 1,
    );
  }

  Future<void> cleanDatabase() async {
    try {
      final db = await instance.database;
      await db!.transaction((txn) async {
        var batch = txn.batch();
        batch.delete(mst_cs_login);
        batch.delete(mst_add_application);
        batch.delete(mst_application_category);
        batch.delete(mst_all_dropdown);
        batch.delete(mst_district);
        batch.delete(mst_taluka);
        batch.delete(mst_panchayat);
        batch.delete(mst_village);
        batch.delete(mst_application_document);
        // batch.delete(syncTeacherDb);
        // batch.delete(studentAttenDb);
        // batch.delete(teacherAttenDb);
        await batch.commit();
      });
    } catch (error) {
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }

//----------------- MST_CS_LOGIN Operation ------------------------------------

  Future<int> insertLoginSession(LoginSessionModel model) async {
    final db = await instance.database;
    final result = await db!.insert(mst_cs_login, model.toJson());
    return result;
  }

  Future<LoginSessionModel?> getLoginSession() async {
    final db = await instance.database;
    final data = await db!.query(mst_cs_login);
    List<LoginSessionModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(LoginSessionModel.fromJson(row)));
      return applicationList.length > 0 ? applicationList[0] : null;
    } else {
      return null;
    }
  }

//------------------------------------------------------------------------------------

//----------------- MST_ADD_APPLICATION Operation ------------------------------------

  Future<int> insertMstAddApplicationModel(MstAddApplicationModel model) async {
    final db = await instance.database;
    final result = await db!.insert(mst_add_application, model.toJson());
    return result;
  }

  Future<int> updateMstAddApplicationModel(String id, String applicationData,
      String lstUpdDate, String crnTab) async {
    final db = await instance.database;
    var res = await db!.rawUpdate(
        'UPDATE $mst_add_application SET $application_data = ?, $lst_upd_date=? , $current_tab=?  WHERE id = ?',
        [applicationData, lstUpdDate, crnTab, id]);
    return res;
  }

  Future<List<MstAddApplicationModel>> getAllMstAddApplicationModel() async {
    final db = await instance.database;
    var data = await db!.query(mst_add_application,orderBy: "id desc, cast(draft_id AS INTEGER)  desc");
    List<MstAddApplicationModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(MstAddApplicationModel.fromJson(row)));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  Future<List<MstAddApplicationModel>> getBuildingApplications() async {
    final db = await instance.database;
    var data = await db!.query(mst_add_application,where: "$category_id == '2' " ,  orderBy: "id desc, cast(draft_id AS INTEGER)  desc");
    List<MstAddApplicationModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(MstAddApplicationModel.fromJson(row)));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  Future<List<MstAddApplicationModel>> getTradeApplications() async {
    final db = await instance.database;
    var data = await db!.query(mst_add_application,where: "$category_id == '3' " ,  orderBy: "id desc, cast(draft_id AS INTEGER)  desc");
    List<MstAddApplicationModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(MstAddApplicationModel.fromJson(row)));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  Future<List<MstAddApplicationModel>> getOtherApplications() async {
    final db = await instance.database;
    var data = await db!.query(mst_add_application,where: "$category_id == '5' " ,  orderBy: "id desc, cast(draft_id AS INTEGER)  desc");
    List<MstAddApplicationModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(MstAddApplicationModel.fromJson(row)));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  Future<List<MstAddApplicationModel>> getMaintenanceApplications() async {
    final db = await instance.database;
    var data = await db!.query(mst_add_application,where: "$category_id == '4' " ,  orderBy: "id desc, cast(draft_id AS INTEGER)  desc");
    List<MstAddApplicationModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(MstAddApplicationModel.fromJson(row)));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  Future<int?> getDraftApplicationCount(String dId) async {
    final db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $mst_add_application where draft_id = '+dId));
  }

  Future<int?> getApplicationCount(String dId) async {
    final db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $mst_add_application where generated_application_id = '+dId));
  }

  Future<List<MstAddApplicationModel>> getAllApplicationModel() async {
    final db = await instance.database;
    var data = await db!.query(mst_add_application,where: '$final_submit_flag == "Y" ', orderBy: "$application_sync_status asc, cast($draft_id AS INTEGER)  desc, $id desc ");
    List<MstAddApplicationModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(MstAddApplicationModel.fromJson(row)));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  Future<List<MstAddApplicationModel>> getAllSyncApplication() async {
    final db = await instance.database;
    var data = await db!.query(mst_add_application,
        where: '$application_sync_status = ? AND $from_web != "Y" ',
        whereArgs: ["Y"],
        orderBy: "id DESC");
    List<MstAddApplicationModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach(
          (row) => applicationList.add(MstAddApplicationModel.fromJson(row)));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  Future<List<MstAddApplicationModel>> getAllPendingApplication() async {
    final db = await instance.database;
    var data = await db!.query(mst_add_application,
        where: '$application_sync_status = ? AND $final_submit_flag == "Y" ',
        whereArgs: ["N"],
        orderBy: "id DESC");
    List<MstAddApplicationModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach(
          (row) => applicationList.add(MstAddApplicationModel.fromJson(row)));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  Future<int> getAllUnSyncApplicationCount() async {
    final db = await instance.database;
    var data = await db!.query(mst_add_application,
        where: '$application_sync_status = ?',
        whereArgs: ["N"],
        orderBy: "id DESC");
    List<MstAddApplicationModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach(
          (row) => applicationList.add(MstAddApplicationModel.fromJson(row)));
      return applicationList.length;
    } else {
      return 0;
    }
  }

  Future<MstAddApplicationModel?> getApplicationUsingID(String id) async {
    final db = await instance.database;
    var data =
        await db!.query(mst_add_application, where: 'id = ?', whereArgs: [id]);
    if (data.length > 0) {
      MstAddApplicationModel model = MstAddApplicationModel.fromJson(data[0]);
      return model;
    } else {
      return null;
    }
  }

  Future<String> getApplicationGeneratedIdUsingID(String id) async {
    final db = await instance.database;
    var data =
        await db!.query(mst_add_application, where: 'id = ?', whereArgs: [id]);
    if (data.length > 0) {
      MstAddApplicationModel model = MstAddApplicationModel.fromJson(data[0]);
      return model.gENERATEDAPPLICATIONID.isNotEmpty ? model.gENERATEDAPPLICATIONID : model.draft_id;
    } else {
      return '';
    }
  }

  Future<int> deleteAddedApplication(String id) async {
    final db = await instance.database;
    return await db!
        .delete(mst_add_application, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteApplicationUsingDraftId(String did) async {
    final db = await instance.database;
    return await db!.delete(mst_add_application, where: '$draft_id = ? ', whereArgs: [did]);
  }

  Future<int> deleteApplicationUsingAppId(String did) async {
    final db = await instance.database;
    return await db!.delete(mst_add_application, where: '$generated_application_id = ? ', whereArgs: [did]);
  }

  Future<int> updateSyncTabStatus(String id, String syncTab) async {
    final db = await instance.database;
    var res = await db!.rawUpdate(
        'UPDATE $mst_add_application SET $sync_tab = ? WHERE id = ?',
        [syncTab, id]);
    return res;
  }

  Future<int> updateSyncApplicationId(String id, String appId) async {
    final db = await instance.database;
    var res = await db!.rawUpdate(
        'UPDATE $mst_add_application SET $generated_application_id = ? WHERE id = ?',
        [appId, id]);
    return res;
  }

  Future<int> updateSyncDraftId(String id, String appId) async {
    final db = await instance.database;
    var res = await db!.rawUpdate(
        'UPDATE $mst_add_application SET $draft_id = ? WHERE id = ?',
        [appId, id]);
    return res;
  }

  Future<int> updateSyncMessageStatus(String id, String syncMsg) async {
    final db = await instance.database;
    var res = await db!.rawUpdate(
        'UPDATE $mst_add_application SET $sync_message = ? WHERE id = ?',
        [syncMsg, id]);
    return res;
  }

  Future<int> updateFinalApplicationStatusEmpty(String id) async {
    final db = await instance.database;
    var res = await db!.rawUpdate(
        'UPDATE $mst_add_application SET $final_submit_flag = "" WHERE id = ?',
        [id]);
    return res;
  }

  Future<int> updateSyncApplicationStatus(String id) async {
    final db = await instance.database;
    var res = await db!.rawUpdate(
        'UPDATE $mst_add_application SET $application_sync_status = "Y" WHERE id = ?',
        [id]);
    return res;
  }

  Future<int> updateFinalApplicationStatus(String id) async {
    final db = await instance.database;
    var res = await db!.rawUpdate(
        'UPDATE $mst_add_application SET $final_submit_flag = "Y" WHERE id = ?',
        [id]);
    return res;
  }

//------------------------------------------------------------------------------------

//----------------- MST_APPLICATION_CATEGORY Operation ------------------------------------

  Future<int> insertCategory(MstAppCategoryModel model) async {
    final db = await instance.database;
    final result = await db!.insert(mst_application_category, model.toJson());
    return result;
  }

  Future<List<MstAppCategoryModel>> getAllCategory() async {
    final db = await instance.database;
    var data = await db!.query(mst_application_category);
    List<MstAppCategoryModel> categoryList = [];
    if (data.isNotEmpty) {
      data.forEach(
          (row) => categoryList.add(MstAppCategoryModel.fromJson(row)));
      return categoryList;
    } else {
      return categoryList;
    }
  }

  Future<MstAppCategoryModel?> getCategory(String id) async {
    final db = await instance.database;
    var data = await db!.query(mst_application_category,
        where: '$category_id = ?', whereArgs: [id]);
    List<MstAppCategoryModel> categoryList = [];
    if (data.isNotEmpty) {
      data.forEach(
          (row) => categoryList.add(MstAppCategoryModel.fromJson(row)));
      if (categoryList.length > 0) {
        return categoryList[0];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<int> updateCategoryServiceData(String id, String data) async {
    final db = await instance.database;
    var res = await db!.rawUpdate(
        'UPDATE $mst_application_category SET $service_data_json = ? WHERE category_id = ?',
        [data, id]);
    return res;
  }

  Future<int> deleteCategory() async {
    final db = await instance.database;
    final result = await db!.delete(mst_application_category);
    return result;
  }

//------------------------------------------------------------------------------------

//----------------- MST_ALL_DROPDOWN Operation ------------------------------------

  Future<int> insertDropDownData(DropDownMasterModel model) async {
    final db = await instance.database;
    final result = await db!.insert(mst_all_dropdown, model.toJson());
    return result;
  }

  Future<int> deleteDropDownData(
      String categoryId, String serviceId, String serviceName) async {
    final db = await instance.database;
    var result = await db!.rawDelete(
        'DELETE FROM $mst_all_dropdown WHERE $service_id = "$serviceId" AND $service_name = "$serviceName" ');
    return result;
  }

  Future<List<DropDownMasterModel>> getDropdownDataUsingServiceName(
      String serviceName) async {
    final db = await instance.database;
    var data = await db!.query(mst_all_dropdown,
        where: '$status = ? AND $service_name = ?',
        whereArgs: ["Y", serviceName],
        orderBy: "id ASC");
    List<DropDownMasterModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach(
          (row) => applicationList.add(DropDownMasterModel.fromJson(row)));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  // Future<LoginSessionModel?> getLoginSession() async {
  //   final db = await instance.database;
  //   final data = await db!.query(mst_cs_login);
  //
  //   if (data.length > 0) {
  //     LoginSessionModel model = LoginSessionModel.fromJson(data[0]);
  //     return model;
  //   } else {
  //     return null;
  //   }
  // }

//------------------------------------------------------------------------------------

//----------------- DTGV Operation ------------------------------------

  Future<int> insertDistrict(DistrictModel model) async {
    final db = await instance.database;
    final result = await db!.insert(mst_district, model.toJson());
    return result;
  }

  Future<int> insertTaluka(TalukaModel model) async {
    final db = await instance.database;
    final result = await db!.insert(mst_taluka, model.toJson());
    return result;
  }

  Future<int> insertPanchayat(PanchayatModel model) async {
    final db = await instance.database;
    final result = await db!.insert(mst_panchayat, model.toJson());
    return result;
  }

  Future<int> insertVillage(VillageModel model) async {
    final db = await instance.database;
    final result = await db!.insert(mst_village, model.toJson());
    return result;
  }

  Future<int> deleteDistrictData() async {
    final db = await instance.database;
    return await db!.delete(mst_district);
  }

  Future<int> deleteTalukaData() async {
    final db = await instance.database;
    return await db!.delete(mst_taluka);
  }

  Future<int> deletePanchayatData() async {
    final db = await instance.database;
    return await db!.delete(mst_panchayat);
  }

  Future<int> deleteVillageData() async {
    final db = await instance.database;
    return await db!.delete(mst_village);
  }

  Future<List<DistrictModel>> getAllDistrict() async {
    final db = await instance.database;
    var data = await db!.query(mst_district,
        where: '$status = ?', whereArgs: ["Y"], orderBy: "$district_name ASC ");
    List<DistrictModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(DistrictModel.fromJson(row)));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  Future<List<TalukaModel>> getAllTaluka(String id) async {
    final db = await instance.database;
    var data = await db!.query(mst_taluka,
        where: '$status = ? AND $district_id = ?',
        whereArgs: ["Y", id],
        orderBy: "$taluka_name ASC ");
    List<TalukaModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(TalukaModel.fromJson(row)));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  Future<List<PanchayatModel>> getAllPanchayat(
      String distId, String tpId) async {
    final db = await instance.database;
    var data = await db!.query(mst_panchayat,
        where: '$status = ? AND $district_id = ? AND $taluka_id = ?',
        whereArgs: ["Y", distId, tpId],
        orderBy: "$panchayat_name ASC ");
    List<PanchayatModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(PanchayatModel.fromJson(row)));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  Future<List<VillageModel>> getAllVillage(
      String distId, String tpId, String panchayatId) async {
    final db = await instance.database;
    var data = await db!.query(mst_village,
        where:
            '$status = ? AND $district_id = ? AND $taluka_id = ? AND $panchayat_id = ? ',
        whereArgs: ["Y", distId, tpId, panchayatId],
        orderBy: "$village_name ASC ");
    List<VillageModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(VillageModel.fromJson(row)));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  Future<String> getDistrictName(String id) async {
    final db = await instance.database;
    var data = await db!
        .query(mst_district, where: '$district_id = ?', whereArgs: [id]);
    List<DistrictModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(DistrictModel.fromJson(row)));
      return applicationList[0].district_name! +
          ' (' +
          applicationList[0].district_id! +
          ')';
    } else {
      return id;
    }
  }

  Future<String> getTalukaName(String id) async {
    final db = await instance.database;
    var data =
        await db!.query(mst_taluka, where: '$taluka_id = ?', whereArgs: [id]);
    List<TalukaModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(TalukaModel.fromJson(row)));
      return applicationList[0].taluka_name! +
          ' (' +
          applicationList[0].taluka_id! +
          ')';
    } else {
      return id;
    }
  }

  Future<String> getPanchayatName(String id) async {
    final db = await instance.database;
    var data = await db!
        .query(mst_panchayat, where: '$panchayat_id = ? ', whereArgs: [id]);
    List<PanchayatModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(PanchayatModel.fromJson(row)));
      return applicationList[0].panchayat_name! +
          ' (' +
          applicationList[0].panchayat_id! +
          ')';
    } else {
      return id;
    }
  }

  Future<String> getVillageName(String id) async {
    final db = await instance.database;
    var data = await db!.query(mst_village,
        where: '$village_id = ? ',
        whereArgs: [id],
        orderBy: "$village_name ASC ");
    List<VillageModel> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(VillageModel.fromJson(row)));
      return applicationList[0].village_name! +
          ' (' +
          applicationList[0].village_id! +
          ')';
    } else {
      return id;
    }
  }

//------------------------------------------------------------------------------------

//----------------- MST_APPLICATION_DOCUMENT Operation ------------------------------------

Future<int> insertDocument(MstAppDocumentModel model) async {
  final db = await instance.database;
  final result = await db!.insert(mst_application_document, model.toJson());
  return result;
}

Future<List<MstAppDocumentModel>> getAllDocument(String id) async {
  final db = await instance.database;
  final data = await db!.query(mst_application_document,where: '$app_trn_id = ?',whereArgs: [id]);
  List<MstAppDocumentModel> applicationList = [];
  if (data.isNotEmpty) {
    data.forEach((row) => applicationList.add(MstAppDocumentModel.fromJson(row)));
    return applicationList;
  } else {
    return applicationList;
  }
}

Future<int> deleteDocument(String itemId) async {
  final db = await instance.database;
  var result = await db!.rawDelete('DELETE FROM $mst_application_document WHERE $id = "$itemId" ');
  return result;
}

Future<int> updateSyncStatus(String id) async {
  final db = await instance.database;
  var res = await db!.rawUpdate(
      'UPDATE $mst_application_document SET $sync_status = "Y" WHERE id = ?',
      [id]);
  return res;
}

//------------------------------------------------------------------------------------


//kasim start

  Future<List<DropDownModal>> getDropdown(String service , String category ,String subcategory ) async {
    final db = await instance.database;
    var data = await db!.query(mst_all_dropdown,
        where: '$category_id = ? AND $service_id = ? AND $service_name = ?', whereArgs: [category, subcategory , service ]);
    List<DropDownModal> applicationList = [];
    if (data.isNotEmpty) {
      data.forEach((row) => applicationList.add(new DropDownModal(
          id: row["ITEM_ID"].toString(),
          title: row["ITEM_TITLE"].toString(),
          titleKn: row["ITEM_TITLE_KN"].toString())));
      return applicationList;
    } else {
      return applicationList;
    }
  }

  Future<String> getDropdownName(String service , var itemId) async {
   try{

     if(itemId != null && itemId != 'null'){
       final db = await instance.database;
       var data = await db!.query(mst_all_dropdown,
           where: '$item_id = ? AND $service_name = ?', whereArgs: [itemId.toString(), service]);
       if (data.isNotEmpty && data.length > 0) {
         return data[0]["ITEM_TITLE"].toString();
       }
       else {
         return itemId;
       }
     }else{
       return '';
     }
   }on Exception catch (exception) {
      print(exception);
      return itemId;
    }
  }

  Future<String> getDropdownNameUsingCategory(String category,String serviceId,String service , String itemId) async {
    try {
      if (itemId.isNotEmpty && itemId != 'null') {
        final db = await instance.database;
        var data = await db!.query(mst_all_dropdown,
            where: '$category_id = ? AND $service_id = ?  AND $service_name = ? AND $item_id = ?',
            whereArgs: [category, serviceId, service, itemId]);
        if (data.isNotEmpty && data.length > 0) {
          return data[0]["ITEM_TITLE"].toString();
        } else {
          return itemId;
        }
      } else {
        return '';
      }
    } on Exception catch (exception) {
      print(exception);
      return itemId;
    }
  }

  Future<String> getCurrentTab(String draftID) async {

        final db = await instance.database;
        var data = await db!.query(mst_add_application,
            where: '$draft_id = ? ',
            whereArgs: [draftID]);
        if (data.isNotEmpty && data.length > 0) {
          return data[0]["CURRENT_TAB"].toString();
        } else {
          return '';
        }

  }
  Future<int> updateOnlineAppData(String id, String applicationData,
      String lstUpdDate) async {
    final db = await instance.database;
    var res = await db!.rawUpdate(
        'UPDATE $mst_add_application SET $application_data = ?, $lst_upd_date=? WHERE id = ?',
        [applicationData, lstUpdDate, id]);
    return res;
  }

//kasim end
}
