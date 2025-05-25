Return-Path: <linux-iio+bounces-19909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A825AC35DC
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 19:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92C61700B0
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 17:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B843325A344;
	Sun, 25 May 2025 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hkz0mitA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B025A2C4;
	Sun, 25 May 2025 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748193550; cv=none; b=CBSH+BI1QTWYst2iLR9dTlEOu4NNb+BRXh0zY0VkBJFpKnRcvp+WFJBdHVbAx3bpm2N3EZPS9yd/x/+kJx4X/TM95WR3zyOr5OG0DRuiLAEeu0rQJyKdhNgnH9q01rZtxREAw49kywPi7jYbbKkb1e5NNYolmb3U0OtPadM6Cog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748193550; c=relaxed/simple;
	bh=wzdqww6ipZYx/fUMVqpLvbRSpz4uleCFxOyB1MNIyZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2v/IwE9qV/I9RLsGPd7K6az940B9vGR97J6zVTLD2ZQ2BSGO1NlWtQbvSDagMv4p6pJGdn1moSBX6D31Z/+3Ho7ErMVTqzHY0Jm20slnehP7m11/WvGBnoZ+W4o5PgPOwnvqPEt7qDEb62ErNSM7tIQxdOGMfBePrbyA7VY9DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hkz0mitA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F93C4CEEA;
	Sun, 25 May 2025 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748193549;
	bh=wzdqww6ipZYx/fUMVqpLvbRSpz4uleCFxOyB1MNIyZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hkz0mitAlhTZYyINs9DxDnFlonxhnfc1CrMT2YXQ0xFhGmRJUGA/FzW/+NGnzikX0
	 EMtqueQWpxUvnHkAtGE8IFqBaG5k4KQrISsa1N5Z4WwMHtTtqQyoX+PD9hPuZuO9Gp
	 haJbLVkDq/0eZyuAOo4wNuDvy3HIFC7kO3CA3kTFMWNA8B+jF2T3S7ZwefLr1q4zi7
	 5NSQsIByNM2DE9mdawdaIANmNXCQM8qYu9QJ1xqt2dhJE0MwZFEElhPjYnPAT7h06P
	 tuEIQJeXS+FJaOOgdMGYYdGhQ5ZOf97SkT4EmZyHG3VZEJ05VixJzORoA0XxOMNHyf
	 SfgVm2vIriY+A==
Date: Sun, 25 May 2025 18:19:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v8 6/7] iio: accel: adxl345: add freefall feature
Message-ID: <20250525181902.72178be9@jic23-huawei>
In-Reply-To: <20250510224405.17910-7-l.rubusch@gmail.com>
References: <20250510224405.17910-1-l.rubusch@gmail.com>
	<20250510224405.17910-7-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 May 2025 22:44:04 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the freefall detection of the sensor together with a threshold and
> time parameter. A freefall magnitude event is detected if the measuring
> signal falls below the threshold.
> 
> Introduce a freefall threshold stored in regmap cache, and a freefall
> time, having the scaled time value stored as a member variable in the
> state instance.
> 
> The generated IIO event is a magnitude event on x&y&z and thus identical
> to what inactivity (with DC-coupling default) would generate. Thus a
> separate set of sysfs handles are setup to configure and enable freefall
> events.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

Up until here all looked good to me but the custom ABI in here 
would need documenting in Documentation/ABI/testing/sysfs-bus-iio* and
runs into the normal problem with custom ABI. It's basically pointless
because no generic code will use it.  Current code assume freefall
is a standard magnitude falling threshold on X&Y&Z.

So it doesn't provide a solution for inactivity DC and freefall effectively
being the same type of detection with different timing parameters.

The only thing I have come up with that is at least close to standard
ABI in this annoying corner case is to use an additional fake channel
with it's own controls as in_accel1_X&Y&Z_*
We can use label to indicate to a user that it is meant for freefall but
labels are also effectively custom ABI (though ABI that is easy to just
pass through to a user interface) so that's not great.  Also, so far
the concept of multiple 'fake' channels isn't a thing so userspace is
unlikely to cope with that well either.

The decision way back to not have multiple events of one type on a given
channel has bitten us a few times before, but this is a little unusual
in that it's not just stacked threshold like you get on hwmon chips where
people don't want to keep changing thresholds when warning levels are
passed because of that temporal element. Those can be dealt with via
more sophisticated userspace code.

No comments below. I haven't looked closely given this fundamental
ABI difference.

Maybe best bet is mere everything other than freefall detection and
basically kick this into the long grass until we figure out a solution that
can sit in the normal ABI without breaking old software (which a change
to a new free fall interface would unfortunately do.)

