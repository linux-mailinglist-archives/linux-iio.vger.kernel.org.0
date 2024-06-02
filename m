Return-Path: <linux-iio+bounces-5653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A77E8D779E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 21:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128151C20898
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 19:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3856F301;
	Sun,  2 Jun 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0jctvoX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6003262B6;
	Sun,  2 Jun 2024 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717357248; cv=none; b=qLqOc9i1zOyrZt9NhE0eUPna1dxT6umwUFTrVS2HGMEn49N6rNujdnzWByPVJAEQDXUkEtqiD3ysyvt9Be+Webjhh70Nw1Y+TOebV9Z4KD7xYXaOWiTot8NEXPeDDbhPiap6rmFCyhrR8gPUiF3WUyPgBQPmAJK3kyhFriW29kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717357248; c=relaxed/simple;
	bh=B2VgIlsViZs57tj2fSDvldLthYxPZ8KkrbbuQ7SvQ9U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxwfbLjs4g7rA7Jf2nIDlrOJkdHQg7g6JZSF3VS4ogFCZoPSB6WGZurwfhqNv5L4dQIUqnhIuX4D8L4ucEUelr9nlSpphyWfvBFRzUYAecOCn4z+jVh/+ye6DItU4UkTCQ4DN9SFdxeSd1Kq2t8Msn0/Gqdky7xF5eKdA9IBjqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0jctvoX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b936c958dso1342105e87.0;
        Sun, 02 Jun 2024 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717357245; x=1717962045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YZQ5jW+8VG+i6oC3GccbqmhN/bn0o76pBkEl22tOlts=;
        b=W0jctvoXGKnv4UxHhEUSIxPrA+EbDtG8QDTTInryfyxt6sv82pMoJcGzjobr1mWEyB
         AQI3a3tNHVQy8viR0fgUpXkSfG22BBNAbdjeYQ+sxe93uRLs9PJ2VixiR1irtzGkRMLe
         t8NdRoMIrwXNWVptK3gDXNXM9nLN7Fjs7SPOXVFI4Vx9150beBlyUQp3vADPm6FDjhMZ
         yJ+WwNnNSk6fS0AxLM7FWVMGKJsjLtiKj3ohMkIIBZxS66bcAMH3Awxq+PHz2RzIWaDG
         CNo/VTuuXxbOF9Y9z681no1XJVmdR8B2d+VFw5RTvXzLBEmztpRSK3VPbNw363iCvhTx
         Uq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717357245; x=1717962045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZQ5jW+8VG+i6oC3GccbqmhN/bn0o76pBkEl22tOlts=;
        b=SmxFMDy318MLJ1mg47/axNY5R9fOSlal+NECbA5M25bTVamxhNtnkjFrGf4+MXvUE4
         dmKiEZ4CrudE3bPb+x8Fu7mslyLALF5Z5TzBsLHhJCWU9LYggKATfiijALJKVk2ZPUGr
         jLtRyWyxKGjjxSvMcwI0YDhfJAYBWE2XlN0Np/Y8y8lny7LISiBcC/8yiimUpXJIwTa+
         X3+3xzaH9Wxz5P/LED3BSWVQEzdXPLCPDIrIT3UAXju7T2Ou2DO/g9ESneuwfTCMVoDQ
         m/vNO/ODMbfO1Udyb8mpFpbzIL/2OL3iIBo2GdXawZV9O32XvyVA0cZlHVGtMNg1BG3x
         pDcg==
X-Forwarded-Encrypted: i=1; AJvYcCXPDSJapERKiByGz+9IsoKMGo3/kWkyvU0YMBEX1G6w7SeHJ3GdKDzfoXfAyk5JZ5wbRxeLJIfJACPWqaWTdGFklnMcC9TPo2cnZUXPAKhutb6f5HiDDO+fb15fUWQs5KxU+ovtvsjo
X-Gm-Message-State: AOJu0YzkevBDWj9wTritdRziAGkz1tHl0wJM5Ai2/BC69FP+05IJJhsr
	w/Wfey+YpNp7s6UUSIrrr/eu04gP2tkxhGHJ+9dczR+fzaOzcNdfSe0QFg==
X-Google-Smtp-Source: AGHT+IElXkeLv81Nw6DWcSG9OurBo8XlxP703RRwvH95i36c4ia2xxVDsJ13/Jp2bO9oCS7cvXKVcg==
X-Received: by 2002:ac2:47e4:0:b0:529:b717:2a14 with SMTP id 2adb3069b0e04-52b8955c254mr4509420e87.14.1717357244639;
        Sun, 02 Jun 2024 12:40:44 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:add1:b1ad:7182:3e90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68cbb64834sm193225866b.1.2024.06.02.12.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:40:44 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 2 Jun 2024 21:40:42 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/17] iio: chemical: bme680: Modify startup procedure
Message-ID: <20240602194042.GF387181@vamoiridPC>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
 <20240527183805.311501-15-vassilisamir@gmail.com>
 <20240602140123.3dd1b793@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602140123.3dd1b793@jic23-huawei>

