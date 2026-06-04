# App Store Connect Update Review Report
Generated: 2026-06-04 11:05:38 UTC

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

Promoted purchases before removal:
{
  "data": [],
  "included": [],
  "links": {
    "self": "https://api.appstoreconnect.apple.com/v1/apps/6774482124/promotedPurchases?fields%5Bsubscriptions%5D=productId%2Cname&fields%5BpromotedPurchases%5D=visibleForAllUsers%2Cstate%2Csubscription%2Cenabled&include=subscription&limit=200"
  },
  "meta": {
    "paging": {
      "total": 0,
      "limit": 200
    }
  }
}

Update attempt 1:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"335903d7-b8db-4454-84fd-f82c9844eea9\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"bdd5fbab-d601-494f-a09b-07436cd36931\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 2:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"8405be51-d244-45a6-8161-601e80f27006\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"d85601bb-3c93-4abc-8b27-e042c901a741\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 3:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"d0477d12-86bf-423e-b2e9-e95d95dd4f5b\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"55033302-3559-40e7-af06-638dd7eb494d\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 4:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"0d21338c-f44c-4d1e-a230-3c7fe4bc91cf\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"ecf82f6c-9d48-4f75-97f6-209ffe83d36c\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 5:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"9e562f86-589c-48b5-83f1-81e3a1ec2b7f\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"218e7db5-1bc0-4e7e-a525-4df0e0482565\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 6:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"63ccb8d9-e7c8-465e-afcd-201ca7f63b82\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"63da406e-a1e6-48a9-9b96-e76b7e03c5e3\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 7:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"26080ee0-d2b9-4dc6-ab46-a751d5358005\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"9084d661-7465-47d4-80ae-4a1e98199703\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 8:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"96352183-3c0f-4170-ae1e-41b23c0ac0e2\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"8122e960-2a84-4927-8846-4b69fad4da5d\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 9:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"051c9fe5-c220-460a-b523-3018b830ee91\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"ad637ea6-3365-472c-a524-afc136de5ae8\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 10:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"08280c58-ea0e-4be8-8727-37d2cb04635b\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"af1ee705-d5c4-46f9-bf92-0b7e6709915a\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 11:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"da33e0a6-cfea-4fb7-98cc-6744b2ca6d34\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"4a4dad67-8321-419c-9ef9-b737c5046fe5\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 12:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"5d655936-ff81-4192-ad52-3631865d8374\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"664ef412-a3af-4306-9d71-7dfe315890c5\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 13:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"89f290a6-84a0-482a-8831-58f8966f6034\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"172e4087-9867-4a50-89a0-ae9f59780678\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 14:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"99ad9795-a43a-41dc-8a82-1af5d65c378f\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"40f57ba2-086e-4a7d-bfbe-a6fd3e98bd3b\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update attempt 15:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"dbca099d-f6c5-4e84-925f-59d2926a22ec\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"762b3d32-06df-4a56-bc49-baa87ab29773\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
    "path": "/reviewSubmissions/200d7fd2-3f06-49ef-8be9-b98ef488728e",
    "method": "PATCH"
  }
}

Update response:
{
  "_error": {
    "status": 409,
    "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"dbca099d-f6c5-4e84-925f-59d2926a22ec\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '927dd867-eb23-40ec-9c78-9813ba0bc918' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/v1/appStoreVersions/927dd867-eb23-40ec-9c78-9813ba0bc918\" : [ {\n          \"id\" : \"762b3d32-06df-4a56-bc49-baa87ab29773\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR\",\n          \"title\" : \"The request cannot be fulfilled because of the state of another resource.\",\n          \"detail\" : \"Version is not ready to be submitted yet, please try again later.\"\n        } ]\n      }\n    }\n  } ]\n}",
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
