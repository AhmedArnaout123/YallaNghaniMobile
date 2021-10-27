import 'dart:convert';

class Payment {
  double amount;

  String date;

  String paymentMethod;

  Payment({
    this.amount,
    this.date,
    this.paymentMethod,
  });

  Payment copyWith({
    double amount,
    String date,
    String paymentMethod,
  }) {
    return Payment(
      amount: amount ?? this.amount,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'date': date,
      'paymentMethod': paymentMethod,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      amount: map['amount'].toDouble(),
      date: map['date'].substring(0, map['date'].indexOf('T')),
      paymentMethod: map['paymentMethod'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source));

  @override
  String toString() =>
      'Payment(amount: $amount, date: $date, paymentMethod: $paymentMethod)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Payment &&
        other.amount == amount &&
        other.date == date &&
        other.paymentMethod == paymentMethod;
  }

  @override
  int get hashCode => amount.hashCode ^ date.hashCode ^ paymentMethod.hashCode;
}
