Return-Path: <linux-iio+bounces-14845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2050A24B07
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 18:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6862A1886B47
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F389B1C8FCE;
	Sat,  1 Feb 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJWJinJM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEB1C5F34;
	Sat,  1 Feb 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430568; cv=none; b=ubhfWtuL9W9sgaMpW4QBFsKv6EILuOKZf+sHps/cWGksr8EIale1NvQO43WQGVNd9crfqU81xQ8WalxwfZZesPFVWWF4ld8mBoCJDx4psI0S8F3mG7KBt+mv/ZakvM5K+3BlE+vBDNOYDuvC92CPq94GyBVLk/CFvovnpe0ceHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430568; c=relaxed/simple;
	bh=Qrdd23R/NIqqOD8tLgPKyOnBoOCKeAuBEzHVsSYAEFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1dJYJA89ttEJxtY/t7GPbEiNwy4YL9t3yfKiH+7E/+NuMLSXMfRNTQDEG8xt3YjD92eVzkR/8F6WiU/olrlE0IjKhqkE2WvFdPhxFJxHxSr3P1aWA1pRhf1IBmJCnrjev8yQAM0tS4n5tD/s3ghlDKHgT3C3BZxn+WDmLyOD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJWJinJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C16C4CED3;
	Sat,  1 Feb 2025 17:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738430568;
	bh=Qrdd23R/NIqqOD8tLgPKyOnBoOCKeAuBEzHVsSYAEFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XJWJinJM+3nfxhFEY7ttQzshr6yE3BLsPWJPIjhULKbBvLse0HWIfk6Dy94ChvqdF
	 7mEOL5euYMethN9ygkM1puaCpEhXkt1ysCuBnXtSJ/3IwM0eeURYoj5PANaekLZGli
	 0Wvlq3zVsuhru74+ax6VMG8GjxRwFXg+02achUc4SBAB13EsPJ7nNh3pD1OfhB5six
	 J3Uh+um7YZBF5PFxgfUc9X3r27j9Gt4C/iQIkwZPDTx26wj1qqmy2B9cSDec6AF4vW
	 xY9Uj+uajfhpGFGKOBB4bIaG1VILPXhSKN1qh2n7uNXprtG+Np4EeKDBsdNrePAaM5
	 ISApRCF6zVycQ==
Date: Sat, 1 Feb 2025 17:22:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v1 10/12] iio: accel: adxl345: add freefall feature
Message-ID: <20250201172242.4064b436@jic23-huawei>
In-Reply-To: <20250128120100.205523-11-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
	<20250128120100.205523-11-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:00:58 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the freefall detection of the sensor together with a threshold and
> time parameter. Add sysfs handle to enable/disable the feature and
> introduce another sysfs macro. This is the third sysfs macro for sysfs
> handles of this sensor. The three sysfs macros allow to cover all
> sensor features and parameters.

They might but they are new ABI, without docs and we have a lot of freefall
detectors supported (pretty much all accelerometers support this)
so needing new ABI is a surprise. Key thing as you've noted
on the type is free fall is just detection of approximately zero magnitude
acceleration on all axes at the same time.

That ABI is the way to do this, not something new.

Jonathan


> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 127 +++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index ef0a12fd59be..62d75d28b6fc 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -170,6 +170,9 @@ struct adxl345_state {
>  	u32 tap_window_us;
>  	bool tap_suppressed;
>  
> +	u8 ff_value;
> +	u32 ff_time_ms;
> +
>  	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
>  };
>  
> @@ -187,6 +190,11 @@ static struct iio_event_spec adxl345_events[] = {
>  		.dir = IIO_EV_DIR_DOUBLETAP,
>  		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
>  	},
> +	{
> +		/* free fall */
> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_FALLING,

This is correct, but you invent freefall attributes otherwise?
It should just use attributes of falling magnitude threshold detection.
Lots of existing precedence for this one.

> +	},
>  };
>  
>  #define ADXL345_CHANNEL(index, reg, axis) {					\
> @@ -442,6 +450,61 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
>  	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fract_us);
>  }
>  
> +/* ff */
> +
> +static int adxl345_is_ff_en(struct adxl345_state *st, bool *en)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = adxl345_read_interrupts(st, &regval);
> +	if (ret)
> +		return ret;
> +
> +	*en = FIELD_GET(ADXL345_INT_FREE_FALL, st->int_map) > 0;
> +
> +	return 0;
> +}
> +
> +static int adxl345_set_ff_en(struct adxl345_state *st, bool en)
> +{
> +	bool ff_en = en && st->ff_value > 0 && st->ff_time_ms > 0;
> +
> +	adxl345_intmap_switch_bit(st, ff_en, ADXL345_INT_FREE_FALL);
> +
> +	return adxl345_write_interrupts(st);
> +}
> +
> +static int adxl345_set_ff_value(struct adxl345_state *st, u8 val)
> +{
> +	st->ff_value = val;
> +
> +	return regmap_write(st->regmap, ADXL345_REG_THRESH_FF, val);
This is just a magnitude threshold. Why not use standard ABI?

> +}
> +
> +static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
> +			       u32 val_fract_us)
I'm guessing this is time before free fall detection after falling
below a threshold?

