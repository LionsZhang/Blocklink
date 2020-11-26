

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lighthouse/generated/l10n.dart';
import 'package:lighthouse/net/constant.dart';
import 'package:lighthouse/net/dio_util.dart';
import 'package:lighthouse/net/model/global_quote.dart';
import 'package:lighthouse/res/colors.dart';
import 'package:lighthouse/res/styles.dart';
import 'package:lighthouse/ui/item/global_quote_item.dart';
import 'package:lighthouse/ui/page/base_page.dart';
import 'package:lighthouse/ui/widget/button/back_button.dart';
import 'package:lighthouse/ui/widget/common_scroll_view.dart';
import 'package:lighthouse/ui/widget/easyrefresh/first_refresh.dart';
import 'package:lighthouse/ui/widget/shot_view.dart';
import 'package:lighthouse/utils/image_util.dart';
import 'package:lighthouse/utils/toast_util.dart';



class GlobalQuotePage extends StatefulWidget {

  GlobalQuotePage({
    Key key,
  }) : super(key: key);

  @override
  _GlobalQuotePageState createState() => _GlobalQuotePageState();
}

class _GlobalQuotePageState extends State<GlobalQuotePage> with BasePageMixin<GlobalQuotePage>, SingleTickerProviderStateMixin {

  ShotController _shotController = new ShotController();

  List<GlobalQuote> _dataList = [];
  bool _init = false;

  @override
  void initState() {
    super.initState();
    _requestData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> refresh({slient = false}) {
    return _requestData();
  }

  Future<void> _requestData() {

    Map<String, dynamic> params = {
      'auth': 1,
      'sort': 1,
      'page': 0,
      'page_size': 10,
    };

    return DioUtil.getInstance().post(Constant.URL_GET_NEWS, params: params,
        successCallBack: (data, headers) {
          if (data == null || data['data'] == null) {
            _finishRequest(success: false);
            return;
          }

          List<GlobalQuote> briefList = GlobalQuote.fromJsonList(data['data']['account_info']) ?? [];

          _dataList.clear();
          _dataList.addAll(briefList);
          _finishRequest(success: true);
        },
        errorCallBack: (error) {
          _finishRequest(success: false);
          ToastUtil.error(error[Constant.MESSAGE]);
        });
  }

  void _finishRequest({bool success}) {
    if (!_init) {
      _init = true;
    }

    setState((){});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colours.gray_100,
        appBar: AppBar(
            leading: BackButtonEx(),
            elevation: 0,
            brightness: Brightness.light,
            backgroundColor: Colours.white,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.share, color: Colours.black,),
                  onPressed: () async {
                    Uint8List pngBytes = await _shotController.makeImageUint8List();

                    Navigator.push(context, new MaterialPageRoute(builder: (_) {
                      return Scaffold(
                          appBar: AppBar(
                            title: Text('shot widget'),
                          ),
                          body: CommonScrollView(
                            children: [
                              Image.memory(pngBytes),
                            ],
                          )
                      );
                    }));
                  }),
            ],
            centerTitle: true,
            title: Text(S.of(context).globalQuote, style: TextStyles.textBlack18)
        ),
        body: ShotView(
          controller: _shotController,
          child: RefreshIndicator(
            onRefresh: _requestData,
            child: !_init ? FirstRefresh() : CommonScrollView(
              physics: ClampingScrollPhysics(),
              children: [
                Stack(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      child: Container(
                        height: 428,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImageUtil.getImgPath('bg_world_map')),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: AspectRatio (
                          aspectRatio: 1.7,
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                    margin: EdgeInsets.symmetric(horizontal: 12 , vertical: 9),
                    decoration: BoxDecoration(
                      color: Colours.white,
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      boxShadow: BoxShadows.normalBoxShadow,
                    ),
                    child: Column(
                      children: [

                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 18, 15, 20),
                          child: Text('BTC交易中', style: TextStyles.textGray500_w400_16),
                        ),

                        GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 12),
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.95,
                          ),
                          itemCount: _dataList.length,
                          itemBuilder: (_, index) {
                            return GlobalQuoteItem(
                              index: index,
                              tradePlatform: '',
                              price: '12345.22',
                              rate: '10.11%',
                            );
                          },
                        )
                      ],
                    )
                ),

              ],
            )
          ),
        )
    );
  }

}