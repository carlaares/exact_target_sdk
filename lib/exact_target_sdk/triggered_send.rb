module ExactTargetSDK
class TriggeredSend < APIObject

  array_property 'Attributes'
  array_property 'Subscribers'
  array_property 'Client'
  property 'TriggeredSendDefinition', :required => true

end
end
