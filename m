Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54AE3DC720
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 19:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhGaRPY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 31 Jul 2021 13:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhGaRPX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 13:15:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3784160F94;
        Sat, 31 Jul 2021 17:15:15 +0000 (UTC)
Date:   Sat, 31 Jul 2021 18:17:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     =?UTF-8?B?VGjDqW8gQm9yw6lt?= Fabris <theobf@usp.br>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: dac: max5821: convert device register to device
 managed function
Message-ID: <20210731181755.6f1024a6@jic23-huawei>
In-Reply-To: <CA+U=DsrQyDsGHDZvnfyE0n8=gdgM4ivTuFFhtw1FO_oqNW+grg@mail.gmail.com>
References: <20210724220159.11998-1-theobf@usp.br>
        <CA+U=DsrQyDsGHDZvnfyE0n8=gdgM4ivTuFFhtw1FO_oqNW+grg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Jul 2021 09:53:54 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sun, Jul 25, 2021 at 1:06 AM Théo Borém Fabris <theobf@usp.br> wrote:
> >
> > Add a device managed hook, via devm_add_action_or_reset() and
> > max5821_regulator_disable(), to disable voltage regulator on device
> > detach.
> > Replace iio_device_register() by devm_iio_device_register() and remove
> > the max5821_remove() function used to unregister the device and disable the
> > voltage regulator.
> > Remove i2c_set_clientdata() from the probe function, since
> > i2c_get_clientdata() is not used anymore.
> > Remove regulator_disable() calls from the probe function.
> >  
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find anything we missed.

Thanks,

Jonathan

> 
> > Signed-off-by: Théo Borém Fabris <theobf@usp.br>
> > ---
> > Changelog:
> > V1 -> V2: Removed regulator_disable() calls and goto statements
> >
> >  drivers/iio/dac/max5821.c | 41 ++++++++++++++++-----------------------
> >  1 file changed, 17 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> > index bd6e75699a63..bd0b7f361154 100644
> > --- a/drivers/iio/dac/max5821.c
> > +++ b/drivers/iio/dac/max5821.c
> > @@ -294,6 +294,11 @@ static const struct iio_info max5821_info = {
> >         .write_raw = max5821_write_raw,
> >  };
> >
> > +static void max5821_regulator_disable(void *reg)
> > +{
> > +       regulator_disable(reg);
> > +}
> > +
> >  static int max5821_probe(struct i2c_client *client,
> >                         const struct i2c_device_id *id)
> >  {
> > @@ -306,7 +311,6 @@ static int max5821_probe(struct i2c_client *client,
> >         if (!indio_dev)
> >                 return -ENOMEM;
> >         data = iio_priv(indio_dev);
> > -       i2c_set_clientdata(client, indio_dev);
> >         data->client = client;
> >         mutex_init(&data->lock);
> >
> > @@ -321,21 +325,29 @@ static int max5821_probe(struct i2c_client *client,
> >                 ret = PTR_ERR(data->vref_reg);
> >                 dev_err(&client->dev,
> >                         "Failed to get vref regulator: %d\n", ret);
> > -               goto error_free_reg;
> > +               return ret;
> >         }
> >
> >         ret = regulator_enable(data->vref_reg);
> >         if (ret) {
> >                 dev_err(&client->dev,
> >                         "Failed to enable vref regulator: %d\n", ret);
> > -               goto error_free_reg;
> > +               return ret;
> > +       }
> > +
> > +       ret = devm_add_action_or_reset(&client->dev, max5821_regulator_disable,
> > +                                      data->vref_reg);
> > +       if (ret) {
> > +               dev_err(&client->dev,
> > +                       "Failed to add action to managed regulator: %d\n", ret);
> > +               return ret;
> >         }
> >
> >         ret = regulator_get_voltage(data->vref_reg);
> >         if (ret < 0) {
> >                 dev_err(&client->dev,
> >                         "Failed to get voltage on regulator: %d\n", ret);
> > -               goto error_disable_reg;
> > +               return ret;
> >         }
> >
> >         data->vref_mv = ret / 1000;
> > @@ -346,25 +358,7 @@ static int max5821_probe(struct i2c_client *client,
> >         indio_dev->modes = INDIO_DIRECT_MODE;
> >         indio_dev->info = &max5821_info;
> >
> > -       return iio_device_register(indio_dev);
> > -
> > -error_disable_reg:
> > -       regulator_disable(data->vref_reg);
> > -
> > -error_free_reg:
> > -
> > -       return ret;
> > -}
> > -
> > -static int max5821_remove(struct i2c_client *client)
> > -{
> > -       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > -       struct max5821_data *data = iio_priv(indio_dev);
> > -
> > -       iio_device_unregister(indio_dev);
> > -       regulator_disable(data->vref_reg);
> > -
> > -       return 0;
> > +       return devm_iio_device_register(&client->dev, indio_dev);
> >  }
> >
> >  static const struct i2c_device_id max5821_id[] = {
> > @@ -386,7 +380,6 @@ static struct i2c_driver max5821_driver = {
> >                 .pm     = &max5821_pm_ops,
> >         },
> >         .probe          = max5821_probe,
> > -       .remove         = max5821_remove,
> >         .id_table       = max5821_id,
> >  };
> >  module_i2c_driver(max5821_driver);
> > --
> > 2.20.1
> >  

