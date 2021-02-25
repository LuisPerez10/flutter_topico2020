import 'package:flutter/material.dart';

class CurstomLoading extends StatefulWidget {
  CurstomLoading({Key key}) : super(key: key);

  @override
  _CurstomLoadingState createState() => _CurstomLoadingState();
}

class _CurstomLoadingState extends State<CurstomLoading>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  // final dynamic _colorTween;
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);

    // _colorTween = _animationController
    //     .drive(ColorTween(begin: Colors.yellow, end: Colors.green));
    _animationController.repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: _animationController.drive(ColorTween(
            begin: Theme.of(context).primaryColor,
            end: Color.fromARGB(255, 29, 161, 243))),
      ),
    );
  }
}
