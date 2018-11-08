# source: https://practicingruby.com/articles/implementing-an-http-file-server

puts("starting server...")

require 'socket' # Provides TCPServer and TCPSocket classes

# Read in moon facts text file 
facts = File.readlines('facts.txt', :encoding => 'ISO-8859-5')

# Initialize a TCPServer object that will listen
# on localhost:2345 for incoming connections.
server = TCPServer.new('', 2345)
puts('✅ Moon Facts Server listening...')


# loop infinitely, processing one incoming
# connection at a time.
loop do

  # Wait until a client connects, then return a TCPSocket
  # that can be used in a similar fashion to other Ruby
  # I/O objects. (In fact, TCPSocket is a subclass of IO.)
  socket = server.accept

  # Read the first line of the request (the Request-Line)
  request = socket.gets

  # Log the request to the console for debugging
  STDERR.puts request

  fact = facts.sample #get a random fact 

  # We need to include the Content-Type and Content-Length headers
  # to let the client know the size and type of data
  # contained in the response. Note that HTTP is whitespace
  # sensitive, and expects each header line to end with CRLF (i.e. "\r\n")
  socket.print "HTTP/1.1 200 OK\r\n" +
               "Content-Type: text/plain\r\n" +
               "Content-Length: #{fact.bytesize}\r\n" +
               "Connection: close\r\n"

  # Print a blank line to separate the header from the response body,
  # as required by the protocol.
  socket.print "\r\n"

  # Print the actual response body, which is the random Moon fact 
  socket.print fact

  # Close the socket, terminating the connection
  socket.close
end