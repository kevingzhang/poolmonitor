
Template.reading.helpers
  
  evaluation: (kpi)->
    'OK'

  readings:->
    facilityId = Session.get 'currentSelectedFacilityId'
    
    shouldShowKpi = (item)->
      #todo
      return true 
    todayDataEntered = (item)->
      today = moment((Session.get 'currentDate') or new Date()).format('YYYYMMDD')
      return readingColl.findOne facilityId:facilityId, kpiId:item._id, logAtYMD:today 


    facilityId = Session.get 'currentSelectedFacilityId'
    items = kpiColl.find facilityId:facilityId 
    items.map (item)->
      todayData = todayDataEntered(item)
      if todayData?
        return {
          insert:false
          _id:todayData._id
          kpiId:item._id
          name:item.name
          desc:item.desc 
          valueString: todayData.valueString
          valueType:item.valueType
          }

      if shouldShowKpi(item)
        return {
          insert:true
          kpiId:item._id
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

    
    kpiId = e.target.parentElement.parentElement.getAttribute('id')
    if AutoForm.validateField(kpiId, 'input', false)
      kpiDoc = kpiColl.findOne kpiId
      newReadingDoc = {}
      newReadingDoc.facilityId = kpiDoc.facilityId
      newReadingDoc.kpiId = kpiId 
      newReadingDoc.valueString = e.target.value
      newReadingDoc.valueType = kpiDoc.valueType

      readingColl.insert newReadingDoc

  'click .reset':(e,t)->
    readingId = e.target.getAttribute 'data-id'
    if readingId?
      readingColl.remove readingId


    # ...
