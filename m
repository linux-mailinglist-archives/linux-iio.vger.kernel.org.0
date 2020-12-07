Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A9C2D0B11
	for <lists+linux-iio@lfdr.de>; Mon,  7 Dec 2020 08:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgLGHX1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Dec 2020 02:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgLGHX0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Dec 2020 02:23:26 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8175C0613D0;
        Sun,  6 Dec 2020 23:22:40 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id q1so11275458ilt.6;
        Sun, 06 Dec 2020 23:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRwc/mkX+x98mxkFTUylyi4vYWawdbNlrEiMUaEC2Z4=;
        b=nw2CA/H5auXu40fNUWdX+sKT+Ixkm0/ViYJkBpw14PY/kGgnt1nujYYUKzCvR95Jjw
         b2Jrt0Qq84DcNh1+H80Imc/9Cpl8Js3oxTAmSS7KQgxo3FYVC/Vc3EzRdLMQCUMjvtgl
         QIUBqcib92gkJzhywqBNvP2lxf20TO2o61VdKyTTqUkUItAN+YuksijaXQCV0MSk7g97
         ao57lgyF8PgZlHr4y7t2QCR21kiG8p+BNVmSAxI4WT3WJjSrf8DIKn5CySRAGWfLSmA3
         ZNN4w6KmHlTtd1BldWxY82hhuvn+b1iyjkBJW8wqQyUMtDADX+CbFK37O6yjYoJJ7qEf
         4W9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRwc/mkX+x98mxkFTUylyi4vYWawdbNlrEiMUaEC2Z4=;
        b=Q4bg5ftK9M40yvgFAlgQX1mG0CBEaGoVe7ssbuzb9QE9Zf7HNWjME169e3cpzoJSXN
         Z9BVRuNY28anU6gb91VMzHEYDHfJz2VYqILMckRwHi8hdgjdHKJmOBiSru2hSdDKDAux
         13vSO7J0gkXbqE0Z2UlbU+ijCx+FHKmPUcuvDYes7K7R+Iaqd9s1FmMNCGKOlTBjB4zB
         T5vq06G55dRywUzEDX2ZV8Dy1tqW6pnXu260jOhIS5/RFimSNyB+3tMoovGr/CE9V5BE
         Tm5z0P3OlvaeWVAAN4N+YZDNQzsfR7gVFwsTqNkDW7RszZAoEXwVSbTV4MR/2jOiCvKS
         jGoQ==
X-Gm-Message-State: AOAM530Qb/Gvt8jjzEz9pdqM4no7A/3u6DJly2yY+y8UGlc7KugusyVj
        oWTJ74dZ6UTLDntY1RARaZn20o3N3by/wkoFpk8=
X-Google-Smtp-Source: ABdhPJx2kYh8tQOO/LvuZBce9R0M5A2XadFsFk7n7rfkD6D0xY32cCg/v1X2XK6rsnrq3GNYg/eQAm2gIoKzxz2SNcs=
X-Received: by 2002:a05:6e02:12a2:: with SMTP id f2mr7273079ilr.292.1607325760213;
 Sun, 06 Dec 2020 23:22:40 -0800 (PST)
MIME-Version: 1.0
References: <20201203095005.72252-1-alexandru.ardelean@analog.com> <20201205163618.3b26334f@archlinux>
In-Reply-To: <20201205163618.3b26334f@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 7 Dec 2020 09:22:28 +0200
Message-ID: <CA+U=Dsr_95ktcCFQApndtsPzO3dSVpvpBYUTDh6njBv15FYV=A@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: dummy: convert all simple allocation devm_ variants
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 5, 2020 at 8:46 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 3 Dec 2020 11:50:03 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > Since a main requirement for an IIO device is to have a parent device
> > object, it makes sense to attach more of the IIO device's objects to the
> > lifetime of the parent object, to clean up the code.
> > The idea is to also provide a base example that is more up-to-date with
> > what's going on lately with most IIO drivers.
>
> To some degree maybe, it's also very very handy for testing odd corner
> cases with.  I'd definitely not recommend it as a reference driver
> because it inherently has some odd corners because we need to
> fake various things that don't exist without hardware.

