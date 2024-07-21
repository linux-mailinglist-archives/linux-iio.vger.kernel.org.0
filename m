Return-Path: <linux-iio+bounces-7774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE83B93866E
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 00:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5DB1F213A2
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 22:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF3E16A94F;
	Sun, 21 Jul 2024 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlnBBtKn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B4216631C;
	Sun, 21 Jul 2024 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721599923; cv=none; b=dP9iNwTzMcrpVK7WrDip9qZ5+6BcQ6upNPcw6CnCOY4fspyxm57xyJkjdK9XvzPr7zbC66yBXqoGLMPElQ2jj1T2zSVlCtIpMiqw4p+kCFFQzk+S0jWZlkxfm/BgYHDfA6aK1o0d1/nw9t9CqQs2Bfa9lcw0z4a5SRWOrAfbMy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721599923; c=relaxed/simple;
	bh=I8qIudDFLW3iFfOEfQ/6z054stLUaEBKK2trw0HdST8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQSX7Q0YjKHwqTeCdwYfrNLC3GqfnXl2h0Eu0rbNKGtSdrZMTtNGahsu8fzyn8e3GcfZqJLILDpOq8H7KIg/feT9/7Cnaph7x32+/9YIogu7EvJKSp8W89otquhTMXjTABCGiVk5FS9zKZXl8uswlPxbDOL4R5KTpHtB8vu+3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlnBBtKn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf858so1868530a12.1;
        Sun, 21 Jul 2024 15:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721599920; x=1722204720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1rXKSpoeDmuCbvzv3Y7fKqy+K9qvWRQ5j+Oes+ywSDE=;
        b=mlnBBtKnFcFKeJomaAyBEFGgi5YYDnTjxSmsi8c0gtRL83eL2qlfE//qzXkalr5nKy
         Os+4pho87YNX2/IGc/2/NoTojiLEkamEUl9lJ5ornaEshHQzLcMgo8s/o5IWHsUMNZ9G
         jApPSlJrjJ09kK9UzI8AHYAiQzAGCNBErNw0GD/gKFprs2a7XwBA+D+G5yYb0OA/MlDl
         0f94YglEVa1Obyait0U0TWVu/qIb62p42La4txDPhNO7dkwbs0B7gSi075Q1p6ovQ7GO
         H8sMmWequdcp5WaSLWVyjXk9uxuXnGB2D6whH7vx6bD1h+QXShwJubIbH6V69I1koHqp
         gl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721599920; x=1722204720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rXKSpoeDmuCbvzv3Y7fKqy+K9qvWRQ5j+Oes+ywSDE=;
        b=qvaK2hZeL3zP2K0Yi97dh76Ny9G4GYENJ9cd3TucE4GP6AWGNAr/V8MHgklzWTi6Lg
         fkjDLgITWp6d9bPZeBC8uKrqNDOv7gU/IOuvKZ0eWhfl0DudmSZz+1hDrPqxVmv6t30U
         eeb6iJvpuzkefuAls5+ElN8uDuH4Scmwe2V+VqrStJe0sy1PkeqLy7SuOTPyKPzB2yyg
         sN+kFDZgD62YJ41qswQnbgxVdz5bTLEcPqC84+IBkxbREoDy8yMPY0zJ4CUXuWY6I4nq
         /JV+j6mS5E+WXjxM/ONnBa1h/f2Hz6gYvP1iFhIJLfhpOlB8j9Rerq1r5W6A8qT91i3o
         x3CA==
X-Forwarded-Encrypted: i=1; AJvYcCWTFRQdjeiX6Fo6FS4Qcq81N4bxG3Pc4gTqCi+SKCIYddw5iSZYCLiuDkJWY5MoHhrM3qT7uMPesrZl90dhwSmQ9FjwNnR2fTlJ3xqODZE5jqE07p9cLfTjB1biWYRc3zfcjUuGmdrZR7xHnFQQ63i8Qua8VtfFGd3Oa4oHd1iXfpDJcw==
X-Gm-Message-State: AOJu0Yxccp8AlIT0HehAoAlK1zqfXIU22k2upM14HHULKxKgr2S1U+52
	7Hwak1rqPI0QHuNrLa7LjIzJ2rxUMwBP4mQL6IfVcnvbFw/DCAcX
X-Google-Smtp-Source: AGHT+IHnjNci52L7HCHCwQcbZPPWo7blU7sM44xuAbcGRU2DAypPW3Kwg+9rlGETeJfB+ApUgI7Onw==
X-Received: by 2002:a17:906:6a2a:b0:a77:cf9d:f498 with SMTP id a640c23a62f3a-a7a4c034e10mr291649566b.40.1721599919378;
        Sun, 21 Jul 2024 15:11:59 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:bc21:fb27:f4e6:6867])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c8becddsm338868166b.137.2024.07.21.15.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 15:11:58 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 22 Jul 2024 00:11:56 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/10] iio: pressure: bmp280: Use sleep and forced
 mode for oneshot captures
