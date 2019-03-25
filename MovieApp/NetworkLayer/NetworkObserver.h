//
//  NetworkObserver.h
//  MovieApp
//
//  Created by Admin on 3/25/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkObserver <NSObject>

-(void) handleSuccessWithJSONData : (id) jsonData : (NSString*) serviceName;
-(void) handleFailWithErrorMessage : (NSString*) errorMessage;

@end
