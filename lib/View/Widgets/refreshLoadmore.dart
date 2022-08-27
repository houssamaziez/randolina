import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

class RereshLoadmor extends StatefulWidget {
    RereshLoadmor({Key? key,required this.widgetref}) : super(key: key);
final widgetref;
  @override
  State<RereshLoadmor> createState() => _RereshLoadmorState();
}

class _RereshLoadmorState extends State<RereshLoadmor> {
   

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length+1).toString());
    if(mounted)
    setState(() {

    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: Container(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
          itemExtent: 100.0,
          itemCount: items.length,
        ),
      ),
    );
  }

  // from 1.5.0, it is not necessary to add this line
  //@override
 // void dispose() {
    // TODO: implement dispose
  //  _refreshController.dispose();
  //  super.dispose();
 // }
}