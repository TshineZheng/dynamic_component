Build your Dynamic components that support simple logic and variable

## Features

- [x] Dynamic variable  
- [x] Dynamic UI  
- [x] Logic  
  - [x] IF Or Not
- [x] codegen

## Getting started
```yaml
dependencies:
  dynamic_component: any

dev_dependencies:
  # option
  dynamic_component_codegen: any
```

## Usage

### Create your widget extends DynamicComponent  

*Example code: `example/lib/widget/my_list_item.dart`*  

```dart
import 'package:dynamic_component/dynamic_component.dart';
import 'package:dynamic_component/dynamic_component_anotation.dart';
import 'package:example/widget/image_widget.dart';

part 'move_item.g.dart';

@Component(variables: [
  'movie_name',
  'movie_image',
])
class MovieItem extends DynamicComponent with _$MovieItemComponent {
  MovieItem({
    Map<String, dynamic>? data,
    Key? key,
  }) : super(data: data, key: key);

  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: [
        Text(movieName),  // genarated，read from data['movie_name']
        ImageWidget(url: movieImage), // data['movie_image']
      ],
    );
  }

  @override
  DSLInfo? get dslInfo => null;
}
```
run `flutter pub run build_runner build` in your terminal

### Export json  
*Example code: `example/test/export_all_widget_test.dart`*  

```dart
MovieItem(data: _movieItemDataForExport).exportJson(context);
```