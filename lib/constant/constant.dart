import 'package:flutter/foundation.dart';

class Constant {
  static const bool isReleaseMode = kReleaseMode;

  static const String ERRNO = 'errno';
  static const String MESSAGE = 'message';
  static const String ERRNO_OK = "OK";
  static const String ERRNO_DIO_ERROR = "DIOERROR";
  static const String ERRNO_UNKNOWN = "UNKNOWN";
  static const String ERRNO_UNKNOWN_MESSAGE = "UNKNOWN MESSAGE";
  static const String ERRNO_FORBIDDEN = "FORBIDDEN";

  static const String KEY_VER = "vf-Ver";
  static const String KEY_DEV = "vf-Dev";
  static const String KEY_DEVICE_ID = "vf-DeviceId";
  static const String KEY_LANGUAGE = "vf-Language";
  static const String KEY_CHANNEL = "vf-Channel";
  static const String KEY_USER_TOKEN = "vf-Token";
  static const String KEY_USER_TS = "vf-Ts";
  static const String KEY_USER_SIGN = "vf-Sign";

  static const String PRIVATE_KEY = "5ffF03b858D5Fd16";       //测试环境
  static const String BASE_URL = 'http://testapi.paomian.co';  //测试环境

  static bool get isTestEnvironment => (BASE_URL == 'http://testapi.paomian.co');

  static const String URL_LOGIN = '/user/login';
  static const String URL_REGISTER = '/user/register';
  static const String URL_VERIFY_CODE = '/user/verifyCode';
  static const String URL_RESET_PASSWORD = '/user/resetPassword';
  static const String URL_GET_ACCOUNT_INFO = '/user/getAccountInfo';

}
