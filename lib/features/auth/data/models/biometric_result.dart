import '../../domain/entities/biometric_result.dart';

class BiometricResultModel extends BiometricResult {
  const BiometricResultModel({
    required super.isSupported,
    required super.isAuthenticated,
    required super.message,
  });

  factory BiometricResultModel.fromEntity(BiometricResult entity) {
    return BiometricResultModel(
      isSupported: entity.isSupported,
      isAuthenticated: entity.isAuthenticated,
      message: entity.message,
    );
  }
}