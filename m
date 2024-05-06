Return-Path: <linux-iio+bounces-4828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA81E8BC4CA
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 02:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E81281488
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 00:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89002370;
	Mon,  6 May 2024 00:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHZQxzPC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253A181;
	Mon,  6 May 2024 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714953898; cv=none; b=G5QoGb79SHPaYWc9ePqARcaZ1V5g0M2iEKUUXrK3vOED7BgXt2bn+S+uJg6Jsq0tichHEWQJ2TjUtebIBjbdoQzRgML0hD0BQkQkTBzasy5I+nHRhYSUsGuvhEoRMfWcFnBboe/bySNEnArHqRuWPkrUnm6jXFvz19DKJdRF55g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714953898; c=relaxed/simple;
	bh=fMQGI+0VWafu7jmW8fCe7yZLVFpbWobr9a/y9JQVs5Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeN76eeYP2clpVq/phCH0g+EBqQBgJx5PsgT58vxJhskMSZvGgsDvpIicnz4zoHHsvfeesnJX3Yx4GmO5jnfAGNBsbJ+cyGPNv/WgcZczNSdpNe1MAe5b0zAkObIH5gb5cYT9nIqhTj5KZsn9DFceWNeYMAKevPcv0dpb8m7gJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHZQxzPC; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59cdf7cd78so79966766b.0;
        Sun, 05 May 2024 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714953894; x=1715558694; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pktbhRd3bzgtNej0hoCzbOCaB77GzfsVgnJrQ4Ck8pU=;
        b=LHZQxzPCHwqNDZGtRljAJl1zaXP28qXiH2VORkKkh6YuYIMu0mPU5rqNj0uasIaLsn
         WyBWuLBmyFnZvNIgw/8YADDqbyLrZd2CyObPbRbQXagJkJUpuWkVdRuNlCHdjLS42Gi8
         HNAABVmKlQRbPqXnCivbqx2ChSS6W87ug7eRBuSAQEiaDZ3za7zkz7QrIyUSx63HMylG
         AixI6R1B20ND9v8w/iZXLjWsM+X4M9RHnHTwmSa5KoghzYcZH7raPoqmyT7hrDhGwqYA
         D6OY+9j679AzbD49dqYlGn95qVoaf3vUGw2YRc/JwzuyiovtnAIE8oKY/6R/CuK362LB
         6eaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714953894; x=1715558694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pktbhRd3bzgtNej0hoCzbOCaB77GzfsVgnJrQ4Ck8pU=;
        b=NF9Gtrd42yQXsIyWEQgvesXw/S8Qih2KJh3AWP+UR3VRyouWQ77C0R6o5jP1rYUQEz
         yNkfKeaGR/zd2+Yvho5giTe9/OQ4d+4zTq7tVT8aQ1+pc/Ne2GxYp/jH+zNxCkJcXSHQ
         8q0zBMNLLDnOHycrqp+ql9VqdGIWr3/CwGCjx7aAFyooWnugs5+fefPjq5k5P3b+MZCe
         rXkFp2PSzP4gsCxQgxf0hIes7/eRgMr+8d6OrXukWSiq6jwgNFz/AuzGBqGr814HuK+9
         Om5Q4CgBllq1/qTUpwMlqwm8w4A6+90LbmmTspf9j86qOAuRo7pFF5BKcre7azcbWryM
         UUKw==
X-Forwarded-Encrypted: i=1; AJvYcCVWgdr8923aSMNkW+8ugrxFr0ZsyS8w7QyZ3IEjmTm7lKvP9zW1GCBqBAVg/f/6NR/0133KV8UF1MVuhdMzqplhzWMTuzBL+wm5BOZ/Zlk2UEihNWY2jm2ShBVDo1wBtCqo0JlNicSD
X-Gm-Message-State: AOJu0YysEH1Zi8BoKfyjYd0Wt5PNRyLadb9k61sJ1z6V0pM4HvDZ12io
	QNv8oObpz3blfCQKNm4/nmQ/fPJbSwu1NNd22KSCfNbywqmKoGIK
