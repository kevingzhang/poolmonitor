@facilityColl = new Mongo.Collection 'facility'

@Schema ?= {}
Schema.Facility = new SimpleSchema
  _id:
    type:String 
  name:
    type:String 
  desc:
    type:String
    optional:true 

facilityColl.attachSchema Schema.Facility

  