Return-Path: <linux-iio+bounces-4989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5678C380C
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 20:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9161F21FF8
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 18:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB244DA0C;
	Sun, 12 May 2024 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1GxZwwp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4F6482D7;
	Sun, 12 May 2024 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715539731; cv=none; b=hjP8NDjccKuMljVwJisPaPr0mwUEMsu0mGoXs9eyPoODidJmTYgcHvEHb3nEfMjZtPX+xY8ukTmDTdeOsO6cDHhat+6P07GfiKBUuWHSJtSZSodpSbNdIJGAiXKg2v+WdrCYQ7U6WVyyyRD3y/DJnpgdYVcIBmq5ETFrOOXxYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715539731; c=relaxed/simple;
	bh=/HWwEKu3IpWPshw7X/6VQSr47rSRSeOC7N3vPo9RirQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJPTo88T77cX9Wqhz0IMrx9CqZcD8lao31eNz8xST7DfJ3y6bPjGQzm16/d0PvbW9rr935zoUS2BKyyujkfbFXXdiciDeOEr3KeO52GQktAI6el8PGrMFPqSrH4p280WXYH3kPgmUM4GK9WOiOU3AbQ9YXD7GwhmhvGVXRyJgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1GxZwwp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34d96054375so2938780f8f.2;
        Sun, 12 May 2024 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715539728; x=1716144528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+O7lc5hMHtIfwmUATRwHmSVa4SUwxY0yRvu0c9x84Xw=;
        b=b1GxZwwpkNBnP7kJ7qbAzXcNzaXXUO0zkRX4+g6avVV8d37ZvSob7NX5X3I2gC5rwg
         5cbUZJODQzamgWCU8zgG3MSBz+39SrD28ObWeGyEOl9X7zxlS1K+IQOJ+KvWSfP+IBqL
         LiXsfc7XZiQrro7ND5eS/faDauYQ/5X+HSjQz53RM+N+hMCaDGkWw9WLeAdNz2a4uMhl
         pJT2PblJAQ5OoUtu9eCb47HdiofLckaf4Uab5AjPZ3PkJhTlVGdtt5tvpwCJknfnl5oS
         fJvmCOAfoJuHKevE3d13KxmEQeqRcIPbjMWGYDETsvkJDwBdVtBq/t5hJKFiFB8meGyM
         bUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715539728; x=1716144528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+O7lc5hMHtIfwmUATRwHmSVa4SUwxY0yRvu0c9x84Xw=;
        b=O6tKpF+aNcpoK+dhAfd5D3P+0SJasWZXrvv2YY91jCNivQYuiIhUBjvRCWIPfH461h
         A+nqICja5JcAVHJXZq4r0uXtK/osyBXzgpetwvAbU2ip92AXHpgS8/bbUO1XV6HJRZvG
         WWXANuKNbau5pqTdE6chvgj4sZPLyWwvxrMWRliFQAQjYaru+ErO/TJWySrCUA5obVcH
         HUkfmw09i4PjHzjEQPsYUubuwbeEseLxZOFRLswdzErrJBQrBQR3ZB3sgWHfGVqJ9TYm
         BuFZfMLcw/AEV1slJsOTx1g825M5gI4+4VDO5nXisEhEFG4DxBAip5u35FWmPhTV3E1y
         YJMA==
X-Forwarded-Encrypted: i=1; AJvYcCUFrJb2w2qEL+iJEX3BgNh220Bx+HT1P/GZdENoqf16QApS6WBkvRQ+IMaktptE4ibbtfb4tsKIcEpFoULxRS00sFVZiw5b78IRf0/mTc1KY4kuUXkxulN90LAzQZHVPSPnXbLIs0BU
X-Gm-Message-State: AOJu0Yzhq6Wx8XMuMA2hR+d2F4pIObdT00xOVWaMcrsggaOZiJz87mbJ
	e2ijv3UVrCOkHjx2JNQqFv/gyeATGkMsDrB+Gw/ZnThb5qBNkkzl
X-Google-Smtp-Source: AGHT+IFZZRx7INwQAaUoOaZ3/pvcDq1HolCznjRoUdO8X0NmJ+//CI8tyFsNl2EIfikBKMgfAmA9hg==
X-Received: by 2002:a05:6000:12d0:b0:34d:9639:79bc with SMTP id ffacd0b85a97d-3504a96a763mr6377956f8f.44.1715539727857;
        Sun, 12 May 2024 11:48:47 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:ce14:864c:436e:5c6d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfffsm9382955f8f.75.2024.05.12.11.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 11:48:47 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 12 May 2024 20:48:45 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/9] iio: pressure: bmp280: Add SCALE, RAW values in
 channels and refactorize them
Message-ID: <20240512184845.GB24095@vamoiridPC>
References: <20240508165207.145554-1-vassilisamir@gmail.com>
 <20240508165207.145554-9-vassilisamir@gmail.com>
 <20240512132914.34f2a571@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512132914.34f2a571@jic23-huawei>

