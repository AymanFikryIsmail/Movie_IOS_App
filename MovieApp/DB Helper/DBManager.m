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
      "CREATE TABLE IF NOT EXISTS movies (movieId TEXT,  title TEXT,  poster_path TEXT, overview TEXT ,  vote_average TEXT  ,  release_date TEXT , isFavourite TEXT ,sortType integer )";
        const char *sqlfavmovies_stmt =
        "CREATE TABLE IF NOT EXISTS favouritemovies (movieId TEXT,  title TEXT,  poster_path TEXT, overview TEXT ,  vote_average TEXT  ,  release_date TEXT , isFavourite TEXT )";
        const char *sqlTraiers_stmt =
        "CREATE TABLE IF NOT EXISTS trailermovies (movieId TEXT,  trailername TEXT,  url TEXT )";
        const char *sqlReviews_stmt =
        "CREATE TABLE IF NOT EXISTS reviewmovies (movieId TEXT,  author TEXT,  content TEXT, url TEXT  )";

        if (sqlite3_exec(movieDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            printf("Failed to create table");
            sqlite3_close(movieDB);
            return false;
        }
        if (sqlite3_exec(movieDB, sqlfavmovies_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            printf("Failed to create table");
            sqlite3_close(movieDB);
            return false;
        }
        if (sqlite3_exec(movieDB, sqlTraiers_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            printf("Failed to create table");
            sqlite3_close(movieDB);
            return false;
        }
        if (sqlite3_exec(movieDB, sqlReviews_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
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

-(BOOL) saveData : (NSArray*)movieList :(int) sortType{

    const char *dbpath = [databasePath UTF8String];

    BOOL isSuccess=false;
     for (int i=0; i<[movieList count]; i++) {
    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
        MoviePOJO* movie=movieList[i];
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO movies (movieId, title, poster_path,  overview, vote_average, release_date ,isFavourite ,sortType ) VALUES (\"%@\", \"%@\", \"%@\" , \"%@\"  , \"%@\" , \"%@\" , \"%@\" , \"%d\")",
                                   movie.mid,  movie.title, movie.poster_path ,
                                   movie.overview , movie.vote_average,  movie.release_date, @"false" , sortType];
                                   const char *insert_stmt = [insertSQL UTF8String];
                                   sqlite3_prepare_v2(movieDB, insert_stmt,
                                                      -1, &statement, NULL);
      
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            isSuccess= true;
        } else {
            printf("Failed to open/create database %i" , i);
            isSuccess= false;
        }
         sqlite3_finalize(statement);
         sqlite3_close(movieDB);
       }
    }

    return isSuccess;
}

-(BOOL) saveFavouriteData :(MoviePOJO*) movie{
    
    const char *dbpath = [databasePath UTF8String];
    
    BOOL isSuccess=false;
    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
       
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO favouritemovies (movieId, title, poster_path,  overview, vote_average, release_date ,isFavourite ) VALUES (\"%@\", \"%@\", \"%@\" , \"%@\"  , \"%@\" , \"%@\" , \"%@\")",
                                   movie.mid,  movie.title, movie.poster_path ,
                                   movie.overview , movie.vote_average,  movie.release_date , movie.isFavourite];
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
            
        
        sqlite3_finalize(statement);
        sqlite3_close(movieDB);
    }
    
    return isSuccess;
}

-(BOOL) savetrailerData : (NSArray*)movieList : (MoviePOJO*) movie{
    
    const char *dbpath = [databasePath UTF8String];
    BOOL isSuccess=false;
    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
        for (int i=0; i<[movieList count]; i++) {
            TrailerPOJO* movietrailer=movieList[i];
           
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO trailermovies (movieId, trailername, url) VALUES (\"%@\", \"%@\", \"%@\")",
                                   movie.mid,  movietrailer.trailerName, movietrailer.TrailerUrl];
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(movieDB, insert_stmt,
                               -1, &statement, NULL);
            
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                isSuccess= true;
            } else {
                printf("Failed to open/create database %i" , i);
                isSuccess= false;
            }
             sqlite3_finalize(statement);
        }
       
        sqlite3_close(movieDB);
    }
    
    return isSuccess;
}


