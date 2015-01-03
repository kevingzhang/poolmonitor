Meteor.publish 'readingOfFacility', (facilityId)->
  today = moment().format('YYYYMMDD')
  readingColl.find facilityId:facilityId, logAtYMD:today