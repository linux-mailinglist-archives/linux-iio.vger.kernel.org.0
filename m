Return-Path: <linux-iio+bounces-14840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F20FA24AE5
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 18:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620A23A6C6A
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A98619341F;
	Sat,  1 Feb 2025 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NumRh9T8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD88AD27;
	Sat,  1 Feb 2025 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738429352; cv=none; b=T0RFIhIOMqZiC2wJSYwf53ewclDj4HLIZTMg5CtbxVxlvy3UwCRHBR/f9NFQ3XrKu0mYf5kv0g1QBMcfUkX1zG8BzNtCePjiekyAuCO0f3evJrvoQAxn+BiG6kU940RQQ72fsVAR84xjZWlNQGD8iD0ePh9xyKXDbt3E+rTthUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738429352; c=relaxed/simple;
	bh=N4tUYMt3N8wj46g18tQ4S48TU0ZKW0DQFm4aSP9j/pE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWCjWWHxuQS2n3YkGO3f6u+4cNBmVfbQiWRoyZPjCt3jB1hSbrAUesWxJecdqqzGYaRQyQxJQWxY8tAingbyffLmT7BGhm0E4Ws1o5YQfq9mG5nPoZlcpyQb6GnGzF/3FnWkZJxp1nTKVLa0qpMxagwZOSjAaMxhbrDyfvbbTjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NumRh9T8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18309C4CED3;
	Sat,  1 Feb 2025 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738429351;
	bh=N4tUYMt3N8wj46g18tQ4S48TU0ZKW0DQFm4aSP9j/pE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NumRh9T8cMwrtj5iApYTLmcWhBvseJECylTA6VINL63CRlacaatFYPWS5U2TYj7MC
	 AziHGQaHtrUvca7S1izECa7hNPf7HLFx+WRIKiZsxdlKX6DHZ/tmkxuz3sjz2DgXNR
	 XypcR2ZcSTx3P+1FdEkti/1y20zLV9F/NOY9Ik70xJ7d2jerjD9vQrU0y3ZSD0QfdE
	 GRz75Kvp3FIQBfVM+WH7wk/2l+VvAhKpKiqD3gqrbkPYt90AoAoW+5hISfLve8WdDQ
	 0ZBNMS63juAHboq9eKf4IbiZjJolfQZjXXqBn/23A5i4sL48M9s/v1ElBDBGcma7VI
	 E2nXU3V8t7V0g==
Date: Sat, 1 Feb 2025 17:02:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v1 06/12] iio: accel: adxl345: add single tap feature
Message-ID: <20250201170225.35d06934@jic23-huawei>
In-Reply-To: <20250128120100.205523-7-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
	<20250128120100.205523-7-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:00:54 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the single tap feature with a threshold in 62.5mg/LSB points and a
> scaled duration in us. Keep singletap threshold by means of IIO but add
> sysfs entry for the duration. Using a sysfs entry allow for a clearer
> naming of the handle to improve usage. Extend the channels for single
> enable x/y/z axis of the feature but also check if threshold (a.k.a
> "value") and duration have reasonable content. When an interrupt is
> caught it will be pushed to the according IIO channel.
> 
> The function call structure is in preparation to be extended for an
> upcoming doubletap feature in the follow up patches.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
The duration ABI isn't standard, so it should come with ABI docs and
some explanation of why we can't use existing ABI.  The postfix of _us
whilst it seems sensible is not inline with existing IIO ABI. Times
are always in seconds.

> +static inline void adxl345_intmap_switch_bit(struct adxl345_state *st,
> +					     bool condition, u8 bit)
> +{
> +	st->int_map = condition ? st->int_map | bit : st->int_map & ~bit;

I'm not convinced the wrapper is that useful.
Maybe can use __clear_bit() and __set_bit()

> +}
> +
> +static inline int adxl345_read_interrupts(struct adxl345_state *st,
> +					  unsigned int *interrupts)
> +{
> +	return regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, interrupts);

I don't see an advantage in this wrapper.  Why not just call regmap
directly. It's pretty self documenting!

> +}
> +
>  static inline int adxl345_write_interrupts(struct adxl345_state *st)
>  {
>  	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
>  }

>  static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -275,6 +413,141 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  					  ADXL345_BW_RATE,
>  					  clamp_val(ilog2(n), 0,
>  						    ADXL345_BW_RATE));
> +	default:
> +		return -EINVAL;
> +	}
> +
Doubt we can get here.


