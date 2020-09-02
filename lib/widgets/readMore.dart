import 'package:flutter/material.dart';

class ReadMoreFunction extends StatefulWidget {
  final String text;
  final Color color;
  ReadMoreFunction(this.text, {this.color});

  @override
  _ReadMoreFunctionState createState() => _ReadMoreFunctionState();
}

class _ReadMoreFunctionState extends State<ReadMoreFunction>
    with TickerProviderStateMixin<ReadMoreFunction> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorOfReadMore = widget.color != null ? widget.color : Colors.black;
    return Column(children: <Widget>[
      AnimatedSize(
          vsync: this,
          duration: const Duration(milliseconds:10),
          child: ConstrainedBox(
              constraints: isExpanded
                  ? BoxConstraints()
                  : BoxConstraints(maxHeight: 50.0),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  widget.text,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ))),
      GestureDetector(
          child: Text('${isExpanded ? 'Show less' : 'Read more'}',
              style: TextStyle(color: colorOfReadMore)),
          onTap: () => setState(() => isExpanded = !isExpanded))
    ]);
  }
}
