part of 'objects.dart';

@JsonSerializable()
class StudentModel {
  String sid;
  String firstName;
  String lastName;
  String email;
  String birthday;
  int age;
  String mobile;
  String gender;
  String address;
  String school;
  String joinedDate;
  String img;
  String lastSeen;
  bool isOnline;
  String token;

  StudentModel(
      this.sid,
      this.firstName,
      this.lastName,
      this.email,
      this.birthday,
      this.age,
      this.mobile,
      this.gender,
      this.address,
      this.school,
      this.joinedDate,
      this.img,
      this.lastSeen,
      this.isOnline,
      this.token);

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}
