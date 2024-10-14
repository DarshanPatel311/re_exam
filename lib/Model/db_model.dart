class ItemModal {
  int? id;
  String? name, author,status;

  ItemModal({this.id, required this.name, required this.author,required this.status});

  factory ItemModal.fromMap(Map m1) {
    return ItemModal(
        id: m1['id'], name: m1['name'], author: m1['author'],status: m1['status']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'status':status,
    };
  }
}