X-Google-Smtp-Source: AGHT+IGNVXJtRV+OOpbW8X4jim49tKqyBzMT4neJuAAWTVVynypjG4/S+PKw6BZWdJQyFFpfXZ0NBQ==
X-Received: by 2002:a17:907:9493:b0:a59:bae0:b12a with SMTP id dm19-20020a170907949300b00a59bae0b12amr2237295ejc.63.1714953894285;
        Sun, 05 May 2024 17:04:54 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:7a5f:ec16:256e:4660])
        by smtp.gmail.com with ESMTPSA id ao18-20020a170907359200b00a59bda080ffsm1503700ejc.194.2024.05.05.17.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:04:53 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 6 May 2024 02:04:52 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/10] iio: pressure: bmp280: Improve indentation and
 line wrapping
Message-ID: <20240506000452.GD17986@vamoiridPC>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
 <20240429190046.24252-2-vassilisamir@gmail.com>
 <20240505195155.0c682ec2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240505195155.0c682ec2@jic23-huawei>

On Sun, May 05, 2024 at 07:51:55PM +0100, Jonathan Cameron wrote:
> On Mon, 29 Apr 2024 21:00:37 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Fix indentations that are not following the standards, remove
> > extra white lines and add missing white lines.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Possibly some reviewers will feel one or two of these are a little over zealous,
> but this does both improve things and bring consistency to this code.
> 
> I'll pick up some of these cleanups now (maybe the whole set but who knows)
> to reduce what is left if we end up with a v6.
> 
> Applied this one to the togreg branch of iio.git and pushed out as testing
> for 0-day to see if we missed anything,
> 
> Thanks,
> 
> Jonathan
> 

Hi Jonathan,

I noticed that, another commit for this driver has been accepted here [1],
which will affect some patches of this series that I am adding. It's not
difficult at all to apply changes to my patches with respect to this new
addition. Should I move on with a v6 without taking into consideration
this change, and if everything is finally approved, I can send
later a v7 with only the changes needed for this new commit?

Cheers,
Vasilis

[1] https://lore.kernel.org/linux-iio/043f2be49df3c11152aaf32fc5467ed43fd59faa.camel@gmail.com/T/#t

