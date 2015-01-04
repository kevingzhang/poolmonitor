Template.selectDate.helpers
  selectDateSchema: () ->
    return new SimpleSchema
      selectedDate:
        type:Date
        optional:true
        label:'Select Date'
        autoform:
          value: new Date()
            # return new Date("2014-10-18T00:00:00.000Z")
            # #return new Date()
            

  curDateString:->
    curDate = Session.get 'currentDate'
    if curDate?
      return moment(curDate).format('MM/DD/YYYY')
    else
      Session.set 'currentDate', new Date()
      return moment().format('MM/DD/YYYY')

  settingDate:->
    Session.get 'settingDate'

Template.selectDate.events
  'click #last': () ->
    curDate = Session.get 'currentDate'
    curDate = moment(curDate).subtract(1, 'days').toDate()
    Session.set 'currentDate', curDate
    # ...

  'click #next': () ->
    curDate = Session.get 'currentDate'
    curDate = moment(curDate).add(1, 'days').toDate()
    Session.set 'currentDate', curDate
    # ...

  'click #click-to-select':()->
    Session.set 'settingDate', true 



AutoForm.hooks
  selectDateForm:
    onSubmit:(insertDoc, updateDoc, currentDoc)->
      @done()
      #console.log insertdoc, updateDoc, currentDoc
      Session.set 'currentDate',(insertDoc.selectedDate)
      return false

    onSuccess:(operation, result, template)->
      Session.set 'settingDate', false 
      #console.log "onSuccess,", operation, result, template 

