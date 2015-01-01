Template.facilityList.rendered = ->
  that = @
  @autorun ->
    facilityId = Session.get 'currentSelectedFacilityId'
    Meteor.subscribe 'facility', facilityId

Template.facilityList.helpers
  siteName:->
    facilityId = Session.get 'currentSelectedFacilityId'
    siteInfoDoc = siteInfoColl.findOne facilities:{$elemMatch:{id:facilityId}}
    
    return siteInfoDoc?.name

  facilityName:->
    facilityId = Session.get 'currentSelectedFacilityId'
    facilityDoc = facilityColl.findOne _id:facilityId 
    return facilityDoc?.name

  facilityDesc:->
    facilityId = Session.get 'currentSelectedFacilityId'
    facilityDoc = facilityColl.findOne _id:facilityId 
    return facilityDoc?.desc

  kpis:->
    facilityId = Session.get 'currentSelectedFacilityId'
    facilityDoc = facilityColl.findOne _id:facilityId 
    return facilityDoc?.kpi 
  tableSettings:->
    showfilter:false
    rowsPerPage:10
    showColumnToggles:true
    useFontAwesome:true
    id:'kpiTable'
    rowClass:(e)->
      rowId = e._id
      if Session.equals("facility/selectedKpi", rowId)
        return 'selected-row'
      else
        return 'regular-row'
    fields:
      [
        {
          key:'name'
          label:'Name'

        },
        {
          key:'desc'
          label:'Description'
        },
        {
          key:'valueType'
          label:'Value Type'
          fn:(f,e)->
            if f.isGeneric
              return f 
            else
              return f + "(*)"
        }
      ]

  selectedKpi:->
    Session.get "facility/selectedKpi"

  autoSaveMode:true 

  selectedKpiDoc = ->
    kpiId = Session.get "facility/selectedKpi"
    return facilityColl.findOne kpiId 

  




Template.facilityList.events
  'click #add-kpi': (e,t) ->
    facilityId = Session.get 'currentSelectedFacilityId'
    
    facilityDoc = facilityColl.findOne _id:facilityId 
    return unless facilityDoc?
    newKpi = {}
    newKpi.id = Random.hexString(24)
    newKpi.name = 'new KPI'
    newKpi.desc = ""
    newKpi.valueType = "Number"
    newKpi.isGeneric = true
    facilityColl.update facilityId, $push:{kpi:newKpi}
    
  'click #siteTable .regular-row': (e,t) ->
    Session.set 'facility/selectedKpi', @_id


    # ...