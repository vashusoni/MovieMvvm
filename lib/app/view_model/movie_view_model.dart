import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_hub/app/data/response/API_RESPONSE.dart';
import 'package:movie_hub/app/models/movie_details.dart';
import 'package:movie_hub/app/models/movie_model.dart';
import 'package:movie_hub/app/repository/movie_list_repository.dart';
import 'package:movie_hub/app/utils/utils.dart';

class MovieViewModel with ChangeNotifier {
  final _movieRepo = MovieRepository();

  String _val = 'dead';
  String _movieid = '';

  void setValue(String val, BuildContext context) {
    _val = val;
    searchMovie(context);
    notifyListeners();
  }

  void setMovieId(String val, BuildContext context) {
    _movieid = val;
    searchMovieDetails(val, context);
    notifyListeners();
  }

  APIResponse<MovieModel> movieList = APIResponse.loading();
  APIResponse<MovieDetails> movieDetails = APIResponse.loading();

  void setMovieList(APIResponse<MovieModel> response) {
    movieList = response;
    notifyListeners();
  }

  void setMovieDetails(APIResponse<MovieDetails> response) {
    movieDetails = response;
    notifyListeners();
  }

  Future<void> searchMovie(BuildContext context) async {
    setMovieList(APIResponse.loading());
    _movieRepo
        .movieList(
      _val,
    )
        .then((value) {
      setMovieList(APIResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setMovieList(APIResponse.error(error.toString()));
    });
  }

  Future<void> searchMovieDetails(String id, BuildContext context) async {
    setMovieList(APIResponse.loading());
    _movieRepo.movieDetails(id).then((value) {
      setMovieDetails(APIResponse.completed(value));
    }).onError((error, stackTrace) {
      setMovieList(APIResponse.error(error.toString()));
    });
    notifyListeners();
  }
}
