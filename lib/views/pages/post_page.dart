import 'package:flutter/material.dart';
import 'package:flutter_assessment/bloc/post_bloc.dart';
import 'package:flutter_assessment/utils/constant/app_color.dart';
import 'package:flutter_assessment/views/widgets/loading_widget.dart';
import 'package:flutter_assessment/views/widgets/post_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearch);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<PostsBloc>().add(GetPostsEvent());
    }
  }

  void _onSearch() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AppBar(
              backgroundColor: AppColor.appBar,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                  top: Radius.circular(20),
                ),
              ),
              title: const Text(
                "Dating List",
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const BackButton(
                color: AppColor.white,
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColor.black,
                      ),
                      filled: true,
                      fillColor: AppColor.textFieldBackground,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),

              centerTitle: true,
              elevation: 0,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BlocBuilder<PostsBloc, PostState>(
          builder: (context, state) {
            if (state.status == PostStatus.loading && state.posts.isEmpty) {
              return const LoadingWidget();
            }

            if (state.status == PostStatus.error) {
              return Center(
                child: Text(state.errorMessage),
              );
            }

            final filteredPosts = state.posts
                .where((post) =>
                (post.name?.first ?? '').toLowerCase().contains(_searchQuery))
                .toList();

            if (filteredPosts.isEmpty) {
              return const Center(
                child: Text("No matching posts found."),
              );
            }

            return ListView.builder(
              controller: _scrollController,
              itemCount: filteredPosts.length +
                  (state.status == PostStatus.loading ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index >= filteredPosts.length) {
                  return const LoadingWidget();
                }
                return PostListItem(post: filteredPosts[index]);
              },
            );
          },
        ),
      ),
    );

  }
}
