Return-Path: <linux-iio+bounces-6716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ACE9133F3
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 14:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E081F21B1E
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 12:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD3D15533B;
	Sat, 22 Jun 2024 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSJdQl9m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9814B97A;
	Sat, 22 Jun 2024 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719059577; cv=none; b=HCADDEORsR9XJEjQ8WyTp+FIBVKffz8Q4M8ClMUXpEC27WdFHADjtgRZZgtJNJCp3Y+xfK63etCcmOGiSZVdk9eygOEgJVrTgT8PU7scgxTBIwBwE1DE0P+lVA8zAVLoB8vUxm2c0571YXHBSujIb75WFTKZpvZk1rOjmUNqLyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719059577; c=relaxed/simple;
	bh=b+g1h9MM0LWD8LDAqbwFyLrltUsvhl2z0kFLEq4bsCY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fol4D/4ayryMqWJGy4+Bz40eTVeQp1VpHh6cvt3LyJbSa3/q5Jn1TuEQMoX5Cvb49rhbHkQPvos7Dn/1jcJ6ylkv0sG0ey9oKP/nxzeTSdsyeZlbw99BTlfga55tdrPZ/8FqxTzjajFKXloW6n9JOYCbdK15BSXQZ6ZnaYKB+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSJdQl9m; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f13dddf7eso345566866b.0;
        Sat, 22 Jun 2024 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719059574; x=1719664374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8a8DntYYAapSniZV29BtMK5NTcACmVvyapG6qtk/kE=;
        b=kSJdQl9m29rhTj/E1UQg8orH2WV/IJFmiB24QeaDYAlF+HITcX8APYxYM5/7oRNnOp
         c8ARPq5YCRYXsP1vN+8uAj66sIBiTGTyoZZGNlMySSGy7Yc2Z7bqwr0nZxEr7feC6bWt
         7J5pDeHE7NZad4oRPQoqG0tGT9E9ukZKJ08c4+GGkcGn/QuUk+SgzBFqhyWA4Bsq08An
         jSBUDDU1NhXW0Q/XENihdGnfapejqhy+gASpaNaMq7OV2LEV/NOPQ1BHmqnkiHN1v3he
         ZchO1WMHl90f1OQlBkdM58iVe/rXfFxvvuGN0+pO2xjpmLwjiFzQd1dHnrzrsJdn+2aw
         7OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719059574; x=1719664374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8a8DntYYAapSniZV29BtMK5NTcACmVvyapG6qtk/kE=;
        b=QsxqhMBhZxh+PngPBCZRUgg0qJMYh7LEOlW6Wn7fiR/aj8C1a6fZKrj3OXKXn162Co
         cRfm8+B3A7aL52qA3mWsaXd7yNMIzm/1mc01CFLURBYEw/OWnQN9UJqLQIXY+Pnw6LtJ
         PQiWmfXP6jsEIiMX5aIC1vg52OdU+KGHLajdMJT6j2gQ9CK2zwv1SGybIq71/DAQunfp
         6sGWcECvVLDhmWoVQS1CdI1gAYX1WR+3/Xl33GJF1PiRN/yRCC6NLG9OXZAOzAwdUnu9
         avrJ4XXSkqOM2KJT5XB+Z/0Mmw0sFF4fhDAOi4swWhKEcMKeV+MyOMEcCiu3ECa4i/kt
         mFwg==
X-Forwarded-Encrypted: i=1; AJvYcCWSBt5TmIr8tmhxCeDWa4o5uriYjlHgI0BW9un8kscPbrZK54wgMhAEIW9qu4B13sLQfDhULblWcSDvDnY/BYeCjEd8lajlIijP6Jfs+MPf5Bv6UVg8DM42pTpU99AEC9G6q7bouaIu
X-Gm-Message-State: AOJu0Yy6XSQxoM2gPRR/hIRdUsZZOjmKZOe/Wwj6iwfV7JJ5+orA6iwE
	MB4QJHkTyZon7YkyDwrCIBo5ql3bdMO6KusrWguYBtdEt+X5a4qs
