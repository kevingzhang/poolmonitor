@facilityColl = new Mongo.Collection 'facility'

@Schema ?= {}

Schema.kpi = new SimpleSchema
  id:
    type:String 
  

Schema.Facility = new SimpleSchema
  _id:
    type:String 
  name:
    type:String 
  desc:
    type:String
    optional:true 
  kpi:
    type:[Schema.kpi]
    optional:true





facilityColl.attachSchema Schema.Facility

  