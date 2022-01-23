import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';
import 'package:give_me_jobs_app/app/modules/home/home_state.dart';
import 'package:give_me_jobs_app/app/modules/home/home_store.dart';
import 'package:shimmer/shimmer.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.store,
  }) : super(key: key);

  final HomeStore store;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Home'),
          centerTitle: true,
          actions: [
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                ),
                const Positioned(
                  top: 5,
                  right: 5,
                  child: CircleAvatar(
                    child: Text('1'),
                    radius: 10,
                    backgroundColor: Colors.red,
                  ),
                )
              ],
            ),
          ],
        ),
        Positioned(
          bottom: -110,
          right: 0,
          left: 0,
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(65),
                  ),
                  child: TripleBuilder(
                    store: store,
                    builder: (context, triple) {
                      return CircleAvatar(
                        foregroundImage: store.user.imgUrl == null ||
                                store.user.imgUrl!.isEmpty
                            ? null
                            : NetworkImage(store.user.imgUrl!),
                        child: store.user.imgUrl == null ||
                                store.user.imgUrl!.isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 60,
                              )
                            : Shimmer.fromColors(
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                ),
                                baseColor: Colors.white,
                                highlightColor: Colors.grey,
                              ),
                        radius: 60,
                      );
                    },
                  )),
              ScopedBuilder<HomeStore, Exception, HomeState>(
                store: store,
                // onLoading: (context) => Column(
                //   children: [
                //     const SizedBox(
                //       height: 10,
                //     ),
                //     Shimmer.fromColors(
                //       baseColor: Colors.white,
                //       highlightColor: Colors.grey,
                //       child: Container(
                //         width: MediaQuery.of(context).size.width * .8,
                //         height: 30,
                //         color: Colors.grey[100],
                //       ),
                //     ),
                //   ],
                // ),
                onState: (context, triple) => Text.rich(
                  TextSpan(
                    text: '${store.user.fullname}\n',
                    style: AppTextStyles.content.copyWith(fontSize: 24),
                    children: [
                      TextSpan(
                        text:
                            '${store.user.course.name} - ${store.user.registration}',
                        style: AppTextStyles.content.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
