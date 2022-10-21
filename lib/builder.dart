
import 'package:build/build.dart';
import 'package:simple_code_gen/src/simple_code_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder simpleCodeGenerator(BuilderOptions options) => SharedPartBuilder([SimpleCodeGenerator()],'simple_extension');