part of 'objects.dart';

@JsonSerializable()
class CourseModel {
  String courseName;
  String language;
  String description;
  String price;
  String session;
  String duration;
  String link;
  String img;

  CourseModel(
    this.courseName,
    this.language,
    this.description,
    this.price,
    this.session,
    this.duration,
    this.link,
    this.img,
  );

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
