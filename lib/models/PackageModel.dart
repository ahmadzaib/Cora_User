class PackageModel {
  dynamic id;
  dynamic categoryName;
  dynamic categoryIcon;

  static PackageModel fromMap(Map<String, dynamic> map) {
    PackageModel packageModelBean = PackageModel();
    packageModelBean.id = map['id']??0;
    packageModelBean.categoryName = map['category_name']??'';
    packageModelBean.categoryIcon = map['category_icon']??'';
    return packageModelBean;
  }

  Map toJson() => {
    "id": id,
    "category_name": categoryName,
    "category_icon": categoryIcon,
  };
}