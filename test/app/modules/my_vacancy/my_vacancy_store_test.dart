import 'package:flutter_test/flutter_test.dart';
import 'package:give_me_jobs_app/app/modules/my_vacancy/my_vacancy_store.dart';

void main() {
  late MyVacancyStore store;

  setUpAll(() {
    store = MyVacancyStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}
