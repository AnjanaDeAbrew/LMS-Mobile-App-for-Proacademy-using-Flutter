// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      json['id'] as String,
      (json['students'] as List<dynamic>).map((e) => e as String).toList(),
      (json['studentArray'] as List<dynamic>)
          .map((e) => StudentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['lastMessage'] as String,
      json['lastMessageTime'] as String,
      json['createdBy'] as String,
      json['messageType'] as String,
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'students': instance.students,
      'studentArray': instance.studentArray,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime,
      'createdBy': instance.createdBy,
      'messageType': instance.messageType,
    };

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      json['courseName'] as String,
      json['language'] as String,
      json['description'] as String,
      json['price'] as String,
      json['session'] as String,
      json['duration'] as String,
      json['link'] as String,
      json['img'] as String,
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'courseName': instance.courseName,
      'language': instance.language,
      'description': instance.description,
      'price': instance.price,
      'session': instance.session,
      'duration': instance.duration,
      'link': instance.link,
      'img': instance.img,
    };

EnrollModel _$EnrollModelFromJson(Map<String, dynamic> json) => EnrollModel(
      StudentModel.fromJson(json['studentModel'] as Map<String, dynamic>),
      CourseModel.fromJson(json['courseModel'] as Map<String, dynamic>),
      json['enrolledDate'] as String,
      json['language'] as String,
    );

Map<String, dynamic> _$EnrollModelToJson(EnrollModel instance) =>
    <String, dynamic>{
      'studentModel': instance.studentModel,
      'courseModel': instance.courseModel,
      'enrolledDate': instance.enrolledDate,
      'language': instance.language,
    };

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      json['conId'] as String,
      json['senderName'] as String,
      json['senderId'] as String,
      json['reciveId'] as String,
      json['message'] as String,
      json['messageTime'] as String,
      json['messageType'] as String,
      json['messageId'] as String,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'conId': instance.conId,
      'senderName': instance.senderName,
      'senderId': instance.senderId,
      'reciveId': instance.reciveId,
      'message': instance.message,
      'messageTime': instance.messageTime,
      'messageType': instance.messageType,
    };

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
      json['sid'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String,
      json['birthday'] as String,
      json['age'] as int,
      json['mobile'] as String,
      json['gender'] as String,
      json['address'] as String,
      json['school'] as String,
      json['joinedDate'] as String,
      json['img'] as String,
      json['lastSeen'] as String,
      json['isOnline'] as bool,
      json['token'] as String,
    );

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'sid': instance.sid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'birthday': instance.birthday,
      'age': instance.age,
      'mobile': instance.mobile,
      'gender': instance.gender,
      'address': instance.address,
      'school': instance.school,
      'joinedDate': instance.joinedDate,
      'img': instance.img,
      'lastSeen': instance.lastSeen,
      'isOnline': instance.isOnline,
      'token': instance.token,
    };
