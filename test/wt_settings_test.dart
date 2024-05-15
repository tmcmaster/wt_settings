import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_models/wt_models.dart';
import 'package:wt_settings/src/local_storage_state_notifier.dart';
import 'package:wt_settings/src/settings.dart';
import 'package:wt_settings/src/settings_date/settings_date_providers.dart';
import 'package:wt_settings/src/settings_int/settings_int_providers.dart';
import 'package:wt_settings/src/settings_object/settings_object_providers.dart';
import 'package:wt_settings/src/settings_string/settings_string_providers.dart';
import 'package:wt_settings/src/storate/settings_storage.dart';

void main() async {
  final log = logger('Unit Tests', level: Level.debug);

  WidgetsFlutterBinding.ensureInitialized();
  await SettingsStorage.init(SettingsStorage.memoryCache);
  final riverpod = ProviderContainer();

  group('SettingsStorage', () {
    test('Getting SettingsStorage instance', () async {
      final instance = await SettingsStorage.instance();
      expect(instance, isNotNull);
    });

    test('Setting and Getting Value', () async {
      final instance = await SettingsStorage.instance();
      expect(instance, isNotNull);
      await instance.setString('__TEST_VALUE_ONE__', 'Test value one');
      final value = instance.getString('__TEST_VALUE_ONE__');
      expect(value, equals('Test value one'));
    });
  });

  group('Test Settings Providers', () {
    test(
      'Boolean',
      () async => providerTest(
        provider: TestSettings.boolean.value,
        notifier: TestSettings.boolean.notifier,
        initialValue: false,
        testValue: true,
        riverpod: riverpod,
      ),
    );
    test(
      'Color',
      () async => providerTest(
        provider: TestSettings.color.value,
        notifier: TestSettings.color.notifier,
        initialValue: Colors.blue,
        testValue: Colors.red,
        riverpod: riverpod,
      ),
    );
    test(
      'Date',
      () async => providerTest(
        provider: TestSettings.date.value,
        notifier: TestSettings.date.notifier,
        initialValue: '2024-01-01',
        testValue: '2023-01-01',
        riverpod: riverpod,
      ),
    );
    test(
      'Enumerate',
      () async => providerTest(
        provider: TestSettings.enumerate.value,
        notifier: TestSettings.enumerate.notifier,
        initialValue: TestEnum.one,
        testValue: TestEnum.two,
        riverpod: riverpod,
      ),
    );
    test(
      'Integer',
      () async => providerTest(
        provider: TestSettings.integer.value,
        notifier: TestSettings.integer.notifier,
        initialValue: 0,
        testValue: 42,
        riverpod: riverpod,
      ),
    );
    test(
      'Object',
      () async => providerTest(
        provider: TestSettings.object.value,
        notifier: TestSettings.object.notifier,
        initialValue: null,
        testValue: TestObjectListStateNotifier.initialObjects[0],
        riverpod: riverpod,
      ),
    );
    test(
      'String',
      () async => providerTest(
        provider: TestSettings.string.value,
        notifier: TestSettings.string.notifier,
        initialValue: 'hamster',
        testValue: 'squirrel',
        riverpod: riverpod,
      ),
    );
    test('Getting SettingsStorage date', () async {
      final instance = await SettingsStorage.instance();
      expect(instance, isNotNull);
      log.d(instance);
    });
  });
}

Future<void> providerTest<T, N extends LocalStorageStateNotifier<T>>({
  required StateNotifierProvider<N, T> provider,
  required AlwaysAliveRefreshable<T> notifier,
  required T initialValue,
  required T testValue,
  required ProviderContainer riverpod,
}) async {
  final defaultValue = riverpod.read(provider);
  expect(defaultValue, equals(initialValue));
  await (riverpod.read(notifier) as LocalStorageStateNotifier<T>).replaceValue(testValue);
  final newValue = riverpod.read(provider);
  expect(newValue, equals(testValue));
  await (riverpod.read(notifier) as LocalStorageStateNotifier<T>).replaceValue(initialValue);
  final originalValue = riverpod.read(provider);
  expect(originalValue, equals(initialValue));
  await (riverpod.read(notifier) as LocalStorageStateNotifier<T>).replaceValue(testValue);
  await (riverpod.read(notifier) as LocalStorageStateNotifier<T>).reload();
  final finalValue = riverpod.read(provider);
  expect(finalValue, equals(testValue));
  return Future.value();
}

mixin TestSettings {
  static final boolean = SettingsBoolProviders(
    key: '__TESTING_BOOLEAN_PROVIDERS__',
    label: 'Testing SettingsBoolProviders',
    initialValue: false,
    none: false,
    hint: 'Testing the Riverpod boolean settings provider.',
  );
  static final color = SettingsColorProviders(
    key: '__TESTING_COLOR_PROVIDERS__',
    label: 'Testing SettingsColorProviders',
    values: [
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.blue,
      Colors.purple,
    ],
    initialValue: Colors.blue,
    none: Colors.blue,
    hint: 'Testing the Riverpod color settings provider.',
  );
  static final date = SettingsDateProviders(
    key: '__TESTING_DATE_PROVIDERS__',
    label: 'Testing SettingsDateProviders',
    initialValue: '2024-01-01',
    hint: 'Testing the Riverpod integer settings provider.',
  );
  static final enumerate = SettingsEnumProviders<TestEnum>(
    key: '__TESTING_ENUMERATE_PROVIDERS__',
    label: 'Testing SettingsEnumProviders',
    values: TestEnum.values,
    initialValue: TestEnum.one,
    none: TestEnum.one,
    hint: 'Testing the Riverpod enumerate settings provider.',
  );
  static final integer = SettingsIntProviders(
    key: '__TESTING_INTEGER_PROVIDERS__',
    label: 'Testing SettingsIntProviders',
    initialValue: 0,
    none: 0,
    hint: 'Testing the Riverpod integer settings provider.',
  );
  static final object = SettingsObjectProviders<TestObject>(
    key: '__TESTING_OBJECT_PROVIDERS__',
    label: 'Testing SettingsObjectProviders',
    getId: (TestObject o) => o.getId(),
    getLabel: (TestObject o) => o.getTitle(),
    listProvider: listProvider,
    none: TestObjectListStateNotifier.initialObjects[0],
    hint: 'Testing the Riverpod object settings provider.',
  );

  static final string = SettingsStringProviders(
    key: '__TESTING_STRING_PROVIDERS__',
    label: 'Testing SettingsStringProviders',
    initialValue: 'hamster',
    hint: 'Testing the Riverpod string settings provider.',
  );
}

final listProvider = StateNotifierProvider<TestObjectListStateNotifier, List<TestObject>>(
  (ref) => TestObjectListStateNotifier(),
);

class TestObjectListStateNotifier extends StateNotifier<List<TestObject>> {
  static const initialObjects = [
    TestObject(),
    TestObject(),
    TestObject(),
  ];
  TestObjectListStateNotifier() : super(initialObjects);
}

class TestObject extends BaseModel<TestObject> {
  const TestObject();

  @override
  String getId() => 'aaa';

  @override
  String getTitle() => 'bbb';

  @override
  List<String> getTitles() => ['id', 'title'];

  @override
  Map<String, dynamic> toJson() => {'id': 'aaa', 'title': 'bbb'};
}

enum TestEnum {
  one,
  two,
  three;
}
