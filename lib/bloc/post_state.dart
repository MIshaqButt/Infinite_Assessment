part of 'post_bloc.dart';

enum PostStatus { loading, success, error }

class PostState extends Equatable {
  final PostStatus status;
  final List<PostData> posts;
  final bool hasReachedMax;
  final String errorMessage;
  final int pageNo;

  const PostState({
    this.status = PostStatus.loading,
    this.hasReachedMax = false,
    this.posts = const [],
    this.errorMessage = "",
    this.pageNo = 1,
  });

  PostState copyWith({
    PostStatus? status,
    List<PostData>? posts,
    bool? hasReachedMax,
    String? errorMessage,
    int? pageNo,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      pageNo: pageNo ?? this.pageNo,
    );
  }

  @override
  List<Object?> get props => [status, posts, hasReachedMax, errorMessage, pageNo];
}