X-Google-Smtp-Source: AGHT+IEOxg0QEzBFScKsxUr+qIJq52lwiHXS8MmL0PifZR7RVigLtyaWNWhDIco9wtMyUUNYj/8Z4w==
X-Received: by 2002:a17:907:a642:b0:a6f:e336:389b with SMTP id a640c23a62f3a-a7242c39008mr25330766b.18.1719059573609;
        Sat, 22 Jun 2024 05:32:53 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:57bf:cecc:afec:b13d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf429a64sm192427266b.26.2024.06.22.05.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 05:32:53 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 22 Jun 2024 14:32:51 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adam Rizkalla <ajarizzo@gmail.com>
Subject: Re: [PATCH v8 3/3] iio: pressure: bmp280: Add triggered buffer
 support
Message-ID: <20240622123251.GB123707@vamoiridPC>
References: <20240617230540.32325-1-vassilisamir@gmail.com>
 <20240617230540.32325-4-vassilisamir@gmail.com>
 <20240622104039.6bb4033b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622104039.6bb4033b@jic23-huawei>

On Sat, Jun 22, 2024 at 10:40:39AM +0100, Jonathan Cameron wrote:
> On Tue, 18 Jun 2024 01:05:40 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > BMP2xx, BME280, BMP3xx, and BMP5xx use continuous buffers for their
> > temperature, pressure and humidity readings. This facilitates the
> > use of burst/bulk reads in order to acquire data faster. The
> > approach is different from the one used in oneshot captures.
> > 
> > BMP085 & BMP1xx devices use a completely different measurement
> > process that is well defined and is used in their buffer_handler().
> > 
> > Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > Link: https://lore.kernel.org/r/20240512230524.53990-6-vassilisamir@gmail.com
> > ---
> The sign extend in buffered path doesn't make much sense as we should be
> advertising the correct bit depth for the channel and making that a userspace
> problem.
> 
> I'd failed to notice you are doing endian conversions just to check
> the skipped values. Ideally we'd leave the channels little endian
> and include that in the channel spec.
> 
> Hmm. I guess this works and if we have to do the endian conversion
> anyway isn't too bad.  It does provide slightly wrong information
> to userspace though.
> 
> So even with this in place I think these channels should be real_bits 24.
> 

Well, I totally get your point. Actually, I think that it makes much more
sense, to check the skipped values in userspace. These are information that
come from the datasheet, and I think that if it is important to someone to
check those values, they can do it. The point is to get the data to
userspace as soon as possible and then it is on the hands of user to do
what they want with that. So I agree that the implementation can be
simplified a lot.

As for the real_bits 24, I kind of get what you mean. I will fix this as
well. I will wait for Adam's comment on the first patch as well, and
then I will send a v9.

> 
> 
> > +static irqreturn_t bmp580_buffer_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	s32 adc_temp, adc_press;
> > +	int ret;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	/* Burst read data registers */
> > +	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
> > +			       data->buf, BMP280_BURST_READ_BYTES);
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to burst read sensor data\n");
> > +		goto out;
> > +	}
> > +
> > +	/* Temperature calculations */
> > +	adc_temp = get_unaligned_le24(&data->buf[0]);
> > +	if (adc_temp == BMP580_TEMP_SKIPPED) {
> > +		dev_err(data->dev, "reading temperature skipped\n");
> > +		goto out;
> > +	}
> > +
> > +	data->sensor_data[1] = sign_extend32(adc_temp, 23);
> 
> the channel type should indicate that it's a 24 bit value. Not our
> problem to sign extend.  Leave that to userspace.
> 

Ok, I understand.


