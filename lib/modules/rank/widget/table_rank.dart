import 'dart:math';
import 'package:chim_kha/component/data/dtos/rank/rank_users.dart';
import 'package:flutter/material.dart';

class TableRank extends StatefulWidget {
  final String urlCall;
  const TableRank({super.key, required this.urlCall});

  @override
  State<StatefulWidget> createState() => _TableRank();
}

class _TableRank extends State<TableRank>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final List<UserRankDto> _data = [];

  @override
  void initState() {
    for (int i = 0; i < 20; i++) {
      _data.add(UserRankDto('user number $i', Random().nextInt(10000),
          Random().nextInt(100000000), 'asd'));
    }
    print(_data);
    super.initState();
  }

  Widget build(BuildContext context) {
    super.build(context);

    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return RenderUserRank(index, _data[index]);
        });
  }

  @override
  bool get wantKeepAlive => true;
}

class RenderUserRank extends StatelessWidget {
  final int _statusRank;
  final UserRankDto _data;
  const RenderUserRank(
    int status,
    UserRankDto dataUser, {
    super.key,
  })  : _data = dataUser,
        _statusRank = status;

  @override
  Widget build(BuildContext context) {
    switch (_statusRank) {
      case 0:
        return BaseCard(
          colorCard: const Color(0xffffcb08),
          boxShadow:
              const BoxShadow(offset: Offset(0, 5), color: Color(0xfff8ad3e)),
          avatar: image,
          children: _renderLeft(_data.name, _data.record),
        );
      case 1:
        return BaseCard(
          colorCard: Color(0xffffd7de),
          boxShadow:
              const BoxShadow(offset: Offset(0, 5), color: Color(0xfff7b8c3)),
          avatar: image,
          children: _renderLeft(_data.name, _data.record),
        );
      default:
        return BaseCard(
          colorCard: const Color.fromARGB(255, 255, 255, 255),
          boxShadow:
              const BoxShadow(offset: Offset(0, 5), color: Color(0xfff2f2f2)),
          avatar: image,
          children: _renderLeft(_data.name, _data.record),
        );
    }
  }

  Widget _renderLeft(String name, int points) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(
              color: Color(0xff6d3919), fontWeight: FontWeight.w600),
        ),
        Text(
          points.toString(),
          style: const TextStyle(color: Color(0xff6d3919), fontSize: 20),
        )
      ],
    );
  }
}

class BaseCard extends StatefulWidget {
  final Widget children;
  final Color colorCard;
  final BoxShadow boxShadow;
  final String avatar;
  const BaseCard(
      {super.key,
      required this.children,
      required this.colorCard,
      required this.boxShadow,
      required this.avatar});

  @override
  State<StatefulWidget> createState() => _BaseCard();
}

class _BaseCard extends State<BaseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: widget.colorCard,
          boxShadow: [widget.boxShadow]),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0, left: 10, right: 15),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50 / 2),
                border: Border.all(color: Colors.green, width: 3)),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(45 / 2),
                ),
                child: Image.network(image)),
          ),
          widget.children
        ],
      ),
    );
  }
}

const String image =
    'https://mochidemy.com/kana/_next/image?url=https%3A%2F%2Fkana-api.mochidemy.com%2Fstorage%2Flessons%2Fimage_kana01.jpg&w=256&q=75';
