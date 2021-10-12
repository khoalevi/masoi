import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

void main() {
  runApp(const MyApp());
}

const version = 'v0.4';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ma sói Fantasy',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(
          title: 'Web hỗ trợ dân làng Fantasy $version'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  Widget _buildClipboardIDButton() {
    return SizedBox(
      width: double.infinity, // <-- match_parent
      child: ElevatedButton(
        child: const Text(
          'Copy ID làng',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          const code = 'f2fcf3fe44d890185f0f11a';
          FlutterClipboard.copy(code).then((value) {
            const snackBar = SnackBar(
              content: Text('Đã copy ID làng rồi nha! :D'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        },
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
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'ID làng: f2fcf3fe44d890185f0f11a',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 8),
                _buildClipboardIDButton(),
                const SizedBox(height: 48),
                const Text(
                  'Nhập tên cần đổi vào ô bên dưới',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 8),
                _buildNameTF(),
                _buildColorPicker(),
                const SizedBox(height: 16),
                _buildNamePreviewTF(),
                const SizedBox(height: 8),
                _buildCodePreviewTF(),
                const SizedBox(height: 8),
                _buildClipboardCodeButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
