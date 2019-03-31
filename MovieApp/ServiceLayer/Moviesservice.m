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
        NSArray<MoviePOJO *>  *moviesArray = (NSArray<MoviePOJO *>*)[dict objectForKey:@"results"];
        [_moviePresenter onSuccess:moviesArray : true];
        
    }
    
}

- (void)getMovies:(id<IMoviePresenter>)moviePresenter {
    _moviePresenter = moviePresenter;
//    if(sortFlage == 1){
//        URL = [NSURL URLWithString:@"http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=fc3140c227807880f6ba2c7bce9d1cb5"];
//    }
//    else{
//        URL= [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/top_rated?api_key=fc3140c227807880f6ba2c7bce9d1cb5"];
//    }
    [NetworkManager connectGetToURL:@"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.%20desc&api_key=655584bcccf3ea4d6c31de42c1468bf8" serviceName:@"Moviesservice" serviceProtocol:self];

}

@end
