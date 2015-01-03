
Template.reading.rendered = ->
  memoryColl = new Mongo.Collection()



Template.reading.helpers
  
  evaluation: (kpi)->
    'OK'

  readings:->
    facilityId = Session.get 'currentSelectedFacilityId'
    
    shouldShowKpi = (item)->
      #todo
      return true 
    todayDataEntered = (item)->
      today = moment().format('YYYYMMDD')
      return readingColl.findOne facilityId:facilityId, kpiId:item._id, logAtYMD:today 


    facilityId = Session.get 'currentSelectedFacilityId'
    items = kpiColl.find facilityId:facilityId 
    items.map (item)->
      todayData = todayDataEntered(item)
      if todayData?
        return {
          insert:false
          _id:item._id
          name:item.name
          desc:item.desc 
          valueString: todayData.valueString
          valueType:item.valueType
          }

      if shouldShowKpi(item)
        return {
          insert:true
          _id:item._id
          name:item.name
          desc:item.desc 
          valueString: ''
          valueType:item.valueType
          }

  inputSchema:(item)->
    switch @valueType
      when "String"
        return new SimpleSchema
          input:
            type:String 
      when "Number"
        return new SimpleSchema
          input:
            type:Number 
      when "Boolean"
        return new SimpleSchema
          input:
            type:Boolean 
      when "Date"
        return new SimpleSchema
          input:
            type:Date 
      else
        return new SimpleSchema
          input:
            type:String 



Template.reading.events
  'blur td.input-value>form>div>input': (e,t) ->

    
    id = e.target.parentElement.parentElement.getAttribute('id')
    if AutoForm.validateField(id, 'input', false)
      kpiDoc = kpiColl.findOne id
      newReadingDoc = {}
      newReadingDoc.facilityId = kpiDoc.facilityId
      newReadingDoc.kpiId = id 
      newReadingDoc.valueString = e.target.value
      newReadingDoc.valueType = kpiDoc.valueType

      readingColl.insert newReadingDoc


    # ...
