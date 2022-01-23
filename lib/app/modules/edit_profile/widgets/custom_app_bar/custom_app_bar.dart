import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';
import 'package:give_me_jobs_app/app/modules/edit_profile/edit_profile_state.dart';
import 'package:give_me_jobs_app/app/modules/edit_profile/edit_profile_store.dart';
import 'package:shimmer/shimmer.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.store,
  }) : super(key: key);

  final EditProfileStore store;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Editar perfil',
            style: AppTextStyles.content,
          ),
          centerTitle: true,
        ),
        Positioned(
          bottom: -60,
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
                child: ScopedBuilder<EditProfileStore, Exception,
                    EditProfileState>(
                  store: store,
                  onLoading: (_) {
                    return CircleAvatar(
                      child: Shimmer.fromColors(
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
                  onState: (context, triple) => CircleAvatar(
                    foregroundImage: triple.user == null ||
                            triple.user!.imgUrl == null ||
                            triple.user!.imgUrl!.isEmpty
                        ? null
                        : triple.user!.imgUrl!.contains('http')
                            ? NetworkImage(triple.user!.imgUrl!)
                            : FileImage(File(triple.user!.imgUrl!))
                                as ImageProvider<Object>?,
                    child: triple.user == null ||
                            triple.user!.imgUrl == null ||
                            triple.user!.imgUrl!.isEmpty
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
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
