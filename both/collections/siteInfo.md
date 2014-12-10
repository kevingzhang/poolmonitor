siteInfo.md

_id:  string, this is the id of mongodb
name: site Name, used to display, can change
desc: descriptions , string
profile: object, see below
  address:
  contact:
  something else
facilities: object. this is obj of all facilities belonging to this site.
  //This is key value pair, key is _id, value is facilityObj
  _id: facilityObj
  facilityObj format looks like below

  name: string, display name, can be changed
  desc: descritions , strings. can be modified. optional
  reads: object, key value pair of all meter reads. 
    _id:readObject
    name: display name
    selectCandidates:[value1, value2]  //if this value exists 
      

  kpi:
    id:kpiObject
      kpiObject format see below
      name: display name string
      def: defObject   //this is how to calculate this kpi, it is a formula such as sum(read1, read2), or just direct equals to read3. read1, 2, 3 are _id
        defObject define below
        func:functionName, such as equal, or sum, or avg
        params:[list of reads_id]
      alertCondition:
        ideal:
          min:value
          max:value   // min can equals to max
        quality:
          min:value
          max:value
        ok:
          min:value
          max:value
        danger:
          min:value
          max:value
      alertAction:
        email:
          [emailList]





