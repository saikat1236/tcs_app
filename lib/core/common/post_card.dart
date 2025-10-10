// import 'package:any_link_preview/any_link_preview.dart';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:photo_view/photo_view.dart';

// import 'image_view.dart';
// import 'media_cache.dart';

// class PostCard extends ConsumerWidget {
//   final Post post;
//   const PostCard({
//     super.key,
//     required this.post,
//   });

//   void deletePost(WidgetRef ref, BuildContext context) async {
//     ref.read(postControllerProvider.notifier).deletePost(post, context);
//   }

//   void upvotePost(WidgetRef ref) async {
//     ref.read(postControllerProvider.notifier).upvote(post);
//   }

//   void downvotePost(WidgetRef ref) async {
//     ref.read(postControllerProvider.notifier).downvote(post);
//   }

//   void awardPost(WidgetRef ref, String award, BuildContext context) async {
//     ref
//         .read(postControllerProvider.notifier)
//         .awardPost(post: post, award: award, context: context);
//   }

//   void navigateToUser(BuildContext context) {
//     Navigator.of(context)
//         .pushNamed(UserProfileScreen.routeName, arguments: {'uid': post.uid});
//   }

//   void navigateToCommunity(BuildContext context) {
//     Navigator.of(context).pushNamed(CommunityScreen.routeName,
//         arguments: {'name': post.communityName});
//   }

//   void navigateToComments(BuildContext context) {
//     // Navigator.of(context).push('/post/${post.id}/comments');
//     Navigator.of(context)
//         .pushNamed(CommentsScreen.routeName, arguments: {'postId': post.id});
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isTypeImage = post.type == 'image';
//     final isTypeText = post.type == 'text';
//     final isTypeLink = post.type == 'link';
//     final user = ref.watch(userProvider)!;
//     final isGuest = !user.isAuthenticated;

//     final currentTheme = ref.watch(themeNotifierProvider);

//     var diffHour = DateTime.now().difference(post.createdAt).inHours;
//     var diffDays = DateTime.now().difference(post.createdAt).inDays;
//     var diffMin = DateTime.now().difference(post.createdAt).inMinutes;
//     var diffSec = DateTime.now().difference(post.createdAt).inSeconds;

//     return Responsive(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 8),
//             decoration: BoxDecoration(
//                 color: const Color.fromARGB(119, 223, 221, 215),
//                 borderRadius: BorderRadius.circular(20)),
//             padding: const EdgeInsets.symmetric(vertical: 5),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (kIsWeb)
//                   Column(
//                     children: [
//                       IconButton(
//                         onPressed: isGuest ? () {} : () => upvotePost(ref),
//                         icon: Icon(
//                           Constants.up,
//                           size: 22,
//                           color: post.upvotes.contains(user.uid)
//                               ? Pallete.redColor
//                               : null,
//                         ),
//                       ),
//                       Text(
//                         '${post.upvotes.length - post.downvotes.length == 0 ? 'Vote' : post.upvotes.length - post.downvotes.length}',
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                       IconButton(
//                         onPressed: isGuest ? () {} : () => downvotePost(ref),
//                         icon: Icon(
//                           Constants.down,
//                           size: 22,
//                           color: post.downvotes.contains(user.uid)
//                               ? Pallete.blueColor
//                               : null,
//                         ),
//                       ),
//                     ],
//                   ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 2,
//                           horizontal: 5,
//                         ).copyWith(right: 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     post.communityName.isEmpty
//                                         ? const SizedBox()
//                                         : GestureDetector(
//                                             onTap: () =>
//                                                 navigateToCommunity(context),
//                                             child: CircleAvatar(
//                                               backgroundImage: NetworkImage(
//                                                 post.communityProfilePic,
//                                               ),
//                                               radius: 16,
//                                             ),
//                                           ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 5),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               post.communityName.isEmpty
//                                                   ? const SizedBox()
//                                                   : Text(
//                                                       post.communityName,
//                                                       maxLines: 1,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: const TextStyle(
//                                                         fontSize: 13,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     ),
//                                               const Padding(
//                                                 padding: EdgeInsets.all(8),
//                                                 child: Icon(
//                                                   Icons.circle,
//                                                   size: 6,
//                                                 ),
//                                               ),
//                                               GestureDetector(
//                                                 onTap: () =>
//                                                     navigateToUser(context),
//                                                 child: Text(
//                                                   post.username,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   maxLines: 1,
//                                                   style: const TextStyle(
//                                                       fontSize: 10),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           if (diffDays > 30)
//                                             Text(
//                                                 '${(diffDays / 30).truncate()} months ago'),
//                                           if (diffDays > 0 && diffDays <= 30)
//                                             Text('$diffDays days ago',
//                                                 style: const TextStyle(
//                                                     fontSize: 10)),
//                                           if (diffHour < 24 && diffMin > 60)
//                                             Text('$diffHour hours ago',
//                                                 style: const TextStyle(
//                                                     fontSize: 10)),
//                                           if (diffMin < 60 && diffSec > 60)
//                                             Text('$diffMin minutes ago',
//                                                 style: const TextStyle(
//                                                     fontSize: 10)),
//                                           if (diffSec < 60)
//                                             Text('$diffSec seconds ago',
//                                                 style: const TextStyle(
//                                                     fontSize: 10)),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 if (post.uid == user.uid &&
//                                     post.communityName.isNotEmpty)
//                                   IconButton(
//                                     onPressed: () => deletePost(ref, context),
//                                     icon: const Icon(
//                                       Icons.delete_outlined,
//                                       color: Pallete.greyColor,
//                                     ),
//                                   ),
//                               ],
//                             ),
//                             if (post.awards.isNotEmpty &&
//                                 post.communityName.isNotEmpty) ...[
//                               const SizedBox(height: 5),
//                               SizedBox(
//                                 height: 25,
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: post.awards.length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     final award = post.awards[index];
//                                     return Image.asset(
//                                       Constants.awards[award]!,
//                                       height: 23,
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 10.0, left: 20, bottom: 5),
//                               child: InkWell(
//                                 onTap: () => navigateToComments(context),
//                                 child: Text(
//                                   post.title,
//                                   maxLines: 1,
//                                   softWrap: true,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             if (isTypeImage)
//                               Center(
//                                 child: SizedBox(
//                                   // width: 250,
//                                   height: 150,
//                                   child: FutureBuilder(
//                                     future: MediaCache.downloadImage(
//                                         post.link!, 'image'),
//                                     builder: ((context, snapshot) {
//                                       if (snapshot.hasData) {
//                                         return GestureDetector(
//                                           onTap: () {
//                                             //HeroDialogRoute
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       ImageViewScreen(
//                                                     child: PhotoView(
//                                                       maxScale:
//                                                           PhotoViewComputedScale
//                                                                   .contained *
//                                                               4,
//                                                       minScale:
//                                                           PhotoViewComputedScale
//                                                                   .contained *
//                                                               1,
//                                                       backgroundDecoration:
//                                                           const BoxDecoration(
//                                                               color: Colors
//                                                                   .transparent),
//                                                       imageProvider: FileImage(
//                                                           snapshot.data!),
//                                                     ),
//                                                   ),
//                                                 ));
//                                           },
//                                           child: Container(
//                                             clipBehavior: Clip.antiAlias,
//                                             decoration: const BoxDecoration(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(12))),
//                                             child: Image.file(
//                                               snapshot.data!,
//                                               fit: BoxFit.contain,
//                                             ),
//                                           ),
//                                         );
//                                       } else {
//                                         return const Loader();
//                                       }
//                                     }),
//                                   ),
//                                 ),
//                               ),
//                             // Container(
//                             //   width: double.infinity,
//                             //   height: 150,
//                             //   padding: const EdgeInsets.all(5),
//                             //   decoration: BoxDecoration(
//                             //     borderRadius: BorderRadius.circular(10),
//                             //   ),
//                             //   child: Image.network(
//                             //     post.link!,
//                             //     fit: BoxFit.contain,
//                             //   ),
//                             // ),
//                             if (isTypeLink)
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 18),
//                                 child: AnyLinkPreview(
//                                   displayDirection:
//                                       UIDirection.uiDirectionHorizontal,
//                                   link: post.link!,
//                                   cache: const Duration(days: 3),
//                                   // urlLaunchMode: ,
//                                   // `onTap: () {
//                                   //   Navigator.push(context, MaterialPageRoute(
//                                   //     builder: (context) {
//                                   //       return Scaffold(
//                                   //         appBar: AppBar(
//                                   //           title: Text('he'),
//                                   //         ),
//                                   //       );
//                                   //     },
//                                   //   ));
//                                   // },  `
//                                 ),
//                               ),
//                             if (isTypeText)
//                               InkWell(
//                                 onTap: () => navigateToComments(context),
//                                 child: Container(
//                                   alignment: Alignment.bottomLeft,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         // softWrap: true,
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         post.description!,
//                                         style: const TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       if (post.description!.length >= 80)
//                                         Text(
//                                           'more...',
//                                           style: TextStyle(
//                                               color: currentTheme
//                                                   .colorScheme.error),
//                                         )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 if (!kIsWeb)
//                                   Row(
//                                     children: [
//                                       // const Icon(Icons.exposure_plus_1_rounded),
//                                       IconButton(
//                                         onPressed: isGuest
//                                             ? () {
//                                                 showSnackBar(context,
//                                                     'opps! your are in anony mode');
//                                               }
//                                             : () => upvotePost(ref),
//                                         icon: Icon(
//                                           Constants.up,
//                                           // Icons.exposure_plus_1_sharp,
//                                           size: 16,
//                                           color: post.upvotes.contains(user.uid)
//                                               ? Pallete.redColor
//                                               : null,
//                                         ),
//                                       ),
//                                       Text(
//                                         '${post.upvotes.length - post.downvotes.length == 0 ? 'Vote' : post.upvotes.length - post.downvotes.length}',
//                                         style: const TextStyle(fontSize: 12),
//                                       ),
//                                       IconButton(
//                                         onPressed: isGuest
//                                             ? () {}
//                                             : () => downvotePost(ref),
//                                         icon: Icon(
//                                           Constants.down,
//                                           // Icons.exposure_minus_1_rounded,
//                                           size: 16,
//                                           color:
//                                               post.downvotes.contains(user.uid)
//                                                   ? Pallete.blueColor
//                                                   : null,
//                                         ),
//                                       ),
//                                       // const Icon(
//                                       // Icons.exposure_minus_1_rounded),
//                                     ],
//                                   ),
//                                 InkWell(
//                                   onTap: () => navigateToComments(context),
//                                   child: Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.comment_outlined,
//                                         size: 18,
//                                       ),
//                                       Text(
//                                         '${post.commentCount == 0 ? ' Comment' : post.commentCount}',
//                                         style: const TextStyle(fontSize: 11),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 if (post.communityName.isNotEmpty)
//                                   ref
//                                       .watch(getCommunityByNameProvider(
//                                           post.communityName))
//                                       .when(
//                                         data: (data) {
//                                           if (data.mods.contains(user.uid)) {
//                                             return IconButton(
//                                               onPressed: () => showDialog(
//                                                   context: context,
//                                                   builder: ((context) {
//                                                     return Center(
//                                                       child: Container(
//                                                         color: Colors.white,
//                                                         height: 150,
//                                                         width: 300,
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(10),
//                                                         child: Column(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .center,
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .center,
//                                                             children: [
//                                                               const Text(
//                                                                   'you are a moderator of this community, as such you have the power to remove this post permanently. DO you have what it takes to have the wrath of your community members ?'),
//                                                               TextButton(
//                                                                   onPressed: () =>
//                                                                       deletePost(
//                                                                           ref,
//                                                                           context),
//                                                                   child: Text(
//                                                                     'yes, delete',
//                                                                     style:
//                                                                         TextStyle(
//                                                                       color: currentTheme
//                                                                           .primaryColor,
//                                                                     ),
//                                                                   ))
//                                                             ]),
//                                                       ),
//                                                     );
//                                                   })),
//                                               icon: const Icon(
//                                                 Icons
//                                                     .admin_panel_settings_outlined,
//                                               ),
//                                             );
//                                           }
//                                           return const SizedBox();
//                                         },
//                                         error: (error, stackTrace) => ErrorText(
//                                           error: error.toString(),
//                                         ),
//                                         loading: () => const Loader(),
//                                       ),
//                                 if (post.communityName.isEmpty)
//                                   const SizedBox(
//                                     width: 120,
//                                   ),
//                                 if (post.communityName.isNotEmpty)
//                                   IconButton(
//                                     onPressed: isGuest
//                                         ? () {
//                                             showSnackBar(context,
//                                                 'oops! seems you are in anonymous mode');
//                                           }
//                                         : () {
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) => Dialog(
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(20),
//                                                   child: GridView.builder(
//                                                     shrinkWrap: true,
//                                                     gridDelegate:
//                                                         const SliverGridDelegateWithFixedCrossAxisCount(
//                                                       crossAxisCount: 4,
//                                                     ),
//                                                     itemCount:
//                                                         user.awards.length,
//                                                     itemBuilder:
//                                                         (BuildContext context,
//                                                             int index) {
//                                                       final award =
//                                                           user.awards[index];

//                                                       return GestureDetector(
//                                                         onTap: () => awardPost(
//                                                             ref,
//                                                             award,
//                                                             context),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                           child: Image.asset(
//                                                               Constants.awards[
//                                                                   award]!),
//                                                         ),
//                                                       );
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                     icon: const Icon(
//                                         Icons.card_giftcard_outlined),
//                                   ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 10),
//         ],
//       ),
//     );
//   }
// }
