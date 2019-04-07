import 'package:flutter/material.dart';
import 'package:flutter_app/pages/search_page.dart';
import 'package:flutter_app/plugin/asr_manager.dart';

//语音页面
class SpeakPage extends StatefulWidget {
  @override
  _SpeakPage createState() => _SpeakPage();
}

class _SpeakPage extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  String speackTips = "长按说话";
  String speackTipsResult = "";
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              animationController.forward();
            }
          });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(30),
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _topItem(),
            _bottomItem(),
          ],
        ),
      ),
    );
  }

  _topItem() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Text(
            "你可以这样说",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                decoration: TextDecoration.none),
          ),
        ),
        Text(
          "故宫门票\n北京一日游\n迪士尼乐园",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
              decoration: TextDecoration.none),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            speackTipsResult,
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }

  _speakStart() {
    animationController.forward();
    setState(() {
      speackTips = "- 识别中 -";
    });
    AsrManager.start().then((value) {
      print("aaaa"+value);
      if (value != null && value.length > 0) {
        setState(() {
          print("识别的结果是：${value}");
          speackTipsResult = value;
        });
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchPage(
                      keyword: value,
                    )));
      }
    }).catchError((e) {
      print("----------" + e.toString());
    });
  }

  _speakStop() {
    animationController.reset();
    animationController.stop();

    AsrManager.stop();
    setState(() {
      speackTips="长按说话";
    });
  }

  _bottomItem() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTapDown: (e) {
              _speakStart();
            },
            onTapUp: (e) {
              _speakStop();
            },
            onTapCancel: () {
              _speakStop();
            },
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      speackTips,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        //占位符， 防止下面的动画使文字移动
                        height: MIC_SIZE,
                        width: MIC_SIZE,
                        child: Center(
                          child: AnimatedMic(
                            animation: animation,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              right: 0,
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.clear,
                  color: Colors.grey,
                  size: 30,
                ),
              ))
        ],
      ),
    );
  }
}

const double MIC_SIZE = 80;

class AnimatedMic extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 1, end: 0.5);
  static final _sizeTween = Tween<double>(begin: MIC_SIZE, end: MIC_SIZE - 20);

  AnimatedMic({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    // TODO: implement build
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        height: _sizeTween.evaluate(animation),
        width: _sizeTween.evaluate(animation),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(MIC_SIZE / 2),
        ),
        child: Icon(
          Icons.mic,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
