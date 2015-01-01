@kpiColl = new Mongo.Collection 'kpi'

@Schema ?= {}

Schema.kpi = new SimpleSchema
  _id:
    type:String 
    # autoValue:->
    #   randomId = Random.hexString(24)
    #   if @isInsert
    #     return randomId 
    #   if @isUpsert
    #     return {$setOnInsert:randomId}
    #   else
    #     @unset()
  facilityId:
    type:String
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
  "bestRange":
    type:Object
    optional:true 
  "bestRange.inside":
    type:Boolean
    defaultValue:true

  'bestRange.lower':
    type:Number
    optional:true
    
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
 
kpiColl.attachSchema Schema.kpi

  