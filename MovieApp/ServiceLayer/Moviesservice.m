//
//  Moviesservice.m
//  MovieApp
//
//  Created by Admin on 3/25/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "Moviesservice.h"

#import "MoviePOJO.h"
#import "TrailerPOJO.h"
@implementation Moviesservice

- (void)handleFailWithErrorMessage:(NSString *)errorMessage {
    [_moviePresenter onFail:errorMessage];
}

- (void)handleSuccessWithJSONData:(id)jsonData :(NSString *)serviceName {
    if ([serviceName isEqualToString:@"Moviesservice"]) {
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSMutableArray<MoviePOJO *>  *moviesArray = [NSMutableArray new];
          NSMutableArray *jsonObj=[[dict objectForKey:@"results"] mutableCopy];
        for(int i=0;i<jsonObj.count;++i){
            MoviePOJO *tempmovie=[MoviePOJO new];
            NSDictionary *tempDic=[jsonObj objectAtIndex:i];
            tempmovie.mid=[tempDic objectForKey:@"id"];
            tempmovie.title=[tempDic objectForKey:@"title"];
            tempmovie.release_date=[tempDic objectForKey:@"release_date"];
            tempmovie.overview=[tempDic objectForKey:@"overview"];
            tempmovie.poster_path=[tempDic objectForKey:@"poster_path"];
            tempmovie.vote_average=[tempDic objectForKey:@"vote_average"];
            tempmovie.isFavourite=@"false";
            [moviesArray addObject:tempmovie];
        }
        [_moviePresenter onSuccess:moviesArray : true];
    }
    
    else if ([serviceName isEqualToString:@"Moviesdetailsservice"]) {
         NSMutableArray  *moviesTrailerArray = [NSMutableArray new];
        NSString *youtubeBaseUrl=@"https://www.youtube.com/watch?v=";
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSMutableArray *jsonObj=[[dict objectForKey:@"results"] mutableCopy];
        for(int i=0;i<jsonObj.count;++i){
            TrailerPOJO *tempTrailer=[TrailerPOJO new];
            NSDictionary *tempDic=[jsonObj objectAtIndex:i];
            tempTrailer.trailerId=[tempDic objectForKey:@"id"];
            NSString *movieTrailerKey=[tempDic objectForKey:@"key"];
            tempTrailer.TrailerUrl=[NSString stringWithFormat:@"%@%@",youtubeBaseUrl,movieTrailerKey];

            [moviesTrailerArray addObject:tempTrailer];
        }
 [_moviedetailsPresenter retrieveTrailers:moviesTrailerArray ];
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

- (void)getMoviesDetails:(id<IMovieDetailsPresenter>)movieDetailsPresenter :(NSString*)movieId{
    _moviedetailsPresenter= movieDetailsPresenter;
    NSString *urlStr=[NSString stringWithFormat:@"http://api.themoviedb.org/3/movie/%d/videos?api_key=655584bcccf3ea4d6c31de42c1468bf8",[movieId intValue]];
    [NetworkManager connectGetToURL:urlStr serviceName:@"Moviesdetailsservice" serviceProtocol:self];
}

@end
