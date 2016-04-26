
require 'sinatra'
require 'json'

post '/payload' do
    var = JSON.parse(request.body.read)
    if var["action"] == "edited"
        if var["changes"]["title"]
            puts "issue edited. Title changed from: " + var["changes"]["title"]["from"]
            var["action"] = "updated"
            httppost(var)
        elsif var["changes"]["body"]
            puts "issue edited. Body changed from: " + var["changes"]["body"]["from"]
            var["action"] = "updated"
            httppost(var)
        end
    end
end

def httppost(var)
    host = ''
    port = ''
    #user = ''
    #pass = ''
    post_ws = "" #workspace
    req = Net::HTTP::Post.new(post_ws, initheader = {'Content-Type' =>'application/json'})
    #req.basic_auth user, pass  
    req.body = var.to_json
    http = Net::HTTP.new(host, port)
    response = http.start {|http1| http1.request(req) }
    puts "Response #{response.code} #{response.message}: #{response.body}"
end
