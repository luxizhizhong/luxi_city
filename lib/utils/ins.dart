
import 'package:dio/dio.dart';
import 'package:luxi_city/config/const.dart';

// or new Dio with a BaseOptions instance.
BaseOptions _options = new BaseOptions(
    baseUrl: ConstKey.baseURL,
    connectTimeout: 5000,
    receiveTimeout: 3000,
);

Dio dio = new Dio(_options);