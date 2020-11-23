Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0852C08F0
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 14:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388122AbgKWNDa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 08:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388291AbgKWND3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 08:03:29 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4296DC0613CF;
        Mon, 23 Nov 2020 05:03:28 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id a19so10018140ilm.3;
        Mon, 23 Nov 2020 05:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VgtEn6nPojjN2lvwmJh9UMbzFe91Uj7vgQrKYEqQmM4=;
        b=cmKeGzC7lz8HlnrMAWzyrHfNpn8Bywv3nPT1Mb46N4ONsackWtmLEbHKhBqVseUVnt
         O6rUIIqSvwg2xOAsN04BxY1/u4tTF3DDmkgM1NPWKo6aT78XwDFRaCvBGxGC0AKHxL10
         JpJIdybwo8n6+OlEMqXrHa8DpNDVMz0TT5mIIHO8B+RpU9q2ZsOgnR2lFZay3JQstYg2
         JpI7Ukkp3AzGkPPYtVLD8jYy0wv6p/KHqXts75XGuquBhe8V+22XulxX7tn0zCgAcHW2
         rsNr74Zsp1H8aef00Cxf37fC93nvRGQIEzGFWeL7zyrYxlY6ZMw+MgAoykaFsRGaNbIY
         Ewfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgtEn6nPojjN2lvwmJh9UMbzFe91Uj7vgQrKYEqQmM4=;
        b=cl2HFzLD4iSbc5L2w/Ug+Ge052J19F6yPXPQqxXPNjO89oXj29/WtgO/nXY3PbcEfR
         3yT+phKwyjOnc9M6kR+gWMtBdE6tsRtlztcBRlP8UTkB6FRLbnGmx7HvrQiipuNirpZM
         JC4Qn0AxqJbZKLFt3nuD2l3kzo8MiMSNjDWthRV3aS8EIxQ7JjX2v1wuAXrvnpV7AXE5
         JoVV8YRGl1YA7qf1waudIgjL6UH/t0aLGpNmVpmsJzsjuHO4DxtH2hUCeHoho1COvvHH
         sB1ABV72ApGDDkfIMx5zNxXwHkc7epozN0RD+FeFZdrE0I2u2TBzO7WGyzLgaTSx03f5
         Q7Sg==
X-Gm-Message-State: AOAM531o8wtseNsDj5IM3o7zXp21DrnDJpm7d76TF2J3MuYQq+96JLBz
        hwTNVygm6sNnnSvRa2LqnqcS7DpuNv17od1bYD2V8SHC
X-Google-Smtp-Source: ABdhPJzbB/GZrJLU4XesvKCAa3niOAF1s8BMslHJ1LJaRzwQhZHU0kLizrvlaX/ZBF7zc6qOSOrDwJhI3ZqnJN/yZOU=
X-Received: by 2002:a92:8707:: with SMTP id m7mr34276204ild.217.1606136607242;
 Mon, 23 Nov 2020 05:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20201117162340.43924-1-alexandru.ardelean@analog.com> <20201121185243.255d33b2@archlinux>
In-Reply-To: <20201121185243.255d33b2@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 23 Nov 2020 15:03:16 +0200
Message-ID: <CA+U=DspcRkY9-RfAvR9wRwbo_zpy87APb6gxnBWjLHRMZesj9A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] iio: core,buffer: add support for multiple IIO
 buffers per IIO device
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 21, 2020 at 8:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 17 Nov 2020 18:23:28 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > Continuing from:
> >   https://lore.kernel.org/linux-iio/20200517144023.6c5cb169@archlinux/
> >
> > This is a V2 of the initial attempt in the discussion above.
> > But it did not occur to me that I should mark it as V2 when I generated
> > the patches.
> > I've only tested [so far] that the current IIO buffer mechnism still works.
> > And decided to show this sketch patchset.
> >
> > This requires the ioctl() centralization mechanism, for which I sent a
> > fix earlier.
> >   https://lore.kernel.org/linux-iio/CA+U=Dsqf3UgyM666Gg9EmehpWiucDx2P0bmsC9JR--JJDT_eWQ@mail.gmail.com/T/#t
> >   https://lore.kernel.org/linux-iio/20201117095154.7189-1-alexandru.ardelean@analog.com/T/#u
> >
> > The gist of this is that now, the first IIO buffer should work as
> > before, but all extra buffers should go through the anon inodes
> > mechanism.
> > I'd need to find a device or a way or a chip to test these extra buffers
> > stuff. But I'm confident that this current form should eventually work
> > with multiple IIO buffers per 1 IIO device and with anon inodes.
> >
> > Maybe I'll take some of the patches in this set separately and send them
> > individually. The problem with patchsets like this that tackle changes
> > in a framework (like IIO) is that I become unsure after the 5th-7th patch,
> > that the approach is correct. And I get even more unsure after that.
> >
> > I'll create some userspace code to test this a bit, but I thought I'd
> > send an RFC in the meantime.
>
> From a first read, with all the warnings you give above, this looks pretty
> good to me.   The kobj stuff is a little nasty and needs more docs
> but other than that it all looks quite pleasant and readable and was
> roughly what I was expecting from earlier discussions (which is great!).
>
> Good work on this, looking forward to next steps.

Thanks.
I'll see about re-spinning this.
With the iio_buffer_set_attrs() change merged, this  patchset has a
new context that I need to take a look at.

>
> Jonathan
>
> >
> > Alexandru Ardelean (12):
> >   iio: core: register chardev only if needed
> >   iio: buffer: add back-ref from iio_buffer to iio_dev
> >   iio: buffer: rework buffer & scan_elements dir creation
> >   iio: buffer: add index to the first IIO buffer dir and symlink it back
> >   iio: core: split __iio_device_attr_init() to init only the attr object
> >   iio: buffer: re-route scan_elements via it's kobj_type
> >   iio: buffer: re-route core buffer attributes via it's new kobj_type
> >   iio: buffer: add helper to get the IIO device to which a buffer
> >     belongs
> >   iio: re-route all buffer attributes through new buffer kobj_type
> >   iio: core: wrap iio device & buffer into struct for character devices
> >   iio: buffer: introduce support for attaching more IIO buffers
> >   iio: buffer: add ioctl() to support opening extra buffers for IIO
> >     device
> >
> >  drivers/iio/accel/adxl372.c                   |  36 +-
> >  drivers/iio/accel/bmc150-accel-core.c         |  34 +-
> >  drivers/iio/adc/at91-sama5d2_adc.c            |  30 +-
> >  .../buffer/industrialio-buffer-dmaengine.c    |  13 +-
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    |  30 +-
> >  .../common/hid-sensors/hid-sensor-trigger.c   |  32 +-
> >  drivers/iio/iio_core.h                        |  11 +
> >  drivers/iio/industrialio-buffer.c             | 582 ++++++++++++++----
> >  drivers/iio/industrialio-core.c               | 117 ++--
> >  include/linux/iio/buffer.h                    |   2 +
> >  include/linux/iio/buffer_impl.h               |  25 +-
> >  include/linux/iio/iio-opaque.h                |   6 +
> >  include/linux/iio/iio.h                       |   2 +-
> >  include/linux/iio/sysfs.h                     |  50 ++
> >  include/uapi/linux/iio/buffer.h               |  16 +
> >  15 files changed, 735 insertions(+), 251 deletions(-)
> >  create mode 100644 include/uapi/linux/iio/buffer.h
> >
>
