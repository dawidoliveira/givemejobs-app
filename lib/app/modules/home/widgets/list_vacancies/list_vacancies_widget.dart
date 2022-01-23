import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/modules/home/home_state.dart';
import 'package:give_me_jobs_app/app/modules/home/home_store.dart';
import 'package:give_me_jobs_app/app/modules/home/widgets/item_vacancy/item_vacancy_widget.dart';
import 'package:give_me_jobs_app/app/shared/models/vacancy_model.dart';
import 'package:shimmer/shimmer.dart';

class ListVacanciesWidget extends StatefulWidget {
  const ListVacanciesWidget({
    Key? key,
    this.myVacancy = false,
    required this.store,
    required this.list,
  }) : super(key: key);

  final bool myVacancy;
  final HomeStore store;

  final List<VacancyModel> list;

  @override
  _ListVacanciesWidgetState createState() => _ListVacanciesWidgetState();
}

class _ListVacanciesWidgetState extends State<ListVacanciesWidget> {
  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<HomeStore, Exception, HomeState>(
      store: widget.store,
      onLoading: (_) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: 4,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) => Shimmer.fromColors(
            child: ListTile(
              title: Container(
                height: 20,
                color: Colors.black,
              ),
              subtitle: Container(
                margin: const EdgeInsets.only(top: 10),
                height: 20,
                color: Colors.black,
              ),
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            baseColor: Colors.white,
            highlightColor: Colors.grey,
          ),
        );
      },
      onState: (context, state) => RefreshIndicator(
        onRefresh: () async {
          await widget.store.init();
        },
        child: ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final vacancy = widget.list[index];
            return ItemVacancyWidget(
              vacancy: vacancy,
              onTap: widget.myVacancy
                  ? () {
                      widget.store.seeMyVacancy(
                        vacancy: vacancy,
                      );
                    }
                  : () {
                      widget.store.seeVacancy(
                        vacancy: vacancy,
                      );
                    },
            );
          },
          itemCount: widget.list.length,
          separatorBuilder: (_, __) => const Divider(),
        ),
      ),
    );
  }
}
