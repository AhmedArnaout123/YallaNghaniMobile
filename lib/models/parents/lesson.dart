import 'dart:convert';

enum PaymentStatus { paied, unPaied }

extension PaymentStatusExtension on PaymentStatus {
  static PaymentStatus fromString(String value) =>
      value.toLowerCase() == 'paied'
          ? PaymentStatus.paied
          : PaymentStatus.unPaied;

  String toArabic() {
    return this == PaymentStatus.paied ? 'مدفوع' : 'غير مدفوع';
  }

  bool get isPaied => this == PaymentStatus.paied;

  bool get isUnPaied => this == PaymentStatus.unPaied;
}

class Lesson {
  int number;

  String date;

  PaymentStatus paymentStatus;

  String paymentNote;

  double fee;

  String summary;
  Lesson({
    this.number,
    this.date,
    this.paymentStatus,
    this.paymentNote,
    this.fee,
    this.summary,
  });

  Lesson copyWith({
    int number,
    String date,
    PaymentStatus paymentStatus,
    String paymentNote,
    double fee,
    String summary,
  }) {
    return Lesson(
      number: number ?? this.number,
      date: date ?? this.date,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentNote: paymentNote ?? this.paymentNote,
      fee: fee ?? this.fee,
      summary: summary ?? this.summary,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'date': date,
      'paymentStatus': paymentStatus
          .toString()
          .substring(paymentStatus.toString().indexOf('.') + 1),
      'paymentNote': paymentNote,
      'fee': fee,
      'summary': summary,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      number: map['number'],
      date: map['date'].substring(0, map['date'].indexOf('T')),
      paymentStatus: PaymentStatusExtension.fromString(map['paymentStatus']),
      paymentNote: map['paymentNote'],
      fee: map['fee'].toDouble(),
      summary: map['summary'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) => Lesson.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Lesson(number: $number, date: $date, paymentStatus: $paymentStatus, paymentNote: $paymentNote, fee: $fee, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Lesson &&
        other.number == number &&
        other.date == date &&
        other.paymentStatus == paymentStatus &&
        other.paymentNote == paymentNote &&
        other.fee == fee &&
        other.summary == summary;
  }

  @override
  int get hashCode {
    return number.hashCode ^
        date.hashCode ^
        paymentStatus.hashCode ^
        paymentNote.hashCode ^
        fee.hashCode ^
        summary.hashCode;
  }
}
