import 'package:dio/dio.dart';
import 'package:flutter_assessment/network/service/api_service.dart';
import 'package:flutter_assessment/utils/constant/app_url.dart';

class PostDataApi {
  final ApiService _apiService = ApiService();

  Future<Response> getPostData(int pageNo, int resultCount) async {
    try {
      final Response response = await _apiService.get(AppUrl.postDataUrl(pageNo, resultCount));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postPostData({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.addPost,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updatePostData(String id, {Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.put(
        '${AppUrl.updatePost}/$id',
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deletePostData(String id) async {
    try {
      final Response response = await _apiService.delete(
        '${AppUrl.deletePost}/$id',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}