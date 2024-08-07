````markdown
# Fancy Search Dropdown

![alt text](image.png)

The `fancy_search_dropdown` package is a customizable Flutter widget that provides an elegant and efficient way to display a dropdown menu with search functionality. This widget is designed to enhance the user experience by offering dynamic suggestions as the user types, making it easy to search and select options from a predefined list.

## Features

- **Customizable Suggestions**: Provide a list of suggestions to be shown in the dropdown.
- **Configurable Styles**: Customize the appearance of the dropdown with `FancySearchDropdownConfig`.
- **Debug Mode**: Option to enable or disable debug mode.

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  fancy_search_dropdown: ^0.0.1
```
````

Run `flutter pub get` to install the package.

## Usage

To use `FancySearchDropdown`, follow these steps:

1. **Import the Package**:

   ```dart
   import 'package:fancy_search_dropdown/fancy_search_dropdown.dart';
   ```

2. **Example Usage**:

   Here’s a basic example of how to use `FancySearchDropdown` in a Flutter app:

   ```dart
   import 'dart:developer';
   import 'package:fancy_search_dropdown/fancy_search_dropdown.dart';
   import 'package:flutter/material.dart';

   void main() {
     runApp(const MyApp());
   }

   class MyApp extends StatelessWidget {
     const MyApp({super.key});

     @override
     Widget build(BuildContext context) {
       return const MaterialApp(
         home: MyHomePage(),
       );
     }
   }

   class MyHomePage extends StatefulWidget {
     const MyHomePage({super.key});

     @override
     State<MyHomePage> createState() => _MyHomePageState();
   }

   class _MyHomePageState extends State<MyHomePage> {
     @override
     Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(
           title: const Text("Fancy Search Dropdown"),
         ),
         body: Padding(
           padding: const EdgeInsets.all(16.0),
           child: FancySearchDropdown(
             labelText: "Select Hospital Name",
             suggestions: const [
               "Family Doctor",
               "Preferred Doctor",
               "Preferred Hospital",
               "Care Taker",
               "Pharmacy",
               "Lab",
             ],
             selectedValue: "Lab",
             maxSuggestionHeight: 300,
             debugMode: false,
             // Uncomment and customize the configuration as needed:
             // config: FancySearchDropdownConfig(
             //   optionBoxElevation: 3,
             //   inActiveSuffix: Icon(Icons.password),
             //   activeSuffix: Icon(Icons.email),
             //   borderRadius: 8,
             //   optionTextStyle: TextStyle(color: Colors.red),
             //   labelTextStyle: TextStyle(color: Colors.black),
             //   activeLeading: Icon(Icons.person),
             //   inputDecoration: InputDecoration(
             //     focusedBorder: OutlineInputBorder(),
             //     border: OutlineInputBorder(),
             //     enabledBorder: OutlineInputBorder(),
             //   ),
             // ),
             onSelected: (value) {
               log("Selected value: $value");
             },
           ),
         ),
       );
     }
   }
   ```

## Parameters

- `suggestions`: A list of suggestions to be displayed in the dropdown.
- `onSelected`: Callback function triggered when a suggestion is selected.
- `labelText`: The label text to be displayed in the `TextField`.
- `selectedValue`: The initially selected value.
- `maxSuggestionHeight`: Maximum height of the suggestion list.
- `config`: Configuration options for styling the dropdown.
- `debugMode`: Boolean to enable or disable debug mode. Set to `false` for production.

## Configuration

`FancySearchDropdownConfig` allows you to customize the appearance of the dropdown. For example:

```dart
FancySearchDropdownConfig(
  inputDecoration: InputDecoration(
    border: OutlineInputBorder(),
    suffixIcon: Icon(Icons.arrow_drop_down),
  ),
  labelTextStyle: TextStyle(color: Colors.blue),
  activeSuffix: Icon(Icons.arrow_drop_up),
  inActiveSuffix: Icon(Icons.arrow_drop_down),
  activeLeading: Icon(Icons.search),
  inActiveLeading: Icon(Icons.search_off),
)
```

## Contributing

Feel free to open issues or pull requests if you have suggestions or improvements.

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Author

Kripa Nand Kumar Sah - [engineerk.k.s6@gmail.com](mailto:engineerk.k.s6@gmail.com)
