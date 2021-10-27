/*
* File : Hotel Login
* Version : 1.0.0
* */

import 'dart:convert';

import 'package:yallangany/AppThemeNotifier.dart';
import 'package:yallangany/cubits/identifier/identifier_cubit.dart';
import 'package:yallangany/helpers/const_data_helper.dart';
import 'package:yallangany/models/parents/parent.dart';
import 'package:yallangany/models/teachers/teacher.dart';
import 'package:yallangany/providers/user_identity_provider.dart';
import 'package:yallangany/services/api_connection/api_connection_service.dart';
import 'package:yallangany/services/notifications/notifications_service.dart';
import 'package:yallangany/services/storage_service/storage_service.dart';
import 'package:yallangany/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'package:yallangany/AppTheme.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ThemeData themeData;
  bool _passwordVisible = false;

  static const String _userNameLabel = "userName";
  static const String _passwordLabel = "password";

  Map<String, String> _errorMessages = {};
  Map<String, String> _formData = {};

  bool _validatePassowrd() {
    if (_formData[_passwordLabel] == null ||
        _formData[_passwordLabel].isEmpty) {
      setState(() {
        _errorMessages[_passwordLabel] = "من فضلك أدخل كلمة المرور";
      });
      return false;
    }

    if (_formData[_passwordLabel].length < 6) {
      setState(() {
        _errorMessages[_passwordLabel] =
            "كلمة المرور يجب أن تكون على الأقل بطول  6 محارف";
      });
      return false;
    }

    _errorMessages[_passwordLabel] = null;

    return true;
  }

  bool _validateUserName() {
    if (_formData[_userNameLabel] == null ||
        _formData[_userNameLabel].isEmpty) {
      setState(() {
        _errorMessages[_userNameLabel] = "من فضلك أدخل اسم المستخدم";
      });
      return false;
    }

    _errorMessages[_userNameLabel] = null;

    return true;
  }

  bool _validateForm() {
    var f1 = _validatePassowrd();
    var f2 = _validateUserName();

    return f1 && f2;
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: themeData.scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text('تسجيل الدخول'),
            ),
            body: Container(
              child: Center(
                child: ListView(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, bottom: 20, top: 35),
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Image(
                          image: AssetImage(
                            './assets/images/yalla.png',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MySize.size24),
                      child: TextFormField(
                        onChanged: (value) {
                          _formData[_userNameLabel] = value;
                        },
                        style: AppTheme.getTextStyle(
                          themeData.textTheme.bodyText1,
                          letterSpacing: 0.1,
                          color: themeData.colorScheme.onBackground,
                          fontWeight: 500,
                        ),
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(
                          errorText: _errorMessages[_userNameLabel],
                          hintText: "اسم المستخدم",
                          hintStyle: AppTheme.getTextStyle(
                            themeData.textTheme.subtitle2,
                            letterSpacing: 0.1,
                            color: themeData.colorScheme.onBackground,
                            fontWeight: 500,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: themeData.colorScheme.background,
                          prefixIcon: Icon(
                            MdiIcons.account,
                            size: MySize.size22,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(0),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MySize.size16),
                      child: TextFormField(
                        onChanged: (value) {
                          _formData[_passwordLabel] = value;
                        },
                        autofocus: false,
                        obscureText: !_passwordVisible,
                        style: AppTheme.getTextStyle(
                          themeData.textTheme.bodyText1,
                          letterSpacing: 0.1,
                          color: themeData.colorScheme.onBackground,
                          fontWeight: 500,
                        ),
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(
                          errorText: _errorMessages[_passwordLabel],
                          hintStyle: AppTheme.getTextStyle(
                            themeData.textTheme.subtitle2,
                            letterSpacing: 0.1,
                            color: themeData.colorScheme.onBackground,
                            fontWeight: 500,
                          ),
                          hintText: "كلمة المرور",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: themeData.colorScheme.background,
                          prefixIcon: Icon(
                            MdiIcons.lockOutline,
                            size: MySize.size22,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: Icon(
                              _passwordVisible
                                  ? MdiIcons.eyeOutline
                                  : MdiIcons.eyeOffOutline,
                              size: MySize.size22,
                            ),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(0),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(MySize.size28)),
                        boxShadow: [
                          BoxShadow(
                            color: themeData.primaryColor.withAlpha(24),
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: MySize.size24),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(Spacing.xy(16, 0)),
                        ),
                        onPressed: login,
                        child: Text(
                          "تسجيل الدخول",
                          style: AppTheme.getTextStyle(
                            themeData.textTheme.bodyText2,
                            fontWeight: 600,
                          ).merge(
                            TextStyle(
                              color: themeData.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 7.5, vertical: 12),
                        child: Text(
                          'إذا لم يكن لديك حساب يمكنك التفضل بزيارتنا إلى مقر المعهد و معرفة تفاصيل أكثر عن خدماتنا المقدمة من خلال التطبيق',
                        ),
                        color: Colors.lightGreen.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void login() async {
    ///
    if (!_validateForm()) return;

    var requestResult = await ApiCaller.request(
      url: '${ConstDataHelper.baseUrl}/auth/login',
      method: HttpMethod.POST,
      body: jsonEncode(_formData),
      headers: {'Content-Type': 'application/json'},
    );

    if (requestResult is Ok) {
      ///
      var outcome = json.decode(requestResult.body)['outcome'];

      String role = outcome['role'];
      if (role != null) {
        ///
        if (role == 'parent') {
          ///
          var parent = outcome['parent'];
          var parentObj = Parent.fromMap(parent);
          parentObj.courses.forEach((course) {
            course.lessonsDates.forEach((ld) async {
              await NotificationService().schdeule(
                course.studentName,
                course.title,
                ld.hour,
                ld.getNotificationTime(),
              );
              print(
                'Registerd Notification At ${ld.getNotificationTime()} for Lesson Date $ld',
              );
            });
          });
          UserIdentityProvieder()
              .setIdentity(role, parent['id'], outcome['token']);

          await _storeIdentity(role, parent['id'], outcome['token']);

          UserIdentityProvieder().setAccountInfo(
              parent['firstName'], parent['lastName'], parent['phoneNumber']);

          await _storeAccountInfo(parent);

          Navigator.of(context).pop();
          Navigator.of(context).pop();

          BlocProvider.of<IdentifierCubit>(context).identify(role);

          ///
        } else if (role == 'teacher') {
          ///
          var teacher = outcome['teacher'];
          // var teacherObj = Teacher.fromMap(teacher);
          // teacherObj.courses.forEach((course) {
          //   course.lessonsDates.forEach((ld) async {
          //     await NotificationService().schdeule(
          //       course.studentName,
          //       course.title,
          //       ld.hour,
          //       ld.getNotificationTime(),
          //     );
          //     print(
          //       'Registerd Notification At ${ld.getNotificationTime()} for Lesson Date $ld',
          //     );
          //   });
          // });

          UserIdentityProvieder()
              .setIdentity(role, teacher['id'], outcome['token']);

          await _storeIdentity(role, teacher['id'], outcome['token']);

          UserIdentityProvieder().setAccountInfo(teacher['firstName'],
              teacher['lastName'], teacher['phoneNumber']);

          await _storeAccountInfo(teacher);

          Navigator.of(context).pop();
          Navigator.of(context).pop();

          BlocProvider.of<IdentifierCubit>(context).identify(role);

          ///
        } else {
          ///
          _showErrorDialog(
            message: 'حدث خطأ غير معروف. الرجاء المحاولة مجدداً',
          );

          print(
            'Unkown Role Is Returned: $role\n response body : ${requestResult.body}',
          );

          ///
        }
      } else {
        ///
        _showErrorDialog(
          message: 'حدث خطأ غير معروف. الرجاء المحاولة مجدداً',
        );

        print('Unkown Response body : ${requestResult.body}');

        ///
      }
    } else if (requestResult is BadRequest) {
      ///
      if (json.decode(requestResult.body)['error'] ==
          'Invalid UserName Or Password') {
        _showErrorDialog(message: 'خطأ في كلمة المرور أو اسم المستخدم');

        ///
      } else {
        print(requestResult.toString());
        _showErrorDialog();
      }
      return;

      ///
    } else {
      ///
      print(
        'An Error: ${requestResult.runtimeType}, Available Details: ${requestResult.toString()}',
      );

      _showErrorDialog();

      return;

      ///
    }
  }

  void _showErrorDialog({message}) {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text('خطأ'),
            content: Text(message ?? 'حدث خطأ أثناء عملية تسجيل الدخول'),
            actions: [
              TextButton(
                child: Text('حسناً'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _storeIdentity(String role, String id, String token) async {
    await StorageService().write('token', token);
    await StorageService().write('id', id);
    await StorageService().write('role', role);
  }

  Future<void> _storeAccountInfo(Map<String, dynamic> account) async {
    await StorageService().write('firstName', account['firstName'].toString());
    await StorageService().write('lastName', account['lastName'].toString());
    await StorageService()
        .write('phoneNumber', account['phoneNumber'].toString());
  }
}
