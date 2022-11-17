class NetworkResponse<T> {
  Status status;
  T? data;
  String? message;

  NetworkResponse.loading(this.message) : status = Status.loading;

  NetworkResponse.completed(this.data) : status = Status.completed;

  NetworkResponse.error(this.message) : status = Status.error;

  NetworkResponse.none() : status = Status.none;

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }
}

enum Status { loading, completed, error, none }
