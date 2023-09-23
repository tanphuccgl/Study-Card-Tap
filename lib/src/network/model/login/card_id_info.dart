class CardIDInfo {
  bool? success;
  List<Data>? data;

  CardIDInfo({this.success, this.data});

  CardIDInfo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? studentID;
  String? titkulCode;
  String? cardID;
  String? fullName;
  String? phoneNumber;
  String? className;

  Data({
    this.studentID,
    this.titkulCode,
    this.cardID,
    this.fullName,
    this.phoneNumber,
    this.className,
  });

  Data.fromJson(Map<String, dynamic> json) {
    studentID = json['StudentID'];
    titkulCode = json['TitkulCode'];
    cardID = json['CardID'];
    fullName = json['FullName'];
    phoneNumber = json['PhoneNumber'];
    className = json['Class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StudentID'] = studentID;
    data['TitkulCode'] = titkulCode;
    data['CardID'] = cardID;
    data['FullName'] = fullName;
    data['PhoneNumber'] = phoneNumber;
    data['Class'] = className;
    return data;
  }
}
