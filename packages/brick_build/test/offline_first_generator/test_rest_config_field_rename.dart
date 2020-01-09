import 'package:brick_offline_first_abstract/abstract.dart';
import 'package:brick_offline_first_abstract/annotations.dart';

final output = r'''
Future<RestConfigNoRename> _$RestConfigNoRenameFromRest(
    Map<String, dynamic> data,
    {RestProvider provider,
    OfflineFirstRepository repository}) async {
  return RestConfigNoRename(someLongField: data['someLongField'] as int);
}

Future<Map<String, dynamic>> _$RestConfigNoRenameToRest(
    RestConfigNoRename instance,
    {RestProvider provider,
    OfflineFirstRepository repository}) async {
  return {'someLongField': instance.someLongField};
}

Future<RestConfigNoRename> _$RestConfigNoRenameFromSqlite(
    Map<String, dynamic> data,
    {SqliteProvider provider,
    OfflineFirstRepository repository}) async {
  return RestConfigNoRename(
      someLongField: data['some_long_field'] == null
          ? null
          : data['some_long_field'] as int)
    ..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$RestConfigNoRenameToSqlite(
    RestConfigNoRename instance,
    {SqliteProvider provider,
    OfflineFirstRepository repository}) async {
  return {'some_long_field': instance.someLongField};
}

Future<RestConfigSnakeRename> _$RestConfigSnakeRenameFromRest(
    Map<String, dynamic> data,
    {RestProvider provider,
    OfflineFirstRepository repository}) async {
  return RestConfigSnakeRename(someLongField: data['some_long_field'] as int);
}

Future<Map<String, dynamic>> _$RestConfigSnakeRenameToRest(
    RestConfigSnakeRename instance,
    {RestProvider provider,
    OfflineFirstRepository repository}) async {
  return {'some_long_field': instance.someLongField};
}

Future<RestConfigSnakeRename> _$RestConfigSnakeRenameFromSqlite(
    Map<String, dynamic> data,
    {SqliteProvider provider,
    OfflineFirstRepository repository}) async {
  return RestConfigSnakeRename(
      someLongField: data['some_long_field'] == null
          ? null
          : data['some_long_field'] as int)
    ..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$RestConfigSnakeRenameToSqlite(
    RestConfigSnakeRename instance,
    {SqliteProvider provider,
    OfflineFirstRepository repository}) async {
  return {'some_long_field': instance.someLongField};
}

Future<RestConfigKebabRename> _$RestConfigKebabRenameFromRest(
    Map<String, dynamic> data,
    {RestProvider provider,
    OfflineFirstRepository repository}) async {
  return RestConfigKebabRename(someLongField: data['some-long-field'] as int);
}

Future<Map<String, dynamic>> _$RestConfigKebabRenameToRest(
    RestConfigKebabRename instance,
    {RestProvider provider,
    OfflineFirstRepository repository}) async {
  return {'some-long-field': instance.someLongField};
}

Future<RestConfigKebabRename> _$RestConfigKebabRenameFromSqlite(
    Map<String, dynamic> data,
    {SqliteProvider provider,
    OfflineFirstRepository repository}) async {
  return RestConfigKebabRename(
      someLongField: data['some_long_field'] == null
          ? null
          : data['some_long_field'] as int)
    ..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$RestConfigKebabRenameToSqlite(
    RestConfigKebabRename instance,
    {SqliteProvider provider,
    OfflineFirstRepository repository}) async {
  return {'some_long_field': instance.someLongField};
}

Future<RestConfigPascalRename> _$RestConfigPascalRenameFromRest(
    Map<String, dynamic> data,
    {RestProvider provider,
    OfflineFirstRepository repository}) async {
  return RestConfigPascalRename(someLongField: data['SomeLongField'] as int);
}

Future<Map<String, dynamic>> _$RestConfigPascalRenameToRest(
    RestConfigPascalRename instance,
    {RestProvider provider,
    OfflineFirstRepository repository}) async {
  return {'SomeLongField': instance.someLongField};
}

Future<RestConfigPascalRename> _$RestConfigPascalRenameFromSqlite(
    Map<String, dynamic> data,
    {SqliteProvider provider,
    OfflineFirstRepository repository}) async {
  return RestConfigPascalRename(
      someLongField: data['some_long_field'] == null
          ? null
          : data['some_long_field'] as int)
    ..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$RestConfigPascalRenameToSqlite(
    RestConfigPascalRename instance,
    {SqliteProvider provider,
    OfflineFirstRepository repository}) async {
  return {'some_long_field': instance.someLongField};
}
''';

@ConnectOfflineFirst(
  restConfig: RestSerializable(fieldRename: FieldRename.none),
)
class RestConfigNoRename extends OfflineFirstModel {
  final int someLongField;

  RestConfigNoRename(this.someLongField);
}

@ConnectOfflineFirst(
  restConfig: RestSerializable(fieldRename: FieldRename.snake),
)
class RestConfigSnakeRename extends OfflineFirstModel {
  final int someLongField;

  RestConfigSnakeRename(this.someLongField);
}

@ConnectOfflineFirst(
  restConfig: RestSerializable(fieldRename: FieldRename.kebab),
)
class RestConfigKebabRename extends OfflineFirstModel {
  final int someLongField;

  RestConfigKebabRename(this.someLongField);
}

@ConnectOfflineFirst(
  restConfig: RestSerializable(fieldRename: FieldRename.pascal),
)
class RestConfigPascalRename extends OfflineFirstModel {
  final int someLongField;

  RestConfigPascalRename(this.someLongField);
}
