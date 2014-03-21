ruleset lab7_1 {
	meta {
		key twilio {
			"account_sid" : "AC7aee905d1042728ef7816b9199586df7",
            "auth_token"  : "5886d8d3279d8d945c2db6c4a1d656d4"
        }
         
        use module a8x115 alias twilio with twiliokeys = keys:twilio()
	}
	rule listen_nearby {
		select when location nearby 
		pre {
			dist = event:attr("dist");
			msg = dist+" mi";
		}
		{
			twilio:send_sms("+12086956442", "+12084953923", msg);
		}
		always {
			set ent:dist dist;
			set ent:msg msg;
		}
	}
	rule listen_far { 
		select when location far 
		pre {
			dist = event:attr("dist");
			msg = "far: "+dist+" mi";
		}
		{
			twilio:send_sms("+12086956442", "+12084953923", msg);
		}
		always {
			set ent:dist dist;
			set ent:msg msg;
		}
	}
	rule show_text {
		select when web cloudAppSelected
		pre {
			dist = ent:dist;
			msg = ent:msg;

			my_html = <<
				<div id="main">
					<p>Dist: #{dist}</p>
					<p>Msg: #{msg}</p>
				</div>
			>>;
		}
		{
			SquareTag:inject_styling();
			CloudRain:createLoadPanel("Text sent", {}, my_html);
		}
	}
}