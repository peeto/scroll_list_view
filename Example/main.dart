import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import '../lib/scroll_list_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrollable Indexable List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScrollTest(),
    );
  }
}

class ScrollTest extends StatefulWidget {
  const ScrollTest({Key key}) : super(key: key);

  @override
  ScrollTestState createState() => ScrollTestState();
}

class ScrollTestState extends State<ScrollTest> {
  ItemScrollController itemScrollController;
  int currentitem = 75;
  int numitems = 100;
  bool autoScroll = true;
  Duration delay = Duration(
      seconds: 1
  );

  @override
  void initState() {
    itemScrollController = ItemScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          Text('\n\nApp heading\n'),

          Container(
            height: 40,
            child: ScrollListView(
                items: List.generate(numitems, (i) => i),
                itemBuilder: (context, index) {
                  if (index==currentitem) {
                    return RaisedButton(
                      child: Text('Item $index'),
                      onPressed: () => print('Clicked on item  $index'),
                    );
                  } else {
                    return FlatButton(
                      child: Text('Item $index'),
                      onPressed: () {
                        setState(() {
                          autoScroll = false;
                          currentitem = index;
                        });
                      },
                    );
                  }
                },
                index: currentitem,
                scrollDirection: Axis.horizontal,
                autoScroll: autoScroll,
                prefixWidget: GestureDetector(
                  child: Icon(
                    Icons.arrow_left,
                  ),
                  onTap: () {
                    if (currentitem > 0) {
                      setState(() {
                        autoScroll = true;
                        currentitem--;
                      });
                    }
                  },
                ),
                suffixWidget: GestureDetector(
                  child: Icon(
                    Icons.arrow_right,
                  ),
                  onTap: () {
                    if (currentitem < numitems) {
                      setState(() {
                        autoScroll = true;
                        currentitem++;
                      });
                    }
                  },
                ),
                animationDelay: Duration(
                  milliseconds: 200,
                ),
              ),

            ),

          Expanded(
            flex: 9,
            child: Center(
              child: Text('App Content'),
            ),
          ),

        ],

      ),
    );
  }
}
