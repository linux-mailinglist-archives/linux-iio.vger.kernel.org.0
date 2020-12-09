Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2752D4F10
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 00:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgLIXvJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 18:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732991AbgLIXvG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 18:51:06 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EBAC0613CF
        for <linux-iio@vger.kernel.org>; Wed,  9 Dec 2020 15:50:26 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id p187so3575965iod.4
        for <linux-iio@vger.kernel.org>; Wed, 09 Dec 2020 15:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6C8Ls/iAI0Rw9NlGVnyiODX+EvNhCNoFRa3JSKvmxMY=;
        b=B85DaE5MICPxxxI2PnWlUStVXaEtbojT+0u37rAMV9zni9Y7RHKfs4TKQ4iLOGAOkl
         hwiwFGxgbTsz22eyLLi/AATrjaO1Z1d784bIg9V0mlDMLeQe9Nnvi1ChI0gXJWKbSMLm
         6PK0yTO6BdFn2xPesoz4BxhRxzHfm6Tt0JPb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6C8Ls/iAI0Rw9NlGVnyiODX+EvNhCNoFRa3JSKvmxMY=;
        b=GN5hWcXPh9UjfNdnKmyy9IAcIiFI8cPPDuzFgAIu1EPvzmcDwPfem0vqsfZi1QTN0y
         NcbFV9WW/8X2vBoRn0qglrwlaM8h4lAfofO6m5imkCEMwGbiHPGUqmjBF1ThmF+RKraZ
         6vSve14G7Z6ig0SZSC5VL7Wx+2nuYjkk8vOMZiDHWTRC0HYUSRqcjePLNh9kK+tMRPDN
         0EVaYXdHw3AdEdII6dEmOiAJ5SX7TPcgTk2jiFXDADzT8xrO4Fk2Aq5wDtGr9G8Pxu93
         PbAV+9br6VHOeTcp542Ptap5sGs9yPqLpe8otw+nPJxNTmtlREqYf2GBSuYaIIo5R3DV
         sPSA==
X-Gm-Message-State: AOAM530nmXFdDFfGDNd8EkEgeC7GNtKNfOpl/LzrjiuUF/aja5lSqe03
        aaIp0aVg8CtR6Cjl8g9ngrRoepjLLgy+P6uDm9HxsWnwkId7WQ==
X-Google-Smtp-Source: ABdhPJxwXqskVlOzYMUd+6Bis/xupzTnWeTibqBTmJ4veRrgse0acRE19ELLaJpE7DrWbq7B0FncIqnogNwCBOCTnEw=
X-Received: by 2002:a02:2246:: with SMTP id o67mr6362252jao.52.1607557825030;
 Wed, 09 Dec 2020 15:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20201209053130.2459172-1-gwendal@chromium.org> <CA+U=DsruBB5vzyD0BZeGOYaKRdzsKgVDroRFzMVsxnyE8ihmfw@mail.gmail.com>
In-Reply-To: <CA+U=DsruBB5vzyD0BZeGOYaKRdzsKgVDroRFzMVsxnyE8ihmfw@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 9 Dec 2020 15:50:13 -0800
Message-ID: <CAPUE2uufA7EgE6Mxw7ASm0q2ScLLHX_teS7JL2yt1dWpFWfCTw@mail.gmail.com>
Subject: Re: [PATCH] iio: set default trig->dev.parent
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 8, 2020 at 11:54 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Wed, Dec 9, 2020 at 7:36 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > When allocated with devm_iio_trigger_alloc(), set trig device parent to
> > the device the trigger is allocated for by default.
> >
> > It can always be reassigned in the probe routine.
> >
> > Check with:
> > for i in $(git diff --name-only) ; do
> >   echo $i
> >   grep devm_iio_trigger_alloc $i
> >   git diff -- $i | grep parent
> > done
>
> I like the idea.
> But I would push this into iio_trigger_alloc() and add a 'parent'
> parameter to the function, similar to iio_device_alloc().
> This is for the behavior consistency between iio_trigger_alloc() &
> devm_iio_trigger_alloc().
> There aren't many uses of iio_trigger_alloc(), so there wouldn't be
> many files to update.
>
> Since the change to "drivers/iio/industrialio-trigger.c" doesn't
> change behavior, I would put that as a first patch, then the updates
> to all the drivers in another patch.
>
> I'd also recommend a semantic patch here:
> @@
> expression trigger, P, name;
> @@
>    trigger = devm_iio_trigger_alloc(P, ...);
>    ...
> -  trigger->dev.parent = P;
>
> This seems to work to generate roughly the same changes.
> Though, I will admit setting up spatch is a bit of a pain.
> There are some prebuilt binaries though:
> https://coccinelle.gitlabpages.inria.fr/website/download.html
>
> I usually put the semantic patch into a file and run:
> spatch --sp-file input.cocci --dir drivers/iio
> pipe the output [which is a patch] into a file and apply it.
Thanks for spatch, it is more formal than my script.
I actually made mistake as some trigger set allocated on &iiodev->dev
instead of its parent.
I think that's an error, as the function iio_trigger_using_own and
attached_own_device semantic is not valid anymore.

