Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C0811F892
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 16:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfLOPnW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 10:43:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfLOPnW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Dec 2019 10:43:22 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9328F206E0;
        Sun, 15 Dec 2019 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576424601;
        bh=w/1w2CSjcG8E0nrmqQ36AgipbA2Tq99pvBzkPq64Hp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k65LwjU2OjtKLNMNPsM2wZAnm+bG313f4Z6OOKy9mSTTb+DyH/c2qy43YvTRt+egs
         yNiOo2409sH6WeDf8w3UJzw4BD7dz9gNtkmPrPqDLpdvwDGKIFk73BX1vz4S/jOKV5
         0WoP/t3bVAHLLvIDa5NkuBcVrB8CqGuiEq4vjtqM=
Date:   Sun, 15 Dec 2019 15:43:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2 4/4] iio: adc: ad7923: Add support for the
 ad7908/ad7918/ad7928
Message-ID: <20191215154316.158c341d@archlinux>
In-Reply-To: <e3e9d03c9679144612f5949eb32565e9b8f119d7.camel@analog.com>
References: <20191210150811.3429-1-djunho@gmail.com>
        <20191210150811.3429-5-djunho@gmail.com>
        <e3e9d03c9679144612f5949eb32565e9b8f119d7.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Dec 2019 07:46:04 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2019-12-10 at 12:08 -0300, Daniel Junho wrote:
> > [External]
> > 
> > The ad7928 is software compatible with the ad7923.
> > The ad7908 and ad7918 are the 8 and 10-bit versions of the ad7928.
> >   
> 
> The patch looks good.
> Comments mostly about namimg.
> One about channel numbers.
> 
> 
> > Signed-off-by: Daniel Junho <djunho@gmail.com>
> > ---
> >  drivers/iio/adc/ad7923.c | 62 +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 51 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> > index 6d56fa0b9e30..ae807fcaad76 100644
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
> > @@ -29,11 +29,14 @@
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
> > +#define AD7923_SEQUENCE_SHADOW	(0x01)		/* use the shadow
> > register
> > +						 * for programming
> > +						 * (only AD7908/7918/7928)  
> 
> 
> [1] Since this reg is only available on these 3 chips, you could rename
> this to AD7908_SEQUENCE_SHADOW  and use it for these 3 chips only.
> That way, you don't need to mention via comment "(only AD7908/7918/7928)"
> 
> 
> > +						 */
> > +#define AD7923_SEQUENCE_PROTECT	(0x10)		/* no interrupt
> > write cycle */
> > +#define AD7923_SEQUENCE_ON	(0x11)		/* continuous sequence */
> >  
> >  #define AD7923_PM_MODE_WRITE(mode)	((mode) << 4)	 /* write mode */
> >  #define AD7923_CHANNEL_WRITE(channel)	((channel) << 6) /* write
> > channel */
> > @@ -74,6 +77,9 @@ enum ad7923_id {
> >  	AD7904,
> >  	AD7914,
> >  	AD7924,
> > +	AD7908,
> > +	AD7918,
> > +	AD7928
> >  };
> >  
> >  #define AD7923_V_CHAN(index, bits)					\
> > @@ -93,7 +99,7 @@ enum ad7923_id {
> >  		},							\
> >  	}
> >  
> > -#define DECLARE_AD7923_CHANNELS(name, bits) \
> > +#define DECLARE_AD7923_4CHANNELS(name, bits) \
> >  const struct iio_chan_spec name ## _channels[] = { \
> >  	AD7923_V_CHAN(0, bits), \
> >  	AD7923_V_CHAN(1, bits), \
> > @@ -102,9 +108,25 @@ const struct iio_chan_spec name ## _channels[] = { \
> >  	IIO_CHAN_SOFT_TIMESTAMP(4), \
> >  }
> >  
> > -static DECLARE_AD7923_CHANNELS(ad7904, 8);
> > -static DECLARE_AD7923_CHANNELS(ad7914, 10);
> > -static DECLARE_AD7923_CHANNELS(ad7924, 12);
> > +#define DECLARE_AD7923_8CHANNELS(name, bits) \  
> 
> Same comments as [1], you could leave DECLARE_AD7923_CHANNELS and declare
> DECLARE_AD7908_CHANNELS which has 8 channels and use for the 3 new chips.
> 
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
> > +static DECLARE_AD7923_4CHANNELS(ad7904, 8);
> > +static DECLARE_AD7923_4CHANNELS(ad7914, 10);
> > +static DECLARE_AD7923_4CHANNELS(ad7924, 12);
> > +static DECLARE_AD7923_8CHANNELS(ad7908, 8);
> > +static DECLARE_AD7923_8CHANNELS(ad7918, 10);
> > +static DECLARE_AD7923_8CHANNELS(ad7928, 12);
> >  
> >  static const struct ad7923_chip_info ad7923_chip_info[] = {
> >  	[AD7904] = {
> > @@ -119,6 +141,18 @@ static const struct ad7923_chip_info
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
> > @@ -131,7 +165,7 @@ static int ad7923_update_scan_mode(struct iio_dev
> > *indio_dev,
> >  	int i, cmd, len;
> >  
> >  	len = 0;
> > -	for_each_set_bit(i, active_scan_mask, AD7923_MAX_CHAN) {
> > +	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels - 1)   
> 
> I got the idea about 'indio_dev->num_channel - 1'.
> This makes the assumption that the number of IIO channels is always HW-
> channels + 1 timestamp channel [which for now is true].
> I'm not sure if this is ok.
> 
> I think Jonathan would be a bit better here to comment.

It is a driver specific assumption so we don't need it to be true
in general.  Perhaps add a comment along the lines of
/* 
 * For this driver the last channel is always the software timestamp so
 * skip that one.
 */


> 
> > {
> >  		cmd = AD7923_WRITE_CR | AD7923_CHANNEL_WRITE(i) |
> >  			AD7923_SEQUENCE_WRITE(AD7923_SEQUENCE_OFF) |
> >  			st->settings;
> > @@ -344,6 +378,9 @@ static const struct spi_device_id ad7923_id[] = {
> >  	{"ad7914", AD7914},
> >  	{"ad7923", AD7924},
> >  	{"ad7924", AD7924},
> > +	{"ad7908", AD7908},
> > +	{"ad7918", AD7918},
> > +	{"ad7928", AD7928},
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(spi, ad7923_id);
> > @@ -353,6 +390,9 @@ static const struct of_device_id ad7923_of_match[] =
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
> > @@ -370,5 +410,5 @@ module_spi_driver(ad7923_driver);
> >  
> >  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> >  MODULE_AUTHOR("Patrick Vasseur <patrick.vasseur@c-s.fr>");
> > -MODULE_DESCRIPTION("Analog Devices AD7904/AD7914/AD7923/AD7924 ADC");
> > +MODULE_DESCRIPTION("Analog Devices
> > AD7904/AD7914/AD7923/AD7924/AD7908/AD7918/AD7928 ADC");  
> 
> This description is becoming long.
> Maybe simplify to 
> MODULE_DESCRIPTION("Analog Devices AD7923 and similar ADC");
> 
> >  MODULE_LICENSE("GPL v2");  