> > ---
> >  drivers/iio/pressure/bmp280-core.c | 108 ++++++++++++++++-------------
> >  drivers/iio/pressure/bmp280-spi.c  |   4 +-
> >  2 files changed, 61 insertions(+), 51 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 09f53d987c7d..1a3241a41768 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -52,7 +52,6 @@
> >   */
> >  enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
> >  
> > -
> >  enum bmp380_odr {
> >  	BMP380_ODR_200HZ,
> >  	BMP380_ODR_100HZ,
> > @@ -181,18 +180,19 @@ static int bmp280_read_calib(struct bmp280_data *data)
> >  	struct bmp280_calib *calib = &data->calib.bmp280;
> >  	int ret;
> >  
> > -
> >  	/* Read temperature and pressure calibration values. */
> >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
> > -			       data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf));
> > +			       data->bmp280_cal_buf,
> > +			       sizeof(data->bmp280_cal_buf));
> >  	if (ret < 0) {
> >  		dev_err(data->dev,
> > -			"failed to read temperature and pressure calibration parameters\n");
> > +			"failed to read calibration parameters\n");
> >  		return ret;
> >  	}
> >  
> > -	/* Toss the temperature and pressure calibration data into the entropy pool */
> > -	add_device_randomness(data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf));
> > +	/* Toss calibration data into the entropy pool */
> > +	add_device_randomness(data->bmp280_cal_buf,
> > +			      sizeof(data->bmp280_cal_buf));
> >  
> >  	/* Parse temperature calibration values. */
> >  	calib->T1 = le16_to_cpu(data->bmp280_cal_buf[T1]);
> > @@ -223,7 +223,7 @@ static int bme280_read_calib(struct bmp280_data *data)
> >  	/* Load shared calibration params with bmp280 first */
> >  	ret = bmp280_read_calib(data);
> >  	if  (ret < 0) {
> > -		dev_err(dev, "failed to read common bmp280 calibration parameters\n");
> > +		dev_err(dev, "failed to read calibration parameters\n");
> >  		return ret;
> >  	}
> >  
> > @@ -283,6 +283,7 @@ static int bme280_read_calib(struct bmp280_data *data)
> >  
> >  	return 0;
> >  }
> > +
> >  /*
> >   * Returns humidity in percent, resolution is 0.01 percent. Output value of
> >   * "47445" represents 47445/1024 = 46.333 %RH.
> > @@ -305,7 +306,7 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
> >  	var = clamp_val(var, 0, 419430400);
> >  
> >  	return var >> 12;
> > -};
> > +}
> >  
> >  /*
> >   * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
> > @@ -538,7 +539,7 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
> >  }
> >  
> >  static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
> > -					       int val)
> > +						 int val)
> >  {
> >  	const int *avail = data->chip_info->oversampling_humid_avail;
> >  	const int n = data->chip_info->num_oversampling_humid_avail;
> > @@ -563,7 +564,7 @@ static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
> >  }
> >  
> >  static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
> > -					       int val)
> > +						int val)
> >  {
> >  	const int *avail = data->chip_info->oversampling_temp_avail;
> >  	const int n = data->chip_info->num_oversampling_temp_avail;
> > @@ -588,7 +589,7 @@ static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
> >  }
> >  
> >  static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
> > -					       int val)
> > +						 int val)
> >  {
> >  	const int *avail = data->chip_info->oversampling_press_avail;
> >  	const int n = data->chip_info->num_oversampling_press_avail;
> > @@ -772,13 +773,12 @@ static int bmp280_chip_config(struct bmp280_data *data)
> >  	int ret;
> >  
> >  	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> > -				 BMP280_OSRS_TEMP_MASK |
> > -				 BMP280_OSRS_PRESS_MASK |
> > -				 BMP280_MODE_MASK,
> > -				 osrs | BMP280_MODE_NORMAL);
> > +				BMP280_OSRS_TEMP_MASK |
> > +				BMP280_OSRS_PRESS_MASK |
> > +				BMP280_MODE_MASK,
> > +				osrs | BMP280_MODE_NORMAL);
> >  	if (ret < 0) {
> > -		dev_err(data->dev,
> > -			"failed to write ctrl_meas register\n");
> > +		dev_err(data->dev, "failed to write ctrl_meas register\n");
> >  		return ret;
> >  	}
> >  
> > @@ -786,8 +786,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
> >  				 BMP280_FILTER_MASK,
> >  				 BMP280_FILTER_4X);
> >  	if (ret < 0) {
> > -		dev_err(data->dev,
> > -			"failed to write config register\n");
> > +		dev_err(data->dev, "failed to write config register\n");
> >  		return ret;
> >  	}
> >  
> > @@ -926,8 +925,8 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
> >  }
> >  
> >  /*
> > - * Returns temperature in Celsius degrees, resolution is 0.01º C. Output value of
> > - * "5123" equals 51.2º C. t_fine carries fine temperature as global value.
> > + * Returns temperature in Celsius degrees, resolution is 0.01º C. Output value
> > + * of "5123" equals 51.2º C. t_fine carries fine temperature as global value.
> >   *
> >   * Taken from datasheet, Section Appendix 9, "Compensation formula" and repo
> >   * https://github.com/BoschSensortec/BMP3-Sensor-API.
> > @@ -1069,7 +1068,8 @@ static int bmp380_read_calib(struct bmp280_data *data)
> >  
> >  	/* Read temperature and pressure calibration data */
> >  	ret = regmap_bulk_read(data->regmap, BMP380_REG_CALIB_TEMP_START,
> > -			       data->bmp380_cal_buf, sizeof(data->bmp380_cal_buf));
> > +			       data->bmp380_cal_buf,
> > +			       sizeof(data->bmp380_cal_buf));
> >  	if (ret) {
> >  		dev_err(data->dev,
> >  			"failed to read temperature calibration parameters\n");
> > @@ -1077,7 +1077,8 @@ static int bmp380_read_calib(struct bmp280_data *data)
> >  	}
> >  
> >  	/* Toss the temperature calibration data into the entropy pool */
> > -	add_device_randomness(data->bmp380_cal_buf, sizeof(data->bmp380_cal_buf));
> > +	add_device_randomness(data->bmp380_cal_buf,
> > +			      sizeof(data->bmp380_cal_buf));
> >  
> >  	/* Parse calibration values */
> >  	calib->T1 = get_unaligned_le16(&data->bmp380_cal_buf[BMP380_T1]);
> > @@ -1159,7 +1160,8 @@ static int bmp380_chip_config(struct bmp280_data *data)
> >  
> >  	/* Configure output data rate */
> >  	ret = regmap_update_bits_check(data->regmap, BMP380_REG_ODR,
> > -				       BMP380_ODRS_MASK, data->sampling_freq, &aux);
> > +				       BMP380_ODRS_MASK, data->sampling_freq,
> > +				       &aux);
> >  	if (ret) {
> >  		dev_err(data->dev, "failed to write ODR selection register\n");
> >  		return ret;
> > @@ -1178,12 +1180,13 @@ static int bmp380_chip_config(struct bmp280_data *data)
> >  
> >  	if (change) {
> >  		/*
> > -		 * The configurations errors are detected on the fly during a measurement
> > -		 * cycle. If the sampling frequency is too low, it's faster to reset
> > -		 * the measurement loop than wait until the next measurement is due.
> > +		 * The configurations errors are detected on the fly during a
> > +		 * measurement cycle. If the sampling frequency is too low, it's
> > +		 * faster to reset the measurement loop than wait until the next
> > +		 * measurement is due.
> >  		 *
> > -		 * Resets sensor measurement loop toggling between sleep and normal
> > -		 * operating modes.
> > +		 * Resets sensor measurement loop toggling between sleep and
> > +		 * normal operating modes.
> >  		 */
> >  		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> >  					BMP380_MODE_MASK,
> > @@ -1201,22 +1204,21 @@ static int bmp380_chip_config(struct bmp280_data *data)
> >  			return ret;
> >  		}
> >  		/*
> > -		 * Waits for measurement before checking configuration error flag.
> > -		 * Selected longest measure time indicated in section 3.9.1
> > -		 * in the datasheet.
> > +		 * Waits for measurement before checking configuration error
> > +		 * flag. Selected longest measure time indicated in
> > +		 * section 3.9.1 in the datasheet.
> >  		 */
> >  		msleep(80);
> >  
> >  		/* Check config error flag */
> >  		ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
> >  		if (ret) {
> > -			dev_err(data->dev,
> > -				"failed to read error register\n");
> > +			dev_err(data->dev, "failed to read error register\n");
> >  			return ret;
> >  		}
> >  		if (tmp & BMP380_ERR_CONF_MASK) {
> >  			dev_warn(data->dev,
> > -				"sensor flagged configuration as incompatible\n");
> > +				 "sensor flagged configuration as incompatible\n");
> >  			return -EINVAL;
> >  		}
> >  	}
> > @@ -1317,9 +1319,11 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
> >  	}
> >  
> >  	/* Start NVM operation sequence */
> > -	ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_NVM_OP_SEQ_0);
> > +	ret = regmap_write(data->regmap, BMP580_REG_CMD,
> > +			   BMP580_CMD_NVM_OP_SEQ_0);
> >  	if (ret) {
> > -		dev_err(data->dev, "failed to send nvm operation's first sequence\n");
> > +		dev_err(data->dev,
> > +			"failed to send nvm operation's first sequence\n");
> >  		return ret;
> >  	}
> >  	if (is_write) {
> > @@ -1327,7 +1331,8 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
> >  		ret = regmap_write(data->regmap, BMP580_REG_CMD,
> >  				   BMP580_CMD_NVM_WRITE_SEQ_1);
> >  		if (ret) {
> > -			dev_err(data->dev, "failed to send nvm write sequence\n");
> > +			dev_err(data->dev,
> > +				"failed to send nvm write sequence\n");
> >  			return ret;
> >  		}
> >  		/* Datasheet says on 4.8.1.2 it takes approximately 10ms */
> > @@ -1338,7 +1343,8 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
> >  		ret = regmap_write(data->regmap, BMP580_REG_CMD,
> >  				   BMP580_CMD_NVM_READ_SEQ_1);
> >  		if (ret) {
> > -			dev_err(data->dev, "failed to send nvm read sequence\n");
> > +			dev_err(data->dev,
> > +				"failed to send nvm read sequence\n");
> >  			return ret;
> >  		}
> >  		/* Datasheet says on 4.8.1.1 it takes approximately 200us */
> > @@ -1501,8 +1507,8 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
> >  		if (ret)
> >  			goto exit;
> >  
> > -		ret = regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
> > -				       sizeof(data->le16));
> > +		ret = regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB,
> > +				       &data->le16, sizeof(data->le16));
> >  		if (ret) {
> >  			dev_err(data->dev, "error reading nvm data regs\n");
> >  			goto exit;
> > @@ -1546,7 +1552,8 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
> >  	while (bytes >= sizeof(*buf)) {
> >  		addr = bmp580_nvmem_addrs[offset / sizeof(*buf)];
> >  
> > -		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR, BMP580_NVM_PROG_EN |
> > +		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR,
> > +				   BMP580_NVM_PROG_EN |
> >  				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
> >  		if (ret) {
> >  			dev_err(data->dev, "error writing nvm address\n");
> > @@ -1554,8 +1561,8 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
> >  		}
> >  		data->le16 = cpu_to_le16(*buf++);
> >  
> > -		ret = regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
> > -					sizeof(data->le16));
> > +		ret = regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB,
> > +					&data->le16, sizeof(data->le16));
> >  		if (ret) {
> >  			dev_err(data->dev, "error writing LSB NVM data regs\n");
> >  			goto exit;
> > @@ -1662,7 +1669,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
> >  		  BMP580_OSR_PRESS_EN;
> >  
> >  	ret = regmap_update_bits_check(data->regmap, BMP580_REG_OSR_CONFIG,
> > -				       BMP580_OSR_TEMP_MASK | BMP580_OSR_PRESS_MASK |
> > +				       BMP580_OSR_TEMP_MASK |
> > +				       BMP580_OSR_PRESS_MASK |
> >  				       BMP580_OSR_PRESS_EN,
> >  				       reg_val, &aux);
> >  	if (ret) {
> > @@ -1713,7 +1721,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
> >  		 */
> >  		ret = regmap_read(data->regmap, BMP580_REG_EFF_OSR, &tmp);
> >  		if (ret) {
> > -			dev_err(data->dev, "error reading effective OSR register\n");
> > +			dev_err(data->dev,
> > +				"error reading effective OSR register\n");
> >  			return ret;
> >  		}
> >  		if (!(tmp & BMP580_EFF_OSR_VALID_ODR)) {
> > @@ -1848,7 +1857,8 @@ static int bmp180_read_calib(struct bmp280_data *data)
> >  	}
> >  
> >  	/* Toss the calibration data into the entropy pool */
> > -	add_device_randomness(data->bmp180_cal_buf, sizeof(data->bmp180_cal_buf));
> > +	add_device_randomness(data->bmp180_cal_buf,
> > +			      sizeof(data->bmp180_cal_buf));
> >  
> >  	calib->AC1 = be16_to_cpu(data->bmp180_cal_buf[AC1]);
> >  	calib->AC2 = be16_to_cpu(data->bmp180_cal_buf[AC2]);
> > @@ -1963,8 +1973,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
> >  	return p + ((x1 + x2 + 3791) >> 4);
> >  }
> >  
> > -static int bmp180_read_press(struct bmp280_data *data,
> > -			     int *val, int *val2)
> > +static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
> >  {
> >  	u32 comp_press;
> >  	s32 adc_press;
> > @@ -2241,6 +2250,7 @@ static int bmp280_runtime_resume(struct device *dev)
> >  	ret = regulator_bulk_enable(BMP280_NUM_SUPPLIES, data->supplies);
> >  	if (ret)
> >  		return ret;
> > +
> >  	usleep_range(data->start_up_time, data->start_up_time + 100);
> >  	return data->chip_info->chip_config(data);
> >  }
> > diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> > index 4e19ea0b4d39..62b4e58104cf 100644
> > --- a/drivers/iio/pressure/bmp280-spi.c
> > +++ b/drivers/iio/pressure/bmp280-spi.c
> > @@ -13,7 +13,7 @@
> >  #include "bmp280.h"
> >  
> >  static int bmp280_regmap_spi_write(void *context, const void *data,
> > -                                   size_t count)
> > +				   size_t count)
> >  {
> >  	struct spi_device *spi = to_spi_device(context);
> >  	u8 buf[2];
> > @@ -29,7 +29,7 @@ static int bmp280_regmap_spi_write(void *context, const void *data,
> >  }
> >  
> >  static int bmp280_regmap_spi_read(void *context, const void *reg,
> > -                                  size_t reg_size, void *val, size_t val_size)
> > +				  size_t reg_size, void *val, size_t val_size)
> >  {
> >  	struct spi_device *spi = to_spi_device(context);
> >  
> > 
> > base-commit: b0a2c79c6f3590b74742cbbc76687014d47972d8
> 

