//
//  DBManager.m
//  MovieApp
//
//  Created by Admin on 3/25/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

//
//static DBManager* dbInstance=nil;
//static sqlite3 *friendDB=nil;
//static sqlite3_stmt    *statement;
//
//+(DBManager*) getInstance{
//
//    if (!dbInstance) {
//        dbInstance= [[super alloc] init ];
//        [dbInstance createDB];
//    }
//    return dbInstance;
//}
//-(BOOL) createDB{
//    NSString *docsDir;
//    NSArray *dirPaths;
//    // Get the documents directory
//    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    docsDir = dirPaths[0];
//    // Build the path to the database file
//    databasePath = [[NSString alloc]
//                    initWithString: [docsDir stringByAppendingPathComponent:
//                                     @"friends1.db"]];
//    const char *dbpath = [databasePath UTF8String];
//
//    if (sqlite3_open(dbpath, &friendDB) == SQLITE_OK)
//    {
//        char *errMsg;
//        const char *sql_stmt =
//        "CREATE TABLE IF NOT EXISTS FRIENDS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT,  EMAIL TEXT, AMGE TEXT ,  lng TEXT  ,  lat TEXT )";
//
//        if (sqlite3_exec(friendDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
//        {
//            printf("Failed to create table");
//            sqlite3_close(friendDB);
//            return false;
//        }
//        sqlite3_close(friendDB);
//    } else {
//
//        printf("Failed to open/create database");
//        sqlite3_close(friendDB);
//        return false;
//    }
//    return true;
//}
//-(BOOL) saveData : (Friend*)frnd{
//
//    const char *dbpath = [databasePath UTF8String];
//
//    if (sqlite3_open(dbpath, &friendDB) == SQLITE_OK)
//    {
//        NSString *insertSQL = [NSString stringWithFormat:
//                               @"INSERT INTO FRIENDS (name, email, amge,  lng, lat) VALUES (\"%@\", \"%@\", \"%@\", \"%@\",\"%@\")",
//                               frnd.name, frnd.email, frnd.amagePath , @(frnd.lng).stringValue , @(frnd.lat).stringValue ];
//
//        const char *insert_stmt = [insertSQL UTF8String];
//        sqlite3_prepare_v2(friendDB, insert_stmt,
//                           -1, &statement, NULL);
//        if (sqlite3_step(statement) == SQLITE_DONE)
//        {
//
//            sqlite3_finalize(statement);
//            sqlite3_close(friendDB);
//            return true;
//        } else {
//            printf("Failed to open/create database");
//
//        }
//        sqlite3_finalize(statement);
//        sqlite3_close(friendDB);
//    }
//
//    return false;
//}
//-(BOOL)updateData :(NSString*) uName :(Friend*) frnd{
//    const char *dbpath = [databasePath UTF8String];
//
//    if (sqlite3_open(dbpath, &friendDB) == SQLITE_OK)
//    {
//        NSString *updateSQL = [NSString stringWithFormat:
//                               @"update  FRIENDS set  name =\"%@\" , email=\"%@\" , amge=\"%@\" , lng=\"%@\" ,  lat=\"%@\" where name = \"%@\" ",
//                               frnd.name, frnd.email, frnd.amagePath , @(frnd.lng).stringValue , @(frnd.lat).stringValue, uName];
//
//        const char *insert_stmt = [updateSQL UTF8String];
//        sqlite3_prepare_v2(friendDB, insert_stmt,
//                           -1, &statement, NULL);
//        if (sqlite3_step(statement) == SQLITE_DONE)
//        {
//
//            sqlite3_finalize(statement);
//            sqlite3_close(friendDB);
//            return true;
//        } else {
//            printf("Failed to open/create database");
//
//        }
//        sqlite3_finalize(statement);
//        sqlite3_close(friendDB);
//    }
//
//    return false;
//}
//-(NSArray*) getData{
//    const char *dbpath = [databasePath UTF8String];
//    //  sqlite3_stmt    *statement;
//    NSMutableArray* result=nil;
//    if (sqlite3_open(dbpath, &friendDB) == SQLITE_OK)
//    {
//        NSString *querySQL = [NSString stringWithFormat:
//                              @"SELECT name, email, amge , lng, lat  FROM friends "];
//
//        const char *query_stmt = [querySQL UTF8String];
//
//        if (sqlite3_prepare_v2(friendDB,
//                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
//        {
//            result=[[NSMutableArray alloc]init ];
//            while (sqlite3_step(statement) == SQLITE_ROW)
//            {
//
//                NSString *nameField = [[NSString alloc]
//                                       initWithUTF8String:
//                                       (const char *) sqlite3_column_text(
//                                                                          statement, 0)];
//
//                NSString *emailField = [[NSString alloc]
//                                        initWithUTF8String:(const char *)
//                                        sqlite3_column_text(statement, 1)];
//                NSString *imageield = [[NSString alloc]
//                                       initWithUTF8String:(const char *)
//                                       sqlite3_column_text(statement, 2)];
//                NSString *lngfield = [[NSString alloc]
//                                      initWithUTF8String:(const char *)
//                                      sqlite3_column_text(statement, 3)];
//                NSString *latfield = [[NSString alloc]
//                                      initWithUTF8String:(const char *)
//                                      sqlite3_column_text(statement, 4)];
//                Friend *f= [[Friend alloc] initWithFriend : nameField : emailField : 5 : imageield :lngfield.floatValue:latfield.floatValue];
//                [ result addObject:f];
//
//            }
//            sqlite3_finalize(statement);
//        }
//        sqlite3_close(friendDB);
//    }
//
//    return  result;
//}
//-(BOOL)deleteRecord :(Friend*) frnd{
//    const char *dbpath = [databasePath UTF8String];
//
//    if (sqlite3_open(dbpath, &friendDB) == SQLITE_OK)
//    {
//        NSString *updateSQL = [NSString stringWithFormat:
//                               @"delete from  FRIENDS  where name =\"%@\" ",frnd.name];
//
//        const char *insert_stmt = [updateSQL UTF8String];
//        sqlite3_prepare_v2(friendDB, insert_stmt,
//                           -1, &statement, NULL);
//        if (sqlite3_step(statement) == SQLITE_DONE)
//        {
//
//            sqlite3_finalize(statement);
//            sqlite3_close(friendDB);
//            return true;
//        } else {
//            printf("Failed to open/create database");
//
//        }
//        sqlite3_finalize(statement);
//        sqlite3_close(friendDB);
//    }
//
//    return false;
//
//}

@end
