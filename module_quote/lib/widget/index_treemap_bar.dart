import 'dart:convert';
import 'dart:core';

import 'package:library_base/mvvm/provider_widget.dart';
import 'package:library_base/res/gaps.dart';
import 'package:library_base/widget/chart/inapp_echart.dart';
import 'package:library_base/widget/easyrefresh/first_refresh.dart';
import 'package:flutter/material.dart';
import 'package:library_base/widget/easyrefresh/loading_empty.dart';
import 'package:module_quote/viewmodel/treemap_model.dart';

class IndexTreemapBar extends StatefulWidget {

  IndexTreemapBar({
    Key? key,
  }) : super(key: key);

  _IndexTreemapBarState createState() => _IndexTreemapBarState();
}

class _IndexTreemapBarState extends State<IndexTreemapBar> {

  late TreemapModel _treemapModel;

  @override
  void initState() {
    super.initState();

    initViewModel();
  }

  void initViewModel() {
    _treemapModel = TreemapModel();
    _treemapModel.getTreemap();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TreemapModel>(
        model: _treemapModel,
        builder: (context, model, child) {
          Widget echart = InappEcharts(
            onLoad: () {
              _treemapModel.setSuccess();
            },
            option: '''
            {
            series: [{
                type: 'treemap',
                squareRatio: 0.6,
                left: '0%',
                right: '0%',
                bottom: '0%',
                top: '0%',
                silent: true,
                nodeClick: false,
                roam: false,
                breadcrumb: {
                    show: false
                },
                levels: [
                    {
                        color: ['#651A21', '#8E242E', '#B72E3B', '#CC3341', '#8797AB', '#4E9768', '#45875D', '#3A794D', '#2B553A'],
                        visualMin: 0,
                        visualMax: 8,
                        colorMappingBy: 'value', 
                        visualDimension: 2,
                        
                        itemStyle: {
                            borderColor: '#fff',
                            borderWidth: 1,
                            gapWidth: 2,
                        },

                    }
                ],
                label: {
                    position: 'inside',
                    formatter: function (params) {
                        if (params.value[0] >= 700000000000) {
                          var arr = [
                              '{name|' + params.name + '}',
                              '{label|' + params.value[1] + '%'  + '}',
                          ];
          
                          return arr.join('\\n');
                        } else if (params.value[0] >= 250000000000) {
                          var arr = [
                              '{name2|' + params.name + '}',
                              '{label2|' + params.value[1] + '%' + '}',
                          ];
          
                          return arr.join('\\n');
                        } else {
                          var arr = [
                              '{name3|' + params.name + '}',
                              '{label3|' + params.value[1] + '%' + '}',
                          ];
          
                          return arr.join('\\n');
                        }
                    },
                    rich: {
                                label: {
                                    fontSize: 11,
                                    color: '#FFFFFF',
                                    lineHeight: 12,
                                    align: 'center'
                                },
                                name: {
                                    fontSize: 12,
                                    lineHeight: 12,
                                    color: '#FFFFFF',
                                    align: 'center'
                                },
                                label2: {
                                    fontSize: 9,
                                    color: '#FFFFFF',
                                    lineHeight: 9,
                                    align: 'center'
                                },
                                name2: {
                                    fontSize: 9,
                                    lineHeight: 9,
                                    color: '#FFFFFF',
                                    align: 'center'
                                },
                                label3: {
                                    fontSize: 6,
                                    color: '#FFFFFF',
                                    lineHeight: 6,
                                    align: 'center'
                                },
                                name3: {
                                    fontSize: 6,
                                    lineHeight: 6,
                                    color: '#FFFFFF',
                                    align: 'center'
                                },
                            }
                },
                data: ${jsonEncode(_treemapModel.treeData)}
            }]
            }
            ''',
          );
          return Scaffold(
              body: Column(
                children: [
                  Expanded (
                      child: Stack(
                          children: [
                            echart,
                            (_treemapModel.isFirst || _treemapModel.isIdle) ? FirstRefresh() :
                            (_treemapModel.isEmpty || _treemapModel.isError) ? LoadingEmpty() : Gaps.empty
                          ])
                  ),
                ],
              )
          );
        }
    );

  }

}

