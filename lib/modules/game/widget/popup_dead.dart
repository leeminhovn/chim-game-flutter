import 'package:chim_kha/component/resource/organisms/button_options.dart';
import 'package:chim_kha/config/router_name.dart';
import 'package:chim_kha/src/data/data_source/local/user_local_storge.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopupDead extends StatefulWidget {
  final int point;
  const PopupDead({required this.point, super.key});

  @override
  State<StatefulWidget> createState() => _PopupDead();
}

class _PopupDead extends State<PopupDead> {
  final int totalPointsLocal =
      int.parse(UserLocalStorge.store.getString("totalPoints") ?? '0');
      final int recordLocal =
        int.parse(UserLocalStorge.store.getString("reCord") ?? '0');
  @override
  void initState() {
    

    if (widget.point > recordLocal) {
      UserLocalStorge.store.setString('record', widget.point.toString());
    }
    UserLocalStorge.store
        .setString('totalPoints', (totalPointsLocal + widget.point).toString());
    super.initState();
  }

  @override
  Widget build(BuildContext contextBuilder) {
    final double screenWidth = MediaQuery.of(contextBuilder).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 230,
          child: Image.asset('assets/other/game_over.png'),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.all(6),
          constraints: BoxConstraints(maxWidth: screenWidth * 0.8),
          width: 300,
          decoration: BoxDecoration(
              color: const Color(0xffdbda96),
              border: Border.all(color: const Color(0xff523747), width: 4)),
          child: AspectRatio(
              aspectRatio: 16 / 8,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ModalResult(
                      title: 'Score',
                      point: widget.point,
                    ),
                     ModalResult(
                      title: 'Record',
                      point: recordLocal,
                    ),
                    ModalResult(
                      title: 'Total',
                      point: totalPointsLocal,
                    ),
                  ],
                ),
              )),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20),
          constraints: BoxConstraints(maxWidth: screenWidth * 0.8),
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonOptions(
                onTap: () {
                  context.go(ApplicationRouteName.dashboard);
                },
                text: 'Home',
              ),
              ButtonOptions(
                onTap: () {
                  context.pushReplacement(ApplicationRouteName.gamePlaySingle);
                },
                text: 'Again',
              )
            ],
          ),
        )
      ],
    );
  }
}

class ModalResult extends StatelessWidget {
  final int _point;
  final String _title;
  const ModalResult({super.key, int point = 0, required String title})
      : _point = point,
        _title = title;

  final TextStyle textLabel = const TextStyle(
    color: Color(0xffd2aa4f),
    fontSize: 23,
    fontWeight: FontWeight.bold,
    shadows: <Shadow>[
      Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 0.0,
        color: Color(0xfff1f0a5),
      ),
    ],
  );

  final TextStyle textValue = const TextStyle(
      color: Colors.white,
      fontSize: 29,
      fontFamily: 'Sabo',
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          _title,
          style: textLabel,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          _point.toString(),
          style: textValue,
        )
      ],
    );
  }
}
