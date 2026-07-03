import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/target_model.dart';

abstract class TargetRemoteDataSource {
  Future<TargetModel> fetchTarget();
}

class TargetRemoteDataSourceImpl implements TargetRemoteDataSource {
  const TargetRemoteDataSourceImpl();

  @override
  Future<TargetModel> fetchTarget() async {
    try {
      final jsonString = await rootBundle.loadString(
        AppConstants.targetJsonPath,
      );

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

      return TargetModel.fromJson(jsonMap);
    } catch (e) {
      throw DataSourceException('Failed to load target location: $e');
    }
  }
}
