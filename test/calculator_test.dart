import 'package:flutter_test/flutter_test.dart';
import 'package:mastedon/utils/calculator.dart';

void main(){

setUp(() {});

setUpAll(() => print('start test cases'));

tearDown(() => {}); // runs after particular test case

tearDownAll(() => print('test cases completed')); // runs after all test cases

  group('test my calculator', () { 

    test('test additon', (){

    Calculator calc = Calculator();
    var result = calc.add(3, 6);

    expect(result, 9);

    expect(result, isNot(10));

  });
  });

  test('test multiplication', (){

    Calculator calc = Calculator();
    var result = calc.multiply(2, 3);

    expect(result, 6);

    expect(result, isNot(10));

  });
}