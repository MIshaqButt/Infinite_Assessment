import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/post_model.dart';
import 'package:flutter_assessment/utils/constant/app_color.dart';
import 'package:flutter_assessment/views/widgets/loading_widget.dart';
import 'package:intl/intl.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});

  final PostData post;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.postItemBackground,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: AppColor.iconColor,
                    size: 15,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Dating',
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Icon(
                Icons.more_horiz,
                color: AppColor.black,
                size: 15,
              ),
            ],
          ),
          Divider(
            color: AppColor.dividerColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Stack(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            // Circular border
                            border: Border.all(
                              color: AppColor.appBar,
                              width: 1.5, // Border thickness
                            ),
                          ),
                          padding: EdgeInsets.all(1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            // Circular clipping
                            child: CachedNetworkImage(
                              imageUrl: post.picture!.large!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => LoadingWidget(),
                              errorWidget: (context, url, error) => Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.appBar, width: 1.5),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        30), // Circular error container
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: AppColor.activeColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              border:
                                  Border.all(color: AppColor.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${post.name!.first} - ${post.dob!.age}',
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '${post.location!.postcode!.substring(0, 2)} km away from you',
                        style: TextStyle(
                          color: AppColor.hintColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_rounded,
                    color: AppColor.iconColor,
                    size: 25,
                  ),
                  SizedBox(width: 15),
                  Icon(
                    Icons.call,
                    color: AppColor.iconColor,
                    size: 25,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: AppColor.black,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Date',
                            style: TextStyle(
                              color: AppColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      FittedBox(
                        child: Text(
                          maxLines: 1,
                          DateFormat('EEE, MMM dd yyyy')
                              .format(DateTime.parse(post.registered!.date!)),
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      FittedBox(
                        child: Text(
                          DateFormat('HH:mm a')
                              .format(DateTime.parse(post.registered!.date!)),
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  color: AppColor.dividerColor,
                ),
                SizedBox(
                  width: size.width * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColor.black,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Location',
                            style: TextStyle(
                              color: AppColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      FittedBox(
                        child: Text(
                          "${post.location!.city}, ${post.location!.state}",
                          maxLines: 2,
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
