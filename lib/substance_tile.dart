import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:srot/substance.dart';

/// A tile for a [Substance].
class SubstanceTile extends StatefulWidget {
  /// Creates a new [SubstanceTile].
  const SubstanceTile({
    required this.substance,
    required this.onTap,
    required this.onLongPress,
    super.key,
  });

  /// The [Substance] to use.
  final Substance substance;

  /// The callback function.
  final void Function() onTap;

  /// The callback function to delete.
  final void Function() onLongPress;

  @override
  State<SubstanceTile> createState() => _SubstanceTileState();
}

class _SubstanceTileState extends State<SubstanceTile> {
  String _getLastUsedDateStr() {
    if (widget.substance.lastUsed != null) {
      final date =
          DateTime.fromMillisecondsSinceEpoch(widget.substance.lastUsed!);
      return DateFormat('MMM d, y').add_jm().format(date);
    } else {
      return 'TBA';
    }
  }

  String _getFutureAllowDateStr() {
    if (widget.substance.lastUsed != null) {
      final futureAllowDate =
          DateTime.fromMillisecondsSinceEpoch(widget.substance.lastUsed!)
              .add(Duration(days: widget.substance.daysBetween));
      return DateFormat('MMM d, y').add_jm().format(futureAllowDate);
    } else {
      return DateFormat('MMM d, y').add_jm().format(DateTime.now());
    }
  }

  double _normalize(int min, int max, int value) {
    return (value - min) / (max - min);
  }

  double _getProgressValue() {
    final lastUsed = widget.substance.lastUsed;
    if (lastUsed == null) return 1;

    final lastUsedDate = DateTime.fromMillisecondsSinceEpoch(lastUsed);
    final futureAllowDate =
        lastUsedDate.add(Duration(days: widget.substance.daysBetween));

    final now = DateTime.now();

    final min = lastUsedDate.millisecondsSinceEpoch;
    final max = futureAllowDate.millisecondsSinceEpoch;

    if (min == max) return 1;

    final value = _normalize(
      min,
      max,
      now.millisecondsSinceEpoch,
    );

    return value;
  }

  @override
  Widget build(BuildContext context) {
    final progressValue = _getProgressValue();
    final progressColor = (progressValue == 1) ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: const Icon(Icons.medical_information),
                title: Text(
                  widget.substance.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.timelapse),
                title: Text('${widget.substance.daysBetween} days'),
              ),
              ListTile(
                leading: const Icon(Icons.skip_previous),
                title: Text(_getLastUsedDateStr()),
              ),
              ListTile(
                leading: const Icon(Icons.skip_next),
                title: Text(_getFutureAllowDateStr()),
              ),
              ListTile(
                leading: const Icon(Icons.watch_later),
                title: LinearProgressIndicator(
                  value: progressValue,
                  color: progressColor,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
