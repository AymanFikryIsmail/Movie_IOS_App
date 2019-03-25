//
//  BaseContract.h
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol BaseContract <NSObject>

@protocol IBaseView <NSObject>

-(void) showLoading;
-(void) hideLoading;
-(void) showErrorMessage : (NSString*) errorMessage;

@end

NS_ASSUME_NONNULL_END
