Meteor.publish 'adminAllSiteInfo', ()->
  
  groups = Roles.getGroupsForUser(@userId, 'admin')
  console.log groups


  return siteInfoColl.find group:{$in:groups}