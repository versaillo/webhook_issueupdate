
require 'sinatra'
require 'json'

post '/payload' do
    var = JSON.parse(request.body.read)
    if var["action"] == "edited"
        if var["changes"]["title"]
            puts "issue edited. Title changed from: " + var["changes"]["title"]["from"]
            var["action"] = "updated"
        elsif var["changes"]["body"]
            puts "issue edited. Body changed from: " + var["changes"]["body"]["from"]
            var["action"] = "updated"
        end
    end
end
