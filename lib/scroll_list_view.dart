import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class ScrollListView extends StatefulWidget {
  const ScrollListView({
    Key key,
    @required this.items,
    @required this.itemBuilder,
    this.index = 0,
    this.scrollDirection = Axis.horizontal,
    this.autoScroll = true,
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
  final bool autoScroll;
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
      if (_allowEvents && widget.autoScroll) itemScrollController.scrollTo(
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