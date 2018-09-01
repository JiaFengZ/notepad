# notepad

一个采用 flutter 构建的备忘录应用

# 功能
* 主页备忘录列表，支持收藏和标签标记
* 备忘录编辑添加页面
* 侧边栏菜单，可根据收藏和标签筛选显示备忘录
* 可自定义编辑标签

# flutter 开发环境构建
* [官网](https://flutter.io/sdk-archive/#windows)下载最新 flutter SDK
* SDK包下载解压到本地目录，设置 Flutter SDK 环境变量，把 ``flutter\bin``添加值path
* 设置 `PUB_HOSTED_URL`:`https://pub.flutter-io.cn`
* 设置 `FLUTTER_STORAGE_BASE_URL`:`https://storage.flutter-io.cn`
* 终端运行 `flutter doctor` 检查环境依赖
* Android Studio 安装 flutter 和 Dart 插件（File>Settings>Plugins on Windows & Linux，Browse repositories…）

# 学习资源
* [Dart 语言教程](https://api.dartlang.org/stable/1.24.3/index.html)
* [flutter 官方文档](https://docs.flutter.io/flutter/rendering/rendering-library.html#classes)
* [flutter 中文网](https://flutterchina.club/widgets-intro/)

# 开发学习记录
## flutter 使用 widget 构建UI界面，界面是由 widget 控件树组成的
* `Container`: 可定位、调整大小的容器
* `Row` 行
* `Column` 列
* `Image` 图片
* `Text` 文本
* `Icon` 图标
* `Appbar` 应用程序标题栏
* `Scaffold` 基本页面布局容器

## 状态管理
* flutter 与 React 在状态管理和界面更新上的理念是类似的，widgets 是界面组件，可以存储状态，
和管理状态，可以是无状态，也可以是有状态的。stateless widgets 只负责根据输入属性渲染界面，
由其父 widgets 管理状态，通过事件回调通知父 widgets 更新状态，从而驱动界面更新。stateful widgets
则是可自身保存并管理状态。
* 通过 setState 方法更新状态，widgets 组件树则会自动调用 build 方法重绘界面。
* 如果状态是对外有输出和副作用的，特别是非局部的用户数据，应父组件管理状态。
* 如果是只关乎自生组件表现的，无需对外输出，比如颜色/动画等，应自身管理状态。
* 通过继承 StatefulWidget类构建有状态widget，然后使用 createState 方法创建存储状态数据的子类，
当这个widget的父级重建时，父级将创建一个新的widget实例，但是Flutter框架将重用已经在树中
的state子类实例并进行更新，而不是再次调用createState创建一个新的。在子类state中通过widget
属性访问父级属性和方法。

## 本地文件存储及JSON序列化和反序列化
* 使用 ``dart:convert`` 的 encode 和 decode 对简单数据进行序列化和反序列化
* decode 反序列化得出的是 Map<String, dynamic> 动态类型数据，会丢失部分静态语言
特性。可以通过引入一个简单的模型类(model class)来解决前面提到的问题。

    ** 一个User.fromJson 构造函数, 用于从一个map构造出一个 User实例 map structure
    ** 一个toJson 方法, 将 User 实例转化为一个map.
```
   class User {
     final String name;
     final String email;

     User(this.name, this.email);

     User.fromJson(Map<String, dynamic> json)
         : name = json['name'],
           email = json['email'];

     Map<String, dynamic> toJson() =>
       {
         'name': name,
         'email': email,
       };
   }
```

```
Map userMap = JSON.decode(json);
var user = new User.fromJson(userMap);
```

* 使用 path_provider 插件读取本地文件系统路径，通过 File API 读写文件数据
```
Future<File> _getNoteFile() async {
  // 获取本地文档目录
  String dir = (await getApplicationDocumentsDirectory()).path;
  // 返回本地文件目录
  return new File('$dir/zjf_notepad.txt');
}

//读数据
Future<List<Map>> getNotes() async {
  try {
    File file = await _getNoteFile();
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
//写数据
Future appendNote(Map note) async {
  final List<Map> existContents = await getNotes();
  existContents.insert(0, note);
  await (await _getNoteFile()).writeAsString(json.encode(existContents));
}
```
