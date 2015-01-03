

Template.reading.helpers
  items: () ->
    facilityId = Session.get 'currentSelectedFacilityId'
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
        return todayData
      if shouldShowKpi(item)
        return {
          insert:true
          name:item.name
          desc:item.desc 
          valueString: ''
          }



