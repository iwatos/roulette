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
  var _inputList = [
    PieData('1', 33),
    PieData('2', 33),
    PieData('3', 33),
  ];
  void functionCalledByAnyone() {
    setState(() {
      _inputList.add(PieData('4', 33));
    });
  }

  var _itemCount = 3;

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

  Widget _buldBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            SvgPicture.asset('lib/images/arrow_down.svg',
                width: 50, height: 50),
            SizedBox(height: 200, child: CircleGraph(pieDataList: _inputList)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _itemCount,
              itemBuilder: (BuildContext context, int index) {
                return _buildInputItem(index);
              },
            ),
            IconButton(
              icon: Icon(Icons.add_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
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
                controller: new TextEditingController(text: 'aaa'),
                decoration: const InputDecoration(
                  hintText: '名前',
                )),
          ),
          SizedBox(width: 12),
          Expanded(
              flex: 1,
              child: TextField(
                  onChanged: (value) {
                    functionCalledByAnyone();
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    hintText: '%',
                  ))),
          SizedBox(width: 12),
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