On Sun, Jun 02, 2024 at 02:01:23PM +0100, Jonathan Cameron wrote:
> On Mon, 27 May 2024 20:38:02 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Modify the startup procedure to reflect the procedure of
> > the Bosch BME68x Sensor API. The initial readings and
> > configuration of the sensor need to happen in the
> > following order:
> > 
> > 1) Read calibration data [1,2]
> > 2) Chip general configuration [3]
> > 3) Gas configuration [4]
> > 
> > After the chip configuration it is necessary to ensure that
> > the sensor is in sleeping mode, in order to apply the gas
> > configuration settings [5].
> > 
> > Also, after the soft reset, it is advised to wait for 5ms [6].
> > 
> > [1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L162
> > [2]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L44
> > [3]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L53
> > [4]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L60
> > [5]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L640
> > [6]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L294
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/chemical/bme680.h      |  2 ++
> >  drivers/iio/chemical/bme680_core.c | 27 ++++++++++++++++++---------
> >  2 files changed, 20 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> > index 17ea59253923..3be2f76a5bfb 100644
> > --- a/drivers/iio/chemical/bme680.h
> > +++ b/drivers/iio/chemical/bme680.h
> > @@ -61,6 +61,8 @@
> >  
> >  #define BME680_MEAS_TRIM_MASK			GENMASK(24, 4)
> >  
> > +#define BME680_STARTUP_TIME_US			5000
> > +
> >  /* Calibration Parameters */
> >  #define BME680_T2_LSB_REG	0x8A
> >  #define BME680_H2_MSB_REG	0xE1
> > diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> > index b055eeee8f1c..afaa43ec3241 100644
> > --- a/drivers/iio/chemical/bme680_core.c
> > +++ b/drivers/iio/chemical/bme680_core.c
> > @@ -505,10 +505,12 @@ static int bme680_chip_config(struct bme680_data *data)
> >  	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> >  				BME680_OSRS_TEMP_MASK | BME680_OSRS_PRESS_MASK,
> >  				osrs);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> >  		dev_err(dev, "failed to write ctrl_meas register\n");
> > +		return ret;
> > +	}
> >  
> > -	return ret;
> > +	return 0;
> >  }
> 
> I think this is an unrelated change so if you want to do this - different patch.
> 

Well, it is not completely unrelated. This function is only doing regmap_reads() 
and after every regmap in case of error it returns in the if statement that exists
after the regmap_read(). In the last check though, instead of exiting inside the if
statement it just sends a dev_err() message, exits the if() and then exits from
the last return. Functionality is the same, it is just not consistent. But I could
split it in 2 commits, no problem!

> >  
> >  static int bme680_gas_config(struct bme680_data *data)
> > @@ -517,6 +519,11 @@ static int bme680_gas_config(struct bme680_data *data)
> >  	int ret;
> >  	u8 heatr_res, heatr_dur;
> >  
> > +	/* Go to sleep */
> > +	ret = bme680_set_mode(data, false);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	heatr_res = bme680_calc_heater_res(data, data->heater_temp);
> >  
> >  	/* set target heater temperature */
> > @@ -847,6 +854,8 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
> >  		return ret;
> >  	}
> >  
> > +	usleep_range(BME680_STARTUP_TIME_US, BME680_STARTUP_TIME_US + 1000);
> > +
> >  	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &data->check);
> >  	if (ret < 0) {
> >  		dev_err(dev, "Error reading chip ID\n");
> > @@ -859,22 +868,22 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
> >  		return -ENODEV;
> >  	}
> >  
> > -	ret = bme680_chip_config(data);
> > +	ret = bme680_read_calib(data, &data->bme680);
> >  	if (ret < 0) {
> > -		dev_err(dev, "failed to set chip_config data\n");
> > +		dev_err(dev,
> > +			"failed to read calibration coefficients at probe\n");
> >  		return ret;
> 
> Maybe you have it in a later patch (it definitely wants to be a different patch from
> this one as different issue), but feels like a bunch of places where
> dev_err_probe() would be good.
> 

Well, since they are in the probe function I guess I could also change those to
dev_err_probe() in a separate commit.

Cheers,
Vasilis

> >  	}
> >  
> > -	ret = bme680_gas_config(data);
> > +	ret = bme680_chip_config(data);
> >  	if (ret < 0) {
> > -		dev_err(dev, "failed to set gas config data\n");
> > +		dev_err(dev, "failed to set chip_config data\n");
> >  		return ret;
> >  	}
> >  
> > -	ret = bme680_read_calib(data, &data->bme680);
> > +	ret = bme680_gas_config(data);
> >  	if (ret < 0) {
> > -		dev_err(dev,
> > -			"failed to read calibration coefficients at probe\n");
> > +		dev_err(dev, "failed to set gas config data\n");
> >  		return ret;
> >  	}
> >  
> 

