ruleset Lab4 {
	rule get_movie {
		select when pageview ".*"
		pre {
			movie_title = page:env("title");
			api_key = "xvtq9xmq5fzaq2f9qrk26g6c";
			movie_query = "http://api.rottentomatoes.com/api/public/v1.0/movies.json";
		}
		http.get(movie_query, {
			apikey=#{api_key},
			q="Toy+Story"
		});
	}
}