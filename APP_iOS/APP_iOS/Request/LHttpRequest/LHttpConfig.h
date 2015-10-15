//
//  LHttpHeader.h
//  baseProject
//
//  Created by Li on 5/5/15.
//  Copyright (c) 2015 Li. All rights reserved.
//

#define kServerUrl      @"http://121.40.131.81/shopping/mall/app/"
#define kSuccessCode    @"1"
#define kSuccessKey     @"success"

#ifndef DLog
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif
#endif
