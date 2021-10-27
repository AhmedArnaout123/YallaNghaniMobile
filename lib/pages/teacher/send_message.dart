/*
* File : Selectable List
* Version : 1.0.0
* */

import 'package:yallangany/cubits/teacher/msseages_sender/messagessender_cubit.dart';
import 'package:yallangany/models/parents/message.dart';
import 'package:yallangany/models/teachers/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMessageScreen extends StatefulWidget {
  final List<Course> courses;
  final String teacherName;
  const SendMessageScreen({Key key, this.courses, this.teacherName})
      : super(key: key);

  @override
  _SendMessageScreenState createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  String _selectedParentId;
  String _selectedStudentName;
  bool _loadingDialogIsShown = false;
  Message message;

  @override
  void initState() {
    super.initState();
    message = Message()
      ..date = DateTime.now().toString().replaceAll(' ', 'T')
      ..senderName = widget.teacherName
      ..title = ''
      ..content = '';
    print(message.date);
  }

  bool get _hasSelectedStudent {
    return _selectedParentId != null;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocListener<MessagesSenderCubit, MessagesSenderState>(
        listener: (context, state) {
          if (state is MessagesSenderIsLoading) {
            _loadingDialogIsShown = true;
            _showLoadingDialog();
          } else {
            if (_loadingDialogIsShown) Navigator.of(context).pop();
            _loadingDialogIsShown = false;
            if (state is MessagesSenderSuccess)
              _showResultDialog('s');
            else if (state is MessagesSenderFailure) _showResultDialog('f');
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "إرسال رسالة",
            ),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            children: [
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    child: Text("إرسال إلى :"),
                    onPressed: _showSelectionDialog,
                  ),

                  ///
                  if (_hasSelectedStudent)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        _selectedStudentName,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                ],
              ),
              SizedBox(height: 18),
              SizedBox(height: 18),
              TextFormField(
                decoration: InputDecoration(hintText: 'العنوان'),
                onChanged: (value) {
                  message.title = value;
                },
              ),
              SizedBox(height: 18),
              TextFormField(
                onChanged: (value) {
                  message.content = value;
                },
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "النص",
                ),
              ),
              SizedBox(height: 18),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: _hasSelectedStudent ? _sendMessage : null,
                  child: Text("إرسال"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    if (message.title.isNotEmpty && message.content.isNotEmpty) {
      BlocProvider.of<MessagesSenderCubit>(context).sendMessages(
        message,
        _selectedParentId,
      );
    } else
      _showEmptyFieldsErrorDialog();
  }

  void _showSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: widget.courses.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(
                    widget.courses[i].studentName,
                  ),
                  onTap: () {
                    setState(() {
                      _selectedParentId = widget.courses[i].parentId;
                      _selectedStudentName = widget.courses[i].studentName;
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
              separatorBuilder: (context, _) {
                return Divider(
                  height: 2,
                );
              },
            ),
          ),
        );
      },
    );
  }

  _showLoadingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text("جاري الإرسال"),
              ),
            ],
          ),
        );
      },
    ).then((value) => _loadingDialogIsShown = false);
  }

  _showResultDialog(String flag) {
    showDialog(
      context: (context),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            content: Text(
              flag == 's' ? 'تم إرسال رسالتك بنجاح' : 'فشل ارسال الرسالة',
            ),
            actions: [
              TextButton(
                child: Text('حسناً'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        );
      },
    );
  }

  void _showEmptyFieldsErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('الرجاء ملئ حقلي العنوان والنص'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('حسناً'),
            )
          ],
        );
      },
    );
  }
}