> +	return -EINVAL;
> +}
> +
> +static int adxl345_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	bool int_en;
> +	bool axis_en;
> +	int ret = -EFAULT;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (dir) {
> +		case IIO_EV_DIR_SINGLETAP:
> +			switch (chan->channel2) {
> +			case IIO_MOD_X:
> +				axis_en = FIELD_GET(ADXL345_X_EN, st->tap_axis_ctrl);
> +				break;
> +			case IIO_MOD_Y:
> +				axis_en = FIELD_GET(ADXL345_Y_EN, st->tap_axis_ctrl);
> +				break;
> +			case IIO_MOD_Z:
> +				axis_en = FIELD_GET(ADXL345_Z_EN, st->tap_axis_ctrl);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +
> +			ret = adxl345_is_tap_en(st, &int_en);
> +			if (ret)
> +				return ret;
> +			return int_en && axis_en;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;

Can't get here I think.

> +}

> +#define ADXL345_generate_iio_dev_attr_FRACTIONAL(A, B, C, D, E)		\
> +	static ssize_t in_accel_##A##_##C##_##E##_show(struct device *dev, \
> +						       struct device_attribute *attr, \
> +						       char *buf)	\
> +	{								\
> +		struct iio_dev *indio_dev = dev_to_iio_dev(dev);	\
> +		struct adxl345_state *st = iio_priv(indio_dev);		\
> +		int vals[2];						\
> +									\
> +		vals[0] = st->B##_##C##_##E;				\
> +		vals[1] = D;						\
> +									\
> +		return iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, vals); \
> +	}								\
> +									\
> +	static ssize_t in_accel_##A##_##C##_##E##_store(struct device *dev, \
> +							struct device_attribute *attr, \
> +							const char *buf, size_t len) \
> +	{								\
> +		struct iio_dev *indio_dev = dev_to_iio_dev(dev);	\
> +		struct adxl345_state *st = iio_priv(indio_dev);		\
> +		int val_int, val_fract_us, ret;				\
> +									\
> +		ret = iio_str_to_fixpoint(buf, 100000, &val_int, &val_fract_us); \
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		ret = adxl345_set_measure_en(st, false);		\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		adxl345_set_##B##_##C(st, val_int, val_fract_us);	\
> +									\
> +		ret = adxl345_set_measure_en(st, true);			\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		return len;						\
> +	}								\
> +	static IIO_DEVICE_ATTR_RW(in_accel_##A##_##C##_##E, 0)
> +
> +ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_singletap, tap, duration, MICRO, us);
> +
> +static struct attribute *adxl345_event_attrs[] = {
> +	&iio_dev_attr_in_accel_gesture_singletap_duration_us.dev_attr.attr,

New ABI so I should be seeing ABI docs.
Also durations (anything time related) in IIO ABI is in seconds.
Does this not map to existing documented ABI of
in_accel_gesture_tap_wait_dur?


> +	NULL
> +};
> +
> +static const struct attribute_group adxl345_event_attrs_group = {
> +	.attrs = adxl345_event_attrs,
> +};
> +
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
>  "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
>  );
> @@ -477,6 +802,17 @@ static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
>  
>  static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat)
>  {
> +	unsigned int regval;
> +	bool check_tap_stat;
> +
> +	check_tap_stat = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0;
> +
> +	if (check_tap_stat) {
> +		/* ACT_TAP_STATUS should be read before clearing the interrupt */
> +		if (regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval))
> +			return -EINVAL;
Don't eat the return value. It might be useful.
		ret = regmap_read()
		if (ret)
			return ret;
> +	}
> +
>  	return regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, int_stat);
>  }
>  
> @@ -499,6 +835,25 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
>  	return 0;
>  }

>  /**
>   * adxl345_irq_handler() - Handle irqs of the ADXL345.
>   * @irq: The irq being handled.
> @@ -516,6 +871,9 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
>  	if (adxl345_get_status(st, &int_stat))
>  		return IRQ_NONE;
>  
> +	if (adxl345_push_event(indio_dev, int_stat) == 0)
> +		return IRQ_HANDLED;

Can have multiple interrupts at once. Say an event that happens to
occur very close to watermark. So I'd normally expect to
carry on looking for interrupts.

> +
>  	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
>  		samples = adxl345_get_samples(st);
>  		if (samples < 0)
> @@ -538,9 +896,14 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
>  
>  static const struct iio_info adxl345_info = {
>  	.attrs		= &adxl345_attrs_group,
> +	.event_attrs	= &adxl345_event_attrs_group,
>  	.read_raw	= adxl345_read_raw,
>  	.write_raw	= adxl345_write_raw,
>  	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
> +	.read_event_config = adxl345_read_event_config,
> +	.write_event_config = adxl345_write_event_config,
> +	.read_event_value = adxl345_read_event_value,
> +	.write_event_value = adxl345_write_event_value,
>  	.debugfs_reg_access = &adxl345_reg_access,
>  	.hwfifo_set_watermark = adxl345_set_watermark,
>  };
> @@ -588,6 +951,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  
>  	st->int_map = 0x00;			/* reset interrupts */
>  
> +	/* Init with reasonable values */
> +	st->tap_threshold = 35;			/*   35 [0x23]            */
> +	st->tap_duration_us = 3;		/*    3 [0x03] -> .001875 */
> +
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &adxl345_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;


