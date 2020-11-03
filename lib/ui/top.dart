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
  static const initValue = 1.0;
  @override
  initState() {
    super.initState();
    _inputList = [
      PieData(WordPair.random().first, initValue),
      PieData(WordPair.random().first, initValue),
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
      _inputList.add(PieData(WordPair.random().first, initValue));
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildItems(),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () {
                _add();
              },
            ),
            SvgPicture.asset(
              'lib/images/arrow_down.svg',
              height: 50,
            ),
            _buildCircleGraph(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildItems() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _itemCount,
      itemBuilder: (BuildContext context, int index) {
        return _buildInputItem(index);
      },
    );
  }

  Widget _buildCircleGraph() {
    final height = 200.0;
    return animate
        ? TweenAnimationBuilder(
            curve: Curves.decelerate,
            duration: Duration(seconds: 3),
            tween: Tween<double>(begin: 0, end: angle),
            builder: (BuildContext context, double size, Widget child) {
              return Transform.rotate(
                  angle: size,
                  child: SizedBox(
                      height: height,
                      child: CircleGraph(pieDataList: _inputList)));
            },
          )
        : SizedBox(height: height, child: CircleGraph(pieDataList: _inputList));
  }

  Row _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RaisedButton(child: const Text('回転リセット'), onPressed: () => reset()),
        RaisedButton(
            child: const Text('回す'),
            onPressed: () {
              setState(() {
                animate = true;
                const min = 50;
                const max = 55;
                const digit = 1000;
                angle += (min * digit + Random().nextInt((max - min) * digit)) /
                    digit;
              });
            }),
      ],
    );
  }

  Widget _buildInputItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              decoration: const InputDecoration(
                hintText: '名前',
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _onChagne(index, name: value);
                }
              },
            ),
          ),
          SizedBox(width: 12),
          Expanded(
              flex: 1,
              child: TextField(
                onChanged: (value) {
                  try {
                    final percentage = double.parse(value);
                    _onChagne(index, percentage: percentage);
                  } catch (e) {
                    print(e);
                  }
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
