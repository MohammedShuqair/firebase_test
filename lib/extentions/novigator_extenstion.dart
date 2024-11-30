import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension NovigatorExtenstion on BuildContext {
  Future<T?> push<T>(Widget destination) async {
    return await Navigator.push<T>(
        this, MaterialPageRoute(builder: (_) => destination));
  }
}
