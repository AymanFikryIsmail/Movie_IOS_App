//
//  MoviePOJO.h
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoviePOJO : NSObject
@property NSString *id;
@property NSString *title;
@property NSString *poster_path;
@property NSString *overview;
@property NSString *vote_average;
@property NSString *release_date;
@property NSString *isFavourite;
-(instancetype) initWithMovie: (NSString*) id : (NSString*) title : (NSString*) poster_path :(NSString*) overview  :(NSString*) vote_average :(NSString*) release_date  :(NSString*) isFavourite ;

@end

NS_ASSUME_NONNULL_END
