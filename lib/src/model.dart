import 'dart:collection';

import 'package:path_to_regexp/path_to_regexp.dart';

class Model {
  /// The regular expression created from [_route].
  RegExp _regExp;

  /// The tokens parsed from [_route].
  List<Token> _tokens;

  Model(String initialRoute, String initialPath)
      : _route = initialRoute,
        _path = initialPath {
    _updateTokens();
  }

  /// Whether [path] matches [route].
  bool get hasMatch => _args != null;

  /// Arguments extracted from the matching [path].
  UnmodifiableMapView<String, String> _args;
  UnmodifiableMapView<String, String> get args => _args;

  /// Parameters declared in [_route].
  UnmodifiableListView<ParameterToken> _parameters;
  UnmodifiableListView<ParameterToken> get parameters => _parameters;

  /// The path to match.
  String _path;
  String get path => _path;
  set path(String value) {
    _path = value;
    _updateMatch();
  }

  /// The pattern created to match [route].
  String get pattern => _regExp.pattern;

  /// Whether this route matches as a prefix.
  bool _prefix = false;
  bool get prefix => _prefix;
  set prefix(bool value) {
    _prefix = value;
    _updateRegExp();
  }

  /// The path specification to turn into a regular expression.
  String _route;
  String get route => _route;
  set route(String value) {
    _route = value;
    _updateTokens();
  }

  void _updateMatch() {
    final match = _regExp.matchAsPrefix(_path);
    if (match != null) {
      final parameters = _parameters.map((p) => p.name).toList();
      _args = UnmodifiableMapView(extract(parameters, match));
    } else {
      _args = null;
    }
  }

  void _updateRegExp() {
    _regExp = tokensToRegExp(_tokens, prefix: _prefix);
    _updateMatch();
  }

  void _updateTokens() {
    _tokens = parse(_route);
    // TODO: replace with `whereType()` once supported by dart2js.
    final parameters = <ParameterToken>[];
    for (final token in _tokens) {
      if (token is ParameterToken) {
        parameters.add(token);
      }
    }
    _parameters = UnmodifiableListView(parameters);
    _updateRegExp();
  }
}
