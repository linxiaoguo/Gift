//
//  LHttpHeader.h
//  baseProject
//
//  Created by Li on 5/5/15.
//  Copyright (c) 2015 Li. All rights reserved.
//

#define kServerUrl      @"http://110.84.128.171:7060/gzydh/api?apiName="
#define kSuccessCode    @"0000"
#define kSuccessKey     @"code"

#ifndef DLog
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif
#endif