I will release a train of patch: the change in iio_trigger_alloc,
devm_iio_trigger_alloc being the first, the spatch changes being the
second and more patches for remaining problematic drivers.
>
> There may be some options to directly patch the files [with spatch],
> but I always forget them.
>
> >
> > That only the obvious assginments have been replaced.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/accel/adxl372.c            | 2 --
> >  drivers/iio/accel/bmc150-accel-core.c  | 1 -
> >  drivers/iio/accel/kxcjk-1013.c         | 2 --
> >  drivers/iio/accel/mma8452.c            | 1 -
> >  drivers/iio/accel/mxc4005.c            | 1 -
> >  drivers/iio/accel/stk8312.c            | 1 -
> >  drivers/iio/accel/stk8ba50.c           | 1 -
> >  drivers/iio/adc/ad7606.c               | 1 -
> >  drivers/iio/adc/ad7766.c               | 1 -
> >  drivers/iio/adc/ad7768-1.c             | 1 -
> >  drivers/iio/adc/at91-sama5d2_adc.c     | 1 -
> >  drivers/iio/adc/max1027.c              | 1 -
> >  drivers/iio/adc/mxs-lradc-adc.c        | 1 -
> >  drivers/iio/chemical/ccs811.c          | 1 -
> >  drivers/iio/chemical/scd30_core.c      | 1 -
> >  drivers/iio/gyro/adxrs290.c            | 1 -
> >  drivers/iio/gyro/bmg160_core.c         | 2 --
> >  drivers/iio/gyro/fxas21002c_core.c     | 1 -
> >  drivers/iio/gyro/mpu3050-core.c        | 1 -
> >  drivers/iio/health/afe4403.c           | 1 -
> >  drivers/iio/health/afe4404.c           | 1 -
> >  drivers/iio/humidity/hts221_buffer.c   | 1 -
> >  drivers/iio/imu/adis_trigger.c         | 1 -
> >  drivers/iio/imu/kmx61.c                | 1 -
> >  drivers/iio/industrialio-trigger.c     | 1 +
> >  drivers/iio/light/gp2ap020a00f.c       | 1 -
> >  drivers/iio/light/rpr0521.c            | 1 -
> >  drivers/iio/light/si1145.c             | 1 -
> >  drivers/iio/light/st_uvis25_core.c     | 1 -
> >  drivers/iio/light/vcnl4000.c           | 1 -
> >  drivers/iio/light/vcnl4035.c           | 1 -
> >  drivers/iio/magnetometer/bmc150_magn.c | 1 -
> >  drivers/iio/magnetometer/rm3100-core.c | 1 -
> >  drivers/iio/potentiostat/lmp91000.c    | 1 -
> >  drivers/iio/pressure/zpa2326.c         | 1 -
> >  drivers/iio/proximity/sx9310.c         | 1 -
> >  drivers/iio/proximity/sx932x.c         | 1 -
> >  drivers/iio/proximity/sx9500.c         | 1 -
> >  38 files changed, 1 insertion(+), 40 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> > index aed2a4930fb0..f21b1f414271 100644
> > --- a/drivers/iio/accel/adxl372.c
> > +++ b/drivers/iio/accel/adxl372.c
> > @@ -1237,8 +1237,6 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
> >
> >                 st->dready_trig->ops = &adxl372_trigger_ops;
> >                 st->peak_datardy_trig->ops = &adxl372_peak_data_trigger_ops;
> > -               st->dready_trig->dev.parent = dev;
> > -               st->peak_datardy_trig->dev.parent = dev;
> >                 iio_trigger_set_drvdata(st->dready_trig, indio_dev);
> >                 iio_trigger_set_drvdata(st->peak_datardy_trig, indio_dev);
> >                 ret = devm_iio_trigger_register(dev, st->dready_trig);
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> > index 48435865fdaf..5c97232051df 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -1362,7 +1362,6 @@ static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
> >                         break;
> >                 }
> >
> > -               t->indio_trig->dev.parent = dev;
> >                 t->indio_trig->ops = &bmc150_accel_trigger_ops;
> >                 t->intr = bmc150_accel_triggers[i].intr;
> >                 t->data = data;
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> > index 560a3373ff20..bb21488febe0 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -1385,7 +1385,6 @@ static int kxcjk1013_probe(struct i2c_client *client,
> >                         goto err_poweroff;
> >                 }
> >
> > -               data->dready_trig->dev.parent = &client->dev;
> >                 data->dready_trig->ops = &kxcjk1013_trigger_ops;
> >                 iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> >                 indio_dev->trig = data->dready_trig;
> > @@ -1394,7 +1393,6 @@ static int kxcjk1013_probe(struct i2c_client *client,
> >                 if (ret)
> >                         goto err_poweroff;
> >
> > -               data->motion_trig->dev.parent = &client->dev;
> >                 data->motion_trig->ops = &kxcjk1013_trigger_ops;
> >                 iio_trigger_set_drvdata(data->motion_trig, indio_dev);
> >                 ret = iio_trigger_register(data->motion_trig);
> > diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> > index bf1d2c8afdbd..2cced843c9e2 100644
> > --- a/drivers/iio/accel/mma8452.c
> > +++ b/drivers/iio/accel/mma8452.c
> > @@ -1465,7 +1465,6 @@ static int mma8452_trigger_setup(struct iio_dev *indio_dev)
> >         if (!trig)
> >                 return -ENOMEM;
> >
> > -       trig->dev.parent = &data->client->dev;
> >         trig->ops = &mma8452_trigger_ops;
> >         iio_trigger_set_drvdata(trig, indio_dev);
> >
> > diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> > index f877263dc6ef..0f037403181f 100644
> > --- a/drivers/iio/accel/mxc4005.c
> > +++ b/drivers/iio/accel/mxc4005.c
> > @@ -454,7 +454,6 @@ static int mxc4005_probe(struct i2c_client *client,
> >                         return ret;
> >                 }
> >
> > -               data->dready_trig->dev.parent = &client->dev;
> >                 data->dready_trig->ops = &mxc4005_trigger_ops;
> >                 iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> >                 indio_dev->trig = data->dready_trig;
> > diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> > index 3b59887a8581..7c3b70eb3f2d 100644
> > --- a/drivers/iio/accel/stk8312.c
> > +++ b/drivers/iio/accel/stk8312.c
> > @@ -558,7 +558,6 @@ static int stk8312_probe(struct i2c_client *client,
> >                         goto err_power_off;
> >                 }
> >
> > -               data->dready_trig->dev.parent = &client->dev;
> >                 data->dready_trig->ops = &stk8312_trigger_ops;
> >                 iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> >                 ret = iio_trigger_register(data->dready_trig);
> > diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> > index 3ead378b02c9..bf0368ce46e1 100644
> > --- a/drivers/iio/accel/stk8ba50.c
> > +++ b/drivers/iio/accel/stk8ba50.c
> > @@ -454,7 +454,6 @@ static int stk8ba50_probe(struct i2c_client *client,
> >                         goto err_power_off;
> >                 }
> >
> > -               data->dready_trig->dev.parent = &client->dev;
> >                 data->dready_trig->ops = &stk8ba50_trigger_ops;
> >                 iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> >                 ret = iio_trigger_register(data->dready_trig);
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > index ee7b108688b3..0af0bb4d5a7f 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -668,7 +668,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
> >                 return -ENOMEM;
> >
> >         st->trig->ops = &ad7606_trigger_ops;
> > -       st->trig->dev.parent = dev;
> >         iio_trigger_set_drvdata(st->trig, indio_dev);
> >         ret = devm_iio_trigger_register(dev, st->trig);
> >         if (ret)
> > diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
> > index b6b6765be7b4..829a3426f235 100644
> > --- a/drivers/iio/adc/ad7766.c
> > +++ b/drivers/iio/adc/ad7766.c
> > @@ -253,7 +253,6 @@ static int ad7766_probe(struct spi_device *spi)
> >                         return -ENOMEM;
> >
> >                 ad7766->trig->ops = &ad7766_trigger_ops;
> > -               ad7766->trig->dev.parent = &spi->dev;
> >                 iio_trigger_set_drvdata(ad7766->trig, ad7766);
> >
> >                 ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 0e93b0766eb4..241c1e0f0cec 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -594,7 +594,6 @@ static int ad7768_probe(struct spi_device *spi)
> >                 return -ENOMEM;
> >
> >         st->trig->ops = &ad7768_trigger_ops;
> > -       st->trig->dev.parent = &spi->dev;
> >         iio_trigger_set_drvdata(st->trig, indio_dev);
> >         ret = devm_iio_trigger_register(&spi->dev, st->trig);
> >         if (ret)
> > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> > index b917a4714a9c..e16a3e3b0618 100644
> > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > @@ -1003,7 +1003,6 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *indio,
> >         if (!trig)
> >                 return NULL;
> >
> > -       trig->dev.parent = indio->dev.parent;
> >         iio_trigger_set_drvdata(trig, indio);
> >         trig->ops = &at91_adc_trigger_ops;
> >
> > diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> > index ca1dff3924ff..e3c8ec107722 100644
> > --- a/drivers/iio/adc/max1027.c
> > +++ b/drivers/iio/adc/max1027.c
> > @@ -473,7 +473,6 @@ static int max1027_probe(struct spi_device *spi)
> >                 }
> >
> >                 st->trig->ops = &max1027_trigger_ops;
> > -               st->trig->dev.parent = &spi->dev;
> >                 iio_trigger_set_drvdata(st->trig, indio_dev);
> >                 ret = devm_iio_trigger_register(&indio_dev->dev,
> >                                                 st->trig);
> > diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> > index 30e29f44ebd2..46325aa40a84 100644
> > --- a/drivers/iio/adc/mxs-lradc-adc.c
> > +++ b/drivers/iio/adc/mxs-lradc-adc.c
> > @@ -459,7 +459,6 @@ static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
> >         if (!trig)
> >                 return -ENOMEM;
> >
> > -       trig->dev.parent = adc->dev;
> >         iio_trigger_set_drvdata(trig, iio);
> >         trig->ops = &mxs_lradc_adc_trigger_ops;
> >
> > diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> > index 60dd87e96f5f..886e96496dbf 100644
> > --- a/drivers/iio/chemical/ccs811.c
> > +++ b/drivers/iio/chemical/ccs811.c
> > @@ -497,7 +497,6 @@ static int ccs811_probe(struct i2c_client *client,
> >                         goto err_poweroff;
> >                 }
> >
> > -               data->drdy_trig->dev.parent = &client->dev;
> >                 data->drdy_trig->ops = &ccs811_trigger_ops;
> >                 iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> >                 indio_dev->trig = data->drdy_trig;
> > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> > index 4d0d798c7cd3..261c277ac4a5 100644
> > --- a/drivers/iio/chemical/scd30_core.c
> > +++ b/drivers/iio/chemical/scd30_core.c
> > @@ -646,7 +646,6 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
> >                 return -ENOMEM;
> >         }
> >
> > -       trig->dev.parent = dev;
> >         trig->ops = &scd30_trigger_ops;
> >         iio_trigger_set_drvdata(trig, indio_dev);
> >
> > diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> > index ca6fc234076e..15223fc09a46 100644
> > --- a/drivers/iio/gyro/adxrs290.c
> > +++ b/drivers/iio/gyro/adxrs290.c
> > @@ -595,7 +595,6 @@ static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
> >         if (!st->dready_trig)
> >                 return -ENOMEM;
> >
> > -       st->dready_trig->dev.parent = &st->spi->dev;
> >         st->dready_trig->ops = &adxrs290_trigger_ops;
> >         iio_trigger_set_drvdata(st->dready_trig, indio_dev);
> >
> > diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> > index 8ddda96455fc..c964355e355b 100644
> > --- a/drivers/iio/gyro/bmg160_core.c
> > +++ b/drivers/iio/gyro/bmg160_core.c
> > @@ -1127,14 +1127,12 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >                 if (!data->motion_trig)
> >                         return -ENOMEM;
> >
> > -               data->dready_trig->dev.parent = dev;
> >                 data->dready_trig->ops = &bmg160_trigger_ops;
> >                 iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> >                 ret = iio_trigger_register(data->dready_trig);
> >                 if (ret)
> >                         return ret;
> >
> > -               data->motion_trig->dev.parent = dev;
> >                 data->motion_trig->ops = &bmg160_trigger_ops;
> >                 iio_trigger_set_drvdata(data->motion_trig, indio_dev);
> >                 ret = iio_trigger_register(data->motion_trig);
> > diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> > index 129eead8febc..1a20c6b88e7d 100644
> > --- a/drivers/iio/gyro/fxas21002c_core.c
> > +++ b/drivers/iio/gyro/fxas21002c_core.c
> > @@ -875,7 +875,6 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
> >         if (ret < 0)
> >                 return ret;
> >
> > -       data->dready_trig->dev.parent = dev;
> >         data->dready_trig->ops = &fxas21002c_trigger_ops;
> >         iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> >
> > diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> > index 00e58060968c..d4f4da9889db 100644
> > --- a/drivers/iio/gyro/mpu3050-core.c
> > +++ b/drivers/iio/gyro/mpu3050-core.c
> > @@ -1111,7 +1111,6 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
> >         }
> >
> >         mpu3050->irq = irq;
> > -       mpu3050->trig->dev.parent = mpu3050->dev;
> >         mpu3050->trig->ops = &mpu3050_trigger_ops;
> >         iio_trigger_set_drvdata(mpu3050->trig, indio_dev);
> >
> > diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> > index 38734e4ce360..1fa8d51d5080 100644
> > --- a/drivers/iio/health/afe4403.c
> > +++ b/drivers/iio/health/afe4403.c
> > @@ -531,7 +531,6 @@ static int afe4403_probe(struct spi_device *spi)
> >                 iio_trigger_set_drvdata(afe->trig, indio_dev);
> >
> >                 afe->trig->ops = &afe4403_trigger_ops;
> > -               afe->trig->dev.parent = afe->dev;
> >
> >                 ret = iio_trigger_register(afe->trig);
> >                 if (ret) {
> > diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
> > index 61fe4932d81d..e1476bf79fe2 100644
> > --- a/drivers/iio/health/afe4404.c
> > +++ b/drivers/iio/health/afe4404.c
> > @@ -538,7 +538,6 @@ static int afe4404_probe(struct i2c_client *client,
> >                 iio_trigger_set_drvdata(afe->trig, indio_dev);
> >
> >                 afe->trig->ops = &afe4404_trigger_ops;
> > -               afe->trig->dev.parent = afe->dev;
> >
> >                 ret = iio_trigger_register(afe->trig);
> >                 if (ret) {
> > diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> > index 95e56917677f..f29692b9d2db 100644
> > --- a/drivers/iio/humidity/hts221_buffer.c
> > +++ b/drivers/iio/humidity/hts221_buffer.c
> > @@ -135,7 +135,6 @@ int hts221_allocate_trigger(struct iio_dev *iio_dev)
> >
> >         iio_trigger_set_drvdata(hw->trig, iio_dev);
> >         hw->trig->ops = &hts221_trigger_ops;
> > -       hw->trig->dev.parent = hw->dev;
> >         iio_dev->trig = iio_trigger_get(hw->trig);
> >
> >         return devm_iio_trigger_register(hw->dev, hw->trig);
> > diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
> > index 64e0ba51cb18..4da2501cc60f 100644
> > --- a/drivers/iio/imu/adis_trigger.c
> > +++ b/drivers/iio/imu/adis_trigger.c
> > @@ -29,7 +29,6 @@ static const struct iio_trigger_ops adis_trigger_ops = {
> >
> >  static void adis_trigger_setup(struct adis *adis)
> >  {
> > -       adis->trig->dev.parent = &adis->spi->dev;
> >         adis->trig->ops = &adis_trigger_ops;
> >         iio_trigger_set_drvdata(adis->trig, adis);
> >  }
> > diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> > index 61885e99d3fc..b804a58fe8fb 100644
> > --- a/drivers/iio/imu/kmx61.c
> > +++ b/drivers/iio/imu/kmx61.c
> > @@ -1272,7 +1272,6 @@ static struct iio_trigger *kmx61_trigger_setup(struct kmx61_data *data,
> >         if (!trig)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       trig->dev.parent = &data->client->dev;
> >         trig->ops = &kmx61_trigger_ops;
> >         iio_trigger_set_drvdata(trig, indio_dev);
> >
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index 583bb51f65a7..5f18b3ec2eb0 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -617,6 +617,7 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
> >         va_end(vargs);
> >         if (trig) {
> >                 *ptr = trig;
> > +               trig->dev.parent = dev;
> >                 devres_add(dev, ptr);
> >         } else {
> >                 devres_free(ptr);
> > diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> > index e2850c1a7353..d1d9f2d319e4 100644
> > --- a/drivers/iio/light/gp2ap020a00f.c
> > +++ b/drivers/iio/light/gp2ap020a00f.c
> > @@ -1551,7 +1551,6 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
> >         }
> >
> >         data->trig->ops = &gp2ap020a00f_trigger_ops;
> > -       data->trig->dev.parent = &data->client->dev;
> >
> >         init_irq_work(&data->work, gp2ap020a00f_iio_trigger_work);
> >
> > diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> > index aa2972b04833..7fe14214bb69 100644
> > --- a/drivers/iio/light/rpr0521.c
> > +++ b/drivers/iio/light/rpr0521.c
> > @@ -981,7 +981,6 @@ static int rpr0521_probe(struct i2c_client *client,
> >                         ret = -ENOMEM;
> >                         goto err_pm_disable;
> >                 }
> > -               data->drdy_trigger0->dev.parent = indio_dev->dev.parent;
> >                 data->drdy_trigger0->ops = &rpr0521_trigger_ops;
> >                 indio_dev->available_scan_masks = rpr0521_available_scan_masks;
> >                 iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
> > diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
> > index b304801c7916..9b5c99823943 100644
> > --- a/drivers/iio/light/si1145.c
> > +++ b/drivers/iio/light/si1145.c
> > @@ -1247,7 +1247,6 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
> >         if (!trig)
> >                 return -ENOMEM;
> >
> > -       trig->dev.parent = &client->dev;
> >         trig->ops = &si1145_trigger_ops;
> >         iio_trigger_set_drvdata(trig, indio_dev);
> >
> > diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
> > index a18a82e6bbf5..10fc5aa8675b 100644
> > --- a/drivers/iio/light/st_uvis25_core.c
> > +++ b/drivers/iio/light/st_uvis25_core.c
> > @@ -210,7 +210,6 @@ static int st_uvis25_allocate_trigger(struct iio_dev *iio_dev)
> >                 return -ENOMEM;
> >
> >         iio_trigger_set_drvdata(hw->trig, iio_dev);
> > -       hw->trig->dev.parent = dev;
> >
> >         return devm_iio_trigger_register(dev, hw->trig);
> >  }
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index fff4b36b8b58..2f7916f95689 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -1002,7 +1002,6 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
> >         if (!trigger)
> >                 return -ENOMEM;
> >
> > -       trigger->dev.parent = &client->dev;
> >         trigger->ops = &vcnl4010_trigger_ops;
> >         iio_trigger_set_drvdata(trigger, indio_dev);
> >
> > diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> > index 765c44adac57..e732d308ac4e 100644
> > --- a/drivers/iio/light/vcnl4035.c
> > +++ b/drivers/iio/light/vcnl4035.c
> > @@ -511,7 +511,6 @@ static int vcnl4035_probe_trigger(struct iio_dev *indio_dev)
> >         if (!data->drdy_trigger0)
> >                 return -ENOMEM;
> >
> > -       data->drdy_trigger0->dev.parent = indio_dev->dev.parent;
> >         data->drdy_trigger0->ops = &vcnl4035_trigger_ops;
> >         iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
> >         ret = devm_iio_trigger_register(indio_dev->dev.parent,
> > diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> > index fc6840f9c1fa..ebe13a5043d4 100644
> > --- a/drivers/iio/magnetometer/bmc150_magn.c
> > +++ b/drivers/iio/magnetometer/bmc150_magn.c
> > @@ -899,7 +899,6 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
> >                         goto err_poweroff;
> >                 }
> >
> > -               data->dready_trig->dev.parent = dev;
> >                 data->dready_trig->ops = &bmc150_magn_trigger_ops;
> >                 iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> >                 ret = iio_trigger_register(data->dready_trig);
> > diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> > index 7242897a05e9..dd811da9cb6d 100644
> > --- a/drivers/iio/magnetometer/rm3100-core.c
> > +++ b/drivers/iio/magnetometer/rm3100-core.c
> > @@ -579,7 +579,6 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
> >                 if (!data->drdy_trig)
> >                         return -ENOMEM;
> >
> > -               data->drdy_trig->dev.parent = dev;
> >                 ret = devm_iio_trigger_register(dev, data->drdy_trig);
> >                 if (ret < 0)
> >                         return ret;
> > diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> > index f34ca769dc20..42751b0bf3f3 100644
> > --- a/drivers/iio/potentiostat/lmp91000.c
> > +++ b/drivers/iio/potentiostat/lmp91000.c
> > @@ -330,7 +330,6 @@ static int lmp91000_probe(struct i2c_client *client,
> >         }
> >
> >         data->trig->ops = &lmp91000_trigger_ops;
> > -       data->trig->dev.parent = dev;
> >         init_completion(&data->completion);
> >
> >         ret = lmp91000_read_config(data);
> > diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> > index 2cecbe0adb3f..70adff62cd20 100644
> > --- a/drivers/iio/pressure/zpa2326.c
> > +++ b/drivers/iio/pressure/zpa2326.c
> > @@ -1413,7 +1413,6 @@ static int zpa2326_init_managed_trigger(struct device          *parent,
> >                 return -ENOMEM;
> >
> >         /* Basic setup. */
> > -       trigger->dev.parent = parent;
> >         trigger->ops = &zpa2326_trigger_ops;
> >
> >         private->trigger = trigger;
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index ee1b4ff05a37..46947776da09 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -1452,7 +1452,6 @@ static int sx9310_probe(struct i2c_client *client)
> >                 if (!data->trig)
> >                         return -ENOMEM;
> >
> > -               data->trig->dev.parent = dev;
> >                 data->trig->ops = &sx9310_trigger_ops;
> >                 iio_trigger_set_drvdata(data->trig, indio_dev);
> >
> > diff --git a/drivers/iio/proximity/sx932x.c b/drivers/iio/proximity/sx932x.c
> > index 26503348ce85..95ad49e627c6 100644
> > --- a/drivers/iio/proximity/sx932x.c
> > +++ b/drivers/iio/proximity/sx932x.c
> > @@ -1336,7 +1336,6 @@ static int sx932x_probe(struct i2c_client *client,
> >                 if (!data->trig)
> >                         return -ENOMEM;
> >
> > -               data->trig->dev.parent = &client->dev;
> >                 data->trig->ops = &sx932x_trigger_ops;
> >                 iio_trigger_set_drvdata(data->trig, indio_dev);
> >
> > diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> > index acb821cbad46..bb42aa5d596e 100644
> > --- a/drivers/iio/proximity/sx9500.c
> > +++ b/drivers/iio/proximity/sx9500.c
> > @@ -950,7 +950,6 @@ static int sx9500_probe(struct i2c_client *client,
> >                 if (!data->trig)
> >                         return -ENOMEM;
> >
> > -               data->trig->dev.parent = &client->dev;
> >                 data->trig->ops = &sx9500_trigger_ops;
> >                 iio_trigger_set_drvdata(data->trig, indio_dev);
> >
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >
