Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEDA3D48BF
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 19:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhGXQaq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 12:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGXQaq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 12:30:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E7660E91;
        Sat, 24 Jul 2021 17:11:15 +0000 (UTC)
Date:   Sat, 24 Jul 2021 18:13:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Chris Lesiak <chris.lesiak@licor.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: humidity: hdc100x: Add margin to the conversion
 time
Message-ID: <20210724181347.2bb349db@jic23-huawei>
In-Reply-To: <CAJCx=gnJJatCbrPiWh5cDkabNLN8PG3e55r_y8veFzPRBRbD_w@mail.gmail.com>
References: <20210614141820.2034827-1-chris.lesiak@licor.com>
        <20210616134335.76715e55@jic23-huawei>
        <20210718155152.66f791bc@jic23-huawei>
        <CAJCx=gnJJatCbrPiWh5cDkabNLN8PG3e55r_y8veFzPRBRbD_w@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Jul 2021 14:31:28 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sun, Jul 18, 2021 at 7:49 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed, 16 Jun 2021 13:43:35 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> > > On Mon, 14 Jun 2021 09:18:20 -0500
> > > Chris Lesiak <chris.lesiak@licor.com> wrote:
> > >  
> > > > The datasheets have the following note for the conversion time
> > > > specification: "This parameter is specified by design and/or
> > > > characterization and it is not tested in production."
> > > >
> > > > Parts have been seen that require more time to do 14-bit conversions for
> > > > the relative humidity channel.  The result is ENXIO due to the address
> > > > phase of a transfer not getting an ACK.
> > > >
> > > > Delay an additional 1 ms per conversion to allow for additional margin.
> > > >
> > > > Fixes: 4839367d99e3 ("iio: humidity: add HDC100x support")
> > > > Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>  
> > >
> > > +CC Matt as this is one of his drivers.  
> >
> > @Matt. Ping.
> >  
> > >
> > > Looks good to me.  
> 
> Looks good to me as well.
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

Thanks.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Jonathan

> 
> > >  
> > > > ---
> > > >  drivers/iio/humidity/hdc100x.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> > > > index 2a957f19048e..9e0fce917ce4 100644
> > > > --- a/drivers/iio/humidity/hdc100x.c
> > > > +++ b/drivers/iio/humidity/hdc100x.c
> > > > @@ -25,6 +25,8 @@
> > > >  #include <linux/iio/trigger_consumer.h>
> > > >  #include <linux/iio/triggered_buffer.h>
> > > >
> > > > +#include <linux/time.h>
> > > > +
> > > >  #define HDC100X_REG_TEMP                   0x00
> > > >  #define HDC100X_REG_HUMIDITY                       0x01
> > > >
> > > > @@ -166,7 +168,7 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
> > > >                                struct iio_chan_spec const *chan)
> > > >  {
> > > >     struct i2c_client *client = data->client;
> > > > -   int delay = data->adc_int_us[chan->address];
> > > > +   int delay = data->adc_int_us[chan->address] + 1*USEC_PER_MSEC;
> > > >     int ret;
> > > >     __be16 val;
> > > >
> > > > @@ -316,7 +318,7 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
> > > >     struct iio_dev *indio_dev = pf->indio_dev;
> > > >     struct hdc100x_data *data = iio_priv(indio_dev);
> > > >     struct i2c_client *client = data->client;
> > > > -   int delay = data->adc_int_us[0] + data->adc_int_us[1];
> > > > +   int delay = data->adc_int_us[0] + data->adc_int_us[1] + 2*USEC_PER_MSEC;
> > > >     int ret;
> > > >
> > > >     /* dual read starts at temp register */  
> > >  
> >  

