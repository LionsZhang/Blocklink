
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library_base/net/apis.dart';
import 'package:library_base/model/account.dart';
import 'package:library_base/global/rt_account.dart';
import 'package:library_base/utils/date_util.dart';
import 'package:library_base/utils/device_util.dart';
import 'package:library_base/utils/encrypt_util.dart';
import 'package:package_info/package_info.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo?.version;
    String language = WidgetsBinding.instance.window.locale.toString();
    String dev = DeviceUtil.isAndroid ? 'Android' : (DeviceUtil.isIOS ? 'iOS' : (DeviceUtil.isWeb ? 'Web' : 'Other'));
    String channel = 'official';
    String timestamp = (DateUtil.getNowDateMs() * 1000).toString();

    options.headers[Apis.KEY_VER] = version;
    options.headers[Apis.KEY_DEV] = dev;
    options.headers[Apis.KEY_LANGUAGE] = language;
    options.headers[Apis.KEY_CHANNEL] = channel;
    options.headers[Apis.KEY_USER_TS] = timestamp;

    if (RTAccount.instance().isLogin()) {
      Account account = RTAccount.instance().getActiveAccount();
      String sign = EncryptUtil.encodeAes(account?.token, Apis.PRIVATE_KEY, timestamp).substring(0, 64);
      options.headers[Apis.KEY_USER_TOKEN] = account?.token;
      options.headers[Apis.KEY_USER_U_ID] = account?.account_id.toString();
      options.headers[Apis.KEY_USER_SIGN] = sign;

    } else {
      options.headers[Apis.KEY_USER_TOKEN] = '';
      options.headers[Apis.KEY_USER_U_ID] = '';
      options.headers[Apis.KEY_USER_SIGN] = '';
    }

    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }
}