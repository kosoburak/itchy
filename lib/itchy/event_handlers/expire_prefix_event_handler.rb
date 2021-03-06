module Itchy::EventHandlers
  # Handler for ExpirePrefix event (image will be expired).
  class ExpirePrefixEventHandler < BaseEventHandler
    def handle!(vmcatcher_event, event_file)
      super
      Itchy::Log.warn "[#{self.class.name}] Just ignoring #{vmcatcher_event.type.inspect}"
    end
  end
end
