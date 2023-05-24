import 'package:flutter/material.dart';
import 'dart:math' show Random;
import 'dart:developer' as dev show log;

void main() {
  runApp(
    MaterialApp(
      title: 'demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var color1 = Colors.yellow;
  var color2 = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: AvailableColorsWidget(
        color1: color1,
        color2: color2,
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        color1 = colors.getRandomElement();
                      });
                    },
                    child: const Text('change color1')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        color2 = colors.getRandomElement();
                      });
                      
                    },
                    child: const Text('change color2')),
              ],
            ),
            const ColorWidget(color: AvailbleColor.one),
            const ColorWidget(color: AvailbleColor.two),
          ],
        ),
      ),
    );
  }
}

class ColorWidget extends StatelessWidget {
  final AvailbleColor color;

  const ColorWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case AvailbleColor.one:
        dev.log('Color1 widget got rebuilt');
        break;
      case AvailbleColor.two:
        dev.log('Color2 widget got rebuilt');
        break;
    }
    final provider = AvailableColorsWidget.of(context, color);

    return Container(
      height: 100,
      color: color == AvailbleColor.one ? provider.color1 : provider.color2,
    );
  }
}

enum AvailbleColor { one, two }

class AvailableColorsWidget extends InheritedModel<AvailbleColor> {
  final MaterialColor color1;
  final MaterialColor color2;

  const AvailableColorsWidget(
      {Key? key,
      required this.color1,
      required this.color2,
      required Widget child})
      : super(
          key: key,
          child: child,
        );

  static AvailableColorsWidget of(BuildContext context, AvailbleColor aspect) {
    return InheritedModel.inheritFrom(context, aspect: aspect)!;
  }

  @override
  bool updateShouldNotify(covariant AvailableColorsWidget oldWidget) {
    dev.log('updateShouldNotify');
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(covariant AvailableColorsWidget oldWidget,
      Set<AvailbleColor> dependencies) {
    if (dependencies.contains(AvailbleColor.one) &&
        color1 != oldWidget.color1) {
      return true;
    }
    if (dependencies.contains(AvailbleColor.two) &&
        color2 != oldWidget.color2) {
      return true;
    }
    return false;
  }
}

final colors = [
  Colors.blue,
  Colors.red,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.cyan,
  Colors.brown,
  Colors.amber,
  Colors.deepPurple,
];

extension RandomElement<E> on Iterable<E> {
  E getRandomElement() => elementAt(
        Random().nextInt(length),
      );
}