Message-ID: <20240721221156.GD325365@vamoiridPC>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
 <20240711211558.106327-8-vassilisamir@gmail.com>
 <20240720122802.2c899ee7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720122802.2c899ee7@jic23-huawei>

On Sat, Jul 20, 2024 at 12:28:02PM +0100, Jonathan Cameron wrote:
> On Thu, 11 Jul 2024 23:15:55 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > This commit adds forced mode support in sensors BMP28x, BME28x, BMP3xx
> > and BMP58x. Sensors BMP18x and BMP085 are old and do not support this
> > feature so their operation is not affected at all.
> > 
> > Essentially, up to now, the rest of the sensors were used in normal mode
> > all the time. This means that they are continuously doing measurements
> > even though these measurements are not used. Even though the sensor does
> > provide PM support, to cover all the possible use cases, the sensor needs
> > to go into sleep mode and wake up whenever necessary.
> > 
> > This commit, adds sleep and forced mode support. Essentially, the sensor
> > sleeps all the time except for when a measurement is requested. When there
> > is a request for a measurement, the sensor is put into forced mode, starts
> > the measurement and after it is done we read the output and we put it again
> > in sleep mode.
> > 
> > For really fast and more deterministic measurements, the triggered buffer
> > interface can be used, since the sensor is still used in normal mode for
> > that use case.
> > 
> > This commit does not add though support for DEEP STANDBY, Low Power NORMAL
> > and CONTINUOUS modes, supported only by the BMP58x version.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> Various minor comments inline.
> 
> Thanks,
> 
> Jonathan
> 

Hi Jonathan,

Thanks again for the amazing feedback!

My answers inline.

