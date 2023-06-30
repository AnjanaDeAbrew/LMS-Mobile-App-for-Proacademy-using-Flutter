part of 'objects.dart';

@JsonSerializable()
class ConversationModel {
  ConversationModel(
    this.id,
    this.students,
    this.studentArray,
    this.lastMessage,
    this.lastMessageTime,
    this.createdBy,
    this.messageType,
  );
  String id;
  List<String> students;
  List<StudentModel> studentArray;
  String lastMessage;
  String lastMessageTime;
  String createdBy;
  String messageType;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}
