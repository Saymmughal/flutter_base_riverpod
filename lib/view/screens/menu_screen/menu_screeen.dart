import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/utils/dimension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base_riverpod/view/widgets/extention/string_extension.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: safeAreaHeight,
      alignment: Alignment.center,
      child: 'Menu Screen'.toText(),
    );
  }
}
