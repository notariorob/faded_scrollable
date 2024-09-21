import 'package:faded_scrollable/faded_scrollable.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Faded Scrollable Demo',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SafeArea(
            child: FadedScrollable(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 40,
                itemBuilder: (context, index) => ListTile(
                  minTileHeight: 32,
                  minVerticalPadding: 0,
                  dense: true,
                  title: Text('Title $index'),
                  subtitle: Text('Subtitle $index'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
