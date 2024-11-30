class DataModel<T> {
  T? data;
  DataState apiState;
  String? message;

  DataModel({this.data, required this.apiState});

  DataModel.loading(
      {this.data, this.message, this.apiState = DataState.loading});

  DataModel.success(
      {this.data, this.message, this.apiState = DataState.success});

  DataModel.error({this.data, this.message, this.apiState = DataState.error});

  bool isLoading() => apiState == DataState.loading;

  bool isSuccess() => apiState == DataState.success;

  bool isError() => apiState == DataState.error;
}

//susses state
//error state
//loading state
enum DataState { loading, success, error }
