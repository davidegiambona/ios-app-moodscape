import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/mood.dart';

class StatsScreen extends StatelessWidget {
  final List<Mood> moodNotes;

  StatsScreen({required this.moodNotes});

  @override
  Widget build(BuildContext context) {
    final moodCounts = _calculateMoodCounts(moodNotes);
    final List<ChartData> chartData = moodCounts.entries
        .map((entry) => ChartData(entry.key, entry.value))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Statistiche Umore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  axisLine: AxisLine(
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.black,
                  ),
                  labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                primaryYAxis: NumericAxis(
                  axisLine: AxisLine(
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.black,
                  ),
                  labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                series: <ChartSeries<ChartData, String>>[
                  BarSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.mood,
                    yValueMapper: (ChartData data, _) => data.count,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Distribuzione degli umori',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, int> _calculateMoodCounts(List<Mood> notes) {
    final counts = <String, int>{};
    for (var note in notes) {
      counts[note.description] = (counts[note.description] ?? 0) + 1;
    }
    return counts;
  }
}

class ChartData {
  final String mood;
  final int count;

  ChartData(this.mood, this.count);
}
