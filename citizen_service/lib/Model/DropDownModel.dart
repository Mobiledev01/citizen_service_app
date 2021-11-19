class DropDownModal {
  String id = '';
  String title = '';
  String titleKn = '';

  DropDownModal({required this.id, required this.title, required this.titleKn});

  DropDownModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    titleKn = json['titleKn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['titleKn'] = this.titleKn;
    return data;
  }
}
