import 'package:firebase_test/logic/follow_provider.dart';
import 'package:firebase_test/network/endpoints.dart';
import 'package:firebase_test/network/network_helper.dart';
import 'package:firebase_test/respository/follow_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/follow_response.dart';

class FollowScreen extends StatelessWidget {
  const FollowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FollowProvider>(
      create: (BuildContext context) => FollowProvider(),
      child: Scaffold(
        appBar:AppBar(
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                    onPressed: () async {
                      Provider.of<FollowProvider>(
                          context,
                          listen: false
                      ).follow(
                          id: 9,
                          context: context,
                      );
                },
                    icon: Icon(Icons.error));
              }
            ),
          ],
        ),
          body: Center(
            child: Consumer<FollowProvider>(
              builder: (context, provider, child) {
                if(provider.followeeResponse==null){
                  return Text("No effect");
                }
                if(provider.followeeResponse!.isError()){
                  return Text("Error");
                }
                if(provider.followeeResponse!.isLoading()){
                  return CircularProgressIndicator();
                }else{
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${provider.followeeResponse!.data?.user?.name}"),
                      Text("${provider.followeeResponse!.data?.user?.email}"),
                    ],
                  );
                }

              },
            )
            ,)),
    );
  }
}
