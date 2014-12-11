Meteor.methods
  testSiteInfoColl:()->
    id = siteInfoColl.initNewSite 'siteName', 'this is the test site'
    siteObj = siteInfoColl.findOne id
    console.dir siteObj
    facilityId = siteInfoColl.addFacilityToSite id, 'my facility', 'desc of this facility'
    console.dir siteObj
    siteInfoColl.removeFacilityFromSite id, facilityId, 'my facility'
    console.dir (siteInfoColl.findOne id)
    siteInfoColl.removeSite siteObj._id
    siteObj = siteInfoColl.findOne id 
    console.dir siteObj

