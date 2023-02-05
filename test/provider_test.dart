

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('PathProvider full implementation', () {
final repositoryProvider = Provider((ref) => Repository(ref.read));

test('fetches catalog', () async {
  final container = ProviderContainer();
  addTearDown(container.dispose);

  Repository repository = container.read(repositoryProvider);

  await expectLater(
    repository.fetchCatalog(),
    completion(Catalog()),
  );
});
  });
}

class Repository {
  Repository( read);

  fetchCatalog() {}
}

class Catalog {
}