On Sun, May 12, 2024 at 01:29:14PM +0100, Jonathan Cameron wrote:
> On Wed,  8 May 2024 18:52:06 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW channels in order
> > to be able to calculate the processed value with standard userspace
> > IIO tools. Can be used for triggered buffers as well.
> > 
> > Even though it is not a good design choice to have SCALE, RAW and
> > PROCESSED together, the PROCESSED channel is kept for ABI compatibility.
> > 
> > While at it, separate BMPxxx and BMExxx device channels since BME
> > supports also humidity measurements.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> num channels is now ARRAY_SIZE(xxx) for all of these rather than
> the previous trick of using the same array and different numbers of channels.
> 
> As such I think you can just replace the 2, 3 with ARRAY_SIZE(bmp280_channels)
> and ARRAY_SIZE(bme280_channels) which will give more obviously correct
> and maintainable code.
> 
> Jonathan
> 

Hi Jonathan!

Indeed, this is a very good addition!!!

Cheers,
Vasilis

> 
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 86 +++++++++++++++++++++++++++---
> >  1 file changed, 78 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 70ce37370ac6..3f8144a0355b 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -137,17 +137,45 @@ enum {
> >  static const struct iio_chan_spec bmp280_channels[] = {
> >  	{
> >  		.type = IIO_PRESSURE,
> > +		/* PROCESSED maintained for ABI backwards compatibility */
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > +				      BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> >  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> >  	},
> >  	{
> >  		.type = IIO_TEMP,
> > +		/* PROCESSED maintained for ABI backwards compatibility */
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > +				      BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> > +	},
> > +};
> > +
> > +static const struct iio_chan_spec bme280_channels[] = {
> > +	{
> > +		.type = IIO_PRESSURE,
> > +		/* PROCESSED maintained for ABI backwards compatibility */
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > +				      BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> > +	},
> > +	{
> > +		.type = IIO_TEMP,
> > +		/* PROCESSED maintained for ABI backwards compatibility */
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > +				      BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> >  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> >  	},
> >  	{
> >  		.type = IIO_HUMIDITYRELATIVE,
> > +		/* PROCESSED maintained for ABI backwards compatibility */
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > +				      BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> >  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> >  	},
> >  };
> > @@ -155,21 +183,20 @@ static const struct iio_chan_spec bmp280_channels[] = {
> >  static const struct iio_chan_spec bmp380_channels[] = {
> >  	{
> >  		.type = IIO_PRESSURE,
> > +		/* PROCESSED maintained for ABI backwards compatibility */
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > +				      BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> >  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> >  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >  					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> >  	},
> >  	{
> >  		.type = IIO_TEMP,
> > +		/* PROCESSED maintained for ABI backwards compatibility */
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > -				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> > -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > -					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> > -	},
> > -	{
> > -		.type = IIO_HUMIDITYRELATIVE,
> > -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > +				      BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> >  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> >  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >  					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> > @@ -537,6 +564,49 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
> >  		default:
> >  			return -EINVAL;
> >  		}
> > +	case IIO_CHAN_INFO_RAW:
> > +		switch (chan->type) {
> > +		case IIO_HUMIDITYRELATIVE:
> > +			ret = data->chip_info->read_humid(data, &chan_value);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val = chan_value;
> > +			return IIO_VAL_INT;
> > +		case IIO_PRESSURE:
> > +			ret = data->chip_info->read_press(data, &chan_value);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val = chan_value;
> > +			return IIO_VAL_INT;
> > +		case IIO_TEMP:
> > +			ret = data->chip_info->read_temp(data, &chan_value);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val = chan_value;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->type) {
> > +		case IIO_HUMIDITYRELATIVE:
> > +			*val = data->chip_info->humid_coeffs[0];
> > +			*val2 = data->chip_info->humid_coeffs[1];
> > +			return data->chip_info->humid_coeffs_type;
> > +		case IIO_PRESSURE:
> > +			*val = data->chip_info->press_coeffs[0];
> > +			*val2 = data->chip_info->press_coeffs[1];
> > +			return data->chip_info->press_coeffs_type;
> > +		case IIO_TEMP:
> > +			*val = data->chip_info->temp_coeffs[0];
> > +			*val2 = data->chip_info->temp_coeffs[1];
> > +			return data->chip_info->temp_coeffs_type;
> > +		default:
> > +			return -EINVAL;
> > +		}
> >  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> >  		switch (chan->type) {
> >  		case IIO_HUMIDITYRELATIVE:
> > @@ -903,7 +973,7 @@ const struct bmp280_chip_info bme280_chip_info = {
> >  	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
> >  	.regmap_config = &bmp280_regmap_config,
> >  	.start_up_time = 2000,
> > -	.channels = bmp280_channels,
> > +	.channels = bme280_channels,
> >  	.num_channels = 3,
> >  
> >  	.oversampling_temp_avail = bmp280_oversampling_avail,
> 

