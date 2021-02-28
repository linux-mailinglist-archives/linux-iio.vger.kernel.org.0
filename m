Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3483273C0
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 19:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhB1SKx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Feb 2021 13:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhB1SKv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2021 13:10:51 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDA8C06174A;
        Sun, 28 Feb 2021 10:10:11 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id o11so7340997iob.1;
        Sun, 28 Feb 2021 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOiXGmNyu1AFQMqqooq8jZOwsRY97fXkpjZ5i2kFFPw=;
        b=c1hEBpIa7r3/uuipRmXpv/HCg6SkaUBr7SSp8MX0J+lphgvp4UamrYRGrmifvAxOS2
         pu+YGNdeywbMoDNttYlUofCwXHl/hRdc4mQnWw7Ajf1+533ko1YJK6/Y/IQ0N8plLpcJ
         5fj0Zu0MDi6zouZVUlMD+ZgMx6SeuogOQyQH+N0RJehbSuy5371nIMkgRwVvQ1lkkN8a
         x6Bf1/YinCOCpmhCEy+b85hOPukki9SY5hpigZov6mvQfHl1MBq0x3h9ukESeAZRzzhg
         qM8O/tJMe1dK68KxcUXgMg23mpUhS4/NL3T39aRGcRI0KUub+IJZFppkESB0yf3qpFD8
         +c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOiXGmNyu1AFQMqqooq8jZOwsRY97fXkpjZ5i2kFFPw=;
        b=NAb51lNh7+9YC6zWJFRt+BPQiTieBZW85OoI4U5G9Z1XrK4z3pgQBVdL7mzrlZa1sV
         vk/gHWLVXg6DsllsGQKmtQ52GGuyAboe0FssEpok/AVRMB4rCBz/1LGLPP47Sk3M4xwM
         tlVPWxJ2Ci/ZU1YbwYxCVs+QH4MQYDa3QJSXTbwDyVJZ6S9Xt9cV6dNWlAzBWcusVEU/
         euErdOrHDi1nYccKWJPCprKiFKIYlnRouiqh97b3Sx6YUiIBjxjjhk1Zz01JONBHp7zN
         2z0HpqT6yX6TLs+w7zYRN76y2FsvMVmDUg4KYxW+tOofnCEfISf6Z0wzuKLqhQ3JFrH/
         EoqA==
X-Gm-Message-State: AOAM531lTVsJtSyRX1016L3K8btihH/jH1bneVeVKx9RktMdB5RaF1nU
        y06CV/OAr4+ujBUicLUTyQSnn+oIM+vy3o/yb2M=
X-Google-Smtp-Source: ABdhPJwvotRT36gBkwgTLcTr8fQDrEWgnCap/krqqffStohHvtoXyG7zXaPmwKiewsW5vcX+CWYOT8ybRtKmCeSynVw=
X-Received: by 2002:a02:2944:: with SMTP id p65mr12040732jap.91.1614535810691;
 Sun, 28 Feb 2021 10:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-21-alexandru.ardelean@analog.com> <877ca331-1a56-1bd3-6637-482bbf060ba9@metafoo.de>
 <20210228143429.00001f01@Huawei.com> <5f9070a5-2c3d-f185-1981-10ec768dbb4a@metafoo.de>
