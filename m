Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF8E2C751D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbgK1Vt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732251AbgK1S7p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:59:45 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7453D22264;
        Sat, 28 Nov 2020 11:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606562858;
        bh=q9t0E9p3Z3A34FvR6fiBWYyqo2/S0QdL1HmGZf6MD8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pjz3QClZgphL8SV16IByCnWTJw3+3yDWQDAESEGwb9ngZV8huuGAzwR4BIN8EBdS0
         xmtACEdE/jioO82ti+0t9/cj/DI1ytrOqX4xq5yXxp/u0ZBNdMqzq4R64kn4Pngx5v
         zXP4xz0T28CLwjRbXxnb29oR5JNrCmGs5kBqrPnc=
Date:   Sat, 28 Nov 2020 11:27:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] iio: magnetometer: Add driver for Yamaha YAS5xx
Message-ID: <20201128112735.57398b74@archlinux>
In-Reply-To: <X8HNcg4fQKbo8yd5@builder.lan>
References: <20201128004038.883289-1-linus.walleij@linaro.org>
        <20201128004038.883289-2-linus.walleij@linaro.org>
        <X8HNcg4fQKbo8yd5@builder.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Nov 2020 22:09:22 -0600
Bjorn Andersson <bjorn.andersson@linaro.org> wrote:

> On Fri 27 Nov 18:40 CST 2020, Linus Walleij wrote:
> 
> > This adds an IIO magnetometer driver for the Yamaha
> > YAS53x magnetometer/compass chips YAS530 and YAS532.
> > A quick survey of the source code released by different
> > vendors reveal that we have these variants in the family
> > with some deployments listed:
> > 
> >  * YAS529 MS-3C (2005 Samsung Aries)
> >  * YAS530 MS-3E (2011 Samsung Galaxy S Advance)
> >  * YAS532 MS-3R (2011 Samsung Galaxy S4)
> >  * YAS533 MS-3F (Vivo 1633, 1707, V3, Y21L)
> >  * (YAS534 is a magnetic switch)
> >  * YAS535 MS-6C
> >  * YAS536 MS-3W
> >  * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5)
> >  * YAS539 MS-3S (2018 Samsung Galaxy A7 SM-A750FN)
> > 
> > The YAS529 is so significantly different from the
> > YAS53x variants that it will require its own driver.
> > The YAS537 and YAS539 have slightly different register
> > sets but have strong similarities so a common driver
> > will probably be reasonable.
> > 
> > The source code for Samsung Galaxy A7's YAS539 is not
> > that significantly different from the YAS530 in the
> > Galaxy S Advance, so I believe we will only need this
> > one driver with quirks to handle all of them.
> > 
> > The YAS539 is actively announced on Yamaha's devices
> > site:
> > https://device.yamaha.com/en/lsi/products/e_compass/
> > 
> > This is a driver written from scratch using buffered
> > IIO and runtime PM handling regulators and reset.
> >   
> 
> Looks quite nice, just spotted some small things as I was skimming
> through the patch.
> 
> > Cc: phone-devel@vger.kernel.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v1->v3:
> > - This is posted along with the DT bindings which are
> >   in v3 so just number everything as v3.  
> 
> $subject still says v2...
> 
> [..]
> > diff --git a/drivers/iio/magnetometer/yamaha-yas53x.c b/drivers/iio/magnetometer/yamaha-yas53x.c  
> [..]
> > +/* On YAS532 the x, y1 and y2 values are 13 bits */
> > +static u16 yas532_extract_axis(u8 *data)
> > +{
> > +	u16 val;
> > +
> > +	/*
> > +	 * These are the bits used in a 16bit word:
> > +	 * 15 14 13 12 11 10 9  8  7  6  5  4  3  2  1  0
> > +	 *    x  x  x  x  x  x  x  x  x  x  x  x  x
> > +	 */
> > +	val = get_unaligned_be16(&data[0]);
> > +	val >>= 2;
> > +	val &= GENMASK(12, 0);  
> 
> Wouldn't it be easier to follow if you GENMASK out the bits you document
> above, then shift them right?

Even better to use FIELD_GET
which does what Bjorn suggested under the hood.

Thanks,

Jonathan

> 
> > +	return val;
> > +}  
> [..]
> > +/**
> > + * yas5xx_measure() - Make a measure from the hardware*
> > + * @yas5xx: The device state
> > + * @t: the raw temperature measurement
> > + * @x: the raw x axis measurement
> > + * @y1: the y1 axis measurement
> > + * @y2: the y2 axis measurement  
> 
> * Return: 
> 
> To complete the kerneldoc.
> 
> > + */
> > +static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
> > +{  
> [..]
> > +/**  
> 
> This will result in someone feeling inclined to send a patch to fix the
> incomplete kerneldoc.
> 
> So please either fill it out, or drop the second '*'.
> 
> > + * yas5xx_get_measure() - Measure a sample of all axis and process
> > + *
> > + * Returned valued are in nanotesla according to some code.
> > + */
> > +static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
> > +{  
> [..]
> > +static int __maybe_unused yas5xx_runtime_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +	struct yas5xx *yas5xx = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = regulator_bulk_enable(ARRAY_SIZE(yas5xx->regs), yas5xx->regs);
> > +	if (ret) {
> > +		dev_err(dev, "cannot enable regulators\n");  
> 
> regulator_bulk_enable() will log which of the regs it failed ot enable,
> so you can omit this.
> 
> Regards,
> Bjorn

