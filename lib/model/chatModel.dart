// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatModel {
  num id;
  String created_at;
  bool is_me;
  String text_msg;
  ChatModel({
    required this.id,
    required this.created_at,
    required this.is_me,
    required this.text_msg,
  });

  ChatModel copyWith({
    num? id,
    String? created_at,
    bool? is_me,
    String? text_msg,
  }) {
    return ChatModel(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      is_me: is_me ?? this.is_me,
      text_msg: text_msg ?? this.text_msg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at,
      'is_me': is_me,
      'text_msg': text_msg,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] as num,
      created_at: map['created_at'] as String,
      is_me: map['is_me'] as bool,
      text_msg: map['text_msg'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(id: $id, created_at: $created_at, is_me: $is_me, text_msg: $text_msg)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.is_me == is_me &&
        other.text_msg == text_msg;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        is_me.hashCode ^
        text_msg.hashCode;
  }
}
