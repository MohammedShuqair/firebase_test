
import 'package:firebase_test/models/follow_response.dart';
import 'package:firebase_test/network/endpoints.dart';
import 'package:firebase_test/network/network_helper.dart';

/// use [NetworkHelper] to get data as Map
/// and return Model object
class FollowRepository{

  static Future<Followee?> followUser(int id)async{
  try {
    final data= await NetworkHelper.postData(Endpoints.follow, {
        "followee_id":"$id",
      });
     return FollowResponse.fromJson(data).followee;
  }  catch (e) {
    print("error ${e}");

    rethrow;
  }

  }
}