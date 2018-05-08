#!/usr/bin/ruby
# encoding: utf-8

require "csv"
require "sinatra"

set :bind, "0.0.0.0"

$redir = CSV.read("words.csv").to_h

get '/' do
    host = request.host
    subdomain = host.split(".")[0..-3].join(".")
    redir = $redir[subdomain]
    if redir
        $stderr.puts redir
        if redir=~/^.{11}$/
            #YID
            redirect "https://www.youtube.com/embed/#{redir}?autoplay=1", 301
        else
            redirect redir, 301
        end
    else
        redirect "https://www.youtube.com/embed/nc_LIR5ExIU?autoplay=1", 301
    end
end
