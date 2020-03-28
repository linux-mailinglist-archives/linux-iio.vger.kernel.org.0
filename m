Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3081966C5
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 15:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgC1Omk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 10:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1Omk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 10:42:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5780520716;
        Sat, 28 Mar 2020 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585406559;
        bh=HKMwuYbUTGNEue8ByOr11Gad1bKuwOOXaGWjoM3Duto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LJ3dDIVgO/sUSb70eqKyqIO4JP3Ycun+z0o6nYYyvUngU/ubADp/Iepozv5BtG2Ft
         UxsUleu1GgXab5BeddFWeLOa3ZBZtHCna9wox5q3ls59xlcldQYacasEO6DU/XThrr
         jG0d9nVeAODgNqeTABfnXcArt6L/aX1x7p64uz50=
Date:   Sat, 28 Mar 2020 14:42:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] iio: adc: mp2629: Add support for mp2629 ADC
 driver
Message-ID: <20200328144234.081b964f@archlinux>
In-Reply-To: <CAHp75VfauHuAv1Wr=7ga=G+6JOYXuop_oyXiwmQgKeB2e_z=tQ@mail.gmail.com>
References: <20200322224626.13160-1-sravanhome@gmail.com>
        <20200322224626.13160-4-sravanhome@gmail.com>
        <CAHp75VfauHuAv1Wr=7ga=G+6JOYXuop_oyXiwmQgKeB2e_z=tQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Mar 2020 01:32:34 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Mar 23, 2020 at 12:47 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
> >
> > Add support for 8-bit resolution ADC readings for input power
> > supply and battery charging measurement. Provides voltage, current
> > readings to mp2629 power supply driver.  
> 
> ...
> 
> > +#include <linux/platform_device.h>  
> 
> > +#include <linux/of_device.h>  
> 
> Don't see users of it.
> 
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regulator/consumer.h>  
> 
> > +#include <linux/sysfs.h>  
> 
> Any users?
> 
> > +#include <linux/regmap.h>  
> 
> Perhaps ordered?
> 
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/machine.h>
> > +#include <linux/iio/driver.h>  
> 
> + blank line?
> 
> > +#include <linux/mfd/mp2629.h>  
> 
> ...
> 
> > +static int mp2629_read_raw(struct iio_dev *indio_dev,
> > +                       struct iio_chan_spec const *chan,
> > +                       int *val, int *val2, long mask)
> > +{
> > +       struct mp2629_adc *info = iio_priv(indio_dev);
> > +       unsigned int rval;
> > +       int ret;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               ret = regmap_read(info->regmap, chan->address, &rval);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               if (chan->address == MP2629_INPUT_VOLT)  
> 
> > +                       rval &= 0x7f;  
> 
> GENMASK() ?
> 
> > +               *val = rval;
> > +               return IIO_VAL_INT;  
> 
> > +       return 0;
> > +}  
> 
> ...
> 
> > +       void **pdata = pdev->dev.platform_data;  
> 
> Same Qs as per other patch.
> 
> ...
> 
> > +       indio_dev->dev.of_node = pdev->dev.of_node;  
> 
> Jonathan, doesn't IIO core do this for all?
>

Nope.  I'm not totally sure it's always safe to do so
as we have some weird parent structures in some cases.
A quick grep suggests that we may be fine though, or
alternatively be able to get away with a set it if not
already set approach.

I'll take a look when I get some time. It would be nice
to clean this up.

Jonathan




