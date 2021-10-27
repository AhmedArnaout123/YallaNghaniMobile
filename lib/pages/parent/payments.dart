import 'package:flutter/material.dart';
import 'package:yallangany/models/parents/payment.dart';
import 'package:yallangany/widgets/parents/payment_viewer.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({Key key, this.payments}) : super(key: key);

  final List<Payment> payments;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الدفعات'),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: payments
              .map(
                (payment) => PaymentViewer(payment: payment),
              )
              .toList(),
        ),
      ),
    );
  }
}
