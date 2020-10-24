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
    final itemCount = 5;
    final pieDataList = [
      new PieData('Work', 5),
      new PieData('Eat', 10),
      new PieData('TV', 35),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            SvgPicture.asset('lib/images/arrow_down.svg',
                width: 50, height: 50),
            SizedBox(height: 200, child: CircleGraph(pieDataList: pieDataList)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int index) {
                return _buildInputItem();
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

  Widget _buildInputItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
                decoration: const InputDecoration(
              hintText: '名前',
            )),
          ),
          SizedBox(width: 12),
          Expanded(
              flex: 1,
              child: TextField(
                  onChanged: (value) {},
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
