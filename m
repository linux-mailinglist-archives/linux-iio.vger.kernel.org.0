Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC123FAD31
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 18:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhH2QoI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 12:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhH2QoI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Aug 2021 12:44:08 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AB0C061575;
        Sun, 29 Aug 2021 09:43:15 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id 2so5210922qtw.1;
        Sun, 29 Aug 2021 09:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1lslXtKd5SxVq+3ls5uH31YZmLPDz+1SD/78XMweCEo=;
        b=UJHnwIkvHdHr3/7Lc1bNuM4083eIapUh2zQyhOEzunSiMF5+PirQE1HOE+xzdIeP+J
         YOoLgUqmHlk107p3A+Pi/TZz3IjaadGwlhLZwA+mIXuAA9BYHd1EWc3aBpkOj+/X71kJ
         eKpVdCH33Qyp9XC9LgdFTwWJqZ3Zx/L/NTA9BI9Oq9suA4jCJQUwoM4Zoi9o9DLqhcW1
         tICJ5hkr7LHQ5//y7H1twFKfZ7pQYlTQH25xgwhRbt2vyC9YSSF2yvQE27NKq32N+Aek
         EkGhTLkn4bg66SN1IQ+k1L8GdizqGjRyvQF+xD9ZyTi1EfTt685FBYo0ElIELSeNP8ad
         3yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1lslXtKd5SxVq+3ls5uH31YZmLPDz+1SD/78XMweCEo=;
        b=F8/vHlc/M/Z7VeNuAO9S+ipB0dxG+ifBjkoeLBXBQ8U3nx3BRkerMFValiZ1q6zV5x
         d+as/EHl+HOPAtKqoJ+GfP3DSOrN7ooO2ZVh90/G0fkchyq4loaO63Qy9mYCuysQbvWH
         spfh6vXnYEAjA4epamlIro4v2COsgmS46jX6ysNuOMyIga9yWr4O3rPjmU6TAv3xnL2d
         Xz/HiDYr7RKCwYMlwqFhr3DqLxUjwU5CzDKploD9ImV5M15vFyaFITUKdEgjCIlFcTao
         4OmnYyvEg4hYSx3vsBbN7Gqp5DfD36jQ7JfvCjnxOcNBg+bCsKmNjIoHY/2pbPgiUfbG
         0R0A==
X-Gm-Message-State: AOAM530bEGtfGe0Vv9YcDVYUDqnxFfoR0sqZ90HeeDWyG/folZTJkZpp
        jbZS8EIhit6KYi8swWBUiZI=
X-Google-Smtp-Source: ABdhPJz7zDoZta+hAamxOebyN80EhXoxzV0SYUtbj9T4cYDKs7w0xl7XV0spzGuZsVZlwZ8eOWIiyw==
X-Received: by 2002:ac8:7b47:: with SMTP id m7mr17189552qtu.178.1630255395008;
        Sun, 29 Aug 2021 09:43:15 -0700 (PDT)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f28sm9195061qkk.10.2021.08.29.09.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 09:43:14 -0700 (PDT)
Date:   Sun, 29 Aug 2021 12:43:12 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v6 2/5] iio: adc: ad7949: fix spi messages on non 14-bit
 controllers
Message-ID: <YSu5IBF9e0eeUp7U@shaak>
References: <20210815213309.2847711-1-liambeguin@gmail.com>
 <20210815213309.2847711-3-liambeguin@gmail.com>
 <20210829153334.07f5c64c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829153334.07f5c64c@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 29, 2021 at 03:33:34PM +0100, Jonathan Cameron wrote:
> On Sun, 15 Aug 2021 17:33:06 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
> 
> > From: Liam Beguin <lvb@xiphos.com>
> > 
> > This driver supports devices with 14-bit and 16-bit sample sizes.
> > This implies different SPI transfer lengths which are not always handled
> > properly by some SPI controllers.
> > 
> > To work around this limitation, define a big endian buffer used to split
> > the buffer into two 8-bit messages in the event that the controller
> > doesn't support 14-bit or 16-bit transfers.
> > A separate buffer is introduced here to avoid performing operations on
> > types of different endianness.
> > 
> > Since all transfers use the same bits_per_word value, move that logic to
> > the probe function, and let transfers default to the value defined in
> > the struct spi_device.
> > 
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> Hi Liam, 
> 
Hi Jonathan,

> I changed the title of this one to avoid it being picked up for automated
> backporting.  I don't mind if you want to request it is backported explicitly
> but it isn't a regression fix (as it never worked on such controllers) and
> is non trivial.  As a result I want a backport to be a deliberate decision.
> Now titled "iio: adc: ad7949: enable use with non 14/16-bit controllers"
> 

That makes sense! I'll be more careful of that in the future.

Thanks,
Liam

