//
//  config.swift
//  MyRx
//
//  Created by Hony on 2017/1/3.
//  Copyright © 2017年 Hony. All rights reserved.
//


import UIKit
import UIColor_Hex_Swift


struct UIConst {
    
    /// 主题色
    static let themeColor = UIColor("#435356")
    
    /// 首页pagecontroll 的黄色
    static let yellowPageColor = UIColor.red
    /// 首页pagecontroll 的灰色
    static let grayPageColor = UIColor.red
    
    /// 屏幕宽度
    static let screenWidth = UIScreen.main.bounds.width
    /// 屏幕高度
    static let screenHeight = UIScreen.main.bounds.height
    /// 宽高比
    static let screenScale = UIScreen.main.scale
    
    /// nav 高度
    static let navHeight = 64.0
    
    static let str = "0.15,0.32,0.23,0.19,0.20,0.18,0.25,0.29,0.30,0.36,0.29,0.23,0.33,0.22,0.18,0.40,0.25,0.24,0.33,0.26,0.19,0.21,0.21,0.22,0.34,0.27,0.20,0.20,0.22,0.22,0.20,0.15,0.29,0.30,0.24,0.19,0.21,0.22,0.21,0.17,0.22,0.39,0.33,0.26,0.26,0.26,0.26,0.24,0.23,0.23,0.22,0.20,0.19,0.20,0.30,0.27,0.47,0.33,0.45,0.35,0.56,0.48,0.62,0.35,0.47,0.54,0.41,0.46,0.43,0.52,0.56,0.53,0.41,0.51,0.41,0.40,0.37,0.56,0.45,0.65,0.40,0.46,0.48,0.49,0.47,0.43,0.53,0.43,0.64,0.49,0.42,0.60,0.61,0.54,0.49,0.52,0.78,0.42,0.52,0.54,0.48,0.58,0.55,0.40,0.30,1.00,0.52,0.58,0.60,0.53,0.64,0.52,0.50,0.69,0.49,0.52,0.61,0.48,0.59,0.50,0.61,0.60,0.82,0.41,0.71,0.56,0.56,0.61,0.46,0.50,0.62,0.52,0.31,0.72,0.74,0.59,0.60,0.51,0.79,0.64,0.36,0.68,0.86,0.69,0.68,0.40,0.58,0.68,0.74,0.49,0.57,0.45,0.55,0.58,0.52,0.60,0.76,0.40,0.58,0.81,0.44,0.61,0.64,0.65,0.46,0.77,0.50,0.56,0.51,0.59,0.55,0.57,0.50,0.71,0.58,0.41,0.60,0.56,0.62,0.53,0.59,0.59,0.61,0.26,0.80,0.67,0.60,0.55,0.70,0.49,0.58,0.48,0.45,0.59,0.30,0.55,0.43,0.88,0.44,0.75,0.60,0.54,0.60,0.56,0.74,0.68,0.53,0.46,0.79,0.50,0.58,0.73,0.68,0.57,0.71,0.50,0.70,0.53,0.60,0.50,0.64,0.56,0.56,0.58,0.66,0.67,0.47,0.52,0.61,0.70,0.51,0.58,0.32,0.70,0.52,0.52,0.55,0.47,0.62,0.57,0.50,0.58,0.71,0.51,0.52,0.58,0.44,0.60,0.55,0.56,0.61,0.66,0.44,0.72,0.65,0.50,0.54,0.52,0.53,0.77,0.48,0.48,0.58,0.55,0.59,0.52,0.41,0.56,0.76,0.61,0.68,0.53,0.61,0.57,0.56,0.46,0.79,0.52,0.61,0.56,0.50,0.47,0.40,0.76,0.71,0.76,0.60,0.57,0.70,0.58,0.67,0.61,0.54,0.70,0.58,0.50,0.72,0.63,0.49,0.62,0.74,0.56,0.73,0.58,0.59,0.61,0.41,0.75,0.61,0.49,0.58,0.71,0.65,0.66,0.64,0.57,0.54,0.64,0.57,0.68,0.52,0.66,0.56,0.70,0.73,0.55,0.54,0.70,0.57,0.67,0.62,0.59,0.49,0.43,0.43,0.41,0.67,0.51,0.62,0.60,0.41,0.51,0.30,0.47,0.47,0.67,0.40,0.58,0.36,0.46,0.43,0.46,0.47,0.61,0.47,0.30,0.36,0.40,0.39,0.41,0.32,0.33,0.66,0.24,0.27,0.32,0.38,0.32,0.35,0.35,0.50,0.55,0.36,0.31,0.32,0.36,0.29,0.36,0.34,0.60,0.31,0.28,0.27,0.33,0.38,0.35,0.32,0.38,0.56,0.32,0.33,0.32,0.34,0.32,0.30,0.32,0.55,0.36,0.32,0.30,0.32,0.39,0.29,0.35,0.32,0.52,0.29,0.30,0.31,0.33,0.37,0.29,0.34,0.49,0.41,0.27,0.25,0.24,0.38,0.30,0.34,0.31,0.57,0.31,0.36,0.35,0.32,0.24,0.26,0.30,0.37,0.50,0.27,0.25,0.28,0.37,0.28,0.30,0.33,0.64,0.33,0.28,0.35,0.39,0.37,0.28,0.34,0.41,0.67,0.31,0.30,0.30,0.49,0.49,0.45,0.43,0.63,0.42,0.40,0.42,0.37,0.46,0.48,0.54,0.45,0.48,0.49,0.70,0.56,0.61,0.56,0.46,0.47,0.69,0.48,0.46,0.56,0.44,0.51,0.42,0.51,0.56,0.62,0.34,0.31,0.50,0.44,0.52,0.57,0.52,0.61,0.72,0.55,0.57,0.56,0.58,0.63,0.57,0.53,0.77,0.44,0.30,0.44,0.55,0.50,0.16,0.23,0.75,0.80,0.40,0.61,0.57,0.71,0.49,0.58,0.55,0.71,0.53,0.50,0.70,0.50,0.60,0.57,0.58,0.54,0.71,0.43,0.58,0.57,0.55,0.52,0.52,0.43,0.62,0.59,0.49,0.47,0.36,0.56,0.44,0.45,0.54,0.71,0.46,0.54,0.45,0.57,0.42,0.60,0.47,0.53,0.68,0.54,0.49,0.57,0.58,0.59,0.51,0.54,0.71,0.47,0.62,0.52,0.49,0.54,0.57,0.52,0.46,0.77,0.45,0.65,0.39,0.43,0.51,0.52,0.59,0.66,0.53,0.58,0.59,0.40,0.64,0.45,0.75,0.55,0.69,0.43,0.44,0.55,0.56,0.62,0.51,0.45,0.77,0.67,0.44,0.57,0.55,0.55,0.51,0.50,0.55,0.78,0.50,0.53,0.61,0.51,0.56,0.50,0.60,0.53,0.70,0.36,0.63,0.58,0.53,0.55,0.52,0.52,0.71,0.48,0.63,0.43,0.53,0.57,0.53,0.54,0.62,0.68,0.37,0.66,0.49,0.56,0.54,0.51,0.50,0.59,0.46,0.45,0.51,0.39,0.43,0.42,0.29,0.39,0.63,0.44,0.45,0.46,0.55,0.47,0.49,0.47,0.63,0.55,0.35,0.52,0.44,0.61,0.45,0.52,0.44,0.70,0.36,0.56,0.54,0.55,0.53,0.59,0.49,0.43,0.78,0.46,0.36,0.36,0.48,0.47,0.41,0.46,0.74,0.50,0.47,0.49,0.47,0.44,0.58,0.55,0.66,0.61,0.48,0.52,0.50,0.42,0.55,0.55,0.45,0.60,0.48,0.51,0.42,0.42,0.43,0.50,0.51,0.45,0.62,0.36,0.53,0.48,0.38,0.33,0.34,0.38,0.48,0.49,0.44,0.43,0.40,0.52,0.46,0.47,0.42,0.57,0.38,0.42,0.42,0.42,0.54,0.42,0.49,0.49,0.55,0.40,0.48,0.52,0.45,0.41,0.49,0.45,0.45,0.42,0.48,0.40,0.43,0.40,0.28,0.32,0.31,0.51,0.32,0.37,0.29,0.36,0.31,0.28,0.33,0.49,0.38,0.27,0.28,0.28,0.37,0.31,0.37,0.33,0.56,0.28"

}

