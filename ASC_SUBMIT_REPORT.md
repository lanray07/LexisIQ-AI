# App Store Connect Submit Report
Generated: 2026-06-04 10:42:23 UTC

Subscription promotional images deleted in this run: 0
Subscription promotional images still present/failed to delete: 0

Version ID: 927dd867-eb23-40ec-9c78-9813ba0bc918
Version attributes: {
  "platform": "IOS",
  "versionString": "1.0",
  "appStoreState": "REJECTED",
  "appVersionState": "REJECTED"
}

Created reviewSubmission: 6c989de0-35e0-48e9-ae12-cfb3c9b27e22
Create reviewSubmissionItem failed:
{
  "status": 409,
  "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"ea1a4dfe-224e-4e1f-9479-d2804087062f\",\n    \"status\" : \"409\",\n    \"code\" : \"STATE_ERROR.ENTITY_STATE_INVALID\",\n    \"title\" : \"appStoreVersions with id '886271058' is not in valid state.\",\n    \"detail\" : \"This resource cannot be reviewed, please check associated errors to see why.\",\n    \"meta\" : {\n      \"associatedErrors\" : {\n        \"/appStoreVersions/886271058\" : [ {\n          \"id\" : \"3bc0aee9-b714-46d2-90c4-c57d56c14e09\",\n          \"status\" : \"409\",\n          \"code\" : \"STATE_ERROR.ITEM_PART_OF_ANOTHER_SUBMISSION\",\n          \"title\" : \"Item is already present in another reviewSubmission\",\n          \"detail\" : \"appStoreVersions with id 886271058 was already added to another reviewSubmission with id 200d7fd2-3f06-49ef-8be9-b98ef488728e\"\n        } ]\n      }\n    }\n  } ]\n}",
  "path": "/reviewSubmissionItems",
  "method": "POST"
}
Submit reviewSubmission failed:
{
  "status": 409,
  "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"0e6e76a3-e02b-4a7e-b63a-c5d289b26ad2\",\n    \"status\" : \"409\",\n    \"code\" : \"ENTITY_ERROR.RELATIONSHIP.REQUIRED\",\n    \"title\" : \"Relationship is required\",\n    \"detail\" : \"App 6774482124 must have an approved appStoreVersions for platform IOS, or an appStoreVersions must be included in this review submission.\",\n    \"source\" : {\n      \"pointer\" : \"/data/relationships/appStoreVersionForReview\"\n    }\n  } ]\n}",
  "path": "/reviewSubmissions/6c989de0-35e0-48e9-ae12-cfb3c9b27e22",
  "method": "PATCH"
}
Legacy appStoreVersionSubmission failed:
{
  "status": 403,
  "detail": "{\n  \"errors\" : [ {\n    \"id\" : \"a5efec38-0792-4755-bfb2-4e61590f299e\",\n    \"status\" : \"403\",\n    \"code\" : \"FORBIDDEN_ERROR\",\n    \"title\" : \"The given operation is not allowed\",\n    \"detail\" : \"The resource 'appStoreVersionSubmissions' does not allow 'CREATE'. Allowed operation is: DELETE\"\n  } ]\n}",
  "path": "/appStoreVersionSubmissions",
  "method": "POST"
}

Final submit_success: False
