import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    ///
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()));

    if (Platform.isIOS) {
      _requestIOSPermission();
    }

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('yalla');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (a, b, c, d) async {},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: null,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  Future selectNotification(String payload) async {
    //Handle notification tapped logic here
  }

  Future cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future show() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'LessonsDatesId', //Required for Android 8.0 or after
      'Lessons Dates', //Required for Android 8.0 or after
      'It\'s for lessons date', //Required for Android 8.0 or after
      importance: Importance.high,
      priority: Priority.high,
      ongoing: true,

      styleInformation: BigTextStyleInformation(''),
    );

    const IOSNotificationDetails iosPatformChannedlSpecifics =
        IOSNotificationDetails(
      presentAlert: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPatformChannedlSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      12345,
      'تذكير',
      'نود تذكيركم بدرس ',
      platformChannelSpecifics,
    );
  }

  Future schdeule(
    String studentName,
    String courseTitle,
    String hour,
    tz.TZDateTime tzDateTime,
  ) async {
    ///
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'LessonsDatesId', //Required for Android 8.0 or after
      'Lessons Dates', //Required for Android 8.0 or after
      'It\'s for lessons date', //Required for Android 8.0 or after
      importance: Importance.high,
      priority: Priority.high,
      ongoing: true,

      styleInformation: BigTextStyleInformation(''),
    );

    const IOSNotificationDetails iosPatformChannedlSpecifics =
        IOSNotificationDetails(
      presentAlert: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPatformChannedlSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      12345,
      'تذكير',
      'نود تذكيركم بدرس $studentName في دورة $courseTitle عند الساعة $hour',
      tzDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );

    // await flutterLocalNotificationsPlugin.zonedSchedule(123, title, body, scheduledDate, notificationDetails, uiLocalNotificationDateInterpretation: uiLocalNotificationDateInterpretation, androidAllowWhileIdle: androidAllowWhileIdle)
  }

  _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
          alert: false,
          badge: true,
          sound: true,
        );
  }
}
