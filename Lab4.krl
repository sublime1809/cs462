ruleset Lab4 {
	global {
		get_movie = function(title) {
			data = http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json", {
				"apikey" : "xvtq9xmq5fzaq2f9qrk26g6c",
				"q" : title
			});
			content = data.pick("$.content").decode();
			movie = content.pick("$.movies[0]");
			movie
		};
	}
	rule get_movie {
		select when pageview ".*"
		pre {
			movie_data = get_movie("Toy+Story");
			movie_str = movie_data.as("str");
			movie_title = movie_data.pick("$.title").as("str");
			movie_critic_rating = movie_data.pick("$.ratings.critics_score").as("str");
			movie_audience_rating = movie_data.pick("$.ratings.audience_score").as("str");
		}
		{
			notify("Getting Here", "With #{movie_str}") with sticky = true;
		}
	}
}