import 'package:analyzer/dart/element/element.dart';
import 'package:brick_build/generators.dart';
import 'package:brick_json_generators/json_serdes_generator.dart';
import 'package:brick_core/field_serializable.dart';
import 'package:brick_core/core.dart';

mixin JsonDeserialize<_Model extends Model, _Annotation extends FieldSerializable>
    on JsonSerdesGenerator<_Model, _Annotation> {
  @override
  final doesDeserialize = true;

  @override
  String? coderForField(field, checker, {required wrappedInFuture, required fieldAnnotation}) {
    final fieldValue = serdesValueForField(field, fieldAnnotation.name!, checker: checker);
    final defaultValue = SerdesGenerator.defaultValueSuffix(fieldAnnotation);

    if (fieldAnnotation.ignoreFrom) return null;

    // DateTime
    if (checker.isDateTime) {
      if (checker.isNullable) {
        return '$fieldValue == null ? null : DateTime.tryParse($fieldValue$defaultValue as String)';
      }
      return 'DateTime.parse($fieldValue$defaultValue as String)';

      // bool, double, int, num, String
    } else if (checker.isDartCoreType) {
      final wrappedCheckerType =
          wrappedInFuture ? 'Future<${checker.targetType}>' : checker.targetType.toString();
      return '$fieldValue as $wrappedCheckerType$defaultValue';

      // Iterable
    } else if (checker.isIterable) {
      final argType = checker.unFuturedArgType;
      final argTypeChecker = checkerForType(checker.argType);
      final castIterable = SerdesGenerator.iterableCast(
        argType,
        isSet: checker.isSet,
        isList: checker.isList,
        isFuture: wrappedInFuture || checker.isFuture,
        forceCast: !checker.isArgTypeASibling,
      );

      // Iterable<RestModel>, Iterable<Future<RestModel>>
      if (checker.isArgTypeASibling) {
        final fromJsonCast = SerdesGenerator.iterableCast(argType,
            isSet: checker.isSet, isList: checker.isList, isFuture: true, forceCast: true);

        var deserializeMethod = '''
          $fieldValue?.map((d) =>
            ${SharedChecker.withoutNullability(argType)}Adapter().from$providerName(d, provider: provider, repository: repository)
          )$fromJsonCast
        ''';

        if (wrappedInFuture) {
          deserializeMethod = 'Future.wait<$argType>($deserializeMethod ?? [])';
        } else if (!checker.isArgTypeAFuture && !checker.isFuture) {
          deserializeMethod = 'await Future.wait<$argType>($deserializeMethod ?? [])';
        }

        if (checker.isSet) {
          return '($deserializeMethod$defaultValue).toSet()';
        }

        return '$deserializeMethod$defaultValue';
      }

      // Iterable<enum>
      if (argTypeChecker.isEnum) {
        if (fieldAnnotation.enumAsString) {
          final nullableSuffix = argTypeChecker.isNullable ? '' : '!';
          return '''$fieldValue.map(
            (value) => ${providerName}Adapter.enumValueFromName(${SharedChecker.withoutNullability(argType)}.values, value)$nullableSuffix
          )$castIterable$defaultValue
          ''';
        } else {
          return '$fieldValue.map((e) => ${SharedChecker.withoutNullability(argType)}.values[e])$castIterable$defaultValue';
        }
      }

      // List
      if (checker.isList) {
        final addon = fieldAnnotation.defaultValue ?? '<${checker.argType}>[]';
        return '$fieldValue$castIterable ?? $addon';

        // Set
      } else if (checker.isSet) {
        final addon = fieldAnnotation.defaultValue ?? '<${checker.argType}>{}';
        return '$fieldValue$castIterable ?? $addon';

        // other Iterable
      } else {
        return '$fieldValue$castIterable$defaultValue';
      }

      // RestModel
    } else if (checker.isSibling) {
      final shouldAwait = wrappedInFuture ? '' : 'await ';

      return '''$shouldAwait${SharedChecker.withoutNullability(checker.unFuturedType)}Adapter().from$providerName(
          $fieldValue, provider: provider, repository: repository
        )''';

      // enum
    } else if (checker.isEnum) {
      if (fieldAnnotation.enumAsString) {
        final nullableSuffix = checker.isNullable ? '' : '!';
        return '${providerName}Adapter.enumValueFromName(${SharedChecker.withoutNullability(field.type)}.values, $fieldValue)$nullableSuffix$defaultValue';
      } else {
        if (checker.isNullable) {
          return '$fieldValue is int ? ${SharedChecker.withoutNullability(field.type)}.values[$fieldValue as int] : null$defaultValue';
        }
        return '${SharedChecker.withoutNullability(field.type)}.values[$fieldValue as int]';
      }

      // Map
    } else if (checker.isMap) {
      return '$fieldValue$defaultValue';
    } else if (checker.fromJsonConstructor != null) {
      final klass = (checker.targetType.element as ClassElement);
      return '${klass.displayName}.fromJson($fieldValue)';
    }

    return null;
  }
}
