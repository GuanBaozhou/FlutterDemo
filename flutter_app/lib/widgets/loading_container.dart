import 'package:flutter/material.dart';

//加载进度条
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool isCover;

  const LoadingContainer(
      {Key key,
      @required this.isLoading,
      this.isCover = false,
      @required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return !isCover
        ? !isLoading ? child : _loadView
        : Stack(
            children: <Widget>[child, isLoading ? _loadView : null],
          );
  }

  Widget get _loadView {
    return Center(child: CircularProgressIndicator(),);
  }
}
