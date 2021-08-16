Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56B93ECFA7
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 09:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhHPHtA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 03:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhHPHtA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 03:49:00 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F354FC0613C1
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 00:48:28 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id l22so10162955vsi.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 00:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnZfn/AOksPTDwn6vTx+nMUzsCcqo75FfKdHjwSoewg=;
        b=PZTUBGq371PVF6hScXNRtMfRg4n4tFR9jnT/hRqU0eSr94+IJq/0FXDPwIT0zEl2Cy
         CZvTZ7pf8Ghl324D+a0iiXuG07atv5izzwdW5bo8ygWIEc6BAkTsQ5YO5r7ntMD1eRsK
         EknQ3/SB2YByeAjy5F4bltQLUZE5flZmMURv+OdM+Drb3Q52uenuqglt6Ua0n8FDS2Z1
         9/D95Yc7ktcKVp++8q6U8lh3WZgbDmpccodzB815vvxLnfl90n3aWqR+B26VJObOlHrT
         qrTXpwIdqOx8u767nYIcsMQkh8sZsla4W7y1mhoPR9qDd6Mcu/+pXEbIo+5TjfbUzsZA
         OvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnZfn/AOksPTDwn6vTx+nMUzsCcqo75FfKdHjwSoewg=;
        b=PHhj6wAG8UIMCpa4VK9M1y1sw0saAYmzzxcMWY6I0Utq28hoynE4A9LF64v02cSI1H
         JsbfJ//zRI7zxETbSEcB5pnYUmgUHxgmpwWgUxY6rHxsUCDJ567TO2cspSeDjV+JvbAW
         7PHB39i+/1qvtBVa8AnXcVl7GOgZteDx27x68rpPI4QpbUgaY1cVSd6gZKWYii2KZfEI
         pBzoryxQefWtfN5MTdEprZhWiCbypYFRPcBsunuyCuJjZQDC9TWn5k6PVXyfVZwl1wCW
         OCEyflgdu1JiJK2RzZCg3Iwmjy2jNiaAYBlNKUDp5xuhSRnUX2FVIAaD+rQ9+zxh13+0
         xXOA==
X-Gm-Message-State: AOAM531yuzNyjbliF3v2l09FyPtos9wFbiGTyCGOBFymmH7kfyibYMVK
        FWu9zVOlhy05sNCqymQe0qjKGU3E0ftH2Tpqr7ak3w==
X-Google-Smtp-Source: ABdhPJxAiZGhbtt2UXfobPUE7N//yiC4iv2XNU3Uc6yEIfDHW8Gyx1PIJTe8d2hroqDG8b5Gwwpri856nieDNc8m9io=
X-Received: by 2002:a05:6102:222f:: with SMTP id d15mr2771845vsb.16.1629100108038;
 Mon, 16 Aug 2021 00:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210726071404.14529-1-aardelean@deviqon.com> <20210726071404.14529-3-aardelean@deviqon.com>
 <20210731183707.20bf8e00@jic23-huawei> <CAASAkoatK69RFyj3Sc1USv70RMBCcOF1rVd-XyensawuoLra5Q@mail.gmail.com>
In-Reply-To: <CAASAkoatK69RFyj3Sc1USv70RMBCcOF1rVd-XyensawuoLra5Q@mail.gmail.com>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 16 Aug 2021 10:48:16 +0300
Message-ID: <CAASAkoaB4t1zpqF4aUCSybga1_S9vs57udzijCB107gOyOwOvQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: st_sensors: remove st_sensors_power_disable() function
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        denis.ciocca@st.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Aug 2021 at 10:30, Alexandru Ardelean <aardelean@deviqon.com> wrote:
>
> On Sat, 31 Jul 2021 at 20:34, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 26 Jul 2021 10:14:02 +0300
> > Alexandru Ardelean <aardelean@deviqon.com> wrote:
> >
> > > This change converts the st_sensors_power_enable() function to use
> > > devm_add_action_or_reset() handlers to register regulator_disable hooks for
> > > when the drivers get unloaded.
> > >
> > > The parent device of the IIO device object is used. This is based on the
> > > assumption that all other devm_ calls in the ST sensors use this reference.
> > >
> > > This makes the st_sensors_power_disable() un-needed.
> > > Removing this also changes unload order a bit, as all ST drivers would call
> > > st_sensors_power_disable() first and iio_device_unregister() after that.
> >
> > Huh.  So currently the drivers turn the power off before calling
> > iio_device_unregister()?
> >
> > That's a bad idea (turn off power when userspace is still available)
> > and looks like a bug fix to me.  Perhaps the reorder should be pulled out as
> > a precursor patch in case anyone wants to backport it?
> >
> > (note I initially thought you were going the other way and was just writing
> >  a rant about breaking the order when I realised you were fixing it ;)

