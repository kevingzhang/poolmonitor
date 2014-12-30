Meteor.publish "facilityList", (siteId)->
  console.log "siteId,", siteId 
  cursors = []
  cursors.push siteInfoColl.find _id:siteId
  cursors.push facilityColl.find siteId:siteId
  return cursors
