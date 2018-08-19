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

Future<File> _getMarkFile() async {
  // 获取本地文档目录
  String dir = (await getApplicationDocumentsDirectory()).path;
  // 返回本地文件目录
  return new File('$dir/zjf_notepadmark.txt');
}

Future<List<Map>> getNotes() async {
  try {
    File file = await _getNoteFile();
    String contents = await file.readAsString();
    final formatContents = json.decode(contents);
    //print(formatContents);
    if (formatContents is List) {
      return formatContents.map((Object item) {
        final Map newItem = item;
        //final Map newItem = json.decode(json.encode(item));
        return newItem;
      }).toList();
    } else {
      return [];
    }
  } on FileSystemException {
    // 发生异常时返回默认值
    return [];
  }
}

Future<List<Map>> getMarks() async {
  try {
    File file = await _getMarkFile();
    String contents = await file.readAsString();
    final formatContents = json.decode(contents);
    if (formatContents is List) {
      return formatContents.map((Object item) {
        final Map newItem = item;
        return newItem;
      }).toList();
    } else {
      return [];
    }
  } on FileSystemException {
    // 发生异常时返回默认值
    return [];
  }
}

Future setNotes(List<Map> contents) async {
  final String writeContents = json.encode(contents);
  print(writeContents);
  await (await _getNoteFile()).writeAsString(writeContents);
}

Future appendNote(Map note) async {
  final List<Map> exitContents = await getNotes();
  exitContents.insert(0, note);
  await (await _getNoteFile()).writeAsString(json.encode(exitContents));
}

Future appendMark(Map mark) async {
  final List<Map> exitContents = await getMarks();
  exitContents.insert(0, mark);
  await (await _getMarkFile()).writeAsString(json.encode(exitContents));
}

Future removeNote(int index) async {
  final List<Map> exitContents = await getNotes();
  exitContents.removeAt(index);
  await (await _getNoteFile()).writeAsString(json.encode(exitContents));
}

Future removeMark(int index) async {
  final List<Map> exitContents = await getMarks();
  exitContents.removeAt(index);
  await (await _getMarkFile()).writeAsString(json.encode(exitContents));
}

Future removeMarks(List<String> ids) async {
  final List<Map> exitContents = await getMarks();
  exitContents.removeWhere((Map mark) {
    return ids.any((String id) {
      return id == mark['id'];
    });
  });
  await (await _getMarkFile()).writeAsString(json.encode(exitContents));
}