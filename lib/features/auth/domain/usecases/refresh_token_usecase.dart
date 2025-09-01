import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';

/// Refresh token use case
/// Handles token refresh when access token expires
class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  Future<Either<Failure, AuthToken>> call(String refreshToken) async {
    // Validate refresh token
    if (refreshToken.isEmpty) {
      return const Left(ValidationFailure('Refresh token is required'));
    }

    // Perform token refresh
    return await repository.refreshToken(refreshToken);
  }
}