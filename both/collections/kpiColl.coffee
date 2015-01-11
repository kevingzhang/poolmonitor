@Lists = new Mongo.Collection 'lists'
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
  kpiGroupName:
    type:String
    label:'KPI Group'
    allowedValues:["Default", "Chemical","Storage", "HVAC", "Mechanical"]
  name:
    type:String 
  unit:
    type:String
    optional:true 
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
  "bestRange.within":
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
  'okRange.within':
    type:Boolean
    defaultValue:true
  
  'okRange.lower':
    type:Number
    optional:true
  'okRange.upper':
    type:Number
    optional:true 
    
  alertRange:
    type:Object
    optional:true 
  'alertRange.within':
    type:Boolean
    defaultValue:true
  
  'alertRange.lower':
    type:Number
    optional:true
  'alertRange.upper':
    type:Number
    optional:true 
 
kpiColl.attachSchema Schema.kpi

  