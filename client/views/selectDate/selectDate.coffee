Template.selectDate.helpers
  selectDateSchema: () ->
    return new SimpleSchema
      selectedDate:
        type:Date
        optional:true
        

  curDateString:->
    curDate = Session.get 'currentDate'
    if curDate?
      return moment(curDate).format('MM/DD/YYYY')
    else
      dateString = moment().format('MM/DD/YYYY')
      Session.set 'currentDate', dateString
      return dateString

 
Template.selectDate.events
 
  'change #select-date input':(e,t)->
    dateString = e.target.value
    console.log dateString 
    if !!dateString
      Session.set 'currentDate', dateString
    


