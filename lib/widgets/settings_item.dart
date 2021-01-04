import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../styles.dart';

typedef SettingsItemCallback = FutureOr<void> Function();

class SettingsNavigationIndicator extends StatelessWidget {
  const SettingsNavigationIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      CupertinoIcons.forward,
      color: Styles.settingsMediumGray,
      size: 21,
    );
  }
}

class SettingsIcon extends StatelessWidget {
  const SettingsIcon({
    @required this.icon,
    this.foregroundColor = CupertinoColors.white,
    this.backgroundColor = CupertinoColors.black,
    Key key,
  })  : assert(icon != null),
        super(key: key);

  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          icon,
          color: foregroundColor,
          size: 20,
        ),
      ),
    );
  }
}

class SettingsItem extends StatefulWidget {
  const SettingsItem({
    @required this.label,
    this.icon,
    this.content,
    this.subtitle,
    this.onPress,
    Key key,
  })  : assert(label != null),
        super(key: key);

  final String label;
  final Widget icon;
  final Widget content;
  final String subtitle;
  final SettingsItemCallback onPress;

  @override
  State<StatefulWidget> createState() => SettingsItemState();
}

class SettingsItemState extends State<SettingsItem> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    var themeData = CupertinoTheme.of(context);
    var brightness = CupertinoTheme.brightnessOf(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: Styles.settingsItemColor(brightness),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          if (widget.onPress != null) {
            setState(() {
              pressed = true;
            });
            await widget.onPress();
            Future.delayed(
              Duration(milliseconds: 150),
              () {
                setState(() {
                  pressed = false;
                });
              },
            );
          }
        },
        child: SizedBox(
          height: widget.subtitle == null ? 44 : 57,
          child: Row(
            children: [
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    bottom: 2,
                  ),
                  child: SizedBox(
                    height: 29,
                    width: 29,
                    child: widget.icon,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: widget.subtitle != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 8.5),
                            Text(widget.label,
                                style: themeData.textTheme.textStyle),
                            SizedBox(height: 4),
                            Text(
                              widget.subtitle,
                              style: Styles.settingsItemSubtitleText(themeData),
                            ),
                          ],
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 1.5),
                          child: Text(widget.label,
                              style: themeData.textTheme.textStyle),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 11),
                child: widget.content ?? Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
