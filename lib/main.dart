import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  Widget _buildList() {
    _randomWordPairs.addAll(generateWordPairs().take(1000));
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _randomWordPairs.length,
        itemBuilder: (BuildContext context, item) {
          if (item.isOdd) {
            return Divider();
          } else {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }

          final index = item ~/ 2;
          return _buildRow(_randomWordPairs[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
        title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18)));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wordpair Generator")),
      body: _buildList(),
    );
  }
}
