import 'package:flutter/material.dart';

import 'package:resource_bundle_manager/localization_source.dart';
import 'package:resource_bundle_manager/string_provider.dart';
import 'app_localization_key.dart';
import 'package:flutter_modular/flutter_modular.dart';

typedef Callback = Widget Function(String? value);

class ResourceBundleManagerTextWidget extends StatelessWidget {
  final Callback callback;
  final AppLocalizationKey contentKey;
  final LocalizationSource source;
  final List<String>? params;

  const ResourceBundleManagerTextWidget(
      {super.key,
      required this.contentKey,
      required this.callback,
      this.source = LocalizationSource.local,
      this.params});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: Modular.get<StringProvider>()
          .valueOf(key: contentKey, params: params),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        return callback(snapshot.data);
      },
    );
  }
}
