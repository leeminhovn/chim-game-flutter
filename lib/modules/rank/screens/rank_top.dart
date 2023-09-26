import 'package:chim_kha/component/general/constant/enums.dart';
import 'package:chim_kha/component/resource/organisms/button_options.dart';
import 'package:chim_kha/modules/rank/widget/table_rank.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RankTop extends StatefulWidget {
  const RankTop({super.key});

  @override
  State<StatefulWidget> createState() => _RankTop();
}

class _RankTop extends State<RankTop>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(
        length: 2, initialIndex: PageRank.record.index, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(6),
          height: double.infinity,
          decoration: BoxDecoration(
              color: const Color(0xffdbda96),
              border: Border.all(color: const Color(0xff523747), width: 4)),
          child: Container(
            padding: const EdgeInsets.all(13),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Color(0xffd2aa4f), width: 2),
                    left: BorderSide(color: Color(0xffd2aa4f), width: 3),
                    bottom: BorderSide(color: Color(0xfff1f0a5), width: 2),
                    right: BorderSide(color: Color(0xfff1f0a5), width: 3))
                // #f1f0a5
                ),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Row(
                children: [
                  ButtonOptions(
                    onTap: () {
                      context.pop();
                    },
                    text: 'Back',
                  )
                ],
              ),
              _buildTabBar(context, _controller),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: const [
                    TableRank(),
                    TableRank(),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

Widget _buildTabBar(BuildContext context, TabController _controller) {
  return Container(
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
    child: Row(
      children: [
        Expanded(
          child: TabBar(
            controller: _controller,
            unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                fontFamily: 'Quicksand'),
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 19,
                fontFamily: 'Quicksand'),
            tabs: const [
              Tab(
                text: 'Record',
              ),
              Tab(
                text: 'Total points',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