Cheers,
Vasilis
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 276 +++++++++++++++++++++++++++--
> >  drivers/iio/pressure/bmp280.h      |  12 ++
> >  2 files changed, 269 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 9c99373d66ec..fc8d42880eb8 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -145,6 +145,12 @@ enum bmp280_scan {
> >  	BME280_HUMID,
> >  };
> >  }
> >  
> > +static int bmp280_set_mode(struct bmp280_data *data, u8 mode)
> > +{
> > +	int ret;
> > +
> > +	switch (mode) {
> > +	case BMP280_SLEEP:
> > +		ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> > +					BMP280_MODE_MASK, BMP280_MODE_SLEEP);
> 
> Use a local variable for the BMP280_MODE_* and then have the regmap_write_bits()
> after the switch statement.
> 
> Could even make it a const data look up given you are getting a value
> based on the enum.
> 

I like a lot both approaches, I feel like the const array one I like it more.

> > +		break;
> > +	case BMP280_FORCED:
> > +		ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> > +					BMP280_MODE_MASK, BMP280_MODE_FORCED);
> > +		break;
> > +	case BMP280_NORMAL:
> > +		ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> > +					BMP280_MODE_MASK, BMP280_MODE_NORMAL);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to  write ctrl_meas register\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int bmp280_wait_conv(struct bmp280_data *data)
> > +{
> > +	unsigned int reg;
> > +	int ret, meas_time;
> > +
> > +	meas_time = BMP280_MEAS_OFFSET;
> > +
> > +	if (data->oversampling_humid)
> > +		meas_time += (1 << data->oversampling_humid) * BMP280_MEAS_DUR +
> > +			       BMP280_PRESS_HUMID_MEAS_OFFSET;
> Add a comment on why, if oversampling_humid is not set we end up with
> no time for measuring humidity.  The MEAS_OFFSET is less than one MEAS_DUR
> so not it's not a case of that already incorporating the time.
> 

This is a check for if we use the BME280 or the BMP280 since humidity is a
feature of only the BME280 sensor. I should add it, thanks.

> 
> > +
> > +	/* Pressure measurement time */
> > +	meas_time += (1 << data->oversampling_press) * BMP280_MEAS_DUR +
> > +		      BMP280_PRESS_HUMID_MEAS_OFFSET;
> > +
> > +	/* Temperature measurement time */
> > +	meas_time += (1 << data->oversampling_temp) * BMP280_MEAS_DUR;
> > +
> > +	usleep_range(meas_time, meas_time * 12 / 10);
> > +
> > +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to read status register\n");
> > +		return ret;
> > +	}
> > +	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
> > +		dev_err(data->dev, "Measurement cycle didn't complete\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int bmp280_chip_config(struct bmp280_data *data)
> >  {
> >  	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
> > @@ -994,7 +1078,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
> >  				BMP280_OSRS_TEMP_MASK |
> >  				BMP280_OSRS_PRESS_MASK |
> >  				BMP280_MODE_MASK,
> > -				osrs | BMP280_MODE_NORMAL);
> > +				osrs | BMP280_MODE_SLEEP);
> >  	if (ret) {
> >  		dev_err(data->dev, "failed to write ctrl_meas register\n");
> >  		return ret;
> > @@ -1100,6 +1184,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
> >  	.read_temp = bmp280_read_temp,
> >  	.read_press = bmp280_read_press,
> >  	.read_calib = bmp280_read_calib,
> > +	.set_mode = bmp280_set_mode,
> > +	.wait_conv = bmp280_wait_conv,
> >  	.preinit = bmp280_preinit,
> >  
> >  	.trigger_handler = bmp280_trigger_handler,
> > @@ -1218,6 +1304,8 @@ const struct bmp280_chip_info bme280_chip_info = {
> >  	.read_press = bmp280_read_press,
> >  	.read_humid = bme280_read_humid,
> >  	.read_calib = bme280_read_calib,
> > +	.set_mode = bmp280_set_mode,
> > +	.wait_conv = bmp280_wait_conv,
> >  	.preinit = bmp280_preinit,
> >  
> >  	.trigger_handler = bme280_trigger_handler,
> > @@ -1505,6 +1593,75 @@ static int bmp380_preinit(struct bmp280_data *data)
> >  	return bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
> >  }
> >  
> > +static int bmp380_set_mode(struct bmp280_data *data, u8 mode)
> > +{
> > +	int ret;
> > +
> > +	switch (mode) {
> > +	case BMP280_SLEEP:
> > +		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> > +					BMP380_MODE_MASK,
> > +					FIELD_PREP(BMP380_MODE_MASK,
> > +						   BMP380_MODE_SLEEP));
> As above. I'd use a local variable to stash the MODE* that you are going
> to write or just look it up in a const array.
> 

Ack.

> > +		break;
> > +	case BMP280_FORCED:
> > +		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> > +					BMP380_MODE_MASK,
> > +					FIELD_PREP(BMP380_MODE_MASK,
> > +						   BMP380_MODE_FORCED));
> > +		break;
> > +	case BMP280_NORMAL:
> > +		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> > +					BMP380_MODE_MASK,
> > +					FIELD_PREP(BMP380_MODE_MASK,
> > +						   BMP380_MODE_NORMAL));
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to  write power control register\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int bmp380_wait_conv(struct bmp280_data *data)
> > +{
> > +	unsigned int reg;
> > +	int ret, meas_time;
> > +
> > +	/* Offset measurement time */
> > +	meas_time = BMP380_MEAS_OFFSET;
> > +
> > +	/* Pressure measurement time */
> > +	meas_time += (1 << data->oversampling_press) * BMP380_MEAS_DUR +
> > +		      BMP380_PRESS_MEAS_OFFSET;
> > +
> > +	/* Temperature measurement time */
> > +	meas_time += (1 << data->oversampling_temp) * BMP380_MEAS_DUR +
> > +		      BMP380_TEMP_MEAS_OFFSET;
> > +
> > +	usleep_range(meas_time, meas_time * 12 / 10);
> > +
> > +	ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to read status register\n");
> > +		return ret;
> > +	}
> > +
> > +	if (!(reg & BMP380_STATUS_DRDY_PRESS_MASK) ||
> > +	    !(reg & BMP380_STATUS_DRDY_TEMP_MASK)) {
> > +		pr_info("Meas_time: %d\n", meas_time);
> 
> Why as pr_info?  Seems like part of the dev_err.
> 

This is one of my forgotten "debug" messages...

> > +		dev_err(data->dev, "Measurement cycle didn't complete\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int bmp380_chip_config(struct bmp280_data *data)
> >  {
> >  	bool change = false, aux;
> > @@ -1565,17 +1722,15 @@ static int bmp380_chip_config(struct bmp280_data *data)
> >  		 * Resets sensor measurement loop toggling between sleep and
> >  		 * normal operating modes.
> >  		 */
> > -		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> > -					BMP380_MODE_MASK,
> > -					FIELD_PREP(BMP380_MODE_MASK, BMP380_MODE_SLEEP));
> > +		ret = bmp380_set_mode(data, BMP280_SLEEP);
> >  		if (ret) {
> >  			dev_err(data->dev, "failed to set sleep mode\n");
> >  			return ret;
> >  		}
> > -		usleep_range(2000, 2500);
> > -		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> > -					BMP380_MODE_MASK,
> > -					FIELD_PREP(BMP380_MODE_MASK, BMP380_MODE_NORMAL));
> > +
> > +		usleep_range(data->start_up_time, data->start_up_time + 500);
> > +
> > +		ret = bmp380_set_mode(data, BMP280_NORMAL);
> >  		if (ret) {
> >  			dev_err(data->dev, "failed to set normal mode\n");
> >  			return ret;
> > @@ -1601,6 +1756,17 @@ static int bmp380_chip_config(struct bmp280_data *data)
> >  		}
> >  	}
> >  
> > +	/* Dummy read to empty data registers. */
> > +	ret = bmp380_read_press(data, &tmp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = bmp380_set_mode(data, BMP280_SLEEP);
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to set sleep mode\n");
> > +		return ret;
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > @@ -1693,6 +1859,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
> >  	.read_temp = bmp380_read_temp,
> >  	.read_press = bmp380_read_press,
> >  	.read_calib = bmp380_read_calib,
> > +	.set_mode = bmp380_set_mode,
> > +	.wait_conv = bmp380_wait_conv,
> >  	.preinit = bmp380_preinit,
> >  
> >  	.trigger_handler = bmp380_trigger_handler,
> > @@ -2080,6 +2248,65 @@ static int bmp580_preinit(struct bmp280_data *data)
> >  	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
> >  }
> >  
> > +static int bmp580_set_mode(struct bmp280_data *data, u8 mode)
> > +{
> > +	int ret;
> > +
> > +	switch (mode) {
> > +	case BMP280_SLEEP:
> > +		ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> > +					BMP580_MODE_MASK,
> > +					FIELD_PREP(BMP580_MODE_MASK,
> > +						   BMP580_MODE_SLEEP));
> > +		break;
> > +	case BMP280_FORCED:
> > +		ret = regmap_set_bits(data->regmap, BMP580_REG_DSP_CONFIG,
> > +				      BMP580_DSP_IIR_FORCED_FLUSH);
> > +
> check that ret.
> 

True, will do.

> > +		ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> > +					BMP580_MODE_MASK,
> > +					FIELD_PREP(BMP580_MODE_MASK,
> > +						   BMP580_MODE_FORCED));
> This one is more complex so a switch statement makes sense here.
> > +		break;
> > +	case BMP280_NORMAL:
> > +		ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> > +					BMP580_MODE_MASK,
> > +					FIELD_PREP(BMP580_MODE_MASK,
> > +						   BMP580_MODE_NORMAL));
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to  write power control register\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int bmp580_wait_conv(struct bmp280_data *data)
> > +{
> > +	/*
> > +	 * Taken from datasheet, Section 2 "Specification, Table 3 "Electrical
> > +	 * characteristics
> > +	 */
> > +	const int time_conv_press[] = { 0, 1050, 1785, 3045, 5670, 10920, 21420,
> > +					42420, 84420};
> > +	const int time_conv_temp[] = { 0, 1050, 1105, 1575, 2205, 3465, 6090,
> > +				       11340, 21840};
> > +	int meas_time;
> > +
> > +	meas_time = 4000 + time_conv_temp[data->oversampling_temp] +
> > +			   time_conv_press[data->oversampling_press];
> > +
> > +	usleep_range(meas_time, meas_time * 12 / 10);
> > +
> > +	return 0;
> > +}
> > +
> one blank line only.

