import 'package:bridge_counter/src/model/historic_results.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoricResultTile extends StatelessWidget {
  const HistoricResultTile({Key? key, required this.result, this.locale})
      : super(key: key);

  final HistoricResult result;
  final String? locale;

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat.yMd(locale).add_Hm();
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 48,
                  child: result.points1 > result.points2
                      ? Icon(Icons.check)
                      : Container(),
                ),
                Text(
                  "${result.team1}  ${result.points1}  x  ${result.points2}  ${result.team2}",
                ),
                SizedBox(
                  width: 48,
                  child: result.points2 > result.points1
                      ? Icon(Icons.check)
                      : Container(),
                ),
              ],
            ),
            Text(dateFormat.format(result.date), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
