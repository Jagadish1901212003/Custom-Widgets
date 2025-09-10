import 'package:custom_widgets/model/incident_details_model.dart';
import 'package:flutter/material.dart';

class PersonInvolvedProvider extends ChangeNotifier {
  List<Person> _personInvolved = [];

  List<Person> get involvedPersons => _personInvolved;

  Person getPersonInvolved(int id) =>
      _personInvolved.firstWhere((element) => element.id == id);

  void addPersonInvolved(Person person) {
    _personInvolved.add(person);
    notifyListeners();
  }

  void addDefaultPerson(Person person) {
    _personInvolved.insert(0, person);
    print("in function addDefaultPerson finally  ::: ${person.supervisorId}");
    notifyListeners();
  }

  void updatePersonInvolved(int id, Person updatedPerson) {
    print("IN UPDATE   1:::::::::::::::");
    int index = _personInvolved.indexWhere((element) => element.id == id);
    _personInvolved[index] = updatedPerson;
    print("NOTIFIYING UPDTAE::::::::::::::::::::");
    notifyListeners();
  }

  void removePersonInvolved(int index) {
    _personInvolved.removeAt(index);
    notifyListeners();
  }

  void removeAllPersonInvolved() {
    _personInvolved = [];
    notifyListeners();
  }
}
