alpine-hugo
===========

[![Docker Repository on Quay](https://quay.io/repository/makii42/alpine-hugo/status "Docker Repository on Quay")](https://quay.io/repository/makii42/alpine-hugo)

This is a small docker image based on the incredibly small
[alpine linux][alpine] image that can be used to build and deploy
[hugo][hugo] websites as a container.

To achieve that, the images comes with an installed [hugo][hugo]
and [nginx][nginx]. It defines two `ONBUILD` triggers for images
based on it:

* add the current folder to `/site`.
* run `hugo` in the `/site` folder.

The default start command will run [nginx][nginx] and serve
content from `/site/public`.

# Great, how do I use it?

You just add a boilerplate `Dockerfile` to your [hugo][hugo] folder,
containing this:

    FROM alpine-hugo

As the this image comes with `ONBUILD` triggers, nothing else is to do!
Build it as usual:

    $ docker build -t myblog .

And run just the same:

    $ docker run --rm --name my-blog-container myblog

The [nginx][nginx] config is pretty much in default configuration, so it's
listening on port 80.


[hugo]: http://gohugo.io/
[alpine]: https://alpinelinux.org/
[nginx]: https://www.nginx.com/
