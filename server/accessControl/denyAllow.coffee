siteInfoColl.allow
  insert: (userId, doc) ->
    Roles.userIsInRole(userId, ['admin'], doc.group)
# ...
  update: (userId, doc, fields, modifier) ->
    Roles.userIsInRole(userId, ['admin'], doc.group)
    # ...
  remove: (userId, doc) ->
    Roles.userIsInRole(userId, ['admin'], doc.group)
  