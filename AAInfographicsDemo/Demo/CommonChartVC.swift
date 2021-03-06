//
//  ViewController.swift
//  AAChartKit-Swift
//
//  Created by An An  on 17/4/18.
//  Copyright © 2017年 An An . All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 *********************************************************************************
 *
 *  🌕 🌖 🌗 🌘  ❀❀❀   WARM TIPS!!!   ❀❀❀ 🌑 🌒 🌓 🌔
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit-Swift/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/7842508/codeforu
 * JianShu       : http://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 *********************************************************************************
 
 */

import UIKit

class CommonChartVC: UIViewController,UIWebViewDelegate {
    open var chartType: AAChartType?
    open var step : Bool?
    open var aaChartModel: AAChartModel?
    open var aaChartView: AAChartView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = self.chartType.map { $0.rawValue }
        self.configureTheSwith()
        self.configureTheSegmentControl()
        
        aaChartView = AAChartView()
        let chartViewWidth = self.view.frame.size.width
        let chartViewHeight = self.view.frame.size.height-220
        aaChartView?.frame = CGRect(x:0,y:60,width:chartViewWidth,height:chartViewHeight)
        ///AAChartViewd的内容高度(内容高度默认和 AAChartView 等高)
        aaChartView?.contentHeight = chartViewHeight-20
        self.view.addSubview(aaChartView!)
        aaChartView?.scrollEnabled = false//禁止图表内容滚动
        
