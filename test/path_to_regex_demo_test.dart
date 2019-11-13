@TestOn('browser')
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:path_to_regexp_demo/app_component.template.dart';
import 'package:test/test.dart';

import 'page_objects/app_po.dart';

void main() {
  AppPO appPO;
  NgTestFixture<AppComponent> testFixture;

  setUp(() async {
    final testBed = NgTestBed.forComponent(AppComponentNgFactory);
    testFixture = await testBed.create();
    final rootElement = testFixture.rootElement;
    final context = HtmlPageLoaderElement.createFromElement(rootElement);
    appPO = AppPO.create(context);
  });

  tearDown(disposeAnyRunningTest);

  test('initial state', () async {
    expect(appPO.caseSensitiveCheckboxPO.checked, isTrue);
    expect(appPO.prefixCheckboxPO.checked, isFalse);
    expect(appPO.routeInputPO.value, isEmpty);
    expect(appPO.pathInputPO.value, isEmpty);
    expect(appPO.patternPO.pattern, r'^$');
    expect(appPO.parametersPO.parameters, isEmpty);
    expect(appPO.matchPO.hasMatch, isTrue);
    expect(appPO.matchPO.arguments, isEmpty);
  });

  test('simple route', () async {
    await testFixture.update((_) {
      appPO.routeInputPO.setValue('/user/:id');
    });
    expect(appPO.patternPO.pattern, r'^/user/([^/]+?)$');
    expect(appPO.parametersPO.parameters, ['id']);
    expect(appPO.matchPO.hasMatch, isFalse);
    await testFixture.update((_) {
      appPO.pathInputPO.setValue('/user/12');
    });
    expect(appPO.matchPO.hasMatch, isTrue);
    expect(appPO.matchPO.arguments, {'id': '12'});
  });

  test('custom parameter', () async {
    await testFixture.update((_) {
      appPO
        ..routeInputPO.setValue(r'/user/:id(\d+)')
        ..pathInputPO.setValue('/user/12');
    });
    expect(appPO.patternPO.pattern, r'^/user/(\d+)$');
    expect(appPO.parametersPO.parameters, ['id']);
    expect(appPO.matchPO.hasMatch, isTrue);
    expect(appPO.matchPO.arguments, {'id': '12'});
    await testFixture.update((_) {
      appPO.pathInputPO.setValue('/user/alice');
    });
    expect(appPO.matchPO.hasMatch, isFalse);
    expect(appPO.matchPO.arguments, isEmpty);
  });

  test('multiple parameters', () async {
    await testFixture.update((_) {
      appPO
        ..routeInputPO.setValue('/group/:gid/user/:uid')
        ..pathInputPO.setValue('/group/1/user/12');
    });
    expect(appPO.parametersPO.parameters, ['gid', 'uid']);
    expect(appPO.matchPO.hasMatch, isTrue);
    expect(appPO.matchPO.arguments, {'gid': '1', 'uid': '12'});
  });

  test('prefix route', () async {
    await testFixture.update((_) {
      appPO
        ..routeInputPO.setValue('/user')
        ..pathInputPO.setValue('/user/details');
    });
    expect(appPO.patternPO.pattern, r'^/user$');
    expect(appPO.matchPO.hasMatch, isFalse);
    await testFixture.update((_) {
      appPO.prefixCheckboxPO.setValue(true);
    });
    expect(appPO.patternPO.pattern, r'^/user(?=/|$)');
    expect(appPO.matchPO.hasMatch, isTrue);
  });

  test('case insensitive route', () async {
    await testFixture.update((_) {
      appPO..routeInputPO.setValue('/user')..pathInputPO.setValue('/USER');
    });
    expect(appPO.matchPO.hasMatch, isFalse);
    await testFixture.update((_) {
      appPO.caseSensitiveCheckboxPO.setValue(false);
    });
    expect(appPO.matchPO.hasMatch, isTrue);
  });
}
