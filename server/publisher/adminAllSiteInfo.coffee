Meteor.publish 'adminAllSiteInfo', ()->
  
  # return unless @userId?
  # if false #user.profile.emails[0] isnt 'admin@poolmonitor.com'
  #   detail = "None admin user try to access admin"
  #   console.log "ERROR:", detail
  #   throw new Meteor.Meteor.Error 404, 'Error 404: Not found', details

  return siteInfoColl.find()