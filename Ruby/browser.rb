require 'socket'
require "json" 
host = 'localhost'     # The web server
port = 2000                          # Default HTTP port
path = "/thanks.html"                 # The file we want 

#puts "What type of request would you like?"
request_type = "POST"
if request_type == "GET"
	request = "#{request_type} #{path} HTTP/1.0\r\n\r\n"
end

if request_type == "POST"
	vikings = Hash.new
	hash = Hash.new
	#puts "What is your name?"
	vikings[:name]="David"
	#puts "What is your email?"
	vikings[:email]= "vikings@gmail.com"
	hash[:viking] = vikings
	jsonparams = hash.to_json
	request = "POST #{path} HTTP/1.0 \nContent-Type: JSON\nContent-Length: #{jsonparams.length}\r\n\r\n#{jsonparams}"
end
socket = TCPSocket.open(host,port)  # Connect to server
socket.print(request)              # Send request
 while line = socket.gets   # Read lines from the server
     puts line      # And print with platform line terminator
  end