> This and previous applied to the togreg branch of iio.git and pushed out
> as testing for 0-day to poke at it.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/ad7949.c | 86 +++++++++++++++++++++++++++-------------
> >  1 file changed, 58 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index adc4487a7d56..a263d0fcec75 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -14,7 +14,6 @@
> >  #include <linux/bitfield.h>
> >  
> >  #define AD7949_CFG_MASK_TOTAL		GENMASK(13, 0)
> > -#define AD7949_CFG_REG_SIZE_BITS	14
> >  
> >  /* CFG: Configuration Update */
> >  #define AD7949_CFG_MASK_OVERWRITE	BIT(13)
> > @@ -71,6 +70,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
> >   * @cfg: copy of the configuration register
> >   * @current_channel: current channel in use
> >   * @buffer: buffer to send / receive data to / from device
> > + * @buf8b: be16 buffer to exchange data with the device in 8-bit transfers
> >   */
> >  struct ad7949_adc_chip {
> >  	struct mutex lock;
> > @@ -81,27 +81,34 @@ struct ad7949_adc_chip {
> >  	u16 cfg;
> >  	unsigned int current_channel;
> >  	u16 buffer ____cacheline_aligned;
> > +	__be16 buf8b;
> >  };
> >  
> >  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
> >  				u16 mask)
> >  {
> >  	int ret;
> > -	int bits_per_word = ad7949_adc->resolution;
> > -	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
> > -	struct spi_message msg;
> > -	struct spi_transfer tx[] = {
> > -		{
> > -			.tx_buf = &ad7949_adc->buffer,
> > -			.len = 2,
> > -			.bits_per_word = bits_per_word,
> > -		},
> > -	};
> >  
> >  	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
> > -	ad7949_adc->buffer = ad7949_adc->cfg << shift;
> > -	spi_message_init_with_transfers(&msg, tx, 1);
> > -	ret = spi_sync(ad7949_adc->spi, &msg);
> > +
> > +	switch (ad7949_adc->spi->bits_per_word) {
> > +	case 16:
> > +		ad7949_adc->buffer = ad7949_adc->cfg << 2;
> > +		ret = spi_write(ad7949_adc->spi, &ad7949_adc->buffer, 2);
> > +		break;
> > +	case 14:
> > +		ad7949_adc->buffer = ad7949_adc->cfg;
> > +		ret = spi_write(ad7949_adc->spi, &ad7949_adc->buffer, 2);
> > +		break;
> > +	case 8:
> > +		/* Here, type is big endian as it must be sent in two transfers */
> > +		ad7949_adc->buf8b = cpu_to_be16(ad7949_adc->cfg << 2);
> > +		ret = spi_write(ad7949_adc->spi, &ad7949_adc->buf8b, 2);
> > +		break;
> > +	default:
> > +		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
> > +		return -EINVAL;
> > +	}
> >  
> >  	/*
> >  	 * This delay is to avoid a new request before the required time to
> > @@ -116,16 +123,6 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >  {
> >  	int ret;
> >  	int i;
> > -	int bits_per_word = ad7949_adc->resolution;
> > -	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
> > -	struct spi_message msg;
> > -	struct spi_transfer tx[] = {
> > -		{
> > -			.rx_buf = &ad7949_adc->buffer,
> > -			.len = 2,
> > -			.bits_per_word = bits_per_word,
> > -		},
> > -	};
> >  
> >  	/*
> >  	 * 1: write CFG for sample N and read old data (sample N-2)
> > @@ -144,9 +141,11 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >  	}
> >  
> >  	/* 3: write something and read actual data */
> > -	ad7949_adc->buffer = 0;
> > -	spi_message_init_with_transfers(&msg, tx, 1);
> > -	ret = spi_sync(ad7949_adc->spi, &msg);
> > +	if (ad7949_adc->spi->bits_per_word == 8)
> > +		ret = spi_read(ad7949_adc->spi, &ad7949_adc->buf8b, 2);
> > +	else
> > +		ret = spi_read(ad7949_adc->spi, &ad7949_adc->buffer, 2);
> > +
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -158,7 +157,25 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >  
> >  	ad7949_adc->current_channel = channel;
> >  
> > -	*val = ad7949_adc->buffer & mask;
> > +	switch (ad7949_adc->spi->bits_per_word) {
> > +	case 16:
> > +		*val = ad7949_adc->buffer;
> > +		/* Shift-out padding bits */
> > +		*val >>= 16 - ad7949_adc->resolution;
> > +		break;
> > +	case 14:
> > +		*val = ad7949_adc->buffer & GENMASK(13, 0);
> > +		break;
> > +	case 8:
> > +		/* Here, type is big endian as data was sent in two transfers */
> > +		*val = be16_to_cpu(ad7949_adc->buf8b);
> > +		/* Shift-out padding bits */
> > +		*val >>= 16 - ad7949_adc->resolution;
> > +		break;
> > +	default:
> > +		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
> > +		return -EINVAL;
> > +	}
> >  
> >  	return 0;
> >  }
> > @@ -266,6 +283,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
> >  
> >  static int ad7949_spi_probe(struct spi_device *spi)
> >  {
> > +	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
> >  	struct device *dev = &spi->dev;
> >  	const struct ad7949_adc_spec *spec;
> >  	struct ad7949_adc_chip *ad7949_adc;
> > @@ -292,6 +310,18 @@ static int ad7949_spi_probe(struct spi_device *spi)
> >  	indio_dev->num_channels = spec->num_channels;
> >  	ad7949_adc->resolution = spec->resolution;
> >  
> > +	/* Set SPI bits per word */
> > +	if (spi_ctrl_mask & SPI_BPW_MASK(ad7949_adc->resolution)) {
> > +		spi->bits_per_word = ad7949_adc->resolution;
> > +	} else if (spi_ctrl_mask == SPI_BPW_MASK(16)) {
> > +		spi->bits_per_word = 16;
> > +	} else if (spi_ctrl_mask == SPI_BPW_MASK(8)) {
> > +		spi->bits_per_word = 8;
> > +	} else {
> > +		dev_err(dev, "unable to find common BPW with spi controller\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	ad7949_adc->vref = devm_regulator_get(dev, "vref");
> >  	if (IS_ERR(ad7949_adc->vref)) {
> >  		dev_err(dev, "fail to request regulator\n");
> 