I'm seeing a bit of a clash with this patch [by Andy from April 2021]:

https://lore.kernel.org/linux-devicetree/20210414195454.84183-4-andriy.shevchenko@linux.intel.com/

I can do the fix commits, but they will be short-lived, since they
will be applied on 5.13 and onwards.
We'd need maybe another set for the LTS kernels.

So, how should we proceed here?
I think I'll do the fix commits anyway for this set.

Thanks
Alex

>
> Probably the best advantage of devm_ functions .
> Not needing to care about un-init order.
>
> I hated debugging driver crashes when they were unloaded, usually
> because the driver gets into a weird state.
>
> I'll send a V2 with the re-order fixes in the front.
>
> >
> > >
> > > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> > > ---
> > >  drivers/iio/accel/st_accel_i2c.c              | 13 +------
> > >  drivers/iio/accel/st_accel_spi.c              | 13 +------
> > >  .../iio/common/st_sensors/st_sensors_core.c   | 34 ++++++++-----------
> > >  drivers/iio/gyro/st_gyro_i2c.c                | 13 +------
> > >  drivers/iio/gyro/st_gyro_spi.c                | 13 +------
> > >  drivers/iio/magnetometer/st_magn_i2c.c        | 13 +------
> > >  drivers/iio/magnetometer/st_magn_spi.c        | 13 +------
> > >  drivers/iio/pressure/st_pressure_i2c.c        | 13 +------
> > >  drivers/iio/pressure/st_pressure_spi.c        | 13 +------
> > >  include/linux/iio/common/st_sensors.h         |  2 --
> > >  10 files changed, 23 insertions(+), 117 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> > > index f711756e41e3..b377575efc41 100644
> > > --- a/drivers/iio/accel/st_accel_i2c.c
> > > +++ b/drivers/iio/accel/st_accel_i2c.c
> > > @@ -177,24 +177,13 @@ static int st_accel_i2c_probe(struct i2c_client *client)
> > >       if (ret)
> > >               return ret;
> > >
> > > -     ret = st_accel_common_probe(indio_dev);
> > > -     if (ret < 0)
> > > -             goto st_accel_power_off;
> > > -
> > > -     return 0;
> > > -
> > > -st_accel_power_off:
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > > -     return ret;
> > > +     return st_accel_common_probe(indio_dev);
> > >  }
> > >
> > >  static int st_accel_i2c_remove(struct i2c_client *client)
> > >  {
> > >       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > >
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > >       st_accel_common_remove(indio_dev);
> > >
> > >       return 0;
> > > diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> > > index bb45d9ff95b8..4ca87e73bdb3 100644
> > > --- a/drivers/iio/accel/st_accel_spi.c
> > > +++ b/drivers/iio/accel/st_accel_spi.c
> > > @@ -127,24 +127,13 @@ static int st_accel_spi_probe(struct spi_device *spi)
> > >       if (err)
> > >               return err;
> > >
> > > -     err = st_accel_common_probe(indio_dev);
> > > -     if (err < 0)
> > > -             goto st_accel_power_off;
> > > -
> > > -     return 0;
> > > -
> > > -st_accel_power_off:
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > > -     return err;
> > > +     return st_accel_common_probe(indio_dev);
> > >  }
> > >
> > >  static int st_accel_spi_remove(struct spi_device *spi)
> > >  {
> > >       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > >
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > >       st_accel_common_remove(indio_dev);
> > >
> > >       return 0;
> > > diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> > > index 0bbb090b108c..a5a140de9a23 100644
> > > --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> > > +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> > > @@ -215,13 +215,19 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
> > >  }
> > >  EXPORT_SYMBOL(st_sensors_set_axis_enable);
> > >
> > > +static void st_reg_disable(void *reg)
> > > +{
> > > +     regulator_disable(reg);
> > > +}
> > > +
> > >  int st_sensors_power_enable(struct iio_dev *indio_dev)
> > >  {
> > >       struct st_sensor_data *pdata = iio_priv(indio_dev);
> > > +     struct device *parent = indio_dev->dev.parent;
> > >       int err;
> > >
> > >       /* Regulators not mandatory, but if requested we should enable them. */
> > > -     pdata->vdd = devm_regulator_get(indio_dev->dev.parent, "vdd");
> > > +     pdata->vdd = devm_regulator_get(parent, "vdd");
> > >       if (IS_ERR(pdata->vdd)) {
> > >               dev_err(&indio_dev->dev, "unable to get Vdd supply\n");
> > >               return PTR_ERR(pdata->vdd);
> > > @@ -233,36 +239,26 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
> > >               return err;
> > >       }
> > >
> > > -     pdata->vdd_io = devm_regulator_get(indio_dev->dev.parent, "vddio");
> > > +     err = devm_add_action_or_reset(parent, st_reg_disable, pdata->vdd);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     pdata->vdd_io = devm_regulator_get(parent, "vddio");
> > >       if (IS_ERR(pdata->vdd_io)) {
> > >               dev_err(&indio_dev->dev, "unable to get Vdd_IO supply\n");
> > > -             err = PTR_ERR(pdata->vdd_io);
> > > -             goto st_sensors_disable_vdd;
> > > +             return PTR_ERR(pdata->vdd_io);
> > >       }
> > >       err = regulator_enable(pdata->vdd_io);
> > >       if (err != 0) {
> > >               dev_warn(&indio_dev->dev,
> > >                        "Failed to enable specified Vdd_IO supply\n");
> > > -             goto st_sensors_disable_vdd;
> > > +             return err;
> > >       }
> > >
> > > -     return 0;
> > > -
> > > -st_sensors_disable_vdd:
> > > -     regulator_disable(pdata->vdd);
> > > -     return err;
> > > +     return devm_add_action_or_reset(parent, st_reg_disable, pdata->vdd_io);
> > >  }
> > >  EXPORT_SYMBOL(st_sensors_power_enable);
> > >
> > > -void st_sensors_power_disable(struct iio_dev *indio_dev)
> > > -{
> > > -     struct st_sensor_data *pdata = iio_priv(indio_dev);
> > > -
> > > -     regulator_disable(pdata->vdd);
> > > -     regulator_disable(pdata->vdd_io);
> > > -}
> > > -EXPORT_SYMBOL(st_sensors_power_disable);
> > > -
> > >  static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
> > >                                       struct st_sensors_platform_data *pdata)
> > >  {
> > > diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
> > > index 3ef86e16ee65..0bd80dfd389f 100644
> > > --- a/drivers/iio/gyro/st_gyro_i2c.c
> > > +++ b/drivers/iio/gyro/st_gyro_i2c.c
> > > @@ -90,24 +90,13 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
> > >       if (err)
> > >               return err;
> > >
> > > -     err = st_gyro_common_probe(indio_dev);
> > > -     if (err < 0)
> > > -             goto st_gyro_power_off;
> > > -
> > > -     return 0;
> > > -
> > > -st_gyro_power_off:
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > > -     return err;
> > > +     return st_gyro_common_probe(indio_dev);
> > >  }
> > >
> > >  static int st_gyro_i2c_remove(struct i2c_client *client)
> > >  {
> > >       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > >
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > >       st_gyro_common_remove(indio_dev);
> > >
> > >       return 0;
> > > diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
> > > index 41d835493347..f74b09fa5cde 100644
> > > --- a/drivers/iio/gyro/st_gyro_spi.c
> > > +++ b/drivers/iio/gyro/st_gyro_spi.c
> > > @@ -94,24 +94,13 @@ static int st_gyro_spi_probe(struct spi_device *spi)
> > >       if (err)
> > >               return err;
> > >
> > > -     err = st_gyro_common_probe(indio_dev);
> > > -     if (err < 0)
> > > -             goto st_gyro_power_off;
> > > -
> > > -     return 0;
> > > -
> > > -st_gyro_power_off:
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > > -     return err;
> > > +     return st_gyro_common_probe(indio_dev);
> > >  }
> > >
> > >  static int st_gyro_spi_remove(struct spi_device *spi)
> > >  {
> > >       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > >
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > >       st_gyro_common_remove(indio_dev);
> > >
> > >       return 0;
> > > diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
> > > index 2dfe4ee99591..0a5117dffcf4 100644
> > > --- a/drivers/iio/magnetometer/st_magn_i2c.c
> > > +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> > > @@ -86,24 +86,13 @@ static int st_magn_i2c_probe(struct i2c_client *client,
> > >       if (err)
> > >               return err;
> > >
> > > -     err = st_magn_common_probe(indio_dev);
> > > -     if (err < 0)
> > > -             goto st_magn_power_off;
> > > -
> > > -     return 0;
> > > -
> > > -st_magn_power_off:
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > > -     return err;
> > > +     return st_magn_common_probe(indio_dev);
> > >  }
> > >
> > >  static int st_magn_i2c_remove(struct i2c_client *client)
> > >  {
> > >       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > >
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > >       st_magn_common_remove(indio_dev);
> > >
> > >       return 0;
> > > diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> > > index fba978796395..1f3bf02b24e0 100644
> > > --- a/drivers/iio/magnetometer/st_magn_spi.c
> > > +++ b/drivers/iio/magnetometer/st_magn_spi.c
> > > @@ -80,24 +80,13 @@ static int st_magn_spi_probe(struct spi_device *spi)
> > >       if (err)
> > >               return err;
> > >
> > > -     err = st_magn_common_probe(indio_dev);
> > > -     if (err < 0)
> > > -             goto st_magn_power_off;
> > > -
> > > -     return 0;
> > > -
> > > -st_magn_power_off:
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > > -     return err;
> > > +     return st_magn_common_probe(indio_dev);
> > >  }
> > >
> > >  static int st_magn_spi_remove(struct spi_device *spi)
> > >  {
> > >       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > >
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > >       st_magn_common_remove(indio_dev);
> > >
> > >       return 0;
> > > diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
> > > index 52fa98f24478..afeeab485c0d 100644
> > > --- a/drivers/iio/pressure/st_pressure_i2c.c
> > > +++ b/drivers/iio/pressure/st_pressure_i2c.c
> > > @@ -103,24 +103,13 @@ static int st_press_i2c_probe(struct i2c_client *client,
> > >       if (ret)
> > >               return ret;
> > >
> > > -     ret = st_press_common_probe(indio_dev);
> > > -     if (ret < 0)
> > > -             goto st_press_power_off;
> > > -
> > > -     return 0;
> > > -
> > > -st_press_power_off:
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > > -     return ret;
> > > +     return st_press_common_probe(indio_dev);
> > >  }
> > >
> > >  static int st_press_i2c_remove(struct i2c_client *client)
> > >  {
> > >       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > >
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > >       st_press_common_remove(indio_dev);
> > >
> > >       return 0;
> > > diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
> > > index ee393df54cee..834ad6d40a70 100644
> > > --- a/drivers/iio/pressure/st_pressure_spi.c
> > > +++ b/drivers/iio/pressure/st_pressure_spi.c
> > > @@ -86,24 +86,13 @@ static int st_press_spi_probe(struct spi_device *spi)
> > >       if (err)
> > >               return err;
> > >
> > > -     err = st_press_common_probe(indio_dev);
> > > -     if (err < 0)
> > > -             goto st_press_power_off;
> > > -
> > > -     return 0;
> > > -
> > > -st_press_power_off:
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > > -     return err;
> > > +     return st_press_common_probe(indio_dev);
> > >  }
> > >
> > >  static int st_press_spi_remove(struct spi_device *spi)
> > >  {
> > >       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > >
> > > -     st_sensors_power_disable(indio_dev);
> > > -
> > >       st_press_common_remove(indio_dev);
> > >
> > >       return 0;
> > > diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> > > index e74b55244f35..fc90c202d15e 100644
> > > --- a/include/linux/iio/common/st_sensors.h
> > > +++ b/include/linux/iio/common/st_sensors.h
> > > @@ -293,8 +293,6 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable);
> > >
> > >  int st_sensors_power_enable(struct iio_dev *indio_dev);
> > >
> > > -void st_sensors_power_disable(struct iio_dev *indio_dev);
> > > -
> > >  int st_sensors_debugfs_reg_access(struct iio_dev *indio_dev,
> > >                                 unsigned reg, unsigned writeval,
> > >                                 unsigned *readval);
> >
