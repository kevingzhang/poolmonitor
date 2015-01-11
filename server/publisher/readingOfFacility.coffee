Meteor.publish 'readingOfFacility', (facilityId, dateString)->
  
  readingColl.find facilityId:facilityId, logAtMDY:dateString