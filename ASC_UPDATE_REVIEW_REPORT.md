# App Store Connect Update Review Report
Generated: 2026-06-04 10:44:26 UTC

Before:
{
  "data": {
    "type": "reviewSubmissions",
    "id": "200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "attributes": {
      "submittedDate": "2026-06-03T05:28:21.013Z",
      "state": "UNRESOLVED_ISSUES"
    },
    "links": {
      "self": "https://api.appstoreconnect.apple.com/v1/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e"
    }
  },
  "links": {
    "self": "https://api.appstoreconnect.apple.com/v1/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e?fields%5BreviewSubmissions%5D=state%2CsubmittedDate"
  }
}

Update response:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"6be36843-b78f-47b0-baad-5fcf646b9ab8\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"26e9e9d6-07e6-46e7-9feb-caa60af48908\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

After:
{
  "data": {
    "type": "reviewSubmissions",
    "id": "200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "attributes": {
      "submittedDate": "2026-06-03T05:28:21.013Z",
      "state": "UNRESOLVED_ISSUES"
    },
    "links": {
      "self": "https://api.appstoreconnect.apple.com/v1/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e"
    }
  },
  "links": {
    "self": "https://api.appstoreconnect.apple.com/v1/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e?fields%5BreviewSubmissions%5D=state%2CsubmittedDate"
  }
}

Final update_success: False
