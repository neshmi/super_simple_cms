module Averails
  module Identity
    def identity(suffixes=nil)
      elements=[self.class.to_s.underscore, (self.id ? self.id : 'nil')]
      elements << suffixes if suffixes
      elements.join('_')
    end
  end

  ActiveRecord::Base.class_eval do
    include Identity
  end
end