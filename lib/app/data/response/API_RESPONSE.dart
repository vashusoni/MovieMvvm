import 'package:movie_hub/app/data/response/status.dart';

class APIResponse<T> {
  Status? status;
  T? data;
  String? message;

  APIResponse(this.status, this.message, this.data);

  APIResponse.loading() : status = Status.LOADING;

  APIResponse.completed(this.data) : status = Status.COMPLETED;

  APIResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status:$status\n Message: $message  \n Data:$data";
  }
}
