import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

class AuthRepositoryInfrastructure extends AuthRepositoryDomain {
  /*

  // Normalment la implementació seria així, es a dir,
  // cada vegada que cridi un data source genero la
  // seva instancia per a despres cridar els metodes
  final AuthDatasourceDomain datasource;

  AuthRepositoryInfrastructure(this.datasource);
  */

  // En aquest cas la majoria de cops sera el mateix datasource
  // i per tant, no em cal generar una instancia de cadascun
  // per tant, apurare una miqueta mes per a estalviar feina
  // al processdor
  final AuthDatasourceDomain datasource;

  AuthRepositoryInfrastructure({AuthDatasourceDomain? datasource})
      : datasource = datasource ?? AuthDatasourceInfrastructure();

  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return datasource.register(email, password, fullName);
  }
}
