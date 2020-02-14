module CoreExtensions
  module HashRejectHidden

    def reject_hidden(sigil = "hidden")
      return {} if self.include? sigil

      result = {}

      self.each do |k, v|
        if v.is_a? Hash and not v.empty?
          inner = v.reject_hidden sigil
          result[k] = inner unless inner.empty?
        else
          result[k] = v
        end
      end

      result
    end

  end
end
