import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yallangany/models/lesson_date.dart';

class Course {
  String studentName;

  String title;

  String parentId;

  List<LessonDate> lessonsDates;
  Course({
    this.studentName,
    this.title,
    this.parentId,
    this.lessonsDates,
  });

  Course copyWith({
    String studentName,
    String title,
    String parentId,
    List<LessonDate> lessonsDates,
  }) {
    return Course(
      studentName: studentName ?? this.studentName,
      title: title ?? this.title,
      parentId: parentId ?? this.parentId,
      lessonsDates: lessonsDates ?? this.lessonsDates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentName': studentName,
      'title': title,
      'parentId': parentId,
      'lessonsDates': lessonsDates?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      studentName: map['studentName'],
      title: map['title'],
      parentId: map['parentId'],
      lessonsDates: List<LessonDate>.from(
          map['lessonsDates']?.map((x) => LessonDate.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Course(studentName: $studentName, title: $title, parentId: $parentId, lessonsDates: $lessonsDates)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.studentName == studentName &&
        other.title == title &&
        other.parentId == parentId &&
        listEquals(other.lessonsDates, lessonsDates);
  }

  @override
  int get hashCode {
    return studentName.hashCode ^
        title.hashCode ^
        parentId.hashCode ^
        lessonsDates.hashCode;
  }
}
