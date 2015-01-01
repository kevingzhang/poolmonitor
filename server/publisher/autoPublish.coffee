#--- autopubSiteInfo
Meteor.publish null, ()->
  return unless @userId?
  groupIds = Roles.getGroupsForUser(@userId, 'admin')
  console.log "auto publish site info, groupIds:", groupIds
  return siteInfoColl.find group:{$in:groupIds}
#---
