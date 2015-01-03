@readingColl = new Mongo.Collection 'reading'

@Schema ?= {}

Schema.Reading = new SimpleSchema
  facilityId:
    type:String 
  kpiId:
    type:String
  logAt:
    type:Date
    autoValue:->
      if @isInsert
        return new Date()
      else if @isUpsert
        return {$setOnInsert: new Date()}
      else
        @unset() 
  logAtYMD:
    type:String
    autoValue:->
      if @isInsert
        return moment().format('YYYYMMDD')
      else if @isUpsert
        return {$setOnInsert: moment().format('YYYYMMDD')}
      else
        @unset() 
  updateAt:
    type:Date
    autoValue:->
      if @isUpdate
        return new Date()
    denyInsert:true
    optional:true

  valueString:
    type:String 
  valueType:
    type:String
    allowedValues:['String', 'Number', 'Boolean', 'Date']
  evaluation:
    type:String 
    autoValue:->
      #todo

      return "OK"
  


readingColl.getTransformedValue = (readingId)->
  readingDoc = readingColl.findOne readingId
  switch readingDoc.valueType
    when 'String'
      return readingDoc.valueString
    when 'Number'
      return Number(readingDoc.valueString)
    when 'Boolean'
      if readingDoc.valueString.toLowerCase() is 'true' then return true else return false 
    when 'Date'
      return Date.parse(readingDoc.valueString)
    else
      return undefined 





