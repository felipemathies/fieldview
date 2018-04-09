module Fieldview
	class Factory
		class << self
      # Construct a new object
      #
      # @param method [Symbol]
      # @param klass [Class]
      # @param attrs [Hash]
      # @raise [IndexError] Error raised when supplied argument is missing a key.
      # @return [Twitter::Base]
      def new(type, attrs = {})
        const_name = type.to_s.underscore.split('_').collect(&:capitalize).join
        Fieldview::const_get(const_name.to_sym).new(attrs)
      end
    end
	end
end