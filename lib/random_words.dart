import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
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
    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18)),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordPairs.remove(pair);
          } else {
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  void _pushedSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair p) {
        return ListTile(
            title: Text(p.asPascalCase, style: TextStyle(fontSize: 16)));
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: Text("Saved Pairs")),
          body: ListView(children: divided));
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wordpair Generator"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushedSaved)
        ],
      ),
      body: _buildList(),
    );
  }
}
