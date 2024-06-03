# Crafter CMS Docker Images

This project is being retired. We're retiring that repository. Prebuilt CrafterCMS Docker Images are available on [Docker Hub](https://hub.docker.com/search?q=craftercms). To manually build your own, use the main project [CrafterCMS](https://github.com/craftercms/craftercms). For instructions, see the [README](https://github.com/craftercms/craftercms/blob/develop/README.md).

For example, to build Docker Images for v4.1.5, you can do this:
```
git clone -b v4.1.5 https://github.com/craftercms/craftercms v4.1.5
cd v4.1.5
./gradlew build deploy bundle buildMainImages
```
