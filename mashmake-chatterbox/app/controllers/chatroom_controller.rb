class ChatroomController < ApplicationController
    before_action :require_user
    
    def index
        @message = Message.new
        @messages = Message.all
        # @messages.append(Message.new(body: 'System: Error'))
    end
end