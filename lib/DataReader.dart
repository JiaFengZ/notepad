import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

Future<File> _getNoteFile() async {
  // 获取本地文档目录
  String dir = (await getApplicationDocumentsDirectory()).path;
  // 返回本地文件目录
  return new File('$dir/zjf_notepad.txt');
}

Future<Map> getNotes() async {
  try {
    File file = await _getNoteFile();
    String  contents = await file.readAsString();
    // 返回文件中的点击数
    return json.decode(contents);
  } on FileSystemException {
    // 发生异常时返回默认值
    return null;
  }
}

Future setNotes(Map contents) async {
  final String writeContents = json.encode(contents);
  await (await _getNoteFile()).writeAsString(writeContents);
}