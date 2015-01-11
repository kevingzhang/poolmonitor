

Router.configure
  #layoutTemplate: 'MasterLayout'
  loadingTemplate: 'Loading'
  notFoundTemplate: 'NotFound'
  templateNameConverter: 'upperCamelCase'
  routeControllerNameConverter: 'upperCamelCase'
Router.configure
  #layoutTemplate:'appBody'
  notFoundTemplate:'appNotFound'
  loadingTemplate: 'appLoading'



Router.map ()->
  @route('join')
  @route('signin')

  @route 'home',
    path:'/'

  
  

  @route 'sys.admin.faclist',
    path:'sysadmin/faclist/:siteId'
    template:'facilityList'
    layoutTemplate:'desktopLayout'
    waitOn:->

      Meteor.subscribe 'facilityList', @params.siteId
    data:->

  @route 'sys.admin',
    path:'sysadmin'
    template:'sysAdmin'
    layoutTemplate:'desktopLayout'
    waitOn:->

      Meteor.subscribe 'adminAllSiteInfo'
    data:->
      siteInfoColl.find {}

  @route 'reading',
    path:'reading'
    template:'reading'
    layoutTemplate:'appBody'
    waitOn:->
      facilityId = Session.get 'currentSelectedFacilityId'
      todayString = (Session.get 'currentDate') or (moment().format('MM/DD/YYYY'))
      ret = []
      ret.push Meteor.subscribe 'facilityKpi', facilityId 
      ret.push Meteor.subscribe 'readingOfFacility', facilityId, todayString
      
      return ret 
    
      