It's funny because during GSoC it seemed like some people would try to
use this as a starting point, then shift to another working ADC/DAC
example.
I was also thinking about maybe extending this a bit further, to have
it a bit more dynamic at load time [being able to load fake IIO
drivers, load fake data to be read via fake IIO device].
No idea when this will be ready, but it's on my long todo-list.

>
> >
> > This change tackles the simple allocations, to convert them to
> > device-managed calls, and tie them to the parent device.
>
> I'm confused or maybe I missrecall how this works.
>
> IIRC there isn't a parent device...
>
> Maybe we could create one via a bit of smoke and magic.

Yep, there isn't one.
I'll add one through some smoke, magic, some OF and maybe some fake
i2c/spi device IDs.

>
>
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/dummy/iio_simple_dummy.c | 29 ++++++++--------------------
> >  1 file changed, 8 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> > index c0b7ef900735..2a2e62f780a1 100644
> > --- a/drivers/iio/dummy/iio_simple_dummy.c
> > +++ b/drivers/iio/dummy/iio_simple_dummy.c
> > @@ -574,11 +574,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
> >        * parent = &client->dev;
> >        */
> >
> > -     swd = kzalloc(sizeof(*swd), GFP_KERNEL);
> > -     if (!swd) {
> > -             ret = -ENOMEM;
> > -             goto error_kzalloc;
> > -     }
> > +     swd = devm_kzalloc(parent, sizeof(*swd), GFP_KERNEL);
> > +     if (!swd)
> > +             return ERR_PTR(-ENOMEM);
> >       /*
> >        * Allocate an IIO device.
> >        *
> > @@ -587,11 +585,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
> >        * It also has a region (accessed by iio_priv()
> >        * for chip specific state information.
> >        */
> > -     indio_dev = iio_device_alloc(parent, sizeof(*st));
> > -     if (!indio_dev) {
> > -             ret = -ENOMEM;
> > -             goto error_ret;
> > -     }
> > +     indio_dev = devm_iio_device_alloc(parent, sizeof(*st));
> > +     if (!indio_dev)
> > +             return ERR_PTR(-ENOMEM);
> >
> >       st = iio_priv(indio_dev);
> >       mutex_init(&st->lock);
> > @@ -615,7 +611,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
> >        *    indio_dev->name = id->name;
> >        *    indio_dev->name = spi_get_device_id(spi)->name;
> >        */
> > -     indio_dev->name = kstrdup(name, GFP_KERNEL);
> > +     indio_dev->name = devm_kstrdup(parent, name, GFP_KERNEL);
> >
> >       /* Provide description of available channels */
> >       indio_dev->channels = iio_dummy_channels;
> > @@ -632,7 +628,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
> >
> >       ret = iio_simple_dummy_events_register(indio_dev);
> >       if (ret < 0)
> > -             goto error_free_device;
> > +             return ERR_PTR(ret);
> >
> >       ret = iio_simple_dummy_configure_buffer(indio_dev);
> >       if (ret < 0)
> > @@ -649,11 +645,6 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
> >       iio_simple_dummy_unconfigure_buffer(indio_dev);
> >  error_unregister_events:
> >       iio_simple_dummy_events_unregister(indio_dev);
> > -error_free_device:
> > -     iio_device_free(indio_dev);
> > -error_ret:
> > -     kfree(swd);
> > -error_kzalloc:
> >       return ERR_PTR(ret);
> >  }
> >
> > @@ -683,10 +674,6 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
> >
> >       iio_simple_dummy_events_unregister(indio_dev);
> >
> > -     /* Free all structures */
> > -     kfree(indio_dev->name);
> > -     iio_device_free(indio_dev);
> > -
> >       return 0;
> >  }
> >
>
