import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roulette/circle_graph.dart';

void main() {
  runApp(RouletteApp());
}

class RouletteApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TopPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class TopPage extends StatefulWidget {
  TopPage({Key key, this.title}) : super(key: key);
  final String title;
  final itemCount = 3;
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            SvgPicture.asset('lib/images/arrow_down.svg',
                width: 50, height: 50),
            SizedBox(height: 200, child: CircleGraph()),
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: 2,
            //   itemBuilder: (BuildContext context, int index) {
            //     return _buildInputItem();
            //   },
            // ),
            Column(
              children: [
                _buildInputItem(),
                _buildInputItem(),
                _buildInputItem()
              ],
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
