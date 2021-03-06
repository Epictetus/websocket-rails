module WebsocketRails
  module ConnectionAdapters
    class WebSocket < Base
      
      def self.accepts?(env)
        Faye::WebSocket.websocket?( env )
      end
      
      def initialize(request,dispatcher)
        super
        @connection = Faye::WebSocket.new( request.env )
        @connection.onmessage = method(:on_message)
        @connection.onerror   = method(:on_error)
        @connection.onclose   = method(:on_close)
        on_open
      end
      
      def send(message)
        @connection.send message
      end

      def on_message(event)
        data = event.respond_to?(:data) ? event.data : event
        super data
      end
      
    end
  end
end
