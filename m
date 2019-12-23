Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D12B12984B
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 16:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfLWPe2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 10:34:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLWPe2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 10:34:28 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 694FC20709;
        Mon, 23 Dec 2019 15:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577115267;
        bh=I/rj9Z7xeB50nNWhbYE/3maqR2d3nmHPWUDnhEg73LE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1NWwa117p6h45f3dJt6s1V6mpQ/Ja7pDl/sTavBMFuS6+p3aY3cXkPA/r9Q+IQl9v
         Y07nDFNJf64CCNTiU80jBWmsbb9DKJAEzrNT4ZLphP5wFf2GbodtWMJEu+77L8tGwh
         6tH9atH7UOyIlrCbdgcGpWMSgn5GpMky2UU3WXkw=
Date:   Mon, 23 Dec 2019 15:34:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] iio: adc: ad7923: Add support for the
 ad7908/ad7918/ad7928
Message-ID: <20191223153421.37596a76@archlinux>
In-Reply-To: <9c85074a84d583527d7c59f1dad7e7f52dcbb300.camel@analog.com>
References: <20191217111158.30888-1-djunho@gmail.com>
        <20191217111158.30888-5-djunho@gmail.com>
        <9c85074a84d583527d7c59f1dad7e7f52dcbb300.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Dec 2019 11:35:49 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2019-12-17 at 08:11 -0300, Daniel Junho wrote:
> > The ad7928 is software compatible with the ad7923.
> > The ad7908 and ad7918 are the 8 and 10-bit versions of the ad7928.
> >   
> 
> One minor nit.
> Fine to leave it like this.
I disagree on that.  The change as it stands makes no sense.

It's a left over of the change to sequence write that was in the
v1 patch that I commented on and Daniel remove.
That change from using the first two bits then mapping those to
bit 3 and IIRC bit 9 to mapping bits 0 and 8 to those places.

These defines had to change to make that work.  Now we have
the changes to the defines but not the sequence function.

However, we get away with it here as the only value ever passed
in is 0.  Hence nothing happens whichever bit is in use.

Given the fix is just to drop that define block, I've done it whilst
applying.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan


> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> > Signed-off-by: Daniel Junho <djunho@gmail.com>
> > ---
> >  drivers/iio/adc/ad7923.c | 57 +++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 50 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> > index 6d56fa0b9e30..1077036d1ed8 100644
> > --- a/drivers/iio/adc/ad7923.c
> > +++ b/drivers/iio/adc/ad7923.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * AD7904/AD7914/AD7923/AD7924 SPI ADC driver
> > + * AD7904/AD7914/AD7923/AD7924/AD7908/AD7918/AD7928 SPI ADC driver
> >   *
> >   * Copyright 2011 Analog Devices Inc (from AD7923 Driver)
> >   * Copyright 2012 CS Systemes d'Information
> > @@ -29,11 +29,13 @@
> >  #define AD7923_PM_MODE_AS	(1)		/* auto shutdown */
> >  #define AD7923_PM_MODE_FS	(2)		/* full shutdown */
> >  #define AD7923_PM_MODE_OPS	(3)		/* normal operation */
> > -#define AD7923_SEQUENCE_OFF	(0)		/* no sequence fonction
> > */
> > -#define AD7923_SEQUENCE_PROTECT	(2)		/* no interrupt
> > write cycle */
> > -#define AD7923_SEQUENCE_ON	(3)		/* continuous sequence */
> >  
> > -#define AD7923_MAX_CHAN		4
> > +#define AD7923_SEQUENCE_OFF	(0x00)		/* no sequence function
> > */
> > +#define AD7908_SEQUENCE_SHADOW	(0x01)		/* use the shadow
> > register
> > +						 * for programming
> > +						 */
> > +#define AD7923_SEQUENCE_PROTECT	(0x10)		/* no interrupt   
> 
> These register changes seem extra.
> They don't seem to do anything.
> I don't mind the change though.
> 
> 
> > write cycle */
> > +#define AD7923_SEQUENCE_ON	(0x11)		/* continuous sequence */
> >  
> >  #define AD7923_PM_MODE_WRITE(mode)	((mode) << 4)	 /* write mode */
> >  #define AD7923_CHANNEL_WRITE(channel)	((channel) << 6) /* write
> > channel */
> > @@ -74,6 +76,9 @@ enum ad7923_id {
> >  	AD7904,
> >  	AD7914,
> >  	AD7924,
> > +	AD7908,
> > +	AD7918,
> > +	AD7928
> >  };
> >  
> >  #define AD7923_V_CHAN(index, bits)					\
> > @@ -102,9 +107,25 @@ const struct iio_chan_spec name ## _channels[] = { \
> >  	IIO_CHAN_SOFT_TIMESTAMP(4), \
> >  }
> >  
> > +#define DECLARE_AD7908_CHANNELS(name, bits) \
> > +const struct iio_chan_spec name ## _channels[] = { \
> > +	AD7923_V_CHAN(0, bits), \
> > +	AD7923_V_CHAN(1, bits), \
> > +	AD7923_V_CHAN(2, bits), \
> > +	AD7923_V_CHAN(3, bits), \
> > +	AD7923_V_CHAN(4, bits), \
> > +	AD7923_V_CHAN(5, bits), \
> > +	AD7923_V_CHAN(6, bits), \
> > +	AD7923_V_CHAN(7, bits), \
> > +	IIO_CHAN_SOFT_TIMESTAMP(8), \
> > +}
> > +
> >  static DECLARE_AD7923_CHANNELS(ad7904, 8);
> >  static DECLARE_AD7923_CHANNELS(ad7914, 10);
> >  static DECLARE_AD7923_CHANNELS(ad7924, 12);
> > +static DECLARE_AD7908_CHANNELS(ad7908, 8);
> > +static DECLARE_AD7908_CHANNELS(ad7918, 10);
> > +static DECLARE_AD7908_CHANNELS(ad7928, 12);
> >  
> >  static const struct ad7923_chip_info ad7923_chip_info[] = {
> >  	[AD7904] = {
> > @@ -119,6 +140,18 @@ static const struct ad7923_chip_info
> > ad7923_chip_info[] = {
> >  		.channels = ad7924_channels,
> >  		.num_channels = ARRAY_SIZE(ad7924_channels),
> >  	},
> > +	[AD7908] = {
> > +		.channels = ad7908_channels,
> > +		.num_channels = ARRAY_SIZE(ad7908_channels),
> > +	},
> > +	[AD7918] = {
> > +		.channels = ad7918_channels,
> > +		.num_channels = ARRAY_SIZE(ad7918_channels),
> > +	},
> > +	[AD7928] = {
> > +		.channels = ad7928_channels,
> > +		.num_channels = ARRAY_SIZE(ad7928_channels),
> > +	},
> >  };
> >  
> >  /**
> > @@ -131,7 +164,11 @@ static int ad7923_update_scan_mode(struct iio_dev
> > *indio_dev,
> >  	int i, cmd, len;
> >  
> >  	len = 0;
> > -	for_each_set_bit(i, active_scan_mask, AD7923_MAX_CHAN) {
> > +	/*
> > +	 * For this driver the last channel is always the software
> > timestamp so
> > +	 * skip that one.
> > +	 */
> > +	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels - 1)
> > {
> >  		cmd = AD7923_WRITE_CR | AD7923_CHANNEL_WRITE(i) |
> >  			AD7923_SEQUENCE_WRITE(AD7923_SEQUENCE_OFF) |
> >  			st->settings;
> > @@ -344,6 +381,9 @@ static const struct spi_device_id ad7923_id[] = {
> >  	{"ad7914", AD7914},
> >  	{"ad7923", AD7924},
> >  	{"ad7924", AD7924},
> > +	{"ad7908", AD7908},
> > +	{"ad7918", AD7918},
> > +	{"ad7928", AD7928},
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(spi, ad7923_id);
> > @@ -353,6 +393,9 @@ static const struct of_device_id ad7923_of_match[] =
> > {
> >  	{ .compatible = "adi,ad7914", },
> >  	{ .compatible = "adi,ad7923", },
> >  	{ .compatible = "adi,ad7924", },
> > +	{ .compatible = "adi,ad7908", },
> > +	{ .compatible = "adi,ad7918", },
> > +	{ .compatible = "adi,ad7928", },
> >  	{ },
> >  };
> >  MODULE_DEVICE_TABLE(of, ad7923_of_match);
> > @@ -370,5 +413,5 @@ module_spi_driver(ad7923_driver);
> >  
> >  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> >  MODULE_AUTHOR("Patrick Vasseur <patrick.vasseur@c-s.fr>");
> > -MODULE_DESCRIPTION("Analog Devices AD7904/AD7914/AD7923/AD7924 ADC");
> > +MODULE_DESCRIPTION("Analog Devices AD7923 and similar ADC");
> >  MODULE_LICENSE("GPL v2");  

