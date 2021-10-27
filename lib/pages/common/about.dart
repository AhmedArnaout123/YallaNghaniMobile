import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('عن المعهد'),
          centerTitle: true,
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.only(left: 24, right: 24, bottom: 20, top: 35),
            children: [
              Image(
                image: AssetImage("./assets/images/about.png"),
              ),
              Text(
                ' معهد يلا نغني للموسيقى والفنون',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 18),
              Text(
                '''معهد يلّا نغني هو مركز تدريبي تعليمي رائد في مجالات الموسيقى والفنون.
هذا التطبيق يهدف الى بناء حلقة تواصل تمتاز بالسهوله، المرونه، الشفافيه والمهنيه مع الطلاب والاهالي.
حيث نقدم من خلاله لمحة عن الدورات التدريبيه والعلاجيه المختلفه المتاحه في المعهد. إضافة الى ذلك، فإن التطبيق يساعد المنتسبين في المعهد سواءً كان طلاب او اولياء امورهم من متابعة المسار التعليمي المحتلن منذ بداية الاشتراك بالدوره. كما ويمكن تتبع عدد الدروس والدفعات النقدية والرسائل المُرسلة من الإدارة أو المعلمين.
ومن أجل التسهيل عليكم ومساعدتكم في تنظيم أموركم سوف يحتوي التطبيق مستقبلاً على ميزة التذكير المُسبق بمواعيد الدروس.                
''',
              ),
              SizedBox(height: 18),
              Text(
                'تواصل معنا',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              buildContactInfo(
                icon: Icons.phone,
                value: '0507770313',
              ),
              buildContactInfo(
                icon: Icons.phone,
                value: '04-6992677',
              ),
              SizedBox(height: 8),
              buildContactInfo(
                icon: Icons.email,
                value: 'hamzahi@hotmail.com',
              ),
              SizedBox(height: 8),
              buildContactInfo(
                icon: Icons.place,
                value: 'طمرة - الشارع الشمالي',
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContactInfo({IconData icon, String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.black),
        Expanded(
          child: Text(
            ' : $value',
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
