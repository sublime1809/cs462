ruleset Lab4 {
	rule get_movie {
		select when pageview ".*"
		pre {
			movie_title = page:env("title");
			api_key = "xvtq9xmq5fzaq2f9qrk26g6c";
			movie_query = "http://api.rottentomatoes.com/api/public/v1.0/movies.json";
			url_content = http:get(movie_query, {
				"apikey": api_key,
				"q": "Toy+Story"
			});
			movie_title = url_content.pick("$.content.movies[0].title");
			movie_critic_rating = url_content.pick("$.content.movies[0].ratings.critics_score");
			movie_audience_rating = url_content.pick("$.content.movies[0].ratings.audience_score");
		}
		{
			notify("Getting Here", "With #{movie_title} #{movie_critic_rating} #{movie_audience_rating}");
		}
	}
}