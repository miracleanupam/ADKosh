import 'package:flutter/material.dart';

class NoResults extends StatelessWidget {
  const NoResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: Text(
        'यहाँ केहि भेटिएन :(',
        style: Theme.of(context).textTheme.displaySmall,
      ),
    ));
  }
}
