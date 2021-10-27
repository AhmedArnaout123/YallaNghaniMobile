import 'package:flutter/material.dart';
import 'package:yallangany/models/parents/payment.dart';
import 'package:yallangany/widgets/parents/info_card.dart';
import 'package:yallangany/widgets/parents/static_info_viewer.dart';

class PaymentViewer extends StatelessWidget {
  const PaymentViewer({Key key, this.payment}) : super(key: key);

  final Payment payment;
  @override
  Widget build(BuildContext context) {
    return InfoCard(infoList: [
      StaticInfoViewer(
        title: 'المبلغ',
        value: "${payment.amount}\₪",
      ),
      StaticInfoViewer(
        title: 'التاريخ',
        value: payment.date,
      ),
      StaticInfoViewer(
        title: 'طريقة الدفع',
        value: payment.paymentMethod,
      ),
    ]);
  }
}
