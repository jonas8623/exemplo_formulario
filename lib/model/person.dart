
import 'dart:math';

class Person {
  String name;
  double weight;
  double height;

  Person(this.name, this.weight, this.height);

  double calculateIMC() => this.weight /  pow(this.height, 2);

  @override
  String toString() {
    return '\nNome: $name\nPeso: $weight\nAltura: $height\nIMC: ${this.calculateIMC()}';
  }
}