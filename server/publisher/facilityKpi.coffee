Meteor.publish "facilityKpi", (facilityId)->
  kpiColl.find facilityId:facilityId
  