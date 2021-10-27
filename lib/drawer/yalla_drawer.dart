import 'package:yallangany/cubits/identifier/identifier_cubit.dart';
import 'package:yallangany/cubits/main_page/main_page_cubit.dart';
import 'package:yallangany/pages/common/about.dart';
import 'package:yallangany/pages/common/login.dart';
import 'package:yallangany/providers/user_identity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:yallangany/AppTheme.dart';
import 'package:yallangany/AppThemeNotifier.dart';
import 'package:yallangany/services/notifications/notifications_service.dart';

class YallaDrawer extends StatefulWidget {
  @override
  _YallaDrawerState createState() => _YallaDrawerState();
}

class _YallaDrawerState extends State<YallaDrawer> {
  ThemeData themeData;

  CustomAppTheme customAppTheme;

  @override
  Widget build(BuildContext context) {
    ///
    bool hasIdentity = UserIdentityProvieder().hasIdentity;

    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget child) {
        int themeType = value.themeMode();
        themeData = AppTheme.getThemeFromThemeMode(themeType);
        customAppTheme = AppTheme.getCustomAppTheme(themeType);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Drawer(
            child: Container(
              color: customAppTheme.bgLayer1,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Container(
                    height: 200,
                    color: Colors.blue,
                    child: Image(
                      image: AssetImage('./assets/images/yalla.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 20),
                  if (hasIdentity)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  UserIdentityProvieder().getFullName(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  UserIdentityProvieder().getPhoneNumber(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  _buildPageNavigator(
                    icon: Icons.home,
                    text: 'الصفحة الرئيسية',
                    onTap: () {
                      Navigator.of(context).pop();
                      BlocProvider.of<MainPageCubit>(context)
                          .goToCommonHomePage();
                    },
                  ),
                  _buildPageNavigator(
                    icon: Icons.info,
                    text: 'عن يلا نغني',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutScreen(),
                      ),
                    ),
                  ),
                  _buildPageNavigator(
                    icon: hasIdentity ? Icons.logout : Icons.login,
                    text: hasIdentity ? 'تسجيل الخروج' : 'تسجيل الدخول',
                    onTap: hasIdentity ? _logoutHandler : _navigateToLoginPage,
                  ),
                  if (hasIdentity)
                    _buildPageNavigator(
                      icon: Icons.person,
                      text: 'حسابي',
                      onTap: () {
                        Navigator.of(context).pop();
                        var mainPageCubit =
                            BlocProvider.of<MainPageCubit>(context);
                        if (UserIdentityProvieder().getRole() == 'parent')
                          mainPageCubit.goToParentHomePage();
                        else
                          mainPageCubit.goToTeahcerHomePage();
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageNavigator({
    String text,
    IconData icon,
    void Function() onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.blue,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  void _navigateToLoginPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  void _logoutHandler() async {
    Navigator.of(context).pop();
    await NotificationService().cancelAll();
    BlocProvider.of<IdentifierCubit>(context).removeIdentity();
  }
}
