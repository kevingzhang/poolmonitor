@testColl = new Mongo.Collection 'test'

Schemas.test = new SimpleSchema
  siteName:
    type:String
    index:1
    unique:true
  
  facilities:
    type: Array 
  'facilities.$':
    type:Object 
  'facilities.$.name':
    type:String
    index:1
    unique:true 
  'facilities.$.desc':
    type:String
    optional:true 
  'facilities.$.reads':
    type:Array
  'facilities.$.reads.$':
    type:Object
  'facilities.$.reads.$.label':
    type:String
    unique:true 
  'facilities.$.reads.$.desc':
    type:String
    optional:true 



testColl.attachSchema Schemas.test