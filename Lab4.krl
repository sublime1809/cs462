ruleset Lab4 {
	meta {
		use module a169x701 alias CloudRain
		use module a41x186  alias SquareTag
	}
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
	rule display_movie_form {
		select when web cloudAppSelected
		pre {
		    my_form = <<
		    	<form>
		    		<label for="movie">Movie: </label>
		    		<input name="movie" type="text" />
		    		<input type="submit" value="Search" />
		    	</form>
		    >>;
		  }
		{
			SquareTag:injectStyling();
			CloudRain:createLoadPanel("Movie Search!", {}, my_form);
		}
	}
}