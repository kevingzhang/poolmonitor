#--- autopubSiteInfo
Meteor.publish null, ()->
  return unless Meteor.userId()?
  groupIds = Roles.getGroupsForUser(Meteor.userId(), 'admin')
  console.log "auto publish site info, groupIds:", groupIds
  return siteInfoColl.find group:{$in:groupIds}
#---
