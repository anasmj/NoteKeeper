// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Note {
  String? title;
  String? content;
  DateTime? date;
  String? id;
  Note({
    this.title,
    this.content,
    this.date,
    this.id,
  });

  Note copyWith({
    String? title,
    String? content,
    DateTime? date,
    String? id,
  }) {
    return Note(
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'date': date?.millisecondsSinceEpoch,
      'id': id,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      date: map['date'] != null ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int) : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Note(title: $title, content: $content, date: $date, id: $id)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.content == content &&
      other.date == date &&
      other.id == id;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      content.hashCode ^
      date.hashCode ^
      id.hashCode;
  }
}
