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