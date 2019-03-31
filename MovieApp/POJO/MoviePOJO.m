//
//  MoviePOJO.m
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "MoviePOJO.h"

@implementation MoviePOJO

-(instancetype) initWithMovie: (NSString*) mid : (NSString*) title : (NSString*) poster_path :(NSString*) overview  :(NSString*) vote_average :(NSString*) release_date  :(NSString*) isFavourite  {
    self=[super init];
    
    if (self) {
        _mid=mid;
        _title=title;
        _poster_path=poster_path;
        _overview=overview;
        _vote_average=vote_average;
        _release_date=release_date;
        _isFavourite=isFavourite;
    }
    
    return self;
}
@end
