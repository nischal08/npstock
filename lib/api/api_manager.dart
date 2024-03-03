import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:npstock/data/enum/request_type.dart';
import 'package:npstock/data/exception/app_exceptions.dart';
import 'package:npstock/data/exception/request_type_exception.dart';

class ApiManager {
  late final Dio _client;
  dynamic responseJson;

  final timeoutDuration = const Duration(seconds: 60);
  ApiManager() {
    _client = Dio();
    _client.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        requestBody: true,
      ),
    );
  }
  Future request({
    required RequestType requestType,
    // dynamic heading = Nothing,
    required String url,
    dynamic parameter,
    dynamic headers,
    ResponseType? responseType,
  }) async {
    Map<String, String> heading = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };

    Response? resp;
    // if (!UtilityProvider.canCallApi()) {
    //   throw "Inactive for too long, Please login";
    // }

    try {
      switch (requestType) {
        case RequestType.get:
          resp = await _client
              .get(
                url,
                options: Options(
                  headers: heading,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.post:
          resp = await _client
              .post(
                url,
                data: parameter,
                options: Options(
                  headers: heading,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.patch:
          resp = await _client
              .patch(
                url,
                data: parameter,
                options: Options(
                  headers: heading,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.postWithHeaders:
          resp = await _client
              .post(
                url,
                data: parameter,
                options: Options(
                  headers: {...heading, ...headers},
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.postWithOnlyHeaders:
          resp = await _client
              .post(
                url,
                data: parameter,
                options: Options(
                  headers: headers,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.delete:
          resp = await _client
              .delete(
                url,
                options: Options(
                  headers: heading,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        default:
          return throw RequestTypeNotFoundException(
            "The HTTP request method is not found",
          );
      }
      return returnResponse(resp);
    } on DioException catch (ex) {
      // if (ex.response!.statusCode == 401) {
      //   await _getRefreshToken();
      //   // navKey.currentState!.pushReplacementNamed(RoutesName.login);
      //   // DatabaseHelperProvider().deleteToken();
      // }

      // if (ex.response!.statusCode == 400) {
      // if (ex.response!.data["coupon_code"] != null) {
      //   throw ex.response!.data["coupon_code"][0];
      // } else if (ex.response!.data["coupon"] != null) {
      //   throw ex.response!.data["coupon"];
      // } else if (ex.response!.data["email"] != null) {
      //   throw ex.response!.data["email"][0];
      // } else
      // if (ex.response!.data[0] != null) {
      // throw ex.response!.data[0];
      // }
      // }

      throw ex.response?.data?["message"] ??
          "Dear customer, we are unable to complete the process. Please try again later.";
    } catch (ex) {
      rethrow;
    }
  }

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _client.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        return responseJson;

      case 201:
        dynamic responseJson = response.data;
        return responseJson;

      case 400:
        dynamic responseJson = response.data;
        throw BadRequestException(responseJson
            .toString()
            .split('[')
            .last
            .trim()
            .replaceAll(']}', ""));

      case 403:
        throw ForbidenIp(response.data.toString());

      case 404:
        dynamic responseJson = jsonDecode(response.data);
        throw UnauthorizedException(responseJson['email'][0].toString());

      default:
        throw FetchDataException(
            'Error occurred while communicating with server '
            'with status code {response.statusCode.toString()}');
    }
  }
}
