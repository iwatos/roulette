import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roulette/circle_graph.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  var itemCount = 3;
  var piedata = [
    new PieData('Work', 35.8),
    new PieData('Eat', 8.3),
    new PieData('Commute', 10.8),
    new PieData('TV', 15.6),
    new PieData('Sleep', 19.2),
    new PieData('Other', 10.3),
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            IconButton(icon: Icon(Icons.add_outlined)),
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
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  hintText: '%',
                )),
          ),
          SizedBox(width: 12),
          IconButton(icon: Icon(Icons.remove_circle_outline)),
        ],
      ),
    );
  }
}
