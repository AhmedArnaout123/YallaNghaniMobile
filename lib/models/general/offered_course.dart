import 'dart:convert';

class OfferedCourse {
  String imageUrl;
  String title;
  String teacherName;
  String description;
  String teacherDescription;
  String id;

  bool isEducational;
  OfferedCourse({
    this.imageUrl,
    this.title,
    this.teacherName,
    this.description,
    this.teacherDescription,
    this.id,
    this.isEducational,
  });

  OfferedCourse copyWith({
    String imageUrl,
    String title,
    String teacherName,
    String description,
    String teacherDescription,
    String id,
    bool isEducational,
  }) {
    return OfferedCourse(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      teacherName: teacherName ?? this.teacherName,
      description: description ?? this.description,
      teacherDescription: teacherDescription ?? this.teacherDescription,
      id: id ?? this.id,
      isEducational: isEducational ?? this.isEducational,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'teacherName': teacherName,
      'description': description,
      'teacherDescription': teacherDescription,
      'id': id,
      'isEducational': isEducational,
    };
  }

  factory OfferedCourse.fromMap(Map<String, dynamic> map) {
    return OfferedCourse(
      imageUrl: map['imageUrl'],
      title: map['title'],
      teacherName: map['teacherName'],
      description: map['description'],
      teacherDescription: map['teacherDescription'],
      id: map['id'],
      isEducational: map['isEducational'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferedCourse.fromJson(String source) =>
      OfferedCourse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OfferedCourse(imageUrl: $imageUrl, title: $title, teacherName: $teacherName, description: $description, teacherDescription: $teacherDescription, id: $id, isEducational: $isEducational)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OfferedCourse &&
        other.imageUrl == imageUrl &&
        other.title == title &&
        other.teacherName == teacherName &&
        other.description == description &&
        other.teacherDescription == teacherDescription &&
        other.id == id &&
        other.isEducational == isEducational;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
        title.hashCode ^
        teacherName.hashCode ^
        description.hashCode ^
        teacherDescription.hashCode ^
        id.hashCode ^
        isEducational.hashCode;
  }
}
