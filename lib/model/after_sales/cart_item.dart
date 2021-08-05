import 'package:test_indo5/model/after_sales/machine_list_dropdown.dart';
import 'package:test_indo5/model/base.dart';

class AfterSalesCartItemModel extends BaseModel {
  String description;
  double itemPrice;
  int count = 0;

  AfterSalesCartItemModel(this.description, this.count, this.itemPrice);
}
