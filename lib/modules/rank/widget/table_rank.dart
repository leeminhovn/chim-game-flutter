import 'package:flutter/material.dart';

class TableRank extends StatefulWidget {
  final String urlCall;
  const TableRank({super.key, required this.urlCall});

  @override
  State<StatefulWidget> createState() => _TableRank();
}

class _TableRank extends State<TableRank>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return const Text('123');
  }

  @override
  bool get wantKeepAlive => true;
}
