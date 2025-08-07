Return-Path: <linux-iio+bounces-22401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D033B1D89F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 15:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CD71AA10D1
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 13:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610FA25A2A2;
	Thu,  7 Aug 2025 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF9xhdhP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A72E36EC;
	Thu,  7 Aug 2025 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572189; cv=none; b=I3bx9C6Bf0ZIM4P26Cslf12Lmb8WVxcgIPoSJUn8BpIf4nJs9jopXtSRSqgdAhNvnihf6wa2Q082j8CgfHwLwcU407lqGmzr1fah7UPdwEeH6OOGiLEO+vr1KOW0mX5XNucTtGYuFz79fLDHPgp08CFt28+rluMA3RRGrXHE/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572189; c=relaxed/simple;
	bh=60f0HspwGwMFdmSTzD2KBC/tMa1Xtd0DilHBC581pJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukoOh7YR0wKRZStEW0vzGp6WWLr98yD3jyx6Pkt4LIbS+ibWcSKHFBpgafH1XgeRNhRhoStrn8UkMQtFxUDY9HQCYNfJTWbxgZFxb9mz7BS3F6QPHxTl7enaED5YJcmvmIo+o+xH9RCHdfaAeMNaLNJSBMgIUbt4flhEhqgiW58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eF9xhdhP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459ddf9019cso3667465e9.0;
        Thu, 07 Aug 2025 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754572185; x=1755176985; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t21oNJ2+kEwHVDNe/DBt9NKLDmLG4nx1kTuI1yhdKLE=;
        b=eF9xhdhPuLeMRpxNBANbdm2mZ1xnE4KnF2R5v52aFz0NOPn9toOFMuLjL6KkLvpDYH
         wweYh2D8C+3rS+Gpd1eX1+YmF6btcCrFfhNscI13lA66qkOS+EekpNVLfVjmSZLxQFSK
         wNOaet5xwEsxf9Bfvh7+y03PIQ26riEeyQZ5DPwp9RlW+YVwdGxeSloeKqxdtUpJKfSF
         6rJOxOtm5/ptfRGU6zmUXhH3xLnz7dSeBZDkHNeguqNUhRMUzi0HDLEBkYt39ODPI+SG
         jsjzyjU2tPaHD0IHDnSNEDOmbko/yMkoyDWny/Fy9Dhyic83rMFCCS3HkNlUu6UCKP/8
         VovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754572185; x=1755176985;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t21oNJ2+kEwHVDNe/DBt9NKLDmLG4nx1kTuI1yhdKLE=;
        b=fxn24JEKKsFFhULqEioSfYHVAqU5ASU5q6fQAj+GOLOQ3tNqFeKoNdI13EUaPkeQ0z
         gt4kW21qzOfiOAxM8+6xoGWnVldbhSxJzd0NtMqbO6b5gj9mshCdVheoiDc+6ES1lZO2
         GTiFPC2veTN4wqzLfw3CTukXkbpk3kiI8ujAW0mSsXFHJYgHJWeIgmoYmf9dFSWiD3Vl
         uCFzXe74pLvWixw9TaDCahk0QSgwDkZhuvLlIUa+nyMXij6oMkLetFYNR0WTPNB/VerP
         tgNbpZGkrwn23ToBxfQkWHKPJ+Yt03S9tWocWB8QdRt1XF1cGzjsq7ZOUNUi3n3sW4GQ
         wsrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLEfwruFh8e/mgsselSInheQ482IXe2rBrTztJaInXBeVmuKckUUv5jFpH/Yv2tCnk3FIM3SgKjgvn@vger.kernel.org, AJvYcCWrYVJDoohSVvUlBtYCdArNQCEQhBw+XWiMKNE7M8YlzFgVnjQLkK31SP2e/WyiV5qUCPJ6t0oSYazv@vger.kernel.org, AJvYcCXEO2YmzzMqz3EZCamTYav2fwE/a1x0yY0cOLomLom/rkYIEhRdxvMpKMCfn/TJWQxAy/YAcSYD10MBfnL1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+51dwEt4Lp99//mhuxaZOPhK8ZaUYCXdY5475y2Oif2q77tuB
	8ewFxk8eSz1TssvWAVhCyR7alKv1Azl/7Q3k+0CePIgKi/zKDOPPtLAn
