import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:resource_bundle_manager/localization_source.dart';
import 'package:resource_bundle_manager/string_provider.dart';

import 'app_localization_key.dart';

typedef Callback = Widget Function(List<String?>? value);

class ResourceBundleManagerMultipleTextWidget extends StatelessWidget {
  final Callback callback;
  final LocalizationSource source;
  final List<ContentData> contentData;

  const ResourceBundleManagerMultipleTextWidget(
      {super.key,
      required this.contentData,
      required this.callback,
      this.source = LocalizationSource.local});

  Future<List<String?>> _future() async {
    return await Future.wait<String?>(contentData.map((e) async =>
        Modular.get<StringProvider>()
            .valueOf(key: e.contentKey, params: e.params)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String?>?>(
      future: _future(),
      builder: (BuildContext context, AsyncSnapshot<List<String?>?> snapshot) {
        return callback(snapshot.data);
      },
    );
  }
}

class ContentData {
  final AppLocalizationKey contentKey;
  final List<String>? params;

  ContentData(this.contentKey, {this.params});
}
