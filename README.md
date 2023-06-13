# wt_settings
Package for managing application settings, using Riverpod providers and persisting to local storage.

## Example of a Boolean setting
```dart
  static final featureOneEnabled = SettingsBoolProviders(
    key: '__FEATURE_ONE_ENABLED__',
    label: 'Feature One',
    hint: 'Enable feature one.',
    hideLabel: true,
  );
```

## Example of a Enum setting
```dart
  static final theme = SettingsEnumProviders<ThemeMode>(
    key: '__THEME__',
    values: ThemeMode.values,
    none: ThemeMode.system,
    label: "Theme Mode",
    hint: "Define the color theme for the app..",
  );
```

## Example of a Color settings
```dart
  static final colorScheme = SettingsColorProviders(
    key: '__COLOR_SCHEME__',
    values: Colors.primaries,
    initialValue: Colors.blue,
    none: Colors.blue,
    label: "Color Scheme",
    hint: "Define the colour scheme for the app..",
  );
```

## Using the settings providers
```dart
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            colorScheme.component,
            theme.component,
            featureOneEnabled.component,
          ],
        ),
      ),
    );
  }
}
```
