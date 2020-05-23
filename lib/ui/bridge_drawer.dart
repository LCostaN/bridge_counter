import 'package:bridge_counter/internationalization/translator.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BridgeDrawer extends StatefulWidget {
  const BridgeDrawer(this.translator, {Key key}) : super(key: key);

  final Translator translator;

  @override
  BridgeDrawerState createState() => BridgeDrawerState();
}

class BridgeDrawerState extends State<BridgeDrawer>
    with SingleTickerProviderStateMixin {
  bool languageIsOpen = false;
  List<Locale> supportedLocales = [
    Locale('pt', 'BR'),
    Locale('en', 'US'),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              Colors.blue.shade600,
              Colors.blue.shade400,
              Colors.blue.shade600,
            ],
            stops: [0.3, 0.5, 0.7],
          ),
        ),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.white,
              ),
              title: Text(
                widget.translator.howToPlay,
                style: Theme.of(context).textTheme.headline5.apply(
                      color: Colors.white,
                    ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () {
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Coming Soon!'),
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
            Divider(
              indent: 8,
              endIndent: 8,
              color: Colors.white,
            ),
            ListTile(
              leading: Icon(
                Icons.translate,
                color: Colors.white,
              ),
              title: Text(
                widget.translator.language,
                style: Theme.of(context).textTheme.headline5.apply(
                      color: Colors.white,
                    ),
              ),
              trailing: Text(
                widget.translator.locale.languageCode.toUpperCase() +
                    '-' +
                    widget.translator.locale.countryCode.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () => setState(() => languageIsOpen = !languageIsOpen),
            ),
            AnimatedSize(
              vsync: this,
              duration: const Duration(milliseconds: 300),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: Colors.white,
                height: languageIsOpen ? null : 0,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 8.0),
                  itemCount: supportedLocales.length,
                  itemBuilder: (context, i) {
                    var locale = supportedLocales[i];
                    var langCode = locale.languageCode.toUpperCase();
                    var countryCode = locale.countryCode.toUpperCase();
                    return ListTile(
                      title: Text('$langCode-$countryCode'),
                      trailing: widget.translator.locale == locale
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      onTap: widget.translator.locale == locale
                          ? null
                          : () {
                              widget.translator.locale = locale;
                              Navigator.of(context).pop();
                            },
                    );
                  },
                  separatorBuilder: (context, j) => Divider(
                    indent: 8,
                    endIndent: 8,
                  ),
                ),
              ),
            ),
            Divider(
              indent: 8,
              endIndent: 8,
              color: Colors.white,
            ),
            ListTile(
              leading: Icon(
                MdiIcons.creation,
                color: Colors.white,
              ),
              title: Text(
                widget.translator.credits,
                style: Theme.of(context).textTheme.headline5.apply(
                      color: Colors.white,
                    ),
              ),
              trailing: Icon(
                Icons.open_in_new,
                color: Colors.white,
              ),
              onTap: () {
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Coming Soon!'),
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
