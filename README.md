# Crafter CMS Docker Images

Builds the Crafter CMS Docker images, including:

1. Authoring Tomcat 
2. Authoring Tomcat with Solr support
3. Delivery Tomcat
4. Delivery Tomcat with Solr support
5. Deployer
6. Git SSH server
7. Profile
8. Logrotate

# Pre-requisites

1. Java
2. Docker

# Gradle Build Tasks

- **clean:** Deletes build folder
- **build:** Builds all Docker images
- **buildMainImages:** Builds main Docker images
- **buildTomcatImagesWithSolrSupport:** Builds Tomcat Docker images with Solr support
- **buildAuthoringTomcat:** Builds the Authoring Tomcat Docker image
- **buildAuthoringTomcatWithSolrSupport:** Builds the Authoring Tomcat With Solr Support Docker image
- **buildDeliveryTomcat:** Builds the Delivery Tomcat Docker image
- **buildDeliveryTomcatWithSolrSupport:** Builds the Delivery Tomcat With Solr Support Docker image
- **buildDeployer:** Builds the Deployer Docker image
- **buildGitSshServer:** Builds the Git SSH Server Docker image
- **buildProfile:** Builds the Profile Docker image
- **buildLogrotate:** Builds the Logrotate Docker image

# Gradle parameters

- **tag**: The tag used on image build, typically will be the version number
- **authoring.bundle**: Can be the URL to download the authoring bundle, or the local tar.gz of the bundle, or the directory with the expanded bundle
- **delivery.bundle**: Can be the URL to download the delivery bundle, or the local tar.gz of the bundle, or the directory with the expanded bundle

# Example commands

- Clean build dir and build all images based on the default bundles:
```bash
    ./gradlew clean build
```
- Build images using bundles downloaded from the web and use a specific version tag:
```bash
    ./gradlew build -Pauthoring.bundle=https://downloads.craftercms.org/3.1.4/crafter-cms-authoring-3.1.4.tar.gz -Pdelivery.bundle=https://downloads.craftercms.org/3.1.4/crafter-cms-authoring-3.1.4.tar.gz -Ptag=3.1.4 
```
- Build images using bundles tars built locally:
```bash
    ./gradlew build -Pauthoring.bundle=/home/jdoe/code/craftercms/bundles/crafter-cms-authoring-3.1.5-SNAPSHOT.tar.gz -Pdelivery.bundle=/home/jdoe/code/craftercms/bundles/crafter-cms-delivery-3.1.5-SNAPSHOT.tar.gz -Ptag=3.1.5-SNAPSHOT
```
- Build images using expanded bundle directories:
```bash
    ./gradlew build -Pauthoring.bundle=/home/jdoe/code/craftercms/crafter-authoring -Pdelivery.bundle=/home/jdoe/code/craftercms/bundles/crafter-delivery -Ptag=3.1.5-SNAPSHOT
```
- Build only the main images and the Tomcat images with Solr support:
```bash
    ./gradlew buildMainImages buildTomcatImagesWithSolrSupport
```
