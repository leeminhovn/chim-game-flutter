import 'package:flutter/material.dart';

class TableRank extends StatefulWidget

 {
  const TableRank({super.key});

  @override
  State<StatefulWidget> createState() => _TableRank();
}

class _TableRank extends State<TableRank> 
with TickerProviderStateMixin, AutomaticKeepAliveClientMixin
{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('build here');
    return Text('123');
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
