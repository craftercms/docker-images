# CrafterCMS Docker Images

Builds the CrafterCMS Docker images, including:

1. Authoring Tomcat
2. Authoring Tomcat with Image Magick
3. Delivery Tomcat
4. Deployer
5. Git SSH server
6. Git HTTPS server
7. Profile
8. Logrotate

# Pre-requisites

1. Java
2. Docker

# Gradle Build Tasks

- **clean:** Deletes build folder
- **build:** Builds all Docker images
- **buildMainImages:** Builds main Docker images
- **buildAuthoringTomcat:** Builds the Authoring Tomcat Docker image
- **buildAuthoringTomcatWithImageMagick:** Build the Authoring Tomcat with Image Magick Docker image
- **buildDeliveryTomcat:** Builds the Delivery Tomcat Docker image
- **buildDeployer:** Builds the Deployer Docker image
- **buildGitSshServer:** Builds the Git SSH Server Docker image
- **buildGitHttpsServer:** Builds the Git SSH Server Docker image
- **buildProfile:** Builds the Profile Docker image
- **buildLogrotate:** Builds the Logrotate Docker image

# Gradle parameters

- **authoringTomcatImageName**: Name to use when building the Authoring Tomcat image (default is `craftercms/authoring_tomcat`).
- **authoringTomcatWithImageMagickImageName:** Name to use when building the Authoring Tomcat with Imagemagick image (default is `craftercms/authoring_tomcat_with_imagemagick`).
- **deliveryTomcatImageName:** Name to use when building the Delivery Tomcat image (default is `craftercms/delivery_tomcat`).
- **deployerImageName:** Name to use when building the Deployer image (default is `craftercms/deployer`).
- **profileImageName:** Name to use when building the Profile image (default is `craftercms/profile`).
- **gitSshServerImageName:** Name to use when building the Git SSH server image (default is `craftercms/git_ssh_server`).
- **gitHttpsServerImageName:** Name to use when building the Git HTTPS server image (default is `craftercms/git_https_server`).
- **logrotateImageName:** Name to use when building the Logrotate image (default is `craftercms/logrotate`).
- **tag:** The tag used on image build, typically will be the version number (e.g. `4.0.0`).
- **enterprise:** If the enterprise edition and enterprise only images should be built.
- **imagemagick:** If the Authoring Tomcat with Imagemagick image should be built.
- **authoringBundle:** Can be the URL to download the authoring bundle, or the local tar.gz of the bundle, or the directory with the expanded bundle.
- **deliveryBundle:** Can be the URL to download the delivery bundle, or the local tar.gz of the bundle, or the directory with the expanded bundle.
- **authoringCustomWebapps:** Paths of custom WARs to be placed in the Authoring Tomcat image, separated by commas. Existing WARs, like `studio.war`, can be overwritten this way with custom overlays.
- **deliveryCustomWebapps:** Paths of custom WARs to be placed in the Delivery Tomcat image, separated by commas. Existing WARs, like `ROOT.war`, can be overwritten this way with custom overlays.

# Example commands

**NOTE:** Make sure to use bundles with Crafter Social if you're building all images or building the Profile image

- Clean build dir and build all images based on the default bundles:
```bash
    ./gradlew clean build
```
- Build images using bundles downloaded from the web and use a specific version tag:
```bash
    ./gradlew build -PauthoringBundle=https://downloads.craftercms.org/4.0.0/social/crafter-cms-authoring-4.0.0.tar.gz -PdeliveryBundle=https://downloads.craftercms.org/4.0.0/social/crafter-cms-authoring-4.0.0.tar.gz -Ptag=4.0.0
```
- Build images using bundles tars built locally:
```bash
    ./gradlew build -PauthoringBundle=/home/jdoe/code/craftercms/bundles/crafter-cms-authoring-4.0.0-SNAPSHOT.tar.gz -PdeliveryBundle=/home/jdoe/code/craftercms/bundles/crafter-cms-delivery-4.0.0-SNAPSHOT.tar.gz -Ptag=4.0.0-SNAPSHOT
```
- Build images using expanded bundle directories:
```bash
    ./gradlew build -PauthoringBundle=/home/jdoe/code/craftercms/crafter-authoring -PdeliveryBundle=/home/jdoe/code/craftercms/bundles/crafter-delivery -Ptag=4.0.0-SNAPSHOT
```
- Build the enterprise images and the Authoring Tomcat with Imagemagick image
```bash
    ./gradlew build -Penterprise -Pimagemagick -PauthoringBundle=https://downloads.craftercms.org/ent/4.0.0E/social/crafter-cms-authoring-4.0.0E.tar.gz -PdeliveryBundle=https://downloads.craftercms.org/ent/4.0.0E/social/crafter-cms-delivery-4.0.0E.tar.gz -Ptag=4.0.0E
```
- Build the Enterprise Authoring image with a custom studio overlay
```bash
    ./gradlew buildAuthoringTomcat -Penterprise -Pauthoring.bundle=https://downloads.craftercms.org/ent/4.0.0E/social/crafter-cms-authoring-4.0.0E.tar.gz -Pauthoring.customWebapps=/home/jdoe/code/craftercms/studio-overlay/target/studio.war -PauthoringTomcatImageName=mycompany/authoring_tomcat -Ptag=4.0.0E
```
