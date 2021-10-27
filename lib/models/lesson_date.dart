import 'dart:convert';

import 'package:timezone/timezone.dart' as tz;

import 'package:yallangany/models/day.dart';

export 'day.dart';

class LessonDate {
  Day day;

  String hour;

  LessonDate({
    this.day,
    this.hour,
  });

  tz.TZDateTime getNotificationTime() {
    ///
    int dayNum = day.toDayNum();
    int notifyHour = getNumericalHour() - 1;
    int notifyMinute = getNumericalMinute();
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, notifyHour, notifyMinute);

    if (now.weekday > dayNum) {
      return scheduledDate.add(Duration(days: 7 - (now.weekday - dayNum)));
    }

    if (now.weekday < dayNum) {
      return scheduledDate.add(Duration(days: dayNum - now.weekday));
    }

    if (now.weekday == dayNum) {
      ///
      if (now.hour < notifyHour) {
        return scheduledDate;
      } else if (now.hour == notifyHour) {
        if (now.minute < notifyMinute) {
          return scheduledDate;
        } else {
          return scheduledDate.add(Duration(days: 7));
        }
      } else {
        return scheduledDate.add(Duration(days: 7));
      }
    }
    return null;
  }

  int getNumericalHour() {
    return int.parse(hour.split('.')[0]);
  }

  int getNumericalMinute() {
    return int.parse(hour.split('.')[1]);
  }

  int compareTo(LessonDate obj) {
    if (obj.day.toDayNum() > day.toDayNum()) return -1;
    if (obj.day.toDayNum() < day.toDayNum()) return 1;
    if (obj.getNumericalHour() > this.getNumericalHour()) return -1;
    if (obj.getNumericalHour() < this.getNumericalHour()) return 1;
    if (obj.getNumericalMinute() > this.getNumericalMinute()) return -1;
    if (obj.getNumericalMinute() < this.getNumericalMinute()) return 1;
    return 0;
  }

  LessonDate copyWith({
    Day day,
    String hour,
  }) {
    return LessonDate(
      day: day ?? this.day,
      hour: hour ?? this.hour,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day.toString().substring(day.toString().indexOf('.') + 1),
      'hour': hour,
    };
  }

  factory LessonDate.fromMap(Map<String, dynamic> map) {
    return LessonDate(
      day: DayExtension.fromString(map['day']),
      hour: map['hour'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LessonDate.fromJson(String source) =>
      LessonDate.fromMap(json.decode(source));

  @override
  String toString() => 'LessonDate(day: $day, hour: $hour)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LessonDate && other.day == day && other.hour == hour;
  }

  @override
  int get hashCode => day.hashCode ^ hour.hashCode;
}
