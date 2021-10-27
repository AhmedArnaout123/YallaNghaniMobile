import 'package:yallangany/AppTheme.dart';
import 'package:yallangany/AppThemeNotifier.dart';
import 'package:yallangany/models/parents/message.dart';
import 'package:yallangany/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  final List<Message> messages;

  const MessagesScreen({Key key, this.messages}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  ThemeData themeData;
  CustomAppTheme customAppTheme;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget child) {
        int themeType = value.themeMode();
        themeData = AppTheme.getThemeFromThemeMode(themeType);
        customAppTheme = AppTheme.getCustomAppTheme(themeType);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: Container(
              color: customAppTheme.bgLayer1,
              child: ListView(
                padding: Spacing.vertical(MediaQuery.of(context).padding.top),
                children: <Widget>[
                  Container(
                    margin: Spacing.fromLTRB(24, 16, 24, 0),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 60,
                            height: 30,
                            alignment: Alignment.center,
                            child: Text(
                              'رجوع',
                              style: TextStyle(
                                color: themeData.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Transform.translate(
                              offset: Offset(18, 0),
                              child: Text(
                                "الرسائل",
                                style: AppTheme.getTextStyle(
                                  themeData.textTheme.bodyText1,
                                  color: themeData.colorScheme.onBackground,
                                  fontWeight: 600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (var message in widget.messages)
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: Spacing.fromLTRB(24, 24, 24, 0),
                            child: _buildSingleMessage(
                              title: message.title,
                              content: message.content,
                              date: message.date,
                              senderName: message.senderName,
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSingleMessage({
    String title,
    String date,
    String senderName,
    String content,
  }) {
    return Container(
      padding: Spacing.vertical(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(MySize.size8)),
        color: customAppTheme.bgLayer1,
        border: Border.all(color: customAppTheme.bgLayer4, width: 1),
        boxShadow: [
          BoxShadow(
            color: customAppTheme.shadowColor,
            blurRadius: MySize.size4,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: Spacing.horizontal(24),
            alignment: Alignment.center,
            child: Text(
              title,
              style: AppTheme.getTextStyle(
                themeData.textTheme.subtitle2,
                color: themeData.colorScheme.onBackground,
                fontWeight: 800,
              ),
            ),
          ),
          Container(
            padding: Spacing.horizontal(24),
            margin: Spacing.top(4),
            child: Text(
              content,
              style: AppTheme.getTextStyle(
                themeData.textTheme.bodyText2,
                color: themeData.colorScheme.onBackground,
                letterSpacing: 0.3,
                fontWeight: 500,
                height: 1.7,
              ),
            ),
          ),
          Container(
            margin: Spacing.top(16),
            child: Divider(
              height: 0,
            ),
          ),
          Container(
            padding: Spacing.only(left: 24, right: 24, top: 16),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                date,
                style: AppTheme.getTextStyle(
                  themeData.textTheme.bodyText2,
                  color: themeData.colorScheme.primary,
                ),
              ),
            ),
          ),
          Container(
            margin: Spacing.top(4),
            padding: Spacing.horizontal(24),
            child: Text(
              senderName,
              style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                  color: themeData.colorScheme.onBackground.withAlpha(160),
                  fontWeight: 500),
            ),
          )
        ],
      ),
    );
  }
}
