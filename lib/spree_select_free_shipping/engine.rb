module SpreeSelectFreeShipping
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_select_free_shipping'

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "spree.register.select_free_shipping", :after => 'spree.environment' do |app|
      app.config.spree.calculators.shipping_methods << Spree::Calculator::FreeShippingDelivery
      app.config.spree.calculators.promotion_actions_create_adjustments << Spree::Calculator::FreeShippingSelection
    end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
