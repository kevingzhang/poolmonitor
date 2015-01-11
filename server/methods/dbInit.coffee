Meteor.methods
  
  dbInit:()->
    counterColl.insert {_id:'facility', curId:0}
    