> > +
> > +	/* Pressure calculations */
> > +	adc_press = get_unaligned_le24(&data->buf[3]);
> > +	if (adc_press == BMP380_PRESS_SKIPPED) {
> > +		dev_err(data->dev, "reading pressure skipped\n");
> > +		goto out;
> > +	}
> > +
> > +	data->sensor_data[0] = adc_press;
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> > +					   iio_get_time_ns(indio_dev));
> > +
> > +out:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
> >  static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
> >  static const int bmp580_temp_coeffs[] = { 1000, 16 };
> > @@ -1929,6 +2204,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
> >  	.start_up_time = 2000,
> >  	.channels = bmp380_channels,
> >  	.num_channels = ARRAY_SIZE(bmp380_channels),
> > +	.avail_scan_masks = bmp280_avail_scan_masks,
> >  
> >  	.oversampling_temp_avail = bmp580_oversampling_avail,
> >  	.num_oversampling_temp_avail = ARRAY_SIZE(bmp580_oversampling_avail),
> > @@ -1955,6 +2231,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
> >  	.read_temp = bmp580_read_temp,
> >  	.read_press = bmp580_read_press,
> >  	.preinit = bmp580_preinit,
> > +
> > +	.buffer_handler = bmp580_buffer_handler,
> >  };
> >  EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
> >  
> > @@ -2133,7 +2411,7 @@ static int bmp180_read_press_adc(struct bmp280_data *data, u32 *adc_press)
> >  		return ret;
> >  
> >  	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
> > -			       data->buf, sizeof(data->buf));
> > +			       data->buf, BMP280_NUM_PRESS_BYTES);
> >  	if (ret) {
> >  		dev_err(data->dev, "failed to read pressure\n");
> >  		return ret;
> > @@ -2204,6 +2482,36 @@ static int bmp180_chip_config(struct bmp280_data *data)
> >  	return 0;
> >  }
> >  
> > +static irqreturn_t bmp180_buffer_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	int ret, chan_value;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	ret = bmp180_read_temp(data, &chan_value);
> > +	if (ret)
> > +		goto out;
> > +
> > +	data->sensor_data[1] = chan_value;
> > +
> > +	ret = bmp180_read_press(data, &chan_value);
> > +	if (ret)
> > +		goto out;
> > +
> > +	data->sensor_data[0] = chan_value;
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> > +					   iio_get_time_ns(indio_dev));
> > +
> > +out:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static const int bmp180_oversampling_temp_avail[] = { 1 };
> >  static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
> >  static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
> > @@ -2218,6 +2526,7 @@ const struct bmp280_chip_info bmp180_chip_info = {
> >  	.start_up_time = 2000,
> >  	.channels = bmp280_channels,
> >  	.num_channels = ARRAY_SIZE(bmp280_channels),
> > +	.avail_scan_masks = bmp280_avail_scan_masks,
> >  
> >  	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
> >  	.num_oversampling_temp_avail =
> > @@ -2238,6 +2547,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
> >  	.read_temp = bmp180_read_temp,
> >  	.read_press = bmp180_read_press,
> >  	.read_calib = bmp180_read_calib,
> > +
> > +	.buffer_handler = bmp180_buffer_handler,
> >  };
> >  EXPORT_SYMBOL_NS(bmp180_chip_info, IIO_BMP280);
> >  
> > @@ -2283,6 +2594,30 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
> >  	return 0;
> >  }
> >  
> > +static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +
> > +	pm_runtime_get_sync(data->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int bmp280_buffer_postdisable(struct iio_dev *indio_dev)
> > +{
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +
> > +	pm_runtime_mark_last_busy(data->dev);
> > +	pm_runtime_put_autosuspend(data->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct iio_buffer_setup_ops bmp280_buffer_setup_ops = {
> > +	.preenable = bmp280_buffer_preenable,
> > +	.postdisable = bmp280_buffer_postdisable,
> > +};
> > +
> >  static void bmp280_pm_disable(void *data)
> >  {
> >  	struct device *dev = data;
> > @@ -2329,6 +2664,7 @@ int bmp280_common_probe(struct device *dev,
> >  	/* Apply initial values from chip info structure */
> >  	indio_dev->channels = chip_info->channels;
> >  	indio_dev->num_channels = chip_info->num_channels;
> > +	indio_dev->available_scan_masks = chip_info->avail_scan_masks;
> >  	data->oversampling_press = chip_info->oversampling_press_default;
> >  	data->oversampling_humid = chip_info->oversampling_humid_default;
> >  	data->oversampling_temp = chip_info->oversampling_temp_default;
> > @@ -2414,6 +2750,14 @@ int bmp280_common_probe(struct device *dev,
> >  					     "failed to read calibration coefficients\n");
> >  	}
> >  
> > +	ret = devm_iio_triggered_buffer_setup(data->dev, indio_dev,
> > +					      iio_pollfunc_store_time,
> > +					      data->chip_info->buffer_handler,
> > +					      &bmp280_buffer_setup_ops);
> > +	if (ret)
> > +		return dev_err_probe(data->dev, ret,
> > +				     "iio triggered buffer setup failed\n");
> > +
> >  	/*
> >  	 * Attempt to grab an optional EOC IRQ - only the BMP085 has this
> >  	 * however as it happens, the BMP085 shares the chip ID of BMP180
> > diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> > index 62b4e58104cf..e5abee15950e 100644
> > --- a/drivers/iio/pressure/bmp280-spi.c
> > +++ b/drivers/iio/pressure/bmp280-spi.c
> > @@ -40,14 +40,10 @@ static int bmp380_regmap_spi_read(void *context, const void *reg,
> >  				  size_t reg_size, void *val, size_t val_size)
> >  {
> >  	struct spi_device *spi = to_spi_device(context);
> > -	u8 rx_buf[4];
> > +	u8 rx_buf[BME280_BURST_READ_BYTES + 1];
> >  	ssize_t status;
> >  
> > -	/*
> > -	 * Maximum number of consecutive bytes read for a temperature or
> > -	 * pressure measurement is 3.
> > -	 */
> > -	if (val_size > 3)
> > +	if (val_size > BME280_BURST_READ_BYTES)
> >  		return -EINVAL;
> >  
> >  	/*
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > index a3d2cd722760..756c644354c2 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
> > @@ -304,6 +304,16 @@
> >  #define BMP280_PRESS_SKIPPED		0x80000
> >  #define BMP280_HUMIDITY_SKIPPED		0x8000
> >  
> > +/* Number of bytes for each value */
> > +#define BMP280_NUM_PRESS_BYTES		3
> > +#define BMP280_NUM_TEMP_BYTES		3
> > +#define BME280_NUM_HUMIDITY_BYTES	2
> > +#define BMP280_BURST_READ_BYTES		(BMP280_NUM_PRESS_BYTES + \
> > +					 BMP280_NUM_TEMP_BYTES)
> > +#define BME280_BURST_READ_BYTES		(BMP280_NUM_PRESS_BYTES + \
> > +					 BMP280_NUM_TEMP_BYTES + \
> > +					 BME280_NUM_HUMIDITY_BYTES)
> > +
> >  /* Core exported structs */
> >  
> >  static const char *const bmp280_supply_names[] = {
> > @@ -397,13 +407,19 @@ struct bmp280_data {
> >  	 */
> >  	int sampling_freq;
> >  
> > +	/*
> > +	 * Data to push to userspace triggered buffer. Up to 3 channels and
> > +	 * s64 timestamp, aligned.
> > +	 */
> > +	s32 sensor_data[6] __aligned(8);
> > +
> >  	/*
> >  	 * DMA (thus cache coherency maintenance) may require the
> >  	 * transfer buffers to live in their own cache lines.
> >  	 */
> >  	union {
> >  		/* Sensor data buffer */
> > -		u8 buf[3];
> > +		u8 buf[BME280_BURST_READ_BYTES];
> >  		/* Calibration data buffers */
> >  		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
> >  		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
> > @@ -425,6 +441,7 @@ struct bmp280_chip_info {
> >  	const struct iio_chan_spec *channels;
> >  	int num_channels;
> >  	unsigned int start_up_time;
> > +	const unsigned long *avail_scan_masks;
> >  
> >  	const int *oversampling_temp_avail;
> >  	int num_oversampling_temp_avail;
> > @@ -459,6 +476,8 @@ struct bmp280_chip_info {
> >  	int (*read_humid)(struct bmp280_data *data, u32 *adc_humidity);
> >  	int (*read_calib)(struct bmp280_data *data);
> >  	int (*preinit)(struct bmp280_data *data);
> > +
> > +	irqreturn_t (*buffer_handler)(int irq, void *p);
> >  };
> >  
> >  /* Chip infos for each variant */
> 

