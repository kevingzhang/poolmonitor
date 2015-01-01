Template.facilityList.rendered = ->
  that = @
  @autorun ->
    facilityId = Session.get 'currentSelectedFacilityId'
    Meteor.subscribe 'facilityKpi', facilityId

Template.facilityList.helpers
  siteName:->
    facilityId = Session.get 'currentSelectedFacilityId'
    siteInfoDoc = siteInfoColl.findOne facilities:{$elemMatch:{id:facilityId}}
    
    return siteInfoDoc?.name

  facilityName:->
    facilityId = Session.get 'currentSelectedFacilityId'
    siteInfoDoc = siteInfoColl.findOne facilities:{$elemMatch:{id:facilityId}}
    return unless siteInfoDoc?.facilities?
    for f in siteInfoDoc.facilities
      if f.id is facilityId
        return f.name

  facilityDesc:->
    facilityId = Session.get 'currentSelectedFacilityId'
    siteInfoDoc = siteInfoColl.findOne facilities:{$elemMatch:{id:facilityId}}
    return unless siteInfoDoc?.facilities?
    for f in siteInfoDoc.facilities
      if f.id is facilityId
        return f.desc

  kpis:->
    facilityId = Session.get 'currentSelectedFacilityId'
    kpiColl.find facilityId:facilityId

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

  selectedKpiDoc: ->
    
    kpiId = Session.get "facility/selectedKpi"
    kpiColl.findOne kpiId
    
  KpiSchema:->
    Schema.kpi





Template.facilityList.events
  'click #add-kpi': (e,t) ->
    facilityId = Session.get 'currentSelectedFacilityId'
    
    newKpi = {}
    newKpi._id = Random.hexString(24)
    newKpi.name = 'new KPI'
    newKpi.facilityId = facilityId
    newKpi.desc = ""
    newKpi.valueType = "Number"
    newKpi.isGeneric = true
    kpiColl.insert newKpi
    
  'click #kpiTable .regular-row': (e,t) ->
    Session.set 'facility/selectedKpi', @_id


    # ...