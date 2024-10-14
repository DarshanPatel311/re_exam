class ItemModal {
  int? id;
  String? name, description,price;

  ItemModal({this.id, required this.name, required this.description,required this.price});

  factory ItemModal.fromMap(Map m1) {
    return ItemModal(
        id: m1['id'], name: m1['name'], description: m1['description'],price: m1['price']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price':price,
    };
  }
}