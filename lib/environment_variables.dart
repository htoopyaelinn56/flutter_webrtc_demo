import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentVariables {
  static final String sfuAppId = dotenv.get('sfu_app_id');
  static final String sfuApiToken = dotenv.get('sfu_api_token');
}
