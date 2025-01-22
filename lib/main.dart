import 'package:flutter/material.dart';
import 'package:flutter_assessment/bloc/post_bloc.dart';
import 'package:flutter_assessment/views/pages/post_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'helpers/bloc_observer.dart';
import 'network/api/post_data_api.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostsBloc(postDataApi: PostDataApi())
            ..add(GetPostsEvent()), // Initial event to fetch posts
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PostPage(),
      ),
    );
  }
}
