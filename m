Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9253CCAF7
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 23:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhGRVej (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Jul 2021 17:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbhGRVej (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Jul 2021 17:34:39 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E2FC061762
        for <linux-iio@vger.kernel.org>; Sun, 18 Jul 2021 14:31:40 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y6so14075811ilj.13
        for <linux-iio@vger.kernel.org>; Sun, 18 Jul 2021 14:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ow7yd/6EUrynMpV9RE7C75DLtK0l6+jas8yJI3xp7nA=;
        b=M46LF2jPXQUEqMWCQA1GJEDgHnFKPafk0j/m7OJpzIwXIXSeRamjQeBx6AezMOeN0g
         IEreoVDKuzhzDPvO8dwW4w9RNjfMLFsLHmuM7cdzhQ5e9Y0zknjPlOTeC4VifadUxhHb
         7rB5RdkrVyPtsfCKYPbOPa3mdXwk5Rz2f4IqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ow7yd/6EUrynMpV9RE7C75DLtK0l6+jas8yJI3xp7nA=;
        b=mtHLYT1PVLfwr0yo72ltFsXd3BkURfFdKzk1gYUG87K4Jdj2Zys20Bb6eVlxFQ/laS
         ACXKluXO1zmc/+jekgtpUIl5pC4eX8MAaFq+ieeSh8P4cPDWXz/x3Gkpx/acJDAF00e6
         fbAsizywgrODPw5/MQhvvaVw8bqBwu/hRL3dEuaTz6i8H4wgjyNcvu8Q52XLYEJ0qPP3
         TiYXPRGZnc3uOHjmeaozlaCS97riPW/17XU0kJrL8kIkoMhzwuIUp9QgE0cXqesAsypd
         ayJ5cuEquoByIMPotOVLiyDz0P3FWu4/Rui5w5HTUhwugSshjGSrdfKwBrpFcTlc4hXm
         etqw==
X-Gm-Message-State: AOAM531NAmpFf2iwtagU761UboRqdSSKu2/QVfmMDAr9x/FJczFdXwlN
        j6o8HlWhCmIp3qlZYEkImhWl5UB8Cp4gyisiOWUu/Q==
X-Google-Smtp-Source: ABdhPJwghGaCyhofCPCUPvO43wl6OmCztC95fJB9QhJBHJw32g7l8URTTePKqAz97E7EEj9n5OiidKZJxOgHf4ayC/4=
X-Received: by 2002:a92:2010:: with SMTP id j16mr14254152ile.98.1626643899633;
 Sun, 18 Jul 2021 14:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210614141820.2034827-1-chris.lesiak@licor.com>
 <20210616134335.76715e55@jic23-huawei> <20210718155152.66f791bc@jic23-huawei>
In-Reply-To: <20210718155152.66f791bc@jic23-huawei>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 18 Jul 2021 14:31:28 -0700
Message-ID: <CAJCx=gnJJatCbrPiWh5cDkabNLN8PG3e55r_y8veFzPRBRbD_w@mail.gmail.com>
Subject: Re: [PATCH v3] iio: humidity: hdc100x: Add margin to the conversion time
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Chris Lesiak <chris.lesiak@licor.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 18, 2021 at 7:49 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 16 Jun 2021 13:43:35 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Mon, 14 Jun 2021 09:18:20 -0500
> > Chris Lesiak <chris.lesiak@licor.com> wrote:
> >
> > > The datasheets have the following note for the conversion time
> > > specification: "This parameter is specified by design and/or
> > > characterization and it is not tested in production."
> > >
> > > Parts have been seen that require more time to do 14-bit conversions for
> > > the relative humidity channel.  The result is ENXIO due to the address
> > > phase of a transfer not getting an ACK.
> > >
> > > Delay an additional 1 ms per conversion to allow for additional margin.
> > >
> > > Fixes: 4839367d99e3 ("iio: humidity: add HDC100x support")
> > > Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
> >
> > +CC Matt as this is one of his drivers.
>
> @Matt. Ping.
>
> >
> > Looks good to me.

Looks good to me as well.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> >
> > > ---
> > >  drivers/iio/humidity/hdc100x.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> > > index 2a957f19048e..9e0fce917ce4 100644
> > > --- a/drivers/iio/humidity/hdc100x.c
> > > +++ b/drivers/iio/humidity/hdc100x.c
> > > @@ -25,6 +25,8 @@
> > >  #include <linux/iio/trigger_consumer.h>
> > >  #include <linux/iio/triggered_buffer.h>
> > >
> > > +#include <linux/time.h>
> > > +
> > >  #define HDC100X_REG_TEMP                   0x00
> > >  #define HDC100X_REG_HUMIDITY                       0x01
> > >
> > > @@ -166,7 +168,7 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
> > >                                struct iio_chan_spec const *chan)
> > >  {
> > >     struct i2c_client *client = data->client;
> > > -   int delay = data->adc_int_us[chan->address];
> > > +   int delay = data->adc_int_us[chan->address] + 1*USEC_PER_MSEC;
> > >     int ret;
> > >     __be16 val;
> > >
> > > @@ -316,7 +318,7 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
> > >     struct iio_dev *indio_dev = pf->indio_dev;
> > >     struct hdc100x_data *data = iio_priv(indio_dev);
> > >     struct i2c_client *client = data->client;
> > > -   int delay = data->adc_int_us[0] + data->adc_int_us[1];
> > > +   int delay = data->adc_int_us[0] + data->adc_int_us[1] + 2*USEC_PER_MSEC;
> > >     int ret;
> > >
> > >     /* dual read starts at temp register */
> >
>
