import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roulette/ui/circle_graph.dart';

class TopPage extends StatefulWidget {
  TopPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<PieData> _inputList;
  int _itemCount;
  double angle = 0;
  bool animate = false;
  @override
  initState() {
    super.initState();
    _inputList = [
      PieData(WordPair.random().first, 33),
      PieData(WordPair.random().first, 33),
      PieData(WordPair.random().first, 33),
    ];
    _itemCount = _inputList.length;
  }

  void _onChagne(int index, {String name, double percentage}) {
    setState(() {
      _inputList[index] = PieData(name ?? _inputList[index].name,
          percentage ?? _inputList[index].percentage);
    });
  }

  void _remove(int index) {
    setState(() {
      _inputList.removeAt(index);
      _itemCount = _inputList.length;
    });
  }

  void _add() {
    setState(() {
      _inputList.add(PieData(WordPair.random().first, 1));
      _itemCount = _inputList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buldBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(widget.title),
    );
  }

  void reset() {
    setState(() {
      animate = false;
      angle = 0;
    });
  }

  Widget _buldBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            SvgPicture.asset('lib/images/arrow_down.svg',
                width: 50, height: 50),
            animate
                ? TweenAnimationBuilder(
                    curve: Curves.decelerate,
                    duration: Duration(seconds: 3),
                    tween: Tween<double>(begin: 0, end: angle),
                    builder: (BuildContext context, double size, Widget child) {
                      return Transform.rotate(
                          angle: size,
                          child: SizedBox(
                              height: 150,
                              child: CircleGraph(pieDataList: _inputList)));
                    },
                  )
                : SizedBox(
                    height: 200, child: CircleGraph(pieDataList: _inputList)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                    child: const Text('RESET'), onPressed: () => reset()),
                RaisedButton(
                    child: const Text('GO！'),
                    onPressed: () {
                      reset();
                      setState(() {
                        animate = true;
                        const min = 30;
                        const max = 50;
                        const digit = 10000;
                        angle += min +
                            Random().nextInt((max - min) * digit) / digit * pi;
                      });
                    }),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _itemCount,
              itemBuilder: (BuildContext context, int index) {
                return _buildInputItem(index, _inputList[index]);
              },
            ),
            IconButton(
              icon: Icon(Icons.add_outlined),
              onPressed: () {
                _add();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputItem(int index, PieData pieData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: TextEditingController(text: pieData.name),
              decoration: const InputDecoration(
                hintText: '名前',
              ),
              onChanged: (value) {
                _onChagne(index, name: value);
              },
            ),
          ),
          SizedBox(width: 12),
          Expanded(
              flex: 1,
              child: TextField(
                controller:
                    TextEditingController(text: '${pieData.percentage}'),
                onChanged: (value) {
                  _onChagne(index, percentage: double.parse(value));
                },
                decoration: const InputDecoration(
                  hintText: '割合',
                ),
                keyboardType: TextInputType.number,
              )),
          SizedBox(width: 12),
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: () {
              _remove(index);
            },
          ),
        ],
      ),
    );
  }
}
