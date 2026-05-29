# GitHub Xcode Release

LexisIQ AI builds through `.github/workflows/xcode-release.yml`.

The workflow has two lanes:

- Pushes to `main` run an unsigned iOS Simulator build.
- Manual workflow dispatches and published GitHub releases archive the iOS app, export an IPA, and upload it to App Store Connect.

## Required Secrets

Configure these in GitHub repository secrets:

- `APPLE_TEAM_ID`
- `APP_STORE_CONNECT_API_KEY_ID`
- `APP_STORE_CONNECT_API_ISSUER_ID`
- `APP_STORE_CONNECT_API_PRIVATE_KEY_BASE64`

The private key should be the base64-encoded contents of the App Store Connect `.p8` key.

The workflow also accepts these aliases if they already exist:

- `DEVELOPMENT_TEAM`
- `APP_STORE_CONNECT_KEY_ID`
- `ASC_KEY_ID`
- `APP_STORE_CONNECT_ISSUER_ID`
- `ASC_ISSUER_ID`
- `APP_STORE_CONNECT_API_PRIVATE_KEY`
- `APP_STORE_CONNECT_PRIVATE_KEY`
- `ASC_PRIVATE_KEY`
- `APP_STORE_CONNECT_PRIVATE_KEY_BASE64`
- `ASC_PRIVATE_KEY_BASE64`

## Optional Signing Secrets

Automatic signing is enabled by default with App Store Connect API authentication. If the repository already stores manual signing assets, the workflow can import them:

- `BUILD_CERTIFICATE_BASE64`
- `P12_PASSWORD`
- `BUILD_PROVISION_PROFILE_BASE64`
- `KEYCHAIN_PASSWORD`

Accepted aliases:

- `IOS_DISTRIBUTION_CERTIFICATE_BASE64`
- `IOS_DISTRIBUTION_CERTIFICATE_PASSWORD`
- `IOS_PROVISION_PROFILE_BASE64`

## Release

In GitHub Actions, run **Xcode Build and App Store Upload** manually and keep `upload_to_app_store_connect` enabled. After Apple processes the uploaded build, select it in App Store Connect for version `1.0`.
