Meteor.methods(
  {
    addExampleUsersWithRole: function(){

      var users = [
            {name:"Normal User",email:"normal@example.com",roles:[], group:"1"},
            {name:"View-Secrets User",email:"view@example.com",roles:['view-secrets'], group:"1"},
            {name:"Manage-Users User",email:"manage@example.com",roles:['manage-users'], group:"1"},
            {name:"Admin User",email:"admin@example.com",roles:['admin'], group:"1"}
          ];

      _.each(users, function (user) {
        var id;

        id = Accounts.createUser({
          email: user.email,
          password: "apple1",
          profile: { name: user.name }
        });

        if (user.roles.length > 0) {
          // Need _id of existing user record so this call must come 
          // after `Accounts.createUser` or `Accounts.onCreate`
          Roles.addUsersToRoles(id, user.roles, user.group);
        }

      });

    }
  }
);