X-Gm-Gg: ASbGncvY3kdnnC84m0KH+YgyWoQmgLTtSODcv7eTL1l7AZEw5eLkK7bDXto8qPXQWEC
	GeDx+s9vF1FO0uFApcYZhztWwlCXgcWPi1c+C7b+iUaiDt/ivI8LPuLq0xbe9iTZCslrn52NQrj
	tgbZzJbQJAgEGikLelDpXkYZJYyzcQh4kj5UzEtXczccPY8VB/PrJLZWUyby6tlDb05vKckEiuJ
	7ZPKdC/lfXJ0t9CUbcSOhLmKwmJJ/p0WFRsz4TXeWDxYFoTZBVPqpJZISg0+dPe93T7Z+YJ+lve
	3grBchIPOXFNhy8gpk4QVKlnc6V8/ObsW096W5PikXh0s59D/P4mgQlSlJuqSH3PlcFGXs38km8
	KLPmx8+TjUka63XS43knkvQ==
X-Google-Smtp-Source: AGHT+IEO9mb5h7m1yfmZXglvzVxbi25FeHRc2cxk1zk2vVJv/ksCknRQ5Qep3lXrYEZ8tCUKzAvMXA==
X-Received: by 2002:a05:600c:4fd5:b0:456:26a1:a0c1 with SMTP id 5b1f17b1804b1-459e70eeb5cmr73207005e9.17.1754572185368;
        Thu, 07 Aug 2025 06:09:45 -0700 (PDT)