True, will do.
> > +
> >  static int bmp580_chip_config(struct bmp280_data *data)
> >  {
> >  	bool change = false, aux;
> > @@ -2150,17 +2377,6 @@ static int bmp580_chip_config(struct bmp280_data *data)
> >  		return ret;
> >  	}
> >  
> > -	/* Restore sensor to normal operation mode */
> > -	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> > -				BMP580_MODE_MASK,
> > -				FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_NORMAL));
> > -	if (ret) {
> > -		dev_err(data->dev, "failed to set normal mode\n");
> > -		return ret;
> > -	}
> > -	/* From datasheet's table 4: electrical characteristics */
> > -	usleep_range(3000, 3500);
> > -
> >  	if (change) {
> >  		/*
> >  		 * Check if ODR and OSR settings are valid or we are
> > @@ -2256,6 +2472,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
> >  	.chip_config = bmp580_chip_config,
> >  	.read_temp = bmp580_read_temp,
> >  	.read_press = bmp580_read_press,
> > +	.set_mode = bmp580_set_mode,
> > +	.wait_conv = bmp580_wait_conv,
> >  	.preinit = bmp580_preinit,
> >  
> >  	.trigger_handler = bmp580_trigger_handler,
> > @@ -2503,6 +2721,16 @@ static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
> >  	return 0;
> >  }
> >  
> > +static int bmp180_set_mode(struct bmp280_data *data, u8 mode)
> > +{
> > +	return 0;
> Add a comment on why these are stubs.  It's in the patch description, but
> better to have it recorded in the code.
> 

I didn't add because as you can see below there is another function exactly
like this one that doesn't have one. Should I add also to the other one?

> > +}
> > +
> > +static int bmp180_wait_conv(struct bmp280_data *data)
> > +{
> > +	return 0;
> > +}
> > +
> >

