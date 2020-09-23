import 'package:flutter/material.dart';

class MyUser extends ChangeNotifier {
  String name;
  List<dynamic> cart;

  MyUser({this.name, this.cart});

  factory MyUser.fromMap(Map map) {
    return MyUser(
      name: map['name'] ?? '', // 디폴트 값은 '' 으로 했습니다.
      cart: map['age'] ?? [],
    );
  }

  String getName() {
    return name;
  }

  void setName(String n) {
    name = n;
  }

  List<int> getCart() {
    return cart;
  }

  void setCart(List<dynamic> c) {
    cart = c;
  }

  void addItem(int k) {
    cart.add(k);
    notifyListeners();
  }

  void removeItem(int k) {
    cart.remove(k);
    notifyListeners();
  }

  void removeAll() {
    cart.clear();
    notifyListeners();
  }
}
