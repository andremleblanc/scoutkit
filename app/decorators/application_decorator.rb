class ApplicationDecorator < SimpleDelegator
  include Rails.application.routes.url_helpers
  
  class << self
    def wrap(collection)
      collection.map{ |e| new(e) }
    end
  end
end
