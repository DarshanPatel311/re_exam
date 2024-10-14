import 'package:get/get.dart';


import '../DB/db_helper.dart';
import '../Model/db_model.dart';


class HomeController extends GetxController {
  RxList<ItemModal> itemList = <ItemModal>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      itemList.value = await DBHelper.dbHelper.getItem();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> addItem(String name, String author,String status) async {
    if (name.isNotEmpty && author.isNotEmpty && status.isNotEmpty) {
      ItemModal itemModal = ItemModal(name: name, author: author,status:status);
      await DBHelper.dbHelper.insertData(itemModal);
      await fetchData();
    } else {
      print("Name or Description is empty");
    }
  }
  Future<void> updateItem(ItemModal item) async {
    try {
      await DBHelper.dbHelper.updateData(item);
      await fetchData();
    } catch (e) {
      print("Error updating item: $e");
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      await DBHelper.dbHelper.deleteData(id);
      await fetchData();
    } catch (e) {
      print("Error deleting item: $e");
    }
  }
}