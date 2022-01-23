import 'package:flutter/material.dart';
import 'package:give_me_jobs_app/app/core/app_text_styles.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  late int tab;

  @override
  void initState() {
    super.initState();
    tab = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(40),
      ),
      padding: const EdgeInsets.all(2),
      child: TabBar(
        controller: widget.tabController,
        labelColor: Colors.green,
        unselectedLabelColor: Colors.grey,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide.none,
        ),
        indicatorWeight: 0,
        onTap: (value) {
          setState(() {
            tab = widget.tabController.index;
          });
        },
        labelPadding: EdgeInsets.zero,
        tabs: [
          Tab(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              decoration: tab == 0
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    )
                  : null,
              child: Text(
                'Novas vagas',
                style: AppTextStyles.content,
              ),
            ),
          ),
          Tab(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              decoration: tab == 1
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    )
                  : null,
              child: Text(
                'Minhas vagas',
                style: AppTextStyles.content,
              ),
            ),
          )
        ],
      ),
    );
  }
}
