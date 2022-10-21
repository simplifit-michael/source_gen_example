import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:simple_code_gen_annotations/simple_code_gen_annotations.dart';
import 'package:source_gen/source_gen.dart';

import 'helper/class_builder.dart';

class SimpleCodeGenerator extends GeneratorForAnnotation<SimpleCode> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    
    final genClassName = 'Gen${visitor.className}';
    final classBuilder = ClassBuilderFactory(className: genClassName);
    
    classBuilder.addFields(visitor.fields, prefix: 'modified');

    return classBuilder.build();
  }
}

class ModelVisitor extends SimpleElementVisitor {
  DartType get className => _className;
  late DartType _className;

  final Map<String, DartType> fields = {};

  @override
  visitConstructorElement(ConstructorElement element) {
    _className = element.type.returnType;
    return super.visitConstructorElement(element);
  }

  @override
  visitFieldElement(FieldElement element) {
    fields[element.name] = element.type;
  }
}
