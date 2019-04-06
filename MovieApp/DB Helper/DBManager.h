//
//  DBManager.h
//  MovieApp
//
//  Created by Admin on 3/25/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "MoviePOJO.h"
#import "TrailerPOJO.h"
#import "ReviewPOJO.h"
NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject
{
    
    NSString *databasePath;
    
}

+(DBManager*) getInstance;
-(BOOL) createDB;
-(BOOL) saveData : (NSArray*)movieList;
-(BOOL) saveFavouriteData :(MoviePOJO*) movie;
-(BOOL) savetrailerData : (NSArray*)movieList : (MoviePOJO*) movie;
-(BOOL) saveReviewData : (NSArray*)movieList : (MoviePOJO*) movie;
-(BOOL)updateFavData :(MoviePOJO*) movie;
-(NSArray*) getAllData;
-(NSArray*) getFavData;

-(NSArray*) getTrailerData : (MoviePOJO*) movie;
-(NSArray*) getReviewData : (MoviePOJO*) movie;
-(BOOL)deleteAll;
@end

NS_ASSUME_NONNULL_END
