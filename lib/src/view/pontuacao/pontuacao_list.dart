import 'package:flutter/material.dart';

class PontuacaoList extends StatefulWidget {
  PontuacaoList({
    Key? key,
    required this.team,
    required this.upperPoints,
    required this.underPoints,
  }) : super(key: key);

  final String team;
  final List<int> upperPoints;
  final List<List<int>> underPoints;

  @override
  State<PontuacaoList> createState() => _PontuacaoListState();
}

class _PontuacaoListState extends State<PontuacaoList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.team,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(indent: 8, endIndent: 8, height: 0),
                Expanded(
                  flex: widget.underPoints.length,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      direction: Axis.vertical,
                      textDirection: TextDirection.rtl,
                      children: widget.upperPoints
                          .map(
                            (e) => Text(e.toString()),
                          )
                          .toList(),
                    ),
                  ),
                ),
                ...buildUnderPoints(),
                const Divider(indent: 8, endIndent: 8, height: 0),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade300,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Upper: ${totalUpperPoints()}'),
              const SizedBox(height: 4),
              Text('Set 1: ${totalUnderPoints(0)}'),
              const SizedBox(height: 4),
              Text('Set 2: ${totalUnderPoints(1)}'),
              const SizedBox(height: 4),
              Text('Set 3: ${totalUnderPoints(2)}'),
              const SizedBox(height: 4),
              Text('Total: ${grandTotal()}'),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> buildUnderPoints() {
    var widgets = <Widget>[];
    widget.underPoints.forEach((roundUnderPoints) {
      widgets.add(const Divider(indent: 8, endIndent: 8, height: 0));
      widgets.add(Expanded(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            direction: Axis.vertical,
            textDirection: TextDirection.rtl,
            children: roundUnderPoints
                .map(
                  (e) => Text(e.toString()),
                )
                .toList(),
          ),
        ),
      ));
    });

    return widgets;
  }

  int totalUpperPoints() {
    int total = widget.upperPoints.fold(0, (value, element) => value + element);
    return total;
  }

  int totalUnderPoints(int i) {
    int total =
        widget.underPoints[i].fold(0, (value, element) => value + element);
    return total;
  }

  int grandTotal() {
    var total = 0;
    total = totalUpperPoints() +
        totalUnderPoints(0) +
        totalUnderPoints(1) +
        totalUnderPoints(2);
    return total;
  }
}