Sorry not to have a better idea :(

Jonathan


> ---
>  drivers/iio/accel/adxl345_core.c | 226 +++++++++++++++++++++++++++++++
>  1 file changed, 226 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index c6f75d6b0db9..c35a5727852c 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -193,6 +193,7 @@ struct adxl345_state {
>  	u32 tap_duration_us;
>  	u32 tap_latent_us;
>  	u32 tap_window_us;
> +	u32 ff_time_ms;
>  
>  	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
>  };
> @@ -825,6 +826,63 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
>  	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fract_us);
>  }
>  
> +/* free-fall */
> +
> +static int adxl345_is_ff_en(struct adxl345_state *st, bool *en)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
> +	if (ret)
> +		return ret;
> +
> +	*en = FIELD_GET(ADXL345_INT_FREE_FALL, regval) > 0;
> +
> +	return 0;
> +}
> +
> +static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
> +{
> +	unsigned int regval, ff_threshold;
> +	bool en;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &ff_threshold);
> +	if (ret)
> +		return ret;
> +
> +	en = cmd_en && ff_threshold > 0 && st->ff_time_ms > 0;
> +
> +	regval = en ? ADXL345_INT_FREE_FALL : 0x00;
> +
> +	return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> +				  ADXL345_INT_FREE_FALL, regval);
> +}
> +
> +static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
> +			       u32 val_fract_us)
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
>  static int adxl345_find_odr(struct adxl345_state *st, int val,
>  			    int val2, enum adxl345_odr *odr)
>  {
> @@ -1689,6 +1747,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
>  	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
>  		samples = adxl345_get_samples(st);
>  		if (samples < 0)
> @@ -1763,7 +1832,156 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> +/* free-fall sysfs */
> +
> +static ssize_t in_accel_mag_freefall_en_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	bool en;
> +	int val, ret;
> +
> +	ret = adxl345_is_ff_en(st, &en);
> +	if (ret)
> +		return ret;
> +
> +	val = en ? 1 : 0;
> +
> +	return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> +}
> +
> +static ssize_t in_accel_mag_freefall_en_store(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	int val, ret;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = adxl345_set_measure_en(st, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = adxl345_set_ff_en(st, val > 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = adxl345_set_measure_en(st, true);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +static IIO_DEVICE_ATTR_RW(in_accel_mag_freefall_en, 0);
> +
> +static ssize_t in_accel_mag_freefall_value_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &val);
> +	if (ret)
> +		return ret;
> +
> +	return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> +}
> +
> +static ssize_t in_accel_mag_freefall_value_store(struct device *dev,
> +						 struct device_attribute *attr,
> +						 const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	int val, ret;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val < 0 || val > 255)
> +		return -EINVAL;
> +
> +	ret = adxl345_set_measure_en(st, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADXL345_REG_THRESH_FF, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = adxl345_set_measure_en(st, true);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +static IIO_DEVICE_ATTR_RW(in_accel_mag_freefall_value, 0);
> +
> +static ssize_t in_accel_mag_freefall_period_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	int vals[2];
> +
> +	vals[0] = st->ff_time_ms;
> +	vals[1] = 1000;
> +
> +	return iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, vals);
> +}
> +
> +static ssize_t in_accel_mag_freefall_period_store(struct device *dev,
> +						  struct device_attribute *attr,
> +						  const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	int val_int, val_fract_us, ret;
> +
> +	ret = iio_str_to_fixpoint(buf, 100000, &val_int, &val_fract_us);
> +	if (ret)
> +		return ret;
> +
> +	ret = adxl345_set_measure_en(st, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = adxl345_set_ff_time(st, val_int, val_fract_us);
> +	if (ret)
> +		return ret;
> +
> +	ret = adxl345_set_measure_en(st, true);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +static IIO_DEVICE_ATTR_RW(in_accel_mag_freefall_period, 0);
> +
> +static struct attribute *adxl345_event_attrs[] = {
> +	&iio_dev_attr_in_accel_mag_freefall_en.dev_attr.attr,
> +	&iio_dev_attr_in_accel_mag_freefall_value.dev_attr.attr,
> +	&iio_dev_attr_in_accel_mag_freefall_period.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group adxl345_event_attrs_group = {
> +	.attrs = adxl345_event_attrs,
> +};
> +
>  static const struct iio_info adxl345_info = {
> +	.event_attrs    = &adxl345_event_attrs_group,
>  	.read_raw	= adxl345_read_raw,
>  	.write_raw	= adxl345_write_raw,
>  	.read_avail	= adxl345_read_avail,
> @@ -1806,6 +2024,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  					 ADXL345_DATA_FORMAT_FULL_RES |
>  					 ADXL345_DATA_FORMAT_SELF_TEST);
>  	unsigned int tap_threshold;
> +	unsigned int ff_threshold;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> @@ -1825,6 +2044,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
>  	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
>  
> +	ff_threshold = 8;			/*    8 [0x08]            */
> +	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
> +
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &adxl345_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -1936,6 +2158,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		if (ret)
>  			return ret;
>  
> +		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_FF, ff_threshold);
> +		if (ret)
> +			return ret;
> +
>  		/* FIFO_STREAM mode is going to be activated later */
>  		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
>  		if (ret)


