

Router.configure
  layoutTemplate: 'MasterLayout'
  loadingTemplate: 'Loading'
  notFoundTemplate: 'NotFound'
  templateNameConverter: 'upperCamelCase'
  routeControllerNameConverter: 'upperCamelCase'

Router.map ()->
  @route 'home',
    path:'/'

  @route 'autoform',
    path:'/autoform'
    
    data:()->
      return "hello"

  @route 'store',
    path:'/store/:storeId',
    waitOn:()->
      h1 = Meteor.subscribe 'storeInfo', @params.storeId
      h2 = Meteor.subscribe 'storeQueue', @params.storeId
      return [h1,h2]


    data:()->
      

      storeInfo = storeColl.findOne @params.storeId
      storeQueue = queueColl.find storeId:@params.storeId

      return {
              storeInfo : storeInfo
              storeQueue: storeQueue}

    action:()->
      if @ready()
        @render()
      else
        @render('loading')

  
  @route 'storeKeeper',
    path: 'storekeeper/:storeId'
    onBeforeAction: (pause)->
      unless Meteor.user()?
        @render 'login'
        pause()

    waitOn:()->
      h1 = Meteor.subscribe 'storeInfo', @params.storeId
      h2 = Meteor.subscribe 'storeQueue', @params.storeId
      return [h1,h2]
    data:()->
      
      storeInfo = storeColl.findOne @params.storeId
      storeQueue = queueColl.find storeId:@params.storeId

      return {
              storeInfo : storeInfo
              storeQueue: storeQueue}
    action:()->
      if @ready()
        @render()
      else

  @route 'admin',
    path:'/admin'

  @route 'site.admin',
    path:'/site/admin'
    template:'siteAdmin'
    waitOn:()->
      poolId = Session.get('poolId')
      return unless poolId?
      return Meteor.subscribe 'siteInfo', poolId
    data:->
      poolId = Session.get('poolId')
      siteInfo = siteInfoColl.find _id:poolId
      return unless siteInfo?
      return siteInfo

  @route 'sys.admin.faclist',
    path:'sysadmin/faclist/:siteId'
    template:'facilityList'
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
    waitOn:->
      facilityId = Session.get 'currentSelectedFacilityId'
      Meteor.subscribe 'facilityKpi', facilityId 
    data:->
      facilityId = Session.get 'currentSelectedFacilityId'
      items = kpiColl.find facilityId:facilityId 
      return {kpis:items}



