require 'socket'               # Get sockets from stdlib
require "json"
public
def openfile(filename)
 puts File.read(filename)
end
def filesize(filename="index.html")
	puts File.read(filename.length)
end
server = TCPServer.open(2000)  # Socket to listen on port 2000
loop {                         # Servers run forever
  client = server.accept      # Wait for a client to connect
  header = ""
  while line = client.gets
  	header += line
  	break if header =~ /\r\n\r\n$/
  end
  	header1 = header.split("\n")
	request = header1[0].split(" ")

	method = request[0]
	path = request[1]
	http = request[2]

	#puts method
	#puts http
	#puts path
	
  if method == "GET"
  	client.puts "#{http} 200 OK"
  	client.puts(Time.now.ctime)  # Send the time to the client
	client.puts "Content-Type: "
  	client.puts "Content-Length: "
  	client.openfile("."+path)
  elsif method == "POST"
  	params = {} 
  	bodysize = header1[-2].split(" ")[1].to_i
  	body = client.read(bodysize)
  	params = JSON.parse(body)
  	data = "<li>Name: #{params['viking']['name']}</li><li>Email: #{params['viking']['email']}</li>"
  	#puts data
  	content_body = File.read("."+path)
  	content_body = content_body.gsub("<%= yield %>", data)
  	client.puts "#{http} 200 OK"
  	client.puts(Time.now.ctime)  # Send the time to the client
	client.puts "Content-Type: JSON"
  	client.puts "Content-Size: #{content_body.size}"
  	client.puts(content_body)
  	#client.puts("#{http} 200 ok\nContent-Type: html\ncontent-size: #{content_body.size}\r\n\r\n#{content_body}")

  else
  	client.puts "#{http} Error 404"
  end
 	
  client.puts "Closing the connection. Bye!"
  client.close                 # Disconnect from the client
}

