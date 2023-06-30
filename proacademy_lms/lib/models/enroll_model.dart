part of 'objects.dart';

@JsonSerializable()
class EnrollModel {
  StudentModel studentModel;
  CourseModel courseModel;
  String enrolledDate;
  String language;

  EnrollModel(
      this.studentModel, this.courseModel, this.enrolledDate, this.language);

  factory EnrollModel.fromJson(Map<String, dynamic> json) =>
      _$EnrollModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnrollModelToJson(this);
}
