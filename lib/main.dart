import 'package:flutter/material.dart';
import 'package:memo_app/edit.dart';
import 'package:memo_app/data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MemoList(),
    );
  }
}

class MemoListState extends State<MemoList> {
  final _memoList = <MemoDataModel>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  MemoDataModel _currentMemo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memo App'),
      ),
      body: _buildList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addMemo,
        tooltip: 'New Memo',
        child: new Icon(Icons.add),
      ),
    );
  }

  void _addMemo() {
    setState(() {
      _currentMemo = new MemoDataModel(title: "", content: "");
      _memoList.add(_currentMemo);
      Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                new Edit(_currentMemo.content, _onChanged)),
      );
    });
  }

  void _onChanged(String text) {
    setState(() {
      _currentMemo.content = text;
    });
  }

  Widget _buildList() {
    final itemCount = _memoList.length == 0 ? 0 : _memoList.length * 2 - 1;
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: itemCount,
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider();
          final index = (i / 2).floor();
          final model = _memoList[index];
          return _buildRow(model.content, index);
        });
  }

  Widget _buildRow(String content, int index) {
    return ListTile(
      title: Text(
        content,
        style: _biggerFont,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        _currentMemo = _memoList[index];
        Navigator.of(context).push(
          MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  new Edit(_currentMemo.content, _onChanged)),
        );
      },
    );
  }
}

class MemoList extends StatefulWidget {
  @override
  MemoListState createState() => MemoListState();
}
