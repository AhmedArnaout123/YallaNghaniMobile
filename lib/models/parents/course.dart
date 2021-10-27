import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yallangany/models/lesson_date.dart';
import 'package:yallangany/models/parents/lesson.dart';
import 'package:yallangany/models/parents/payment.dart';

class Course {
  String title;

  String studentName;

  String teacherName;

  double lessonFee;

  double parentBalance;

  List<Payment> payments;

  List<Lesson> lessons;

  List<LessonDate> lessonsDates;
  Course({
    this.title,
    this.studentName,
    this.teacherName,
    this.lessonFee,
    this.parentBalance,
    this.payments,
    this.lessons,
    this.lessonsDates,
  });

  Course copyWith({
    String title,
    String studentName,
    String teacherName,
    double lessonFee,
    double parentBalance,
    List<Payment> payments,
    List<Lesson> lessons,
    List<LessonDate> lessonsDates,
  }) {
    return Course(
      title: title ?? this.title,
      studentName: studentName ?? this.studentName,
      teacherName: teacherName ?? this.teacherName,
      lessonFee: lessonFee ?? this.lessonFee,
      parentBalance: parentBalance ?? this.parentBalance,
      payments: payments ?? this.payments,
      lessons: lessons ?? this.lessons,
      lessonsDates: lessonsDates ?? this.lessonsDates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'studentName': studentName,
      'teacherName': teacherName,
      'lessonFee': lessonFee,
      'parentBalance': parentBalance,
      'payments': payments?.map((x) => x.toMap())?.toList(),
      'lessons': lessons?.map((x) => x.toMap())?.toList(),
      'lessonsDates': lessonsDates?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      title: map['title'],
      studentName: map['studentName'],
      teacherName: map['teacherName'],
      lessonFee: map['lessonFee'].toDouble(),
      parentBalance: map['parentBalance'].toDouble(),
      payments:
          List<Payment>.from(map['payments']?.map((x) => Payment.fromMap(x))),
      lessons: List<Lesson>.from(map['lessons']?.map((x) => Lesson.fromMap(x))),
      lessonsDates: List<LessonDate>.from(
          map['lessonsDates']?.map((x) => LessonDate.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Course(title: $title, studentName: $studentName, teacherName: $teacherName, lessonFee: $lessonFee, parentBalance: $parentBalance, payments: $payments, lessons: $lessons, lessonsDates: $lessonsDates)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.title == title &&
        other.studentName == studentName &&
        other.teacherName == teacherName &&
        other.lessonFee == lessonFee &&
        other.parentBalance == parentBalance &&
        listEquals(other.payments, payments) &&
        listEquals(other.lessons, lessons) &&
        listEquals(other.lessonsDates, lessonsDates);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        studentName.hashCode ^
        teacherName.hashCode ^
        lessonFee.hashCode ^
        parentBalance.hashCode ^
        payments.hashCode ^
        lessons.hashCode ^
        lessonsDates.hashCode;
  }
}
