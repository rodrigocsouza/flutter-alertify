library alertify;

import 'package:flutter/material.dart';
import './src/animation_transition.dart';
import './src/constants.dart';

export './src/constants.dart';

class Alertify {
  final BuildContext context;
  final bool isDismissible;
  final AlertifyType alertType;
  final String content;
  final String title;
  final String buttonText;
  final AnimationType animationType;
  final Object destino;

  Alertify(
      {@required this.context,
      @required this.isDismissible,
      this.alertType,
      @required this.content,
      this.title,
      this.buttonText,
      this.animationType,
      this.destino});

  Future show() async {
    showGeneralDialog(
        useRootNavigator: false,
        //routeSettings: new RouteSettings( name: "/home" ),
        barrierDismissible: true,
        context: context,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return _buildDialog();
        },
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.grey.withOpacity(0.2),
        transitionDuration: Duration(milliseconds: 250),
        transitionBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) =>
            _buildAnimation(animation, secondaryAnimation, child));
  }

  Widget _buildDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      insetAnimationCurve: Curves.easeInOutCubic,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildIcon(),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '${this.title}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Muli',
                      fontSize: 22,
                      color: Colors.black87),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${this.content}',
                  style: TextStyle(fontSize: 16, fontFamily: 'Muli'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          _buildButton()
        ],
      ),
    );
  }

  Widget _buildIcon() {
    Widget icon =
        Icon(Icons.check_circle_outline, size: 72, color: Colors.green);

    switch (this.alertType) {
      case AlertifyType.success:
        icon = Icon(Icons.check_circle_outline, size: 72, color: Colors.green);
        break;
      case AlertifyType.error:
        icon = Icon(Icons.error_outline, size: 72, color: Colors.redAccent);
        break;
      case AlertifyType.info:
        icon = Icon(Icons.info_outline, size: 72, color: Colors.blue);
        break;
      case AlertifyType.warning:
        icon = Icon(Icons.warning, size: 72, color: Colors.orange);
        break;
      case AlertifyType.none:
        icon = Container();
        break;
      default:
        icon = Icon(Icons.check_circle_outline, size: 72, color: Colors.green);
        break;
    }
    return icon;
  }

  Widget _buildButton() {
    Color buttonColor = Colors.green;
    switch (this.alertType) {
      case AlertifyType.success:
        buttonColor = Colors.green;
        break;
      case AlertifyType.error:
        buttonColor = Colors.red;
        break;
      case AlertifyType.info:
        buttonColor = Colors.blue;
        break;
      case AlertifyType.warning:
        buttonColor = Colors.orange;
        break;
      case AlertifyType.none:
        buttonColor = Colors.grey;
        break;
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Material(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              color: buttonColor,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                onTap: () {
                  print(
                      "***************************** F E C H A N D O *********************************");
                  if (destino == null) {
                    print("Destino está nulo!");
                    Navigator.pop(context);
                  } else {
                    print("Destino NÃO está nulo!");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => this.destino));
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Center(
                      child: Text(
                    '${this.buttonText}',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, fontFamily: 'Muli'),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildAnimation(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var anim;
    switch (this.animationType) {
      case AnimationType.leftToRight:
        anim =
            AnimationTransition.fromLeft(animation, secondaryAnimation, child);
        break;
      case AnimationType.rightToLeft:
        anim =
            AnimationTransition.fromRight(animation, secondaryAnimation, child);
        break;
      case AnimationType.topToBottom:
        anim =
            AnimationTransition.fromTop(animation, secondaryAnimation, child);
        break;
      case AnimationType.bottomToTop:
        anim = AnimationTransition.fromBottom(
            animation, secondaryAnimation, child);
        break;
      case AnimationType.inToOut:
        anim = AnimationTransition.grow(animation, secondaryAnimation, child);
        break;
      case AnimationType.outToIn:
        anim = AnimationTransition.shrink(animation, secondaryAnimation, child);
        break;
      default:
        AnimationTransition.grow(animation, secondaryAnimation, child);
        break;
    }
    return anim;
  }
}