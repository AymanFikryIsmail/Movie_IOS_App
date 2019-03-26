//
//  DBManager.m
//  MovieApp
//
//  Created by Admin on 3/25/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager


static DBManager* dbInstance=nil;
static sqlite3 *movieDB=nil;
static sqlite3_stmt    *statement;

+(DBManager*) getInstance{

    if (!dbInstance) {
        dbInstance= [[super alloc] init ];
        [dbInstance createDB];
    }
    return dbInstance;
}
-(BOOL) createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"movies.db"]];
    const char *dbpath = [databasePath UTF8String];

    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
        //ID INTEGER PRIMARY KEY AUTOINCREMENT,
        char *errMsg;
        const char *sql_stmt =
      "CREATE TABLE IF NOT EXISTS movies (movieId TEXT,  title TEXT,  poster_path TEXT, overview TEXT ,  vote_average TEXT  ,  release_date TEXT , isFavourite TEXT )";

        if (sqlite3_exec(movieDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            printf("Failed to create table");
            sqlite3_close(movieDB);
            return false;
        }
        sqlite3_close(movieDB);
    } else {
        printf("Failed to open/create database");
        sqlite3_close(movieDB);
        return false;
    }
    return true;
}
-(BOOL) saveData : (NSArray*)movieList{

    const char *dbpath = [databasePath UTF8String];

    BOOL isSuccess=false;
    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
        for (int i=0; i<[movieList count]; i++) {
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO movies (movieId, title, poster_path,  overview, vote_average, release_date ,isFavourite ) VALUES (\"%@\", \"%@\", \"%@\" , \"%@\"  , \"%@\" , \"%@\" , \"%@\")",
                                   movieList[i][@"id"],  movieList[i][@"id"],  movieList[i][@"id"] ,
                                   movieList[i][@"id"] ,  movieList[i][@"id"],  movieList[i][@"id"] , @"false"];
                                   const char *insert_stmt = [insertSQL UTF8String];
                                   sqlite3_prepare_v2(movieDB, insert_stmt,
                                                      -1, &statement, NULL);
      
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            isSuccess= true;
        } else {
            printf("Failed to open/create database");
            isSuccess= false;
        }
       
       }
         sqlite3_finalize(statement);
        sqlite3_close(movieDB);
    }

    return isSuccess;
}
-(BOOL)updateFavData :(MoviePOJO*) movie{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
        NSString *updateSQL = [NSString stringWithFormat:@"update  movies  set  isFavourite =\"%@\"  where movieId = \"%@\" ",movie.isFavourite , movie.id];

        const char *insert_stmt = [updateSQL UTF8String];
        sqlite3_prepare_v2(movieDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_finalize(statement);
            sqlite3_close(movieDB);
            return true;
        } else {
            printf("Failed to open/create database");
        }
        sqlite3_finalize(statement);
        sqlite3_close(movieDB);
    }

    return false;
}
-(NSArray*) getAllData{
    const char *dbpath = [databasePath UTF8String];
    //  sqlite3_stmt    *statement;
    NSMutableArray* result=nil;
    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT movieId, title, poster_path,  overview, vote_average, release_date ,isFavourite FROM movies "];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(movieDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            result=[[NSMutableArray alloc]init ];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *movieIdField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *titleField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *poster_pathField  = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *overviewField   = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSString *vote_averageField   = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                NSString *release_dateField   = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                NSString *isFavouriteField   = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                
                MoviePOJO *m= [[MoviePOJO alloc] initWithMovie: movieIdField : titleField : poster_pathField : overviewField :vote_averageField:release_dateField : isFavouriteField];
                [ result addObject:m];

            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(movieDB);
    }

    return  result;
}

-(NSArray*) getFavData { 
    const char *dbpath = [databasePath UTF8String];
    //  sqlite3_stmt    *statement;
    NSMutableArray* result=nil;
    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT movieId, title, poster_path,  overview, vote_average, release_date ,isFavourite FROM movies  where  isFavourite= true"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(movieDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            result=[[NSMutableArray alloc]init ];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *movieIdField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *titleField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *poster_pathField  = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *overviewField   = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSString *vote_averageField   = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                NSString *release_dateField   = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                NSString *isFavouriteField   = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                
                MoviePOJO *m= [[MoviePOJO alloc] initWithMovie: movieIdField : titleField : poster_pathField : overviewField :vote_averageField:release_dateField : isFavouriteField];
                [ result addObject:m];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(movieDB);
    }
    
    return  result;
}


@end
