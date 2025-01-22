import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_assessment/models/post_model.dart';
import 'package:flutter_assessment/network/api/post_data_api.dart';
import 'package:flutter_assessment/network/service/api_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostsBloc extends Bloc<PostEvent, PostState> {
  final PostDataApi postDataApi;

  PostsBloc({required this.postDataApi}) : super(const PostState()) {
    on<GetPostsEvent>(_onGetPostsEvent, transformer: droppable());
  }

  Future<void> _onGetPostsEvent(GetPostsEvent event, Emitter<PostState> emit) async {
    try {
      emit(state.copyWith(status: PostStatus.loading));

      final nextPage = state.pageNo + 1;
      final response = await postDataApi.getPostData(nextPage, 10);

      if (response.statusCode == 200) {
        final postModel = PostModel.fromJson(response.data);

        final newPosts = postModel.results ?? [];
        final hasMorePosts = newPosts.isNotEmpty;

        emit(state.copyWith(
          status: PostStatus.success,
          posts: [...state.posts, ...newPosts],
          pageNo: hasMorePosts ? nextPage : state.pageNo,
          hasReachedMax: !hasMorePosts,
        ));
      }
    } on DioException catch (e) {
      final apiException = ApiException.fromDioException(e);
      emit(state.copyWith(status: PostStatus.error, errorMessage: apiException.message));
    }
  }
}
