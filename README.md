## Faded Scrollable

A Flutter widget that adds a fade effect to the top and bottom of a scrollable widget. The amount of fade depends on the scroll position, and the fade can be customized to appear proportional or fixed based on the scrolling.

![Faded Scrollable Demo](https://github.com/notariorob/faded_scrollable/blob/main/demo_images/faded_scrollable.gif?raw=true "Faded Scrollable Demo")

### Features
- Fades the top and/or bottom of a scrollable widget.
- Customize the minimum and maximum fade area for both top and bottom of the screen.
- Configure the fade to be proportional to the scroll or a fixed amount.

### Installation

Add the following to your `pubspec.yaml` under `dependencies`:

```yaml
dependencies:
  faded_scrollable: ^1.0.0
```

Then, run flutter pub get to install the package.

### Usage

Here is a basic example of how to use `FadedScrollable`:

```dart
import 'package:flutter/material.dart';
import 'package:faded_scrollable/faded_scrollable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Faded Scrollable Example')),
        body: const FadedScrollable(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: 40,
            itemBuilder: (context, index) => ListTile(
              dense: true,
              title: Text('Title $index'),
              subtitle: Text('Subtitle $index'),
            ),
          ),
        ),
      ),
    );
  }
}
```

### Parameters

You can customize the behavior of the fade effect by using the various parameters available:

- `child` (`Widget`): The widget that will be faded at the top and bottom. This widget or one of its children must be scrollable (e.g., `ListView`, `SingleChildScrollView`).
- `scrollRatioStart` (`double`): Defines at what scroll ratio the top fade will start. Default is `0.0` (start fading at the beginning of the scroll).
- `scrollRatioEnd` (`double`): Defines at what scroll ratio the bottom fade will start to disappear. Default is `1.0` (start fading at the end of the scroll).
- `minTopScreenRatioFade` (`double`): The minimum portion of the screen that should be faded from the top. Default is `0.05` (5% of the screen).
- `maxTopScreenRatioFade` (`double`): The maximum portion of the screen that should be faded from the top. Default is `0.175` (17.5% of the screen).
- `minBottomScreenRatioFade` (`double`): The minimum portion of the screen that should be faded from the bottom. Default is `0.05`.
- `maxBottomScreenRatioFade` (`double`): The maximum portion of the screen that should be faded from the bottom. Default is `0.175`.
- `proportionalFade` (`bool`): Whether the fade amount should be proportional to the scroll position. Default is `true`.

### Contributing
Contributions are welcome! Please file an issue if you encounter any problems or have suggestions for new features.

1. Fork the repository.
2. Create a new branch (git checkout -b new-feature).
3. Make your changes.
4. Submit a pull request.


### Issues
If you encounter any issues, please file them in the [issue tracker](https://github.com/notariorob/faded_scrollable/issues).