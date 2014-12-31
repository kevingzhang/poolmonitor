Meteor.publish "facility", (facilityId)->
  facilityColl.find _id:facilityId
  