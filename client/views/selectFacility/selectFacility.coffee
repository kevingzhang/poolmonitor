Template.selectFacility.rendered = ->
  that = @
  @autorun ()->
    facilityId = Session.get 'currentSelectedFacilityId'
    that.find(".select-bar select").value = facilityId or ''

Template.selectFacility.helpers
  options: () ->
    groupIds = Roles.getGroupsForUser(Meteor.userId(), 'admin')
    siteCursor = siteInfoColl.find group:{$in:groupIds}
    ret = siteCursor.map (s)->
      optgroup: s.name
      options:s.facilities.map (f)->{label:"#{f.name} - #{f.desc}", value:f.id}
    
    #console.log ret 
    return ret  

  selectFacilitySchema: ->
    new SimpleSchema
      facilityId:
        type:String 
        label:" "

  



Template.selectFacility.events
  'change .select-bar select': (e,t) ->
    facilityId = e.target.value
    Session.set 'currentSelectedFacilityId', facilityId
    # ...