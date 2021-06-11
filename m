Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB363A4844
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 20:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFKSFM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 14:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhFKSFH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 14:05:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7847261411;
        Fri, 11 Jun 2021 18:03:08 +0000 (UTC)
Date:   Fri, 11 Jun 2021 19:05:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: humidity: hdc100x: Add margin to the conversion
 time
Message-ID: <20210611190503.0cdda724@jic23-huawei>
In-Reply-To: <CAHp75VdBHdqFDqnZc2Ow2Muc_fHk_PZuSqEXMJcxJE6_YEL8gw@mail.gmail.com>
References: <20210610104136.00002e4e@Huawei.com>
        <20210610134432.1752842-1-chris.lesiak@licor.com>
        <CAHp75VdBHdqFDqnZc2Ow2Muc_fHk_PZuSqEXMJcxJE6_YEL8gw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Jun 2021 16:55:20 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jun 10, 2021 at 4:47 PM Chris Lesiak <chris.lesiak@licor.com> wrote:
> >
> > The datasheets have the following note for the conversion time
> > specification: "This parameter is specified by design and/or
> > characterization and it is not tested in production."
> >
> > Parts have been seen that require more time to do 14-bit conversions for
> > the relative humidity channel.  The result is ENXIO due to the address
> > phase of a transfer not getting an ACK.
> >
> > Delay an additional 1 ms per conversion to allow for additional margin.  
> 
> This is crucial and not so visible in the code, see below.
> 
> > Fixes: 4839367d99e3 ("iio: humidity: add HDC100x support")
> > Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
Small process note.

For IIO at least, please don't send new versions of patches as replies
to earlier series.  Whilst it doesn't matter that much here, for large
series it can get very confusing and runs the risk of be picking up
the wrong patch versions.

A new thread is much easier to deal with.

Jonathan

> > ---
> >  drivers/iio/humidity/hdc100x.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> > index 2a957f19048e..91790aa8beeb 100644
> > --- a/drivers/iio/humidity/hdc100x.c
> > +++ b/drivers/iio/humidity/hdc100x.c
> > @@ -166,7 +166,7 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
> >                                    struct iio_chan_spec const *chan)
> >  {
> >         struct i2c_client *client = data->client;
> > -       int delay = data->adc_int_us[chan->address];
> > +       int delay = data->adc_int_us[chan->address] + 1000;  
> 
> + 1 * USEC_PER_MSEC;
> 
> >         int ret;
> >         __be16 val;
> >
> > @@ -316,7 +316,7 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
> >         struct iio_dev *indio_dev = pf->indio_dev;
> >         struct hdc100x_data *data = iio_priv(indio_dev);
> >         struct i2c_client *client = data->client;
> > -       int delay = data->adc_int_us[0] + data->adc_int_us[1];
> > +       int delay = data->adc_int_us[0] + data->adc_int_us[1] + 2000;  
> 
> + 2 * USEC_PER_MSEC
> 
> >         int ret;
> >
> >         /* dual read starts at temp register */  
> 
> Above might require to add #include <vdso/time64.h>.
> 

