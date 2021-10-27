import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yallangany/models/teachers/course.dart';

class Teacher {
  String firstName;

  String lastName;

  String id;

  String userName;

  String imageUrl;

  String phoneNumber;

  List<Course> courses;
  Teacher({
    this.firstName,
    this.lastName,
    this.id,
    this.userName,
    this.imageUrl,
    this.phoneNumber,
    this.courses,
  });

  Teacher copyWith({
    String firstName,
    String lastName,
    String id,
    String userName,
    String imageUrl,
    String phoneNumber,
    List<Course> courses,
  }) {
    return Teacher(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      id: id ?? this.id,
      userName: userName ?? this.userName,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      courses: courses ?? this.courses,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'id': id,
      'userName': userName,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'courses': courses?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      firstName: map['firstName'],
      lastName: map['lastName'],
      id: map['id'],
      userName: map['userName'],
      imageUrl: map['imageUrl'],
      phoneNumber: map['phoneNumber'],
      courses: List<Course>.from(map['courses']?.map((x) => Course.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Teacher.fromJson(String source) =>
      Teacher.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Teacher(firstName: $firstName, lastName: $lastName, id: $id, userName: $userName, imageUrl: $imageUrl, phoneNumber: $phoneNumber, courses: $courses)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Teacher &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.id == id &&
        other.userName == userName &&
        other.imageUrl == imageUrl &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.courses, courses);
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        id.hashCode ^
        userName.hashCode ^
        imageUrl.hashCode ^
        phoneNumber.hashCode ^
        courses.hashCode;
  }
}
