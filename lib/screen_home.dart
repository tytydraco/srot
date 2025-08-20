import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:srot/storage.dart';
import 'package:srot/substance.dart';
import 'package:srot/substance_tile.dart';

/// The home screen.
class ScreenHome extends StatefulWidget {
  /// Creates a new [ScreenHome].
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  Future<void> _addSubstance() async {
    final nameController = TextEditingController();
    final daysBetweenController = TextEditingController();

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add'),
        content: Column(
          spacing: 4,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Substance name',
              ),
              keyboardType: TextInputType.name,
            ),
            TextFormField(
              controller: daysBetweenController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Days between',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final substance = Substance(
                name: nameController.text,
                daysBetween: int.parse(daysBetweenController.text),
              );
              await addSubstance(substance);
              setState(() {});

              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  Future<void> _removeSubstance(Substance substance) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Remove'),
        content: Column(
          spacing: 4,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Are you sure you want to remove ${substance.name}?'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await removeSubstance(substance);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Srot'),
      ),
      body: FutureBuilder(
        future: getSubstances(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData && asyncSnapshot.data!.isNotEmpty) {
            final substances = asyncSnapshot.data!;

            return GridView.count(
              padding: const EdgeInsets.all(8),
              childAspectRatio: 0.75,
              crossAxisCount: 2,
              children: substances
                  .map(
                    (e) => SubstanceTile(
                      substance: e,
                      onTap: () async {
                        await updateSubstance(e);
                        setState(() {});
                      },
                      onLongPress: () async {
                        await _removeSubstance(e);
                        setState(() {});
                      },
                    ),
                  )
                  .toList(),
            );
          } else {
            return const Center(
              child: Text('Nothing to show.'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSubstance,
        child: const Icon(Icons.add),
      ),
    );
  }
}
