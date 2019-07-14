//
//  SynthesizeSingleton.h
//  CocoaWithLove
//
//  Created by Matt Gallagher on 20/10/08.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

// 声明单件类的类方法
#define DECLARE_SINGLETON_FOR_CLASS(classname) \
+ (classname*)shared##classname;

// 获取单件实例的宏定义
#define GET_SINGLET(classname) \
[classname shared##classname]

// 合成单件类
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil;\
\
+ (classname *)shared##classname \
{ \
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
shared##classname = [[self alloc] init];\
});\
return shared##classname; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
} \
\