        aaChartModel = AAChartModel()
            .chartType(self.chartType!)//图形类型
            .colorsTheme(["#9b43b4","#ef476f","#ffd066","#04d69f","#25547c",])//主题颜色数组
            .title("")//图形标题
            .subtitle("")//图形副标题
            .dataLabelEnabled(false)//是否显示数字
            .tooltipValueSuffix("℃")//浮动提示框单位后缀
            .backgroundColor("#ffffff")//图表背景色(默认就是白色)
            .animationType(AAChartAnimationType.Bounce)//图形渲染动画类型为"bounce"
            .series([
                AASeriesElement()
                    .name("Tokyo")
                    .data([7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6])
                    .toDic()!,
                AASeriesElement()
                    .name("New York")
                    .data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5])
                    .toDic()!,
                AASeriesElement()
                    .name("Berlin")
                    .data([0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0])
                    .toDic()!,
                AASeriesElement()
                    .name("London")
                    .data([3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8])
                    .toDic()!,])
        
        self.configureTheStyleForDifferentTypeChart()
        
        aaChartView?.aa_drawChartWithChartModel(aaChartModel!)
        
    }
    
    func configureTheStyleForDifferentTypeChart() {
        
        if (self.chartType == AAChartType.Area && self.step == true)
            || (self.chartType == AAChartType.Line && self.step == true) {
            aaChartModel = self.chartType == AAChartType.Area ? aaChartModel?.gradientColorEnable(true) : aaChartModel?.gradientColorEnable(false)
            aaChartModel = aaChartModel?.series([
                AASeriesElement()
                    .name("Berlin")
                    .data([149.9, 171.5, 106.4, 129.2, 144.0, 176.0, 135.6, 188.5, 276.4, 214.1, 95.6, 54.4])
                    .step(true)//设置折线样式为直方折线,连接点位置默认靠左👈
                    .toDic()!,
                AASeriesElement()
                    .name("New York")
                    .data([83.6, 78.8, 188.5, 93.4, 106.0, 84.5, 105.0, 104.3, 131.2, 153.5, 226.6, 192.3])
                    .step(true)//设置折线样式为直方折线,连接点位置默认靠左👈
                    .toDic()!,
                AASeriesElement()
                    .name("Tokyo")
                    .data([48.9, 38.8, 19.3, 41.4, 47.0, 28.3, 59.0, 69.6, 52.4, 65.2, 53.3, 72.2])
                    .step(true)//设置折线样式为直方折线,连接点位置默认靠左👈
                    .toDic()!,
                ])
            
        } else if self.chartType == AAChartType.Column
            || self.chartType == AAChartType.Bar {
            aaChartModel = aaChartModel?
                .categories(["Jan", "Feb", "Mar", "Apr", "May", "Jun","Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
                .legendEnabled(true)
                .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])
                .animationType(AAChartAnimationType.Bounce)
                .animationDuration(1200)
        } else if self.chartType == AAChartType.Area
            || self.chartType == AAChartType.AreaSpline {
            aaChartModel = aaChartModel?
                .symbolStyle(AAChartSymbolStyleType.InnerBlank)//设置折线连接点样式为:内部白色
                .gradientColorEnable(true)
                .legendEnabled(true)
                .markerRadius(5)
                .symbol(AAChartSymbolType.Circle)
            
            if self.chartType == AAChartType.AreaSpline {
                aaChartModel = aaChartModel?
                    .gradientColorEnable(false)
                    .animationType(AAChartAnimationType.EaseFrom)//设置图表渲染动画类型为 EaseFrom
                    .series([
                        AASeriesElement()
                            .name("Tokyo Hot")
                            .data([0.45, 0.43, 0.50, 0.55, 0.58, 0.62, 0.83, 0.39, 0.56, 0.67, 0.50, 0.34, 0.50, 0.67, 0.58, 0.29, 0.46, 0.23, 0.47, 0.46, 0.38, 0.56, 0.48, 0.36])
                            .toDic()!,
                        AASeriesElement()
                            .name("Berlin Hot")
                            .data([0.38, 0.31, 0.32, 0.32, 0.64, 0.66, 0.86, 0.47, 0.52, 0.75, 0.52, 0.56, 0.54, 0.60, 0.46, 0.63, 0.54, 0.51, 0.58, 0.64, 0.60, 0.45, 0.36, 0.67])
                            .toDic()!,
                        AASeriesElement()
                            .name("New York Hot")
                            .data([0.46, 0.32, 0.53, 0.58, 0.86, 0.68, 0.85, 0.73, 0.69, 0.71, 0.91, 0.74, 0.60, 0.50, 0.39, 0.67, 0.55, 0.49, 0.65, 0.45, 0.64, 0.47, 0.63, 0.64])
                            .toDic()!,
                        AASeriesElement()
                            .name("London Hot")
                            .data([0.60, 0.51, 0.52, 0.53, 0.64, 0.84, 0.65, 0.68, 0.63, 0.47, 0.72, 0.60, 0.65, 0.74, 0.66, 0.65, 0.71, 0.59, 0.65, 0.77, 0.52, 0.53, 0.58, 0.53])
                            .toDic()!,
                        ])
            }
            
        } else if self.chartType == AAChartType.Line
            || self.chartType == AAChartType.Spline {
            aaChartModel = aaChartModel?
                .symbolStyle(AAChartSymbolStyleType.BorderBlank)//设置折线连接点样式为:边缘白色
                .markerRadius(6)
            if self.chartType == AAChartType.Spline {
                aaChartModel = aaChartModel?
                    .animationType(AAChartAnimationType.SwingFromTo)
                    .series([
                        AASeriesElement()
                            .name("Tokyo")
                            .data([50, 320, 230, 370, 230, 400,])
                            .toDic()!,
                        AASeriesElement()
                            .name("New York")
                            .data([80, 390, 210, 340, 240, 350,])
                            .toDic()!,
                        AASeriesElement()
                            .name("Berlin")
                            .data([100, 370, 180, 280, 260, 300,])
                            .toDic()!,
                        AASeriesElement()
                            .name("London")
                            .data([130, 350, 160, 310, 250, 268,])
                            .toDic()!,
                        ])
            }
        }
    }
    
    func configureTheSegmentControl() {
        var segmentedNamesArray:NSArray
        var typeLabelNameArr:NSArray
        
        if self.chartType == AAChartType.Column
            || self.chartType == AAChartType.Bar {
            segmentedNamesArray = [["No stacking",
                                    "Normal stacking",
                                    "Percent stacking"],
                                   ["Square corners",
                                    "Rounded corners",
                                    "Wedge"]
            ];
            typeLabelNameArr = ["Stacking type selection",
                                "Corners Style type selection"];
        } else {
            segmentedNamesArray = [["No stacking",
                                    "Normal stacking",
                                    "Percent stacking"],
                                   ["Circle",
                                    "Square",
                                    "Diamond",
                                    "Triangle",
                                    "Triangle-down"]
            ];
            typeLabelNameArr = ["Stacking type selection",
                                "Chart symbol type selection"];
        }
        
        for  i in 0..<segmentedNamesArray.count {
            let segment = UISegmentedControl.init(items: segmentedNamesArray[i] as? [Any])
            segment.frame = CGRect(x: 20, y: 40.0*CGFloat(i) + (self.view.frame.size.height-145), width: self.view.frame.size.width-40, height: 20)
            segment.tag = i;
            segment.tintColor = UIColor.red
            segment.selectedSegmentIndex = 0
            segment.addTarget(self, action:#selector(segmentDidSelected(segmentedControl:)), for:.valueChanged)
            self.view.addSubview(segment)
            
            let subLabel = UILabel()
            subLabel.font = UIFont(name: "EuphemiaUCAS", size: 12.0)
            subLabel.frame = CGRect(x: 20, y: 40*CGFloat(i)+(self.view.frame.size.height-165), width: self.view.frame.size.width-40, height: 20)
            subLabel.numberOfLines = 0
            subLabel.text = typeLabelNameArr[i] as? String
            subLabel.backgroundColor = UIColor.white
            self.view.addSubview(subLabel)
        }
    }
    
    func segmentDidSelected(segmentedControl:UISegmentedControl) {
        
        switch segmentedControl.tag {
        case 0:
            let stackingArr = [AAChartStackingType.False,
                               AAChartStackingType.Normal,
                               AAChartStackingType.Percent]
            aaChartModel = aaChartModel?.stacking(AAChartStackingType(rawValue: stackingArr[segmentedControl.selectedSegmentIndex].rawValue)!)
            break
            
        case 1:
            if self.chartType == AAChartType.Column || self.chartType == AAChartType.Bar {
                let borderRadiusArr = [0,10,100]
                aaChartModel = aaChartModel?.borderRadius(borderRadiusArr[segmentedControl.selectedSegmentIndex])
            } else {
                let symbolArr = [AAChartSymbolType.Circle,
                                 AAChartSymbolType.Square,
                                 AAChartSymbolType.Diamond,
                                 AAChartSymbolType.Triangle,
                                 AAChartSymbolType.Triangle_down]
                aaChartModel = aaChartModel?.symbol(AAChartSymbolType(rawValue: symbolArr[segmentedControl.selectedSegmentIndex].rawValue)!)
            }
            break
            
        default:
            break
        }
        aaChartView?.aa_refreshChartWholeContentWithChartModel(aaChartModel!)
    }
    
    func configureTheSwith() {
        var nameArr:NSArray
        var switchWidth:CGFloat
        
        if self.chartType == AAChartType.Column || self.chartType == AAChartType.Bar {
            nameArr = ["xReversed",
                       "yReversed",
                       "xInverted",
                       "Polarization",
                       "DataShow",];
            switchWidth = (self.view.frame.size.width-40)/5
        } else {
            nameArr = ["xReversed",
                       "yReversed",
                       "xInverted",
                       "Polarization",
                       "DataShow",
                       "HideMarker"];
            switchWidth = (self.view.frame.size.width-40)/6
        }
        
        for  i in 0..<nameArr.count {
            let uiswitch = UISwitch()
            uiswitch.frame = CGRect(x: switchWidth*CGFloat(i)+20, y: self.view.frame.size.height-70, width: switchWidth, height: 20)
            uiswitch.isOn = false
            uiswitch.tag = i;
//            uiswitch.onTintColor = UIColor.blue
            uiswitch.addTarget(self, action: #selector(switchDidChange(switchView:)), for:.valueChanged)
            self.view.addSubview(uiswitch)
            
            let subLabel = UILabel()
            subLabel.font = UIFont(name: "EuphemiaUCAS", size: nameArr.count == 5 ? 10.0:9.0)
            subLabel.frame = CGRect(x: switchWidth*CGFloat(i)+20, y:self.view.frame.size.height-45, width:  switchWidth, height: 35)
            subLabel.numberOfLines = 0
            subLabel.text = nameArr[i] as? String
            subLabel.backgroundColor = UIColor.clear
            self.view .addSubview(subLabel)
        }
    }
    
    func switchDidChange(switchView:UISwitch) {
        
        switch switchView.tag {
        case 0:
            aaChartModel = aaChartModel?.xAxisReversed(switchView.isOn)
            break
        case 1:
            aaChartModel = aaChartModel?.yAxisReversed(switchView.isOn)
            break
        case 2:
            aaChartModel = aaChartModel?.inverted(switchView.isOn)
            break
        case 3:
            aaChartModel = aaChartModel?.polar(switchView.isOn)
            break
        case 4:
            aaChartModel = aaChartModel?.dataLabelEnabled(switchView.isOn)
            break
        case 5:
            aaChartModel = aaChartModel?.markerRadius(switchView.isOn ? 0:5)//折线连接点半径长度,为0时相当于没有折线连接点
            break
        default:
            break
        }
        
        aaChartView?.aa_refreshChartWholeContentWithChartModel(aaChartModel!)
    }
    
}

