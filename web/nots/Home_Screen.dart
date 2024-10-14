import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../DB/Home_controller.dart';







class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var nameController = TextEditingController();
    var descriptionController = TextEditingController();
    var priceController = TextEditingController();
    var editpriceController = TextEditingController();
    var editNameController = TextEditingController();
    var editDesController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title:  Text('Auction Data ',style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xffe57332)
        ),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: controller.itemList.length,
                itemBuilder: (context, index) {
                  final items = controller.itemList[index];

                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items.name ?? '',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,

                        ),),
                        Text(items.description ?? '',style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black54
                        ),),
                      ],
                    ),
                    subtitle: Text(items.price??''),

                    trailing: SizedBox(
                      width: 100,  // Ensure the trailing widget doesn't consume entire width
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {

                              editNameController.text = items.name ?? '';
                              editDesController.text = items.description ?? '';
                              editpriceController.text=items.price??'';
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Edit item'),
                                    content: Container(
                                      height: 150,
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: editNameController,
                                            decoration: const InputDecoration(
                                                hintText: 'Enter new item'),
                                          ),
                                          TextField(
                                            controller: editDesController,
                                            decoration: const InputDecoration(
                                                hintText: 'Enter new description'),
                                          ),
                                          TextField(
                                            controller: editpriceController,
                                            decoration: const InputDecoration(
                                                hintText: 'Enter new Price'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          if (editNameController.text.isNotEmpty && editDesController.text.isNotEmpty&& editpriceController.text.isNotEmpty) {
                                            items.name = editNameController.text;
                                            items.description = editDesController.text;
                                            items.price=editpriceController.text;

                                            Get.find<HomeController>()
                                                .updateItem(items);

                                          }
                                          Get.back();
                                        },
                                        child:  Text('Save'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit,color: Color(0xffe57332),),
                          ),
                          IconButton(
                            onPressed: () {
                              // Delete the item
                              controller.deleteItem(items.id!);
                            },
                            icon: const Icon(Icons.delete,color: Colors.redAccent,),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffe57332),
        onPressed: () {
        showDialog(context: context, builder: (context) =>AlertDialog(
          title: Text("Add Data"),
          content: Container(
            height: 300,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
              ],
            ),

          ),
          actions: [
            TextButton(onPressed: () async {
              await controller.addItem(
                  nameController.text, descriptionController.text,priceController.text );
              nameController.clear();
              descriptionController.clear();
              priceController.clear();
              Get.back();

            }, child: Text("Save")),
            TextButton(onPressed: () {
              Navigator.pop(context);


            }, child: Text("cancal")),
          ],
        ));
      },),
    );
  }
}