Spree::Adjustment.class_eval do
  def set_eligibility_with_zero_fix
    if originator && originator.calculator.class == Spree::Calculator::FreeShippingSelection
      update_attribute_without_callbacks(:eligible, true)
    else
      set_eligibility_without_zero_fix
    end
  end
  alias_method_chain :set_eligibility, :zero_fix
end
