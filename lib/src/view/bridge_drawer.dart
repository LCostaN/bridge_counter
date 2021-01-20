import 'package:bridge_counter/internationalization/translator.dart';
import 'package:flutter/material.dart';

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
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12.0),
            color: Colors.black,
            child: Tab(
              icon: Icon(Icons.settings, color: Colors.white),
              child: Text(
                widget.translator.settings,
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
          ),
          const Divider(
            indent: 8,
            endIndent: 8,
          ),
          ListTile(
            leading: Icon(
              Icons.translate,
            ),
            title: Text(
              widget.translator.language,
              style: Theme.of(context).textTheme.headline5,
            ),
            trailing: Text(
              widget.translator.locale.languageCode.toUpperCase() +
                  '-' +
                  widget.translator.locale.countryCode.toUpperCase(),
              style: TextStyle(),
            ),
            onTap: () => setState(() => languageIsOpen = !languageIsOpen),
          ),
          AnimatedSize(
            vsync: this,
            duration: const Duration(milliseconds: 300),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
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
                separatorBuilder: (context, j) => const Divider(
                  indent: 8,
                  endIndent: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
