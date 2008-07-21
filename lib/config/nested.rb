module ActiveScaffold::Config
  class Nested < Base
    self.crud_type = :read

    def initialize(core_config)
      @core = core_config
    end

    # global level configuration
    # --------------------------
    cattr_accessor :shallow_delete
    @@shallow_delete = false

    # instance-level configuration
    # ----------------------------
    attr_accessor :shallow_delete

    # Add a nested ActionLink
    def add_link(label, models, options={})
      options = {
        :security_method => ('nested_' + models.join('_')).to_sym,
        :label => label, 
        :type => :record,         
        :position => :after, 
        :parameters => {:associations => models.join(' ')}
      }.merge(options)
      @core.action_links.add('nested', options)
    end

    # the label for this Nested action. used for the header.
    attr_writer :label
    def label
      @label ? as_(@label) : "#{as_('Add Existing')} #{@core.label.singularize}"
    end

  end
end
