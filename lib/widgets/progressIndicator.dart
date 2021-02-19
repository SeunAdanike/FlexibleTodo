import 'package:flexibletodo/models/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressIndicator extends StatefulWidget {
  final int percentage;
  final String dayName;
  final String dayMonth;

  ProgressIndicator({
    @required this.percentage,
    @required this.dayName,
    @required this.dayMonth,
  });
  @override
  _ProgressIndicatorState createState() => _ProgressIndicatorState(
        percentage,
        dayName,
        dayMonth,
      );
}

class _ProgressIndicatorState extends State<ProgressIndicator> {
  int _percentage;
  String _dayName;
  String _dayMonth;

  _ProgressIndicatorState(
    this._percentage,
    this._dayName,
    this._dayMonth,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearPercentIndicator(
          curve: Curves.easeIn,
          width: 150.0,
          animation: true,
          animationDuration: 2000,
          lineHeight: 10.0,
          percent: (_percentage / 100),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: (_percentage <= 30)
              ? barColors['red']
              : (_percentage <= 50)
                  ? barColors['yellow']
                  : (_percentage <= 80)
                      ? barColors['yellowish']
                      : (_percentage <= 99)
                          ? barColors['greenish']
                          : barColors['green'],
        ),
        Text(
          _dayName,
          style: GoogleFonts.ubuntu(
            fontSize: 13,
          ),
        ),
        Text(
          _dayMonth,
          style: GoogleFonts.ubuntu(
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
