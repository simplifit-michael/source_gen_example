
import 'package:simple_code_gen_annotations/simple_code_gen_annotations.dart';

part 'my_class.g.dart';

@simpleCode
class MyClass {
  final int myInt;
  final String myString;
  final bool _secret;

  MyClass(this.myInt, this._secret, this.myString);
  MyClass.troll(this.myInt, this._secret, this.myString);
}
