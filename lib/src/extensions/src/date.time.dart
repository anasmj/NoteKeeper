part of '../extensions.dart';

extension DateTimeExt on DateTime {
  String get formattedDate => DateFormat('d MMM').format(this);
  String get formattedTime => DateFormat('h.mm a').format(this);
  bool get isToday => DateTime.now().difference(this).inDays == 0;
}
