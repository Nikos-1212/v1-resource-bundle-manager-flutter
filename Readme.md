# Resource Bundle Manager

Gutenberg Project - Resource Bundle Manager Module

[![Build Status](https://app.bitrise.io/app/15e5d660-0dcb-46b1-b81d-d43b230ec3eb/status.svg?token=zOSzuQxe-J7x6uHzan46NQ&branch=master)](https://app.bitrise.io/app/15e5d660-0dcb-46b1-b81d-d43b230ec3eb)

## Finish setup

- [ ] Set up local build
- [ ] Set up GitHub restrictions
- [ ] Release the version
- [ ] Add it to the container
- [ ] Additional tool using scripts

### Local builds

#### Get a PAT

1. Head to https://github.com/settings/tokens and create a token with `repo` and `packages` scope
2. Make sure this token is authorised to access `discovery-ltd` repositories

#### iOS - Access token

Open `~/.netrc` and add the PAT you just created:

```
machine api.github.com
login YOUR_GITHUB_USERNAME
password YOUR_GITHUB_PERSONAL_ACCESS_TOKEN
```

On some versions of MacOS, the default permissions of the netrc file may give you issues. In that case, fix the perms by running

```
chmod 600 .netrc
```

#### iOS - dev tools

**Ruby/Cocoapods:** Like most iOS projects, ours also make use of Cocoapods. Find install instructions [here](https://guides.cocoapods.org/using/getting-started.html)

**git-lfs:** Some of the repo's use git-lfs to wrangle large files. Install this using `brew install git-lfs`


#### Android - access token

Using the same PAT you used in the iOS setup, open `~/.gradle/gradle.properties` and add two new properties:

```properties
mavenUsername=YOUR_GITHUB_USERNAME 
mavenPassword=YOUR_GITHUB_PERSONAL_ACCESS_TOKEN
```

#### Android - build tools

**Android SDK:** the easiest is to install this via Android Studio

**Android Studio:** Download and install the latest version. Be prepared for Flutter to download half the internet.


### GitHub restrictions

1. Set up branch protections rules for `master` and `develop`
   - Require pull request before merging
   - Require approvals (1)
   - Require status checks to pass before merging (WIP & Bitrise build)
2. Enable dependabot alerts (in the Security tab)

### Releasing

1. Create a branch name `release/<version>`
2. Update the version in `resource_bundle_manager/pubspec.yaml`
3. Make sure your release branch is up-to-date with `master`
4. Open a PR from your release branch to master
5. Wait...

### Add it to the container

In the container, add the package to the `dependencies`.

```yaml
...
dependencies:
  ...
  resource_bundle_manager:
    git:
      url: git@github.com:discovery-ltd/v1-resource-bundle-manager-flutter.git
      path: resource_bundle_manager
      ref: <latest version>
```

### Tool Scripts

```shell
#Use this command to get all dependencies 
sh pub_get.sh

#Use this command to generate code using build_runner tool
sh build_runner.sh

#Use this command to perform static analysis in dart code
sh analyze.sh

#Use this command to run the unit test and generate coverage
sh test_coverage.sh

#Use this command to generate binary files for android and iOS
sh build_app.sh

#Use this command to generate the AppLocalizationKey.dart class
sh string_gen.sh
```

