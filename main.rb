#!/usr/bin/env ruby

require 'sinatra'

get '/' do
	erb :index
end

get /\A\/(\d{1,3})\z/ do #get any get request that's "/<1 to 3 digit number>", like a url
	erb :postview
end