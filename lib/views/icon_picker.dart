import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({super.key});

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  List<String> resources = [];
  String? selectedResource;

  Future<List<String>> loadAsset(BuildContext context) async {
    final manifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final images = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith('assets/icons'));
    return List.from(images);
  }

  void updateAsset() async {
    final iconFiles = await loadAsset(context);
    setState(() {
      resources = iconFiles;
    });
  }

  @override
  void initState() {
    super.initState();

    updateAsset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.count(
        crossAxisCount: 4,
        children: resources.map(
          (resource) {
            final resourceParts = resource.split('/');
            final resourceName = resourceParts[resourceParts.length - 1];

            return InkWell(
              onTap: () => setState(
                () => Navigator.of(context).pop(
                  resource,
                ),
              ),
              child: GridTile(
                child: Card(
                  elevation: 6,
                  color: selectedResource == resourceName ? Colors.white : null,
                  child: SvgPicture.asset(resource, fit: BoxFit.cover),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