Thats in_accel_mag_falling_period in standard ABI and IIRC is in seconds.


> +{
> +	unsigned int regval;
> +	int val_ms;
> +
> +	/*
> +	 * max value is 255 * 5000 us = 1.275000 seconds
> +	 *
> +	 * Note: the scaling is similar to the scaling in the ADXL380
> +	 */
> +	if (1000000 * val_int + val_fract_us > 1275000)
> +		return -EINVAL;
> +
> +	val_ms = val_int * 1000 + DIV_ROUND_UP(val_fract_us, 1000);
> +	st->ff_time_ms = val_ms;
> +
> +	regval = DIV_ROUND_CLOSEST(val_ms, 5);
> +
> +	/* Values between 100ms and 350ms (0x14 to 0x46) are recommended. */
> +	return regmap_write(st->regmap, ADXL345_REG_TIME_FF, min(regval, 0xff));
> +}
> +
>  static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -711,6 +774,49 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +#define ADXL345_generate_iio_dev_attr_INT(A, B, C)			\
> +	static ssize_t in_accel_##A##_##B##_##C##_show(struct device *dev, \
> +						       struct device_attribute *attr, \
> +						       char *buf)	\
> +	{								\
> +		struct iio_dev *indio_dev = dev_to_iio_dev(dev);	\
> +		struct adxl345_state *st = iio_priv(indio_dev);		\
> +		int val;						\
> +									\
> +		val = st->B##_##C;					\
> +									\
> +		return iio_format_value(buf, IIO_VAL_INT, 1, &val);	\
> +	}								\
> +									\
> +	static ssize_t in_accel_##A##_##B##_##C##_store(struct device *dev, \
> +							struct device_attribute *attr, \
> +							const char *buf, size_t len) \
> +	{								\
> +		struct iio_dev *indio_dev = dev_to_iio_dev(dev);	\
> +		struct adxl345_state *st = iio_priv(indio_dev);		\
> +		int val, ret;						\
> +									\
> +		ret = kstrtoint(buf, 0, &val);				\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		if (val < 0 || val > 255)				\
> +			return -EINVAL;					\
> +									\
> +		ret = adxl345_set_measure_en(st, false);		\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		adxl345_set_##B##_##C(st, val);				\
> +									\
> +		ret = adxl345_set_measure_en(st, true);			\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		return len;						\
> +	}								\
> +	static IIO_DEVICE_ATTR_RW(in_accel_##A##_##B##_##C, 0)
> +
>  #define ADXL345_generate_iio_dev_attr_EN(A, B)				\
>  	static ssize_t in_accel_##A##_##B##_en_show(struct device *dev, \
>  						    struct device_attribute *attr, \
> @@ -798,13 +904,20 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}								\
>  	static IIO_DEVICE_ATTR_RW(in_accel_##A##_##C##_##E, 0)
>  
> +ADXL345_generate_iio_dev_attr_INT(freefall, ff, value);
> +
>  ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_singletap, tap, duration, MICRO, us);
>  ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, window, MICRO, us);
>  ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, latent, MICRO, us);
> +ADXL345_generate_iio_dev_attr_FRACTIONAL(freefall, ff, time, MILLI, ms);
>  
> +ADXL345_generate_iio_dev_attr_EN(freefall, ff);
>  ADXL345_generate_iio_dev_attr_EN(gesture_doubletap, suppressed);
>  
>  static struct attribute *adxl345_event_attrs[] = {
> +	&iio_dev_attr_in_accel_freefall_ff_en.dev_attr.attr,
> +	&iio_dev_attr_in_accel_freefall_ff_value.dev_attr.attr,
> +	&iio_dev_attr_in_accel_freefall_time_ms.dev_attr.attr,
>  	&iio_dev_attr_in_accel_gesture_singletap_duration_us.dev_attr.attr,
>  	&iio_dev_attr_in_accel_gesture_doubletap_suppressed_en.dev_attr.attr,
>  	&iio_dev_attr_in_accel_gesture_doubletap_latent_us.dev_attr.attr,
> @@ -1041,6 +1154,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
>  			return ret;
>  	}
>  
> +	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
> +		ret = iio_push_event(indio_dev,
> +				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							IIO_MOD_X_AND_Y_AND_Z,
> +							IIO_EV_TYPE_MAG,
> +							IIO_EV_DIR_FALLING),
> +				     ts);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return -ENOENT;
>  }
>  
> @@ -1148,6 +1272,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	st->tap_window_us = 20;			/*   20 [0x14] -> .025    */
>  	st->tap_latent_us = 20;			/*   20 [0x14] -> .025    */
>  
> +	st->ff_value = 8;			/*    8 [0x08]            */
> +	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
> +
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &adxl345_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;


