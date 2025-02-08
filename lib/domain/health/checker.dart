/// Интерфейс для проверки здоровья API
abstract class HealthChecker {
  Future<bool> checkApiHealth();
}