In-Reply-To: <5f9070a5-2c3d-f185-1981-10ec768dbb4a@metafoo.de>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 28 Feb 2021 20:09:59 +0200
Message-ID: <CA+U=DsoqJQP=U8efMUfbPDOTTTiqfpMsEfjK1k6VgFbJ_DBt7w@mail.gmail.com>
Subject: Re: [PATCH v6 20/24] iio: buffer: add ioctl() to support opening
 extra buffers for IIO device
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 28, 2021 at 5:54 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 2/28/21 3:34 PM, Jonathan Cameron wrote:
> > On Sun, 28 Feb 2021 09:51:38 +0100
> > Lars-Peter Clausen <lars@metafoo.de> wrote:
> >
> >> On 2/15/21 11:40 AM, Alexandru Ardelean wrote:
> >>> With this change, an ioctl() call is added to open a character device for a
> >>> buffer. The ioctl() number is 'i' 0x91, which follows the
> >>> IIO_GET_EVENT_FD_IOCTL ioctl.
> >>>
> >>> The ioctl() will return an FD for the requested buffer index. The indexes
> >>> are the same from the /sys/iio/devices/iio:deviceX/bufferY (i.e. the Y
> >>> variable).
> >>>
> >>> Since there doesn't seem to be a sane way to return the FD for buffer0 to
> >>> be the same FD for the /dev/iio:deviceX, this ioctl() will return another
> >>> FD for buffer0 (or the first buffer). This duplicate FD will be able to
> >>> access the same buffer object (for buffer0) as accessing directly the
> >>> /dev/iio:deviceX chardev.
> >>>
> >>> Also, there is no IIO_BUFFER_GET_BUFFER_COUNT ioctl() implemented, as the
> >>> index for each buffer (and the count) can be deduced from the
> >>> '/sys/bus/iio/devices/iio:deviceX/bufferY' folders (i.e the number of
> >>> bufferY folders).
> >>>
> >>> Used following C code to test this:
> >>> -------------------------------------------------------------------
> >>>
> >>>    #include <stdio.h>
> >>>    #include <stdlib.h>
> >>>    #include <unistd.h>
> >>>    #include <sys/ioctl.h>
> >>>    #include <fcntl.h"
> >>>    #include <errno.h>
> >>>
> >>>    #define IIO_BUFFER_GET_FD_IOCTL      _IOWR('i', 0x91, int)
> >>>
> >>> int main(int argc, char *argv[])
> >>> {
> >>>           int fd;
> >>>           int fd1;
> >>>           int ret;
> >>>
> >>>           if ((fd = open("/dev/iio:device0", O_RDWR))<0) {
> >>>                   fprintf(stderr, "Error open() %d errno %d\n",fd, errno);
> >>>                   return -1;
> >>>           }
> >>>
> >>>           fprintf(stderr, "Using FD %d\n", fd);
> >>>
> >>>           fd1 = atoi(argv[1]);
> >>>
> >>>           ret = ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &fd1);
> >>>           if (ret < 0) {
> >>>                   fprintf(stderr, "Error for buffer %d ioctl() %d errno %d\n", fd1, ret, errno);
> >>>                   close(fd);
> >>>                   return -1;
> >>>           }
> >>>
> >>>           fprintf(stderr, "Got FD %d\n", fd1);
> >>>
> >>>           close(fd1);
> >>>           close(fd);
> >>>
> >>>           return 0;
> >>> }
> >>> -------------------------------------------------------------------
> >>>
> >>> Results are:
> >>> -------------------------------------------------------------------
> >>>    # ./test 0
> >>>    Using FD 3
> >>>    Got FD 4
> >>>
> >>>    # ./test 1
> >>>    Using FD 3
> >>>    Got FD 4
> >>>
> >>>    # ./test 2
> >>>    Using FD 3
> >>>    Got FD 4
> >>>
> >>>    # ./test 3
> >>>    Using FD 3
> >>>    Got FD 4
> >>>
> >>>    # ls /sys/bus/iio/devices/iio\:device0
> >>>    buffer  buffer0  buffer1  buffer2  buffer3  dev
> >>>    in_voltage_sampling_frequency  in_voltage_scale
> >>>    in_voltage_scale_available
> >>>    name  of_node  power  scan_elements  subsystem  uevent
> >>> -------------------------------------------------------------------
> >>>
> >>> iio:device0 has some fake kfifo buffers attached to an IIO device.
> >> For me there is one major problem with this approach. We only allow one
> >> application to open /dev/iio:deviceX at a time. This means we can't have
> >> different applications access different buffers of the same device. I
> >> believe this is a circuital feature.
> > Thats not quite true (I think - though I've not tested it).  What we don't
> > allow is for multiple processes to access them in an unaware fashion.
> > My assumption is we can rely on fork + fd passing via appropriate sockets.
> >
> >> It is possible to open the chardev, get the annonfd, close the chardev
> >> and keep the annonfd open. Then the next application can do the same and
> >> get access to a different buffer. But this has room for race conditions
> >> when two applications try this at the very same time.
> >>
> >> We need to somehow address this.
> > I'd count this as a bug :).  It could be safely done in a particular custom
> > system but in general it opens a can of worm.

I'll take a look at this.

> >
> >> I'm also not much of a fan of using ioctls to create annon fds. In part
> >> because all the standard mechanisms for access control no longer work.
> > The inability to trivially have multiple processes open the anon fds
> > without care is one of the things I like most about them.
> >
> > IIO drivers and interfaces really aren't designed for multiple unaware
> > processes to access them.  We don't have per process controls for device
> > wide sysfs attributes etc.  In general, it would be hard to
> > do due to the complexity of modeling all the interactions between the
> > different interfaces (events / buffers / sysfs access) in a generic fashion.
> >
> > As such, the model, in my head at least, is that we only want a single
> > process to ever be responsible for access control.  That process can then
> > assign access to children or via a deliberate action (I think passing the
> > anon fd over a unix socket should work for example).  The intent being
> > that it is also responsible for mediating access to infrastructure that
> > multiple child processes all want to access.
> >
> > As such, having one chrdev isn't a disadvantage because only one process
> > should ever open it at a time.  This same process also handles the
> > resource / control mediation.  Therefore we should only have one file
> > exposed for all the standard access control mechanisms.
> >
> Hm, I see your point, but I'm not convinced.
>
> Having to have explicit synchronization makes it difficult to mix and
> match. E.g. at ADI a popular use case for testing was to run some signal
> generator application on the TX buffer and some signal analyzer
> application on the RX buffer.
>
> Both can be launched independently and there can be different types of
> generator and analyzer applications. Having to have a 3rd application to
> arbitrate access makes this quite cumbersome. And I'm afraid that in
> reality people might just stick with the two devices model just to avoid
> this restriction.

I'm neutral on this part of the debate.
I feel this may be some older discussion being refreshed here (it's
just a personal feeling).

I can try to accommodate a solution if something (else) is agreed.
Though at this point it may be a little slower.
I'm no longer an ADI employee, so it may take me a little longer to
test some things.

>
> - Lars
>
