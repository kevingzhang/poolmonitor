@facilityColl = new Mongo.Collection 'facility'

@Schema ?= {}

Schema.kpi = new SimpleSchema
  id:
    type:String 
    # autoValue:->
    #   randomId = Random.hexString(24)
    #   if @isInsert
    #     return randomId 
    #   if @isUpsert
    #     return {$setOnInsert:randomId}
    #   else
    #     @unset()
  name:
    type:String 
  desc:
    type:String
    optional:true
  valueType:
    type:String
    allowedValues:["String", "Number", "Boolean", "Date"]
  isGeneric:
    type:Boolean
    defaultValue:true 
  function:
    type:Object
    optional:true
  bestRange:
    type:Object
    optional:true 
  "bestRange.inside":
    type:Boolean
    defaultValue:true

  'bestRange.lower':
    type:Number
    
  'bestRange.upper':
    type:Number 
    optional:true
    # autoValue:->
    #   unless @isSet 
    #     return @siblingField("lower")

  okRange:
    type:Object
    optional:true 
  'okRange.inside':
    type:Boolean
    defaultValue:true
  'okRange.upper':
    type:Number
    optional:true 
  'okRange.lower':
    type:Number
    optional:true
    
  alertRange:
    type:Object
    optional:true 
  'alertRange.inside':
    type:Boolean
    defaultValue:true
  'alertRange.upper':
    type:Number
    optional:true 
  'alertRange.lower':
    type:Number
    optional:true
 
  
  

Schema.Facility = new SimpleSchema
  _id:
    type:String 
  name:
    type:String 
  desc:
    type:String
    optional:true 
  kpi:
    type:[Schema.kpi]
    





facilityColl.attachSchema Schema.Facility

  