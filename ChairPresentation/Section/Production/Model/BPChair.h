//
//  BPChair.h
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/23.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BPChair <NSObject>
@end

@interface BPChair : JSONModel
/*
 2016-03-23 15:20:22.142 FMDB[2146:144735] ..:pillowfuction = 3D
 2016-03-23 15:20:22.153 FMDB[2146:144735] ..:serial = 金豪+
 2016-03-23 15:20:22.154 FMDB[2146:144735] ..:chairback_height = 背高可调
 2016-03-23 15:20:22.155 FMDB[2146:144735] ..:discount3_interval = 2200-2250
 2016-03-23 15:20:22.155 FMDB[2146:144735] ..:discount3_price = 2206.44
 2016-03-23 15:20:22.156 FMDB[2146:144735] ..:cushion_height = 座高可调
 2016-03-23 15:20:22.156 FMDB[2146:144735] ..:application_metting = 会议椅
 2016-03-23 15:20:22.157 FMDB[2146:144735] ..:cushion_deep = 座深可调
 2016-03-23 15:20:22.158 FMDB[2146:144735] ..:section = 4段
 2016-03-23 15:20:22.159 FMDB[2146:144735] ..:application_relaxation = 无
 2016-03-23 15:20:22.170 FMDB[2146:144735] ..:application_charge = 主管办公椅
 2016-03-23 15:20:22.171 FMDB[2146:144735] ..:application_staff = 职员办公椅
 2016-03-23 15:20:22.172 FMDB[2146:144735] ..:handrail_function = 4D扶手
 2016-03-23 15:20:22.173 FMDB[2146:144735] ..:cushion_angle = 座角度可调
 2016-03-23 15:20:22.173 FMDB[2146:144735] ..:fabric_pillow = 网
 2016-03-23 15:20:22.174 FMDB[2146:144735] ..:chairback_waist = 腰高可调
 2016-03-23 15:20:22.175 FMDB[2146:144735] ..:namech = 金豪+L-AG-HAM
 2016-03-23 15:20:22.175 FMDB[2146:144735] ..:id = 1
 2016-03-23 15:20:22.176 FMDB[2146:144735] ..:application_train = 无
 2016-03-23 15:20:22.187 FMDB[2146:144735] ..:function = 头枕可高度及角度调整；全球首创单杆式操控底盘（专利型）可同步倾仰，多段锁定，人性化后仰弹力调整；椅背可高低调整,自动弹性腰枕（专利型）；椅座可高低、深度及角度调整；扶手可高低升降，扶手面旋转角度，宽度及前后可调。
 2016-03-23 15:20:22.188 FMDB[2146:144735] ..:discount35_interval = 2550-2600
 2016-03-23 15:20:22.189 FMDB[2146:144735] ..:fabric_backcushion = 网
 2016-03-23 15:20:22.190 FMDB[2146:144735] ..:liestyle = 可选配躺舒宝
 2016-03-23 15:20:22.190 FMDB[2146:144735] ..:application_chatting = 洽谈椅
 2016-03-23 15:20:22.191 FMDB[2146:144735] ..:fabric_cushion = 网
 2016-03-23 15:20:22.191 FMDB[2146:144735] ..:discount35_price = 2574.18
 2016-03-23 15:20:22.192 FMDB[2146:144735] ..:nameen = EHPL-AG-HAM
 2016-03-23 15:20:22.192 FMDB[2146:144735] ..:price = 6810.0
 2016-03-23 15:20:22.199 FMDB[2146:144735] ..:application_office = 无
 2016-03-23 15:20:22.201 FMDB[2146:144735] ..:material_description = 头枕、背垫、腰枕及椅座均为进口网布；灰色塑胶框架，TPU扶手垫；操控杆、头枕插条、头枕横把手、背支撑架、扶手垫支撑座、扶手升降按钮、扶手管、底盘支撑架均为铝合金精抛光；进口100mm气压棒,340mm铝合金精抛光椅脚,65mm PU滑轮。
 2016-03-23 15:20:22.202 FMDB[2146:144735] ..:chairback_waistadjust = 3D自动弹力调整
 */

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *namech;
@property (nonatomic, copy) NSString *nameen;
@property (nonatomic, copy) NSString *serial;
@property (nonatomic, copy) NSString *material_description;

@property (nonatomic, copy) NSString *function;

@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) CGFloat discount3_price;
@property (nonatomic, copy) NSString *discount3_interval;
@property (nonatomic, assign) CGFloat discount35_price;

@property (nonatomic, copy) NSString *discount35_interval;
@property (nonatomic, copy) NSString *application_charge;
@property (nonatomic, copy) NSString *application_staff;
@property (nonatomic, copy) NSString *application_metting;
@property (nonatomic, copy) NSString *application_chatting;

@property (nonatomic, copy) NSString *application_office;
@property (nonatomic, copy) NSString *application_relaxation;
@property (nonatomic, copy) NSString *application_train;
@property (nonatomic, copy) NSString *fabric_pillow;
@property (nonatomic, copy) NSString *fabric_backcushion;

@property (nonatomic, copy) NSString *fabric_cushion;
@property (nonatomic, copy) NSString *pillowfuction;
@property (nonatomic, copy) NSString *chairback_height;
@property (nonatomic, copy) NSString *chairback_waist;
@property (nonatomic, copy) NSString *chairback_waistAdjust;

@property (nonatomic, copy) NSString *cushion_height;
@property (nonatomic, copy) NSString *cushion_deep;
@property (nonatomic, copy) NSString *cushion_angle;
@property (nonatomic, copy) NSString *section;
@property (nonatomic, copy) NSString *handrail_function;

@property (nonatomic, copy) NSString *lieStyle;
@property (nonatomic, assign) NSInteger rank;

@end