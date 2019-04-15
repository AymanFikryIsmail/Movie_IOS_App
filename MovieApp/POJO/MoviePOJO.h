//
//  MoviePOJO.h
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <Realm/Realm.h>

@interface MoviePOJO : NSObject
@property NSString *mid;
@property NSString *title;
@property NSString *poster_path;
@property NSString *overview;
@property NSString *vote_average;
@property NSString *release_date;
@property NSString *isFavourite;
@property NSInteger sortType;
-(instancetype) initWithMovie: (NSString*) mid : (NSString*) title : (NSString*) poster_path :(NSString*) overview  :(NSString*) vote_average :(NSString*) release_date  :(NSString*) isFavourite ;

@end

//
//#import <Realm/Realm.h>
//#import "MoviePOJO.h"
//@interface MovieArrayPOJO : RLMObject
//// ... other property declarations
//@property RLMArray<MoviePOJO *>*movieList;
//@end

