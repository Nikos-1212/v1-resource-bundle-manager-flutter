#!/bin/bash

src_path=resource_bundle_manager/assets/base.json
dest_path='resource_bundle_manager/lib/app_localization_key.dart'
output=''
touch $dest_path
echo '' > $dest_path
echo 'enum AppLocalizationKey {' >> $dest_path
jq -n 'input | keys[]' $src_path | tr -d '"' | tr -s '.' '_' | tr -s '\n' ',$\n' | sed 's/.$//' >> $dest_path

echo -e '\n}' >> $dest_path

