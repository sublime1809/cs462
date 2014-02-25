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
		    	<form id="movie_form" onsubmit="return false">
		    		<label for="movie">Movie: </label>
		    		<input name="movie" type="text" />
		    		<input type="submit" value="Search" />
		    	</form>
		    	<div id="movie_info">Search to get details.</div>
		    >>;
		  }
		{
			SquareTag:injectStyling();
			CloudRain:createLoadPanel("Movie Search!", {}, my_form);
			watch("#movie_form", "submit");
		}
	}
	rule get_movie {
		select when web submit "#movie_form"
		pre {
			search_title = event:attr("movie");
			movie_data = get_movie(search_title);
			movie_title = movie_data.pick("$.title").as("str");
			movie_year = movie_data.pick("$.year").as("str");
			movie_critic_rating = movie_data.pick("$.ratings.critics_score").as("str");
			movie_audience_rating = movie_data.pick("$.ratings.audience_score").as("str");
			movie_info = <<
				<ul>
					<li>Title: #{movie_title}</li>
					<li>Year: #{movie_year}</li>
					<li>Critic Rating: #{movie_critic_rating}</li>
					<li>Audience Rating: #{movie_audience_rating}</li>
				</ul>
			>>;
		}
		if (movie_title.length > 0) then {
			replace_inner("#movie_info", movie_info);
		}
		notfired {
			raise explicit event display_error;
		}
	}
	rule display_search_error {
		select when explicity display_error
		pre {
			error_msg = <<
				Could not find movie.
			>>;
		}
		{
			replace_inner("#movie_info", error_msg);
		}
	}
}