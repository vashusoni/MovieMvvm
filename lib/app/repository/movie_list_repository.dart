import 'package:flutter/cupertino.dart';
import 'package:movie_hub/app/data/network/BaseApiServices.dart';
import 'package:movie_hub/app/models/movie_details.dart';
import 'package:movie_hub/app/models/movie_model.dart';
import 'package:movie_hub/app/resources/appUrl.dart';

import '../data/network/NetWorkApiServices.dart';

class MovieRepository {
  final BaseApiService _apiService = NetWorkApiServices();

  Future<MovieModel> movieList(String val) async {
    dynamic response = await _apiService
        .getGetResponse("${AppUrl.baseUrl}?s=$val&apikey=${AppUrl.apiKey}");

    return response = MovieModel.fromJson(response);
  }

  Future<MovieDetails> movieDetails(String id) async {
    dynamic response = await _apiService
        .getGetResponse("${AppUrl.baseUrl}?i=$id&apikey=${AppUrl.apiKey}");

    return response = MovieDetails.fromJson(response);
  }
}
