import 'package:test_indo5/model/base.dart';

class AfterSalesModel extends BaseModel{
  int id = 0;
  String displayName = ''; // after sales number
  String modelMachineId = ""; // tipe mesin
  String modelMachineName = ""; // tipe mesin
  String brandId = ""; // brand
  String brandName = ""; // brand
  String serialNumber = ''; // serial number
  String invoice = ''; // invoice pembelian
  String deliveryDate = ''; // tanggal pengiriman
  String warranty = ''; // status garansi
  String serviceType = ''; // maintenance
  String scheduleDate = ''; // jadwal kunjungan
  String userId = ""; // Teknisi
  String userName = ""; // Teknisi
  String todo = ''; // permasalahan mesin
  String problemSolving = ''; // laporan kunjungan teknisi
  String stageId = ""; // status
  String stageName = ""; // status
  String customColor = ''; // status
  String createDate = ''; // created date

  AfterSalesModel(jsonMap) {
    this.id = jsonMap?['id'] ?? 0;
    this.displayName = verify(jsonMap['display_name']) ?? "";
    this.modelMachineId = verify(jsonMap['model_machine_id'], 0) ?? "";
    this.modelMachineName = verify(jsonMap['model_machine_id'], 1) ?? "";
    this.brandId = verify(jsonMap['brand_id'], 0) ?? "";
    this.brandName = verify(jsonMap['brand_id'], 1) ?? "";
    this.serialNumber = verify(jsonMap['serial_number']) ?? "";
    this.invoice = verify(jsonMap['invoice']) ?? "";
    this.deliveryDate = verify(jsonMap['delivery_date']) ?? "";
    this.warranty = verify(jsonMap['warranty']) ?? "";
    this.serviceType = verify(jsonMap['service_type']) ?? "";
    this.scheduleDate = verify(jsonMap['schedule_date']) ?? "";
    this.userId = verify(jsonMap['user_id'], 0) ?? "";
    this.userName = verify(jsonMap['user_id'], 1) ?? "";
    this.todo = verify(jsonMap['todo']) ?? "";
    this.problemSolving = verify(jsonMap['problem_solving']) ?? "";
    this.stageId = verify(jsonMap['stage_id'], 0) ?? "";
    this.stageName = verify(jsonMap['stage_id'], 1) ?? "";
    this.customColor = verify(jsonMap['custom_color']) ?? "#ffffff";
    this.createDate = jsonMap['create_date'] ?? "";
  }

  
}
