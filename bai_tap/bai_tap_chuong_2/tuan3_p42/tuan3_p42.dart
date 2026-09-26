class Animal {
  String name = "";
  
  Animal({required this.name});
  Animal.macDinh(String name) {
    this.name = name;
  }

  void breathe(){
    print("Thở...");
  }
  void move(){
    print("Di chuyển...");
  }
}

mixin Flyable {
  double altitude = 100;

  void fly() {
    print("Tôi đang bay... ở độ cao ${altitude}m");
  }

  void land() {
    print("Tôi đáp đất...");
  }

}

mixin Swimable {
  void swim(){
    print('Tôi đang bơi...');
  }

  void dive() {
    print('Tôi đang lặn sâu...');
  }
}

abstract class Describable{
  String describe();
}


class Dog extends Animal with Swimable implements Describable {
  Dog([String name = ""]) : super.macDinh(name);

  void bark() {
    print('Gâu gâu...');
  }

  @override
  String describe() {
    return 'Tôi là một con chó dễ thương và thích gặm xương.';
  }
}

class Duck extends Animal with Swimable, Flyable implements Describable{
  Duck([String name = ""]) : super.macDinh(name);

  void quack() {
    print('Quack quack...');
  }

  @override
  String describe() {
    return 'Tôi là một chú vịt thích bơi lội.';
  }
}

void main() {
  Dog dog = Dog("Chó cưng");
  print(dog.describe());
  dog.breathe();
  dog.swim();
  dog.bark();

  print('-----');

  Duck duck = Duck("Vịt Donald");
  print(duck.describe()); 
  duck.fly();           
  duck.swim();     
  duck.quack();
}