

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/constant/constant.dart';
import 'package:lighthouse/net/model/account.dart';
import 'package:lighthouse/net/rt_account.dart';
import 'package:lighthouse/utils/date_util.dart';
import 'package:lighthouse/utils/device_util.dart';
import 'package:lighthouse/utils/encrypt_util.dart';
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

    options.headers[Constant.KEY_VER] = version;
    options.headers[Constant.KEY_DEV] = dev;
    options.headers[Constant.KEY_LANGUAGE] = language;
    options.headers[Constant.KEY_CHANNEL] = channel;
    options.headers[Constant.KEY_USER_TS] = timestamp;

    if (RTAccount.instance().isLogin()) {
      Account account = RTAccount.instance().getActiveAccount();
      String sign = EncryptUtil.encodeAes(account?.token, Constant.PRIVATE_KEY, timestamp);
      options.headers[Constant.KEY_USER_TOKEN] = account?.token;
      options.headers[Constant.KEY_USER_SIGN] = sign;

    } else {
      options.headers[Constant.KEY_USER_TOKEN] = '';
      options.headers[Constant.KEY_USER_SIGN] = '';
    }

    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }
}
