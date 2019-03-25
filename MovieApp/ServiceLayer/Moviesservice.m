//
//  Moviesservice.m
//  MovieApp
//
//  Created by Admin on 3/25/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "Moviesservice.h"

@implementation Moviesservice

- (void)handleFailWithErrorMessage:(NSString *)errorMessage {
    [_moviePresenter onFail:errorMessage];
}

- (void)handleSuccessWithJSONData:(id)jsonData :(NSString *)serviceName {
    if ([serviceName isEqualToString:@"Moviesservice"]) {
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSArray *moviesArray = [dict objectForKey:@"results"];
        NSDictionary *moviesDict = moviesArray[0];
        MoviePOJO *movie = [MoviePOJO new];
//        [contact setName:[contactDict objectForKey:@"name"]];
//        [contact setEmail:[contactDict objectForKey:@"email"]];
        [_moviePresenter onSuccess:movie];
        
    }
    
}

- (void)getMovies:(id<IMoviePresenter>)moviePresenter {
    _moviePresenter = moviePresenter;
    [NetworkManager connectGetToURL:@"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.%20desc&api_key=655584bcccf3ea4d6c31de42c1468bf8" serviceName:@"Moviesservice" serviceProtocol:self];

}

@end
