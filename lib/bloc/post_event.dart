part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPostsEvent extends PostEvent{
}

class PageNoEvent extends PostEvent {
  final int pageNo;

  const PageNoEvent(this.pageNo);
}