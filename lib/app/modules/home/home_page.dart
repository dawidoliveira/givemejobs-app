import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_app/app/modules/home/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:give_me_jobs_app/app/modules/home/widgets/list_vacancies/list_vacancies_widget.dart';
import 'package:give_me_jobs_app/app/modules/home/widgets/tab_bar/tab_bar_widget.dart';
import 'package:give_me_jobs_app/app/shared/widgets/custom_drawer/custom_drawer.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          store: store,
        ),
        preferredSize: const Size.fromHeight(140),
      ),
      drawer: const CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
        child: Column(
          children: [
            TabBarWidget(tabController: tabController),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ScopedBuilder(
                store: store,
                onState: (context, state) => TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListVacanciesWidget(
                      store: store,
                      list: store.state.vacancies!,
                    ),
                    ListVacanciesWidget(
                      store: store,
                      myVacancy: true,
                      list: store.state.myVacancies!,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
