@siteInfoColl = new Mongo.Collection 'siteinfo'

@Schema = {}

Schema.Address = new SimpleSchema
  streetNumber:
    type:String
  city:
    type:String
  state:
    type:String
  zipCode:
    type:SimpleSchema.RegEx.ZipCode

Schema.SiteInfoProfile = new SimpleSchema
  address:
    type:Schema.Address 
    optional:true 
  contact:
    type:String
    optional:true
  email:
    type:SimpleSchema.RegEx.Email 
    optional:true 

Schema.Facility = new SimpleSchema
  id:
    type:String 
  name:
    type:String 
  desc:
    type:String
    optional:true 



Schema.SiteInfoSchema = new SimpleSchema
  name:
    type:String
    label:"Site Name"
  group:
    type:String
  desc:
    type:String
    optional:true

  profile:
    type:Schema.SiteInfoProfile
    optional:true
  facilities:
    type:[Schema.Facility]
    optional:true 
  

siteInfoColl.attachSchema Schema.SiteInfoSchema

# @siteInfoColl.initNewSite = (name, desc)->
#   return siteInfoColl.insert {name:name, desc:desc}

# @siteInfoColl.removeSite = (siteId)->
#   siteInfoColl.remove {_id:siteId}

# @siteInfoColl.addFacilityToSite = (siteId, facilityName, facilityDesc)->
#   siteObj = siteInfoColl.findOne siteId
#   unless siteObj?
#     throw new Meteor.Error "Cannot addFacility to an non existing site"
#   hash = facilityName.hashCode()
#   if siteObj.facilities?
    
#     if siteObj.facilities.hash?
#       return {e:'This facility name is existing'}
  
#   updateObj = {}
#   updateObj["facilities.#{hash}"] = {_id:hash, name:facilityName, desc:facilityDesc}
#   siteInfoColl.update {_id:siteId}, {$set:updateObj}
#   return {r:hash}

# @siteInfoColl.removeFacilityFromSite = (siteId, facilityId, facilityName)->
#   facilityId ?= facilityName.hashCode()
#   updateObj = {}
#   updateObj["facilities.#{facilityId}"] = true
#   siteInfoColl.update {_id:siteId}, {$unset:updateObj}
#   return {r:facilityId}

# @siteInfoColl.addReadsToFacility  = (siteId, facilityId, name, selectCandidates)->
#   nameHash = name.hashCode()
#   siteObj = siteInfoColl.findOne siteId
#   facilityObj = siteObj.facilities[facilityId]
#   readObj = facilityObj?.reads[nameHash]
#   if readObj?
#     return {e:'This read is existing'}
#   updateObj = {}
#   updateObj["facilities.#{facilityId}.reads[#{nameHash}"] = {_id:nameHash, name:name, selectCandidates:selectCandidates}
#   siteInfoColl.update {_id:siteId}, {$set:{updateObj}}
#   return {r:nameHash}

# @siteInfoColl.removeReadsFromFacility = (siteId, facilityId, keysId)->
#   updateObj = {}
#   updateObj["facilities.#{facilityId}.reads[#{nameHash}"] = true
#   siteInfoColl.update {_id:siteId}, {$unset:{updateObj}}
  


# @siteInfoColl.addKpiToFacility  = (siteId, facilityId, newKpiObj )->
#   nameHash = kpiName.hashCode()
#   siteObj = siteInfoColl.findOne siteId
#   facilityObj = siteObj.facilities[facilityId]
#   kpiObj = facilityObj?.kpi[nameHash]
#   if kpiObj?
#     return {e:'This kpi is existing'}
#   updateObj = {}
#   newKpiObj._id = nameHash
#   updateObj["facilities.#{facilityId}.kpi[#{nameHash}"] = newKpiObj
#   siteInfoColl.update {_id:siteId}, {$set:{updateObj}}
#   return {r:nameHash}

# @siteInfoColl.removeKpiFromFacility = (siteId, facilityId, kpiId)->
#   updateObj = {}
#   updateObj["facilities.#{facilityId}.kpi[#{kpiId}"] = true
#   siteInfoColl.update {_id:siteId}, {$unset:{updateObj}}
  