Received: from nsa ([185.128.9.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459de91ea4csm146945685e9.10.2025.08.07.06.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:09:45 -0700 (PDT)
Date: Thu, 7 Aug 2025 14:10:01 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] iio: adc: ad7476: Drop convstart chan_spec
Message-ID: <ngcbj6p7vfakah5fqsxqjlmrcycpg5rxfrbh4s34fll2kb3zq2@eyesluawn5w2>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <09bf5e7973c37413ada950741e6e09c375e37c57.1754559149.git.mazziesaccount@gmail.com>
 <tc4od3jtqnj743naxefx5lxkha46wohuuvw46mik6nullvsqbe@knj4t23eaodw>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tc4od3jtqnj743naxefx5lxkha46wohuuvw46mik6nullvsqbe@knj4t23eaodw>

On Thu, Aug 07, 2025 at 01:41:31PM +0100, Nuno Sá wrote:
> On Thu, Aug 07, 2025 at 12:34:52PM +0300, Matti Vaittinen wrote:
> > The ad7476 driver defines separate chan_spec structures for operation
> > with and without convstart GPIO. At quick glance this may seem as if the
> > driver did provide more than 1 data-channel to users - one for the
> > regular data, other for the data obtained with the convstart GPIO.
> > 
> > The only difference between the 'convstart' and 'non convstart'
> > -channels is presence / absence of the BIT(IIO_CHAN_INFO_RAW) in
> > channel's flags.
> > 
> > We can drop the convstart channel spec, and related convstart macro, by
> > allocating a mutable per driver instance channel spec an adding the flag
> > in probe if needed. This will simplify the driver with the cost of added
> > memory consumption.
> > 
> > Assuming there aren't systems with very many ADCs and very few
> > resources, this tradeoff seems worth making.
> > 
> > Simplify the driver by dropping the 'convstart' channel spec and
> > allocating the chan spec for each driver instance.
> 
> I do not agree with this one. Looking at the diff, code does not look
> simpler to me...

Ok, on a second thought I'm ok with this. It makes adding devices easier
and (IIUC) for the one you're adding later we only have "convst_channel"
channels.

On comment though...

> 
> - Nuno Sá
> 
> > 
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > 
> > ---
> > Revision history:
> >  v1 => v2:
> >  - New patch
> > 
> > I considered squashing this change with the one limiting the chip_info
> > scope. Having this as a separate change should help reverting if someone
> > complains about the increased memory consumption though.
> > ---
> >  drivers/iio/adc/ad7476.c | 31 ++++++++++++++++++-------------
> >  1 file changed, 18 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > index e97742912b8e..a30eb016c11c 100644
> > --- a/drivers/iio/adc/ad7476.c
> > +++ b/drivers/iio/adc/ad7476.c
> > @@ -29,8 +29,6 @@ struct ad7476_state;
> >  struct ad7476_chip_info {
> >  	unsigned int			int_vref_mv;
> >  	struct iio_chan_spec		channel[2];
> > -	/* channels used when convst gpio is defined */
> > -	struct iio_chan_spec		convst_channel[2];
> >  	void (*reset)(struct ad7476_state *);
> >  	bool				has_vref;
> >  	bool				has_vdrive;
> > @@ -41,6 +39,7 @@ struct ad7476_state {
> >  	struct gpio_desc		*convst_gpio;
> >  	struct spi_transfer		xfer;
> >  	struct spi_message		msg;
> > +	struct iio_chan_spec		channel[2];
> >  	int				scale_mv;
> >  	/*
> >  	 * DMA (thus cache coherency maintenance) may require the
> > @@ -153,24 +152,18 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
> >  #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
> >  		BIT(IIO_CHAN_INFO_RAW))
> >  #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
> > -#define AD7091R_CONVST_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), \
> > -		BIT(IIO_CHAN_INFO_RAW))
> >  #define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
> >  		BIT(IIO_CHAN_INFO_RAW))
> >  
> >  static const struct ad7476_chip_info ad7091_chip_info = {
> >  	.channel[0] = AD7091R_CHAN(12),
> >  	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > -	.convst_channel[0] = AD7091R_CONVST_CHAN(12),
> > -	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> >  	.reset = ad7091_reset,
> >  };
> >  
> >  static const struct ad7476_chip_info ad7091r_chip_info = {
> >  	.channel[0] = AD7091R_CHAN(12),
> >  	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > -	.convst_channel[0] = AD7091R_CONVST_CHAN(12),
> > -	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> >  	.int_vref_mv = 2500,
> >  	.has_vref = true,
> >  	.reset = ad7091_reset,
> > @@ -282,7 +275,7 @@ static int ad7476_probe(struct spi_device *spi)
> >  	const struct ad7476_chip_info *chip_info;
> >  	struct ad7476_state *st;
> >  	struct iio_dev *indio_dev;
> > -	int ret;
> > +	int ret, i;
> >  
> >  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> >  	if (!indio_dev)
> > @@ -332,16 +325,28 @@ static int ad7476_probe(struct spi_device *spi)
> >  	if (IS_ERR(st->convst_gpio))
> >  		return PTR_ERR(st->convst_gpio);
> >  
> > +	/*
> > +	 * This will never realize. Unless someone changes the channel specs
> > +	 * in this driver. And if someone does, without changing the loop
> > +	 * below, then we'd better immediately produce a big fat error, before
> > +	 * the change proceeds from that developer's table.
> > +	 */
> > +	BUILD_BUG_ON(ARRAY_SIZE(st->channel) != ARRAY_SIZE(chip_info->channel));

I guess it make sense but still looks too fancy for this :)

> > +	for (i = 0; i < ARRAY_SIZE(st->channel); i++) {
> > +		st->channel[i] = chip_info->channel[i];
> > +		if (st->convst_gpio)

I would flip this an do:
	if (!st->convst_gpio)
		break;
		
> > +			st->channel[i].info_mask_separate |=
> > +				BIT(IIO_CHAN_INFO_RAW);
		
		__set_bit()...

- Nuno Sá

> > +	}
> > +
> >  	st->spi = spi;
> >  
> >  	indio_dev->name = spi_get_device_id(spi)->name;
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> > -	indio_dev->channels = chip_info->channel;
> > -	indio_dev->num_channels = 2;
> > +	indio_dev->channels = st->channel;
> > +	indio_dev->num_channels = ARRAY_SIZE(st->channel);
> >  	indio_dev->info = &ad7476_info;
> >  
> > -	if (st->convst_gpio)
> > -		indio_dev->channels = chip_info->convst_channel;
> >  	/* Setup default message */
> >  
> >  	st->xfer.rx_buf = &st->data;
> > -- 
> > 2.50.1
> > 
> 
> 

