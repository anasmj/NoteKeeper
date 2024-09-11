import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loading.provider.g.dart';

@riverpod
class Loading extends _$Loading {
  @override
  bool build() => false;
  update(bool v) => state = v;
}
