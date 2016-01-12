module SafeUpdate
  def self.extended(*)
    ActiveRecord::Associations::Builder::Association.class_eval do
      unless method_defined? :valid_options_original
        alias :valid_options_original :valid_options
        def valid_options
          valid_options_original + [:safe_update]
        end
      end
    end
  end

  def belongs_to(name, options = {})
    return_status = super(name, options)

    belongs_to_generator(name) if options[:safe_update]

    return_status
  end

  private

  def belongs_to_generator(attr_name)
    define_method(attr_name) do
      attribute = super()

      attribute.instance_variable_set(:@_caller, self)

      attribute.define_singleton_method(:_update_record) do
        return(super()) if changes.empty?

        new_record = self.class.new(
          attributes.except('id', 'updated_at'))

        return(false) unless new_record.send(:_create_record)

        @_caller.send("#{attr_name}=", new_record)

        unless @_caller.save == true
          raise("Unable to save dependent model: #{@_caller.errors.full_messages}")
        end

        new_record.attributes.each { |k, v| send("#{k}=", v) }
        true
      end

      attribute
    end
  end
end
