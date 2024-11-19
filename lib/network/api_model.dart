class ApiModel<T>{
  T? data;
  ApiState apiState;

  ApiModel({
    this.data,
  required  this.apiState
  });
  ApiModel.loading({
    this.data,
    this.apiState=ApiState.loading
  });
  ApiModel.success({
    this.data,
    this.apiState=ApiState.success
  });
  ApiModel.error({
    this.data,
    this.apiState=ApiState.error
  });
  bool isLoading()=>apiState==ApiState.loading;
  bool isSuccess()=>apiState==ApiState.success;
  bool isError()=>apiState==ApiState.error;
}
//susses state
//error state
//loading state
enum ApiState{
  loading,
  success,
  error
}