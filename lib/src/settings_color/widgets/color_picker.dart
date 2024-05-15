import 'package:flutter/material.dart';
import 'package:spring_button/spring_button.dart';
import 'package:wt_logging/wt_logging.dart';

final Map<int, double> _correctSizes = {};
final PageController pageController = PageController(keepPage: true);

class FastColorPicker extends StatelessWidget {
  static final log = logger(FastColorPicker);

  final MaterialColor selectedColor;
  final IconData? icon;
  final Function(MaterialColor) onColorSelected;
  final List<MaterialColor> colors;

  const FastColorPicker({
    super.key,
    this.icon,
    this.selectedColor = Colors.blue,
    required this.onColorSelected,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SelectedColor(
            icon: icon,
            selectedColor: selectedColor,
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: createColors(context, colors),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> createColors(BuildContext context, List<MaterialColor> colors) {
    const size = SelectedColor.size;
    return [
      for (final c in colors)
        SpringButton(
          SpringButtonType.OnlyScale,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: AnimatedContainer(
              width: size,
              height: size,
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
                border: Border.all(
                  width: c == selectedColor ? 4 : 2,
                  color: Colors.white,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: size * 0.1,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            log.d('=====>> value has changed: $c');
            onColorSelected.call(c);
          },
          useCache: false,
          scaleCoefficient: 0.9,
          duration: 1000,
        ),
    ];
  }

  double correctButtonSize(int itemSize, double screenWidth) {
    const firstSize = 52;
    final maxWidth = screenWidth - firstSize;
    bool isSizeOkay = false;
    double finalSize = 48;
    do {
      finalSize -= 2;
      final eachSize = finalSize * 1.2;
      final buttonsArea = itemSize * eachSize;
      isSizeOkay = maxWidth > buttonsArea;
    } while (!isSizeOkay);
    _correctSizes[itemSize] = finalSize;
    return finalSize;
  }
}

class SelectedColor extends StatelessWidget {
  static const size = 30.0;

  final MaterialColor selectedColor;
  final IconData? icon;

  const SelectedColor({super.key, required this.selectedColor, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: selectedColor,
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black38,
          ),
        ],
      ),
      child: icon != null
          ? Icon(
              icon,
              color: selectedColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              size: 22,
            )
          : null,
    );
  }
}
