import 'package:feather/src/models/internal/application_error.dart';
import 'package:feather/src/resources/config/app_const.dart';
import 'package:feather/src/resources/config/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetHelper {
  static Padding buildPadding(
      {double left = 0, double top = 0, double right = 0, double bottom = 0}) {
    return Padding(
        padding: buildEdgeInsets(
            left: left, top: top, right: right, bottom: bottom));
  }

  static EdgeInsets buildEdgeInsets(
      {double left = 0, double top = 0, double right = 0, double bottom = 0}) {
    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  static LinearGradient buildGradient(Color startColor, Color endColor) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.2, 0.99],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        startColor,
        endColor,
      ],
    );
  }

  static Widget buildProgressIndicator() {
    return Center(
        key: Key("progress_indicator"),
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        ));
  }

  static Widget buildErrorWidget(BuildContext context,
      ApplicationError applicationError, VoidCallback voidCallback) {
    String errorText = "";
    if (applicationError == ApplicationError.locationNotSelectedError) {
      errorText = Strings.errorLocationNotSelected;
    } else if (applicationError == ApplicationError.connectionError) {
      errorText = Strings.errorServerConnection;
    } else if (applicationError == ApplicationError.apiError) {
      errorText = Strings.errorServer;
    } else {
      errorText = Strings.unknownError;
    }
    return Directionality(
      textDirection: TextDirection.ltr,
        child: Center(
            key: Key("error_widget"),
            child: SizedBox(
                width: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      errorText,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                    ),
                    FlatButton(
                      child: Text("Retry",
                          style: Theme.of(context).textTheme.subtitle),
                      onPressed: voidCallback,
                    )
                  ],
                ))));
  }

  static LinearGradient buildGradientBasedOnDayCycle(int sunrise, int sunset) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int sunriseMs = sunrise * 1000;
    int sunsetMs = sunset * 1000;
    if (currentTime > sunriseMs && currentTime < sunsetMs) {
      return buildGradient(
          AppConst.dayStartGradientColor, AppConst.dayEndGradientColor);
    } else {
      return buildGradient(
          AppConst.nightStartGradientColor, AppConst.nightEndGradient);
    }
  }

  static LinearGradient getGradient({sunriseTime = 0, sunsetTime = 0}) {
    if (sunriseTime == 0 && sunsetTime == 0) {
      return WidgetHelper.buildGradient(
          AppConst.nightStartGradientColor, AppConst.nightEndGradient);
    } else {
      return buildGradientBasedOnDayCycle(sunriseTime, sunsetTime);
    }
  }
}
