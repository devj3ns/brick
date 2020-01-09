import 'package:analyzer/dart/element/element.dart';
import 'package:brick_offline_first_abstract/annotations.dart';
import 'package:brick_build/src/annotation_finder.dart';
import 'package:brick_build/src/utils/fields_for_class.dart';

/// Convert `@OfflineFirst` annotations into digestible code
class _OfflineFirstSerdesFinder extends AnnotationFinder<OfflineFirst> {
  _OfflineFirstSerdesFinder();

  from(element) {
    final obj = objectForField(element);

    if (obj == null) {
      return OfflineFirst();
    }

    final where = obj
        .getField("where")
        .toMapValue()
        ?.map((key, value) => MapEntry(key.toStringValue(), value.toStringValue()));

    return OfflineFirst(
      where: where,
    );
  }
}

/// Discover all fields with `@OfflineFirst`
class OfflineFirstFields extends FieldsForClass<OfflineFirst> {
  final finder = _OfflineFirstSerdesFinder();

  OfflineFirstFields(ClassElement element) : super(element: element);
}
