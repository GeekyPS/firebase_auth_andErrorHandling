

import './user.dart';

void addMoney(List<User> usersList, int money, String id) {
  int x = usersList.indexWhere((element) => element.userId == id);



  usersList[x].positiveMoney += money;
}

void removeMoney(List<User> usersList, int money, String id) {
  int x = usersList.indexWhere((element) => element.userId == id);

  usersList[x].negativeMoney -= money;
}
