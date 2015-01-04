
Template.reading.helpers
  
  evaluation: ()->
    return if @insert  #no date entry yet
    return unless !!@valueString
    kpiDoc = kpiColl.findOne @kpiId
    if kpiDoc.valueType is 'Number'
      value = Number(@valueString)
      if kpiDoc.bestRange? and (kpiDoc.bestRange.lower? or kpidoc.bestRange.upper?)
        if kpiDoc.bestRange.within
          if (kpiDoc.bestRange.lower or Number.MIN_VALUE) < value < (kpiDoc.bestRange.upper or Number.MAX_VALUE)
            return 'Best' + "Between:#{kpiDoc.bestRange.lower} and #{kpiDoc.bestRange.upper}"
        else
          if (value < (kpiDoc.bestRange.lower or Number.MIN_VALUE)) or (value > (kpiDoc.bestRange.upper or Number.MAX_VALUE))
            return 'Best' + "Out of:#{kpiDoc.bestRange.lower} and #{kpiDoc.bestRange.upper}"
      if kpiDoc.okRange? and (kpiDoc.okRange.lower? or kpidoc.okRange.upper?)
        if kpiDoc.okRange.within
          if (kpiDoc.okRange.lower or Number.MIN_VALUE) < value < (kpiDoc.okRange.upper or Number.MAX_VALUE)
            return 'OK' + "Between:#{kpiDoc.okRange.lower} and #{kpiDoc.okRange.upper}"
        else
          if (value < (kpiDoc.okRange.lower or Number.MIN_VALUE)) or (value > (kpiDoc.okRange.upper or Number.MAX_VALUE))
            return 'OK' + "Out of:#{kpiDoc.okRange.lower} and #{kpiDoc.okRange.upper}"
      if kpiDoc.alertRange? and (kpiDoc.alertRange.lower? or kpidoc.alertRange.upper?)
        if kpiDoc.alertRange.within
          if (kpiDoc.alertRange.lower or Number.MIN_VALUE) < value < (kpiDoc.alertRange.upper or Number.MAX_VALUE)
            return 'Alert' + "Between:#{kpiDoc.alertRange.lower} and #{kpiDoc.alertRange.upper}"
        else
          if (value < (kpiDoc.alertRange.lower or Number.MIN_VALUE)) or (value > (kpiDoc.alertRange.upper or Number.MAX_VALUE))
            return 'Alert' + "Out of :#{kpiDoc.alertRange.lower} and #{kpiDoc.alertRange.upper}"
      
      return 'Alert: out of range'
    else
      ''

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
