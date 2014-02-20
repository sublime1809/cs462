ruleset Lab4 {
	global {
		datasource library_data <- "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=xvtq9xmq5fzaq2f9qrk26g6c";
	}
	rule get_movie {
		select when pageview ".*"
		pre {
			movie_data = datasource:library_data("q=Toy+Story");
			movie_title = movie_data.pick("$.content.movies[0].title");
			movie_critic_rating = movie_data.pick("$.content.movies[0].ratings.critics_score");
			movie_audience_rating = movie_data.pick("$.content.movies[0].ratings.audience_score");
		}
		{
			notify("Getting Here", "With #{movie_data}") with sticky = true;
		}
	}
}