module ExactTargetSDK

# Assumes that the "SubscriberKey feature" is not enabled on your account, and
# thus explicitly sets the SubscriberKey to be the same as the EmailAddress
# (and vice-versa). This allows all methods to be used without ever needing to 
# refer to the SubscriberKey (just use EmailAddress).
#
# If the SubscriberKey is explicitly set, it will be left alone (in case you do
# have the SubscriberKey feature enabled).
#
# When updating, the email address may be updated by setting the SubscriberKey
# property to the current email address, and the EmailAddress property to the
# new email address.
class Subscriber < APIObject

  property 'SubscriberKey', :required => true
  property 'EmailAddress', :required => true
  property 'EmailTypePreference'
  array_property 'Client'
  array_property 'Attributes'
  array_property 'Lists'

  before_validation do
    self.SubscriberKey = self.EmailAddress if self.SubscriberKey.nil?
    self.EmailAddress = self.SubscriberKey if self.EmailAddress.nil?
  end

  def self.find(filters)
    client = ExactTargetSDK::Client.new
    simple_filters = filters.collect do |property, operator, value|
      ExactTargetSDK::SimpleFilterPart.new(Property: property, SimpleOperator: operator, Value: value)
    end
    filter = if simple_filters.size == 1
      simple_filters.first
    else
      ExactTargetSDK::ComplexFilterPart.new('LeftOperand' => simple_filters[0], 'RightOperand' => simple_filters[1], 'LogicalOperator' => ExactTargetSDK::LogicalOperators::AND)
    end
    client.Retrieve('Subscriber', filter, 'ID', 'EmailAddress', 'SubscriberKey', 'Status')
  end
end

end
