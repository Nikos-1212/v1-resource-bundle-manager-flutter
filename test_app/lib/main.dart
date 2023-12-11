import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:framework_contracts_flutter/resource_manager/resource_common_contract.dart';
import 'package:resource_bundle_manager/app_localization_key.dart';
import 'package:resource_bundle_manager/resource_bundle_manager.dart';
import 'package:resource_bundle_manager/resource_bundle_manager_multiple_text_widget.dart';
import 'package:resource_bundle_manager/resource_bundle_manager_text_widget.dart';
import 'package:resource_bundle_manager/string_provider.dart';

Future<void> main() async {
  runApp(ModularApp(module: MyModule(), child: MyApp()));
}

class MyModule extends Module {
  VGStringProvider _resourceBundleManager = VGStringProvider.instance;

  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<VGStringProvider>((i) => _resourceBundleManager),
      ];
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controller = TextEditingController(text: "");

  @override
  Future<void> initResourceBundleConfig() async {
    var _isDoneDownloadingResource = false;

    /// Retrieve the device's locale setting
    /// Platform.localeName returns the language code as well as the country code.
    /// We will split the value and use only the language code

    String languageCode = Platform.localeName.split('_')[0];
    await Modular.get<StringProvider>().initConfig(
        ResourceConfig(tenant: "9998", locale: languageCode, groupId: ""),
        callback: () {
      setState(() {
        _isDoneDownloadingResource = true;
      });
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    initResourceBundleConfig();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Resource Bundle Manager'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ResourceBundleManagerTextWidget(
                    callback: (String? value) {
                      return TextField(
                        controller: _controller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: value,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        ),
                      );
                    },
                    contentKey: AppLocalizationKey.txtconnectapp_001),
                SizedBox(height: 32.0),
                ResourceBundleManagerTextWidget(
                    callback: (String? value) {
                      return ElevatedButton(
                        onPressed: () {},
                        child: Text(value ?? ""),
                      );
                    },
                    contentKey: AppLocalizationKey.txtconnectapp_001),
                SizedBox(height: 32.0),
                ResourceBundleManagerTextWidget(
                    callback: (String? value) {
                      return Text(value ?? "");
                    },
                    contentKey: AppLocalizationKey.txtconnectapp_001),
                SizedBox(height: 32.0),
                ResourceBundleManagerTextWidget(
                    callback: (String? value) {
                      return Text(value ?? "");
                    },
                    contentKey: AppLocalizationKey.txtconnectapp_001),
                SizedBox(height: 32.0),
                Text("\n Param1 = \"First\", Param2 = \"Second\""),
                ResourceBundleManagerTextWidget(
                  callback: (String? value) {
                    return Text(value ?? "");
                  },
                  contentKey: AppLocalizationKey.txtconnectapp_001,
                  params: ["First", "Second", "Third"],
                ),
                ResourceBundleManagerMultipleTextWidget(
                    contentData: [
                      ContentData(AppLocalizationKey.already_have_an_account_2,
                          params: ["sample", "sample1"]),
                      ContentData(AppLocalizationKey
                          .appdevices_applehealth_txtconnect_001)
                    ],
                    callback: (List<String?>? values) {
                      return TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: values?[0],
                            labelText: values?[1],
                          ),
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (String? value) {
                            return (value != null && value.contains('@'))
                                ? 'Do not use the @ char.'
                                : null;
                          });
                    }),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
