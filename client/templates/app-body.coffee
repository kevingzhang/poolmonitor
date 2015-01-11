Template.appBody.helpers
  lists:->
    groupIds = Roles.getGroupsForUser(Meteor.userId(), 'admin')
    siteCursor = siteInfoColl.find group:{$in:groupIds}
    ret = siteCursor.map (s)->
      optgroup: s.name
      options:s.facilities.map (f)->{desc:f.desc, fid:f.id}
    
    console.log ret 
    return ret
    # ...
  activeListClass:(fid)->
    curFid = Session.get 'currentSelectedFacilityId'
    if fid is curFid  
      return 'active'

Template.appBody.events
  'click .list-todo': (e,t) ->
    facilityId = @fid
    Session.set 'currentSelectedFacilityId', facilityId
    
  