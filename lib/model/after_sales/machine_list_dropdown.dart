import 'package:test_indo5/model/base.dart';

class MachineListDropdown extends BaseModel {
  int id = 0;
  String name = '';
  String brand = '';
  int brandId = 0;
  String serialNumber = '';
  String warranty = '';
  String invoice = '';
  int invoiceId = 0;
  String deliveryDate = '';

  MachineListDropdown(json) {
    this.id = json['id'] ?? 0;
    this.name = json['name'] ?? "";
    this.brand = verify(json['brand'], 1);
    this.brandId = int.parse(verify(json['brand'], 0));
    this.serialNumber = json['serial_number'] ?? "";
    this.warranty = json['warranty'] ? "Warranty" : "Non Warranty";
    this.invoice = verify(json['invoice_id'], 1);
    this.invoiceId = int.parse(verify(json['invoice_id'], 0) ?? "0");
    this.deliveryDate = json['delivery_date'] ?? "";
  }
}
