import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/follow_response.dart';
import '../network/api_model.dart';
import '../network/network_helper.dart';
import '../respository/follow_repository.dart';


class FollowProvider extends ChangeNotifier{
ApiModel<Followee>? followeeResponse;

  void follow({
    required int id,
    required BuildContext context,
  })async{
    try {
      followeeResponse=ApiModel.loading();
      notifyListeners();
       final data= await FollowRepository.followUser(id);
      followeeResponse=ApiModel.success(data: data);
       notifyListeners();
    }  catch (e) {
      followeeResponse=ApiModel.error();
      notifyListeners();
      AppException appException=e as AppException;
      ScaffoldMessenger.of(context)
          .showSnackBar(
          SnackBar(
              content: Text(
                  "${appException.statusCode}${appException.message}"
              )));
    }
  }
}