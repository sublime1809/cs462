ruleset HelloWorldApp {
	  meta {
		name "Hello World"
		description <<
			Hello World
		>>
		author ""
		logging off
		use module a169x701 alias CloudRain
		use module a41x186  alias SquareTag
	  }
	  dispatch {
	  }
	  global {
	  }
	  rule HelloWorld is active {
	   	select when web cloudAppSelected
		pre {
			value = ent:boo;
		    my_html = <<
		      <h5>Hello, World! #{value}</h5>
		    >>;
		    key = "boo";
		  }
		{
			SquareTag:injectStyling();
			CloudRain:createLoadPanel("Hello World!", {}, my_html);
		}
		always {
			set ent:#{key} "ahh";
		}
	  }
}
