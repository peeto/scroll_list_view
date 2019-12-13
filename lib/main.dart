import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

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
                    );
                  } else {
                    return FlatButton(
                      child: Text('Item $index'),
                      onPressed: () {
                        setState(() {
                          currentitem = index;
                        });
                      },
                    );
                  }
                },
                index: currentitem,
                scrollDirection: Axis.horizontal,
                prefixWidget: GestureDetector(
                  child: Icon(
                    Icons.arrow_left,
                  ),
                  onTap: () {
                    if (currentitem > 0) {
                      setState(() {
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

class ScrollListView extends StatefulWidget {
  const ScrollListView({
    Key key,
    @required this.items,
    @required this.itemBuilder,
    this.index = 0,
    this.scrollDirection = Axis.horizontal,
    this.prefixWidget,
    this.suffixWidget,
    this.animationDelay = const Duration(
      seconds: 1,
    ),
  }) : super(key: key);

  final List items;
  final IndexedWidgetBuilder itemBuilder;
  final int index;
  final Axis scrollDirection;
  final Widget prefixWidget;
  final Widget suffixWidget;
  final Duration animationDelay;

  @override
  ScrollListViewState createState() => ScrollListViewState();
}

class ScrollListViewState extends State<ScrollListView> {
  ItemScrollController itemScrollController = ItemScrollController();
  bool _allowEvents = false;

  @override
  void initState() {
    _allowEvents = false;
    super.initState();
    itemScrollController = ItemScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _allowEvents = true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.scrollDirection == Axis.horizontal) {

      return Row(
        children: _content(),
      );

    } else {

      return Column(
        children: _content(),
      );

    }

  }

  List<Widget> _content() {
    if (_allowEvents) itemScrollController.scrollTo(
      index: widget.index,
      duration: widget.animationDelay,
    );

    return <Widget>[

      if (widget.prefixWidget != null) widget.prefixWidget,

      Expanded(
        child: ScrollablePositionedList.builder(
          scrollDirection: widget.scrollDirection,
          initialScrollIndex: widget.index,
          itemCount: widget.items.length,
          itemScrollController: itemScrollController,
          itemBuilder: (context, index) {
            return widget.itemBuilder(context, index);
          },
        ),
      ),

      if (widget.suffixWidget != null) widget.suffixWidget,

    ];
  }

}