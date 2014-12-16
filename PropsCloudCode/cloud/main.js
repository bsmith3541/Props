var PropsUser = Parse.Object.extend("PropsUser");

// Check if fbId is set, and enforce uniqueness based on the fbId column.
Parse.Cloud.beforeSave("PropsUser", function(request, response) {
  if (!request.object.get("fbId")) {
    response.error('A PropsUser must have a fbId.');
  } else {
    var query = new Parse.Query(PropsUser);
    query.equalTo("fbId", request.object.get("fbId"));
    query.first({
      success: function(object) {
        if (object) {
          response.error("A PropsUser with this Facebook ID already exists.");
        } else {
          response.success();
        }
      },
      error: function(error) {
        response.error("Could not validate uniqueness for this Props User.");
      }
    });
  }
});
