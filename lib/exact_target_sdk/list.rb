module ExactTargetSDK
class List < APIObject

  property 'ID'
  property 'ListName'
  property 'Status'
  property 'Action'

  array_property 'Subscribers'

  def self.find_by_email(email)
    client = ExactTargetSDK::Client.new
    filter = ExactTargetSDK::SimpleFilterPart.new(Property: "EmailAddress", SimpleOperator: ExactTargetSDK::SimpleOperator::EQUALS, Value: email)
    response = client.Retrieve('ListSubscriber', filter, 'ListID', 'SubscriberKey', 'Status')
  end

end
end
