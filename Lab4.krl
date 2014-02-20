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
			}).pick($.content);
		}
		{
			notify("Getting Here", "With #{api_key}");
			replace_inner("#main", urlcontent);
		}
	}
}