import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../c/dimen_constant.dart';

class UIUtils {
  static AppBar getAppBar(
    String text,
    VoidCallback? onPressed,
    VoidCallback? onPressCodeViewer, {
    Color backgroundColor = Colors.purple,
  }) {
    Widget buildActionWidget() {
      if (onPressCodeViewer == null) {
        return Container();
      } else {
        return IconButton(
          icon: const Icon(
            Icons.code,
            color: Colors.white,
          ),
          onPressed: onPressCodeViewer,
        );
      }
    }

    return AppBar(
      title: Text(text),
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),

      //add action on appbar
      actions: [
        buildActionWidget(),
      ],
      backgroundColor: backgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  static Widget getButton(
    String text,
    VoidCallback? onPressed, {
    double marginTop = DimenConstants.marginPaddingMedium,
  }) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      height: DimenConstants.buttonHeight * 1.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimenConstants.radiusMedium),
            side: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
              width: 0.5,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: DimenConstants.txtMedium,
                ),
              ),
            ),
            const SizedBox(width: DimenConstants.marginPaddingMedium),
            const Icon(
              Icons.double_arrow,
            ),
          ],
        ),
      ),
    );
  }

  static OutlinedButton getOutlineButton(
    String text,
    VoidCallback? onPressed,
  ) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: const BorderSide(
          width: 2.0,
          color: Colors.red,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimenConstants.radiusRound),
        ),
      ),
      child: Text(text),
    );
  }

  static Text getText(String text) {
    return Text(
      text,
      style: UIUtils.getStyleText(),
    );
  }

  static TextStyle getStyleText() {
    return const TextStyle(
      color: Colors.black,
      fontSize: DimenConstants.txtMedium,
    );
  }

  static TextStyle getCustomFontTextStyle() {
    return const TextStyle(
      color: Colors.blueAccent,
      fontFamily: 'Pacifico',
      fontWeight: FontWeight.w400,
      fontSize: 36.0,
    );
  }

  static LinearGradient getCustomGradient() {
    return const LinearGradient(
      colors: [Colors.pink, Colors.blueAccent],
      begin: FractionalOffset(0.0, 0.0),
      end: FractionalOffset(0.6, 0.0),
      stops: [0.0, 0.6],
      tileMode: TileMode.clamp,
    );
  }

  static CircularProgressIndicator getCircularProgressIndicator(Color color) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color),
    );
  }

  static Future sleep(int timeInSecond, Function? function) {
    return Future.delayed(
      Duration(seconds: timeInSecond),
      () => function?.call(),
    );
  }

  static void showAlertDialog(
    BuildContext context,
    String title,
    String message,
    String? cancelTitle,
    VoidCallback? cancelAction,
    String okTitle,
    VoidCallback? okAction,
  ) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff232426),
          ),
        ),
        title: Text(title),
        actions: [
          if (cancelTitle != null)
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Get.back();
                cancelAction?.call();
              },
              child: Text(
                cancelTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff0A79F8),
                ),
              ),
            ),
          CupertinoDialogAction(
            child: Text(
              okTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xffFF0000),
              ),
            ),
            onPressed: () {
              Get.back();
              okAction?.call();
            },
          ),
        ],
      ),
    );
  }

  static void showErrorDialog(
    BuildContext context,
    String title,
    String message,
    String okTitle,
    VoidCallback? okCallback,
  ) {
    showAlertDialog(
      context,
      title,
      message,
      null,
      null,
      okTitle,
      okCallback,
    );
  }

  static void showSnackBar(
    String title,
    String message,
  ) {
    Get.snackbar(
      title, // title
      message, // message
      // barBlur: 20,
      isDismissible: true,
      duration: const Duration(seconds: 3),
    );
  }

  static void showDialogSuccess(
    BuildContext context,
    String msg,
    VoidCallback? onClickConfirm,
  ) {
    showGeneralDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            width: 300,
            margin: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(DimenConstants.radiusMedium),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: DimenConstants.marginPaddingMedium),
                AvatarGlow(
                  glowColor: Colors.green,
                  endRadius: 60,
                  duration: const Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  child: Image.asset(
                    "assets/images/ic_success.png",
                    height: 60,
                    width: 60,
                  ),
                ),
                // SizedBox(height: DimenConstants.marginPaddingMedium),
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff232426),
                  ),
                ),
                const SizedBox(height: DimenConstants.radiusMedium),
                const Divider(
                  color: Color(0xffC8C8CA),
                  height: 1,
                ),
                SizedBox(
                  width: double.infinity,
                  height: DimenConstants.heightButton,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xff0A79F8),
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      // backgroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                      onClickConfirm?.call();
                    },
                    child: const Text(
                      "Đóng",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: anim,
            curve: Curves.bounceIn,
            reverseCurve: Curves.bounceIn,
          ),
          child: child,
        );
      },
    );
  }

  static Widget buildHorizontalDivider(
      Color color, double width, double height) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      height: height,
      width: width,
      color: color,
    );
  }

  static Widget buildVerticalDivider(Color color, double height) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      height: height,
      width: 1,
      color: color,
    );
  }

  static void showFullWidthSnackBar(String title, String message,
      {bool isTop = true}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      duration: const Duration(seconds: 2),
      titleText: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color(0xff232426),
        ),
      ),
      icon: const Image(
        image: AssetImage('assets/images/ic_check_mark_green.png'),
        width: 20,
        height: 15,
      ),
      backgroundColor: const Color.fromARGB(255, 212, 245, 217),
      snackStyle: SnackStyle.GROUNDED,
      margin: EdgeInsets.zero,
      colorText: const Color.fromARGB(255, 35, 36, 38),
      snackPosition: isTop ? SnackPosition.TOP : SnackPosition.BOTTOM,
    );
  }

  static void showFullWidthSnackBarError(String title, String message,
      {bool isTop = true}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      duration: const Duration(seconds: 2),
      titleText: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color(0xff232426),
        ),
      ),
      icon: const Image(
        image: AssetImage('assets/images/ic_x.png'),
        width: 20,
        height: 20,
        color: Color(0xffF13232),
      ),
      backgroundColor: const Color(0xffFFDFDF),
      snackStyle: SnackStyle.GROUNDED,
      margin: EdgeInsets.zero,
      colorText: const Color(0xff232426),
      snackPosition: isTop ? SnackPosition.TOP : SnackPosition.BOTTOM,
    );
  }
}