-(BOOL) saveReviewData : (NSArray*)movieList : (MoviePOJO*) movie{
    
    const char *dbpath = [databasePath UTF8String];
    BOOL isSuccess=false;
    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
        for (int i=0; i<[movieList count]; i++) {
            ReviewPOJO* movieReview=movieList[i];
            
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO reviewmovies (movieId, author , content, url) VALUES (\"%@\", \"%@\", \"%@\" , \"%@\")",
                                   movie.mid,  movieReview.author,movieReview.content, movieReview.url];
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(movieDB, insert_stmt,
                               -1, &statement, NULL);
            
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                isSuccess= true;
            } else {
                printf("Failed to open/create database %i" , i);
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
        NSString *updateSQL = [NSString stringWithFormat:@"update  favouritemovies  set  isFavourite =\"%@\"  where movieId = \"%@\" ",movie.isFavourite , movie.mid];

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
-(NSArray*) getAllData :(int) sortType{
    const char *dbpath = [databasePath UTF8String];
    //  sqlite3_stmt    *statement;
    NSMutableArray* result=nil;
    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT movieId, title, poster_path,  overview, vote_average, release_date ,isFavourite FROM movies where sortType =\"%d\" " ,sortType];
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

-(NSArray*) checkISFavData :(MoviePOJO*) movie{
    const char *dbpath = [databasePath UTF8String];
    //  sqlite3_stmt    *statement;
    NSMutableArray* result=nil;
    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT movieId, title, poster_path,  overview, vote_average, release_date ,isFavourite FROM favouritemovies  where  movieId=  \"%@\" " ,movie.mid];
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
        NSString *querySQL = [NSString stringWithFormat:@"SELECT movieId, title, poster_path,  overview, vote_average, release_date ,isFavourite FROM favouritemovies  where  isFavourite=  \"%@\" " ,@"true"];
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


-(NSArray*) getTrailerData : (MoviePOJO*) movie{
    const char *dbpath = [databasePath UTF8String];
    //  sqlite3_stmt    *statement;
    NSMutableArray* result=nil;
    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT movieId, trailername, url FROM trailermovies  where  movieId=  \"%@\" " ,movie.mid];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(movieDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            result=[[NSMutableArray alloc]init ];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *movieIdField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *titleField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *TrailerUrlField  = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
              
                
                TrailerPOJO *m= [TrailerPOJO new]  ;
                m.movieId=movieIdField;
                m.trailerName=titleField;
                m.TrailerUrl=TrailerUrlField;
                [ result addObject:m];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(movieDB);
    }
    
    return  result;
}



-(NSArray*) getReviewData : (MoviePOJO*) movie{
    const char *dbpath = [databasePath UTF8String];
    //  sqlite3_stmt    *statement;
    NSMutableArray* result=nil;
    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT movieId, author, content, url FROM reviewmovies  where  movieId=  \"%@\" " ,movie.mid];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(movieDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            result=[[NSMutableArray alloc]init ];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *movieIdField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *titleField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *contentField  = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
            NSString *url = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                ReviewPOJO *m= [ReviewPOJO new]  ;
                m.movieId=movieIdField;
                m.author=titleField;
                m.content=contentField;
                  m.url=url;

                [ result addObject:m];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(movieDB);
    }
    
    return  result;
}

-(BOOL)deleteAll{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &movieDB) == SQLITE_OK)
    {
        NSString *updateSQL = [NSString stringWithFormat: @"delete from  movies  "];
        
        const char *insert_stmt = [updateSQL UTF8String];
        sqlite3_prepare_v2(movieDB, insert_stmt,-1, &statement, NULL);
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
@end
