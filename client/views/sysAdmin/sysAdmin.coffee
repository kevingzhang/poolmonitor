Template.sysAdmin.helpers
  siteInfoSchema: () ->
    Schema.SiteInfoSchema
    # ...
  siteInfoColl:->
    siteInfoColl 

  sitesInGroup:->
    siteInfoColl.find()

  selectedSiteId:->
    Session.get "sysAdmin/selectedSite"

  siteTableSettings:->
    showfilter:false
    rowsPerPage:10
    showColumnToggles:true
    useFontAwesome:true
    id:'siteTable'
    rowClass:(e)->
      rowId = e._id
      if Session.equals("sysAdmin/selectedSite", rowId)
        return 'selected-row'
      else
        return 'regular-row'
    fields:
      [
        {
          key:'name'
          label:'Name'

        },
        {
          key:'group' 
          label:'GroupId'

        },
        {
          key:'desc'
          label:'Description'
        },
        {
          key:'facilities'
          label:'Facilities #'
          fn:(f,e)->
            if Array.isArray(f)
              ret = "[#{f.length}] "
              for fac in f 
                ret += ", #{fac.name}"
              return ret 
            else
              0

        },
        {
          key:'_id'
          label:'Action'
          fn:(f,e)->
            return new Handlebars.SafeString "<i data-id='#{f}' class='fa fa-cog'></i>"
        }
        
      ]

Template.sysAdmin.events
  'click #siteTable .regular-row': (e,t) ->
    Session.set 'sysAdmin/selectedSite', @_id

  'click #siteTable .regular-row .fa-cog':(e,t)->
    siteId = e.currentTarget.getAttribute('data-id')
    if siteId?
      Router.go "/sysadmin/faclist/#{siteId}"
    # ...

