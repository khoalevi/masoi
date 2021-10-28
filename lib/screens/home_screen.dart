import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:masoi/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _villageID = "f2fcf3fe44d890185f0f11a";
  String _name = 'Khoa';
  Color _color = const Color(0xFFFF0000);
  final _nameController = TextEditingController(text: 'Khoa');

  void _changeName(String name) {
    setState(() {
      _name = name;
    });
  }

  void _changeColor(Color color) {
    setState(() {
      _color = color;
    });
  }

  String generateCode(String name, Color color) {
    final hex = '#${color.value.toRadixString(16).substring(2)}';
    return '<color=$hex>F. <b>$name</b></color>';
  }

  Widget _buildNameTF() {
    return TextField(
      textAlign: TextAlign.center,
      maxLength: 8,
      controller: _nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: _changeName,
    );
  }

  Widget _buildColorPicker() {
    return CircleColorPicker(
      onChanged: _changeColor,
      size: const Size(256, 256),
      strokeWidth: 4,
      thumbSize: 36,
    );
  }

  Widget _buildNamePreviewTF() {
    return Container(
      height: 64,
      color: const Color(0xFF565364),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'F. ',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: _color),
            ),
            Text(
              _name,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: _color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodePreviewTF() {
    return Container(
      height: 64,
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: Text(
          generateCode(_name, _color),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }

  Widget _buildClipboardCodeButton() {
    return SizedBox(
      width: double.infinity, // <-- match_parent
      child: ElevatedButton(
        child: const Text(
          'Copy code đổi tên',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          final code = generateCode(_name, _color);
          FlutterClipboard.copy(code).then((value) {
            const snackBar = SnackBar(
              content: Text('Đã copy code đổi tên rồi nha! :D'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Web hỗ trợ dân làng Fantasy $appVersion"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bước 1: Nộp đơn xin gia nhập làng",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: null,
                    child: SelectableText(_villageID),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      FlutterClipboard.copy(_villageID).then((value) {
                        const snackBar = SnackBar(
                          content: Text('Đã Copy ID Làng'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    },
                    child: Text("Copy ID Làng"),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Image.asset("images/instructions.gif"),
              SizedBox(height: 16),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      onSurface: Colors.red,
                    ),
                    child: Text(
                      "Nếu không copy được, hãy thử nhấp giữ dòng ID để hiện tùy chọn copy",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      onSurface: Colors.red,
                    ),
                    child: Text(
                      "hoặc truy cập masoi.org bằng trình duyệt thay vì Messenger",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "Bước 2: Tạo code đổi tên theo làng",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              _buildNameTF(),
              _buildColorPicker(),
              const SizedBox(height: 16),
              _buildNamePreviewTF(),
              const SizedBox(height: 8),
              _buildCodePreviewTF(),
              const SizedBox(height: 8),
              _buildClipboardCodeButton(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  onSurface: Colors.red,
                ),
                child: Text(
                  "Tuyệt đối không tự ý chỉnh sửa code khi chưa có sự đồng ý của TL",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
