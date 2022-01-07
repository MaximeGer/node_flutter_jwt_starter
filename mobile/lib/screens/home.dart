import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/models/cities.dart';
import 'package:mobile/utils/functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                await logout();
                context.go("/login");
              },
              child: const Text("logout")),
          Center(
            child: FutureBuilder<List<City>>(
              future: fetchCities(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('${snapshot.data![index].name}');
                      });
                } else if (snapshot.hasError) {
                  return Text('error ${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
