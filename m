Return-Path: <linux-iio+bounces-7746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE689381ED
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 17:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E34281FE8
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B8E1339B1;
	Sat, 20 Jul 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhbakXjn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101C946C;
	Sat, 20 Jul 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721490960; cv=none; b=i9VUrzKmg6ZBoibhupquoF1t6MNmxpHD8mUPTsOA7XjCignhsLQdc3yCcOhwYP7VRQVSPhxlRAH7WZm3HnR7ZcVkaWklKNxRZEs0mNmaZRjkjyawA/kdOrYX53DLuN/6ew2Wge7oY2W1kklM8PHdUuiCVF9j4RTYpywn9UZk4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721490960; c=relaxed/simple;
	bh=ShzJI7c2pubYGlATGAZ4fgsHqN0oEjb4UcXEfs2BNug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1ErN0oU6auJk7EP5ehVyPYMbgnbw6oMfqVxqh9XbER9UHKf3pG7Bsm+I3F85syQD6GtmDOS+6E8Qv0DQiheIVkFzSXMq4vylyNUd32LLDLLEUVFXseKxI5w8WZ9vMLw0iLOXZ+HQVGTZ5VIeVOgwkF/ntHjnnXbgE8J3bOKebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhbakXjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD93C2BD10;
	Sat, 20 Jul 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721490960;
	bh=ShzJI7c2pubYGlATGAZ4fgsHqN0oEjb4UcXEfs2BNug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qhbakXjnJ8guVm5+iCPVhJELgdP+1hl8pf45Jk954OYlIOIX3qO3P2Er3We5ClBES
	 JMslAgSFX9S/fSeoOA48+WpgkaxcdvB0QIer1bS+WTUJ+i7yW0pZKWCw8vZIPJKy/6
	 /rncaTDtHgWxIJqPClA4E7ziZFdnyi54Az4YR2lwhFY171nPcGHgwG6PqfsoBmj3u0
	 lzUoVAcqxrjiUxIh4v+gAJaaVIcbU7bF0p1Vy51SL4LPBLPrh1gRxarOhPpx0CyOZu
	 Y/V4bGWQAy9sMNMXcAWTBdRG1LeyXAhhjdo99PHEBVAWi4yL9RliiJJDlQNPq6PadR
	 m4p3IOdXCgPCQ==
Date: Sat, 20 Jul 2024 16:55:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>, anshulusr@gmail.com
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr390: Add configurable gain, resolution
 and ALS reading
Message-ID: <20240720165554.5fd16ca0@jic23-huawei>
In-Reply-To: <20240718104947.7384-1-abhashkumarjha123@gmail.com>
References: <20240718104947.7384-1-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 16:19:45 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

>  1) Add support for configuring the gain and resolution(integration time)
>     for the sensor.
>  2) Add a channel for ALS and provide support for reading the raw and
>     scale values.
>  3) Add automatic mode switching between UVS and ALS based on the
>     channel type.
>  4) Calculate 'counts_per_uvi' based on the current gain and integration
>     time.

Hi Abhash,

When a patch lists more than one thing, key thing to think is
"maybe this should be multiple patches?"

Here at very least separate resolution / gain into one or two patches
and the new channel support into another.
Probably yet another patch for point 4,

Various other comments inline.

Jonathan

> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
> ---
>  drivers/iio/light/ltr390.c | 256 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 238 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index fff1e8990..56f3c74ae 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -25,19 +25,33 @@
>  #include <linux/regmap.h>
>  
>  #include <linux/iio/iio.h>
> -
> +#include <linux/iio/sysfs.h>

>  #include <asm/unaligned.h>
>  
>  #define LTR390_MAIN_CTRL      0x00
>  #define LTR390_PART_ID	      0x06
>  #define LTR390_UVS_DATA	      0x10
>  
> +#define LTR390_ALS_DATA       0x0D
> +#define LTR390_ALS_UVS_GAIN   0x05
> +#define LTR390_ALS_UVS_MEAS_RATE 0x04
> +#define LTR390_INT_CFG           0x19
If these are register addresses put them in numeric order so
it is easy to compare with a datasheet table

> +
>  #define LTR390_SW_RESET	      BIT(4)
>  #define LTR390_UVS_MODE	      BIT(3)
>  #define LTR390_SENSOR_ENABLE  BIT(1)
>  
>  #define LTR390_PART_NUMBER_ID 0xb
>  
> +#define LTR390_ALS_UVS_GAIN_MASK 0x07
> +#define LTR390_ALS_UVS_INT_TIME_MASK 0x70
> +#define LTR390_ALS_UVS_INT_TIME_MASK_SHIFT 4

Used FIELD_GET() and FIELD_PREP() then you never
need a separate SHIFT defintion.

> +
> +#define LTR390_SET_ALS_MODE 1
> +#define LTR390_SET_UVS_MODE 2

If these are being use to pick options and not writen to hw
use an enum.  I don't think we care what value they take.


> +
> +#define LTR390_FRACTIONAL_PRECISION 100
> +
>  /*
>   * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
>   * the sensor are equal to 1 UV Index [Datasheet Page#8].
> @@ -60,6 +74,9 @@ struct ltr390_data {
>  	struct i2c_client *client;
>  	/* Protects device from simulataneous reads */
>  	struct mutex lock;
> +	int mode;
> +	int gain;
> +	int int_time_us;
>  };
>  
>  static const struct regmap_config ltr390_regmap_config = {
> @@ -87,36 +104,232 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
>  	return get_unaligned_le24(recieve_buffer);
>  }
>  
> +
one blank line is neough.

> +static int ltr390_set_mode(struct ltr390_data *data, int mode)
As suggested above, use an enum for mode. Give than a type name and you
can use that here.

> +{
> +	if (data->mode == mode)
> +		return 0;
> +
> +	if (mode == LTR390_SET_ALS_MODE) {
> +		regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
> +		data->mode = LTR390_SET_ALS_MODE;
> +	} else if (mode == LTR390_SET_UVS_MODE) {
> +		regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
> +		data->mode = LTR390_SET_UVS_MODE;
Drop this out of the if / else stack and use
	data->mode = mode;
A switch statement may be more appropriate here even if it's a few more lines of
code.

> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ltr390_counts_per_uvi(struct ltr390_data *data)
> +{
> +	int orig_gain = 18;
> +	int orig_int_time = 400;
> +	int divisor = orig_gain * orig_int_time;
> +	int gain = data->gain;
> +
> +	int int_time_ms = DIV_ROUND_CLOSEST(data->int_time_us, 1000);
> +	int uvi = DIV_ROUND_CLOSEST(2300*gain*int_time_ms, divisor);

Spaces around *

> +
> +	return uvi;
> +}
> +
>  static int ltr390_read_raw(struct iio_dev *iio_device,
>  			   struct iio_chan_spec const *chan, int *val,
>  			   int *val2, long mask)
>  {
> -	int ret;
>  	struct ltr390_data *data = iio_priv(iio_device);
> +	int ret;
Don't move code unless there is a strong reason. Fine to
tidy this sort of thing up, but not in a patch doing anything else
as it becomes noise.

>  
Almost certainly need locking here as concurrent accesses to sysfs
files will result in mode changing whilst the read has not yet happened.

>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = ltr390_register_read(data, LTR390_UVS_DATA);
> -		if (ret < 0)
> -			return ret;
> +		switch (chan->type) {
> +		case IIO_UVINDEX:
> +			ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
> +			if (ret < 0)
> +				return ret;
> +
> +		    ret = ltr390_register_read(data, LTR390_UVS_DATA);
Fix the alignment - looks like mix of spaces and tabs.
scripts/checkpatch.pl would have pointed that out.

> +			if (ret < 0)
> +				return ret;
> +
> +			break;
> +
> +		case IIO_INTENSITY:
> +			ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = ltr390_register_read(data, LTR390_ALS_DATA);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +
> +		default:
> +			ret = -EINVAL;
return here. Otherwise you overwrite the value below.

> +		}
> +
>  		*val = ret;
> -		return IIO_VAL_INT;
> +		ret = IIO_VAL_INT;
return here and drop the break.
It is much simpler to follow code if it doesn't unnecessarily not
return in cases like this as we have to scroll down to see if anything else
happens.

> +		break;
> +
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = LTR390_WINDOW_FACTOR;
> -		*val2 = LTR390_COUNTS_PER_UVI;
> -		return IIO_VAL_FRACTIONAL;
> +		mutex_lock(&data->lock);
Add appropriate scope using {} and use 
guard(mutex)(&data->lock) as then in error paths you can 
return without unlocking...
> +
> +		switch (chan->type) {
> +		case IIO_UVINDEX:
> +			ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
> +			if (ret < 0)
mutex held. Result is deadlock.  Above scoped unlocking avoids that without
needing to make sure you unlock in all paths.


> +				return ret;
> +
> +			*val = LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL_PRECISION;
> +			*val2 = ltr390_counts_per_uvi(data);
> +			ret = IIO_VAL_FRACTIONAL;
return here.

> +			break;
> +
> +		case IIO_INTENSITY:
> +			ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val = LTR390_WINDOW_FACTOR;
> +			*val2 = data->gain;
> +
> +			ret = IIO_VAL_FRACTIONAL;
> +			break;
return here.
> +
> +		default:
> +			ret = -EINVAL;
return here.
> +		}
> +
> +		mutex_unlock(&data->lock);
With guard() change above, not needed.
But close scope here with }
> +		break;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		mutex_lock(&data->lock);
Given all paths other than invalid ones need the lock, maybe just take
it outside of the switch statement - still use guard() though to avoid
need to manually unlock.

> +		*val = data->int_time_us;
> +		mutex_unlock(&data->lock);
> +		ret = IIO_VAL_INT;
> +		break;
> +
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
> +
> +	return ret;
This is a bad change as now I need to read to end of function in all
code paths.  Some code styles insist on single exit points, but
the kernel style does not. (not worth a long discussion of why the
two common styles came about). Keep those early returns.


>  }
>  
> -static const struct iio_info ltr390_info = {
> -	.read_raw = ltr390_read_raw,
> +/* integration time in us */
> +static const int ltr390_int_time_map_us[] = {400000, 200000, 100000, 50000, 25000, 12500};
> +static const int ltr390_gain_map[] = {1, 3, 6, 9, 18};
> +
> +static IIO_CONST_ATTR_INT_TIME_AVAIL("400000 200000 100000 50000 25000 12500");
Please use read_avail() callback and the appropriate mask to provide this.
That enables it to be used from in kernel consumers and enforces the
ABI without a reviewer having to check what you have aligns.

> +static IIO_CONST_ATTR(gain_available, "1 3 6 9 18");
Given we don't have a 'gain' control, what is the available applying to?

> +
> +static struct attribute *ltr390_attributes[] = {
> +	&iio_const_attr_integration_time_available.dev_attr.attr,
> +	&iio_const_attr_gain_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ltr390_attribute_group = {
> +	.attrs = ltr390_attributes,
>  };
>  
> -static const struct iio_chan_spec ltr390_channel = {
> +static const struct iio_chan_spec ltr390_channels[] = {
> +	/* UV sensor */
> +	{
>  	.type = IIO_UVINDEX,
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)
> +	.scan_index = 0,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)
Fix style.
	{
		.type = ...

> +	},
> +	/* ALS sensor */
> +	{
> +	.type = IIO_INTENSITY,
> +	.scan_index = 1,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)
> +	},
> +};
> +
> +static int ltr390_set_gain(struct ltr390_data *data, int val)
> +{
> +	int ret, idx;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(ltr390_gain_map); idx++) {
> +		if (ltr390_gain_map[idx] == val) {
> +			mutex_lock(&data->lock);
guard here.
> +			ret = regmap_update_bits(data->regmap,
> +						LTR390_ALS_UVS_GAIN,
> +						LTR390_ALS_UVS_GAIN_MASK, idx);
> +			if (!ret)
			if (ret)
				return ret;
prefer to keep error paths as the out of line ones as if you review
a lot of code, predictability helps review quickly.

> +				data->gain = ltr390_gain_map[idx];
> +
> +			mutex_unlock(&data->lock);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ltr390_set_int_time(struct ltr390_data *data, int val)
> +{
> +	int ret, idx;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(ltr390_int_time_map_us); idx++) {
> +		if (ltr390_int_time_map_us[idx] == val) {
flip logic to reduce indent.
		if (ltr390_int_time_map_us[idx] != val)
			continue;

		guard(mutex)...

> +			mutex_lock(&data->lock);
> +			ret = regmap_update_bits(data->regmap,
> +						LTR390_ALS_UVS_MEAS_RATE,
> +						LTR390_ALS_UVS_INT_TIME_MASK,
> +						idx<<LTR390_ALS_UVS_INT_TIME_MASK_SHIFT);
spaces around << 
Though FIELD_PREP() probably better solution.

> +			if (!ret)
As in previous funciton.
> +				data->int_time_us = ltr390_int_time_map_us[idx];
> +
> +			mutex_unlock(&data->lock);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +				int val, int val2, long mask)
> +{
> +	struct ltr390_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (val2 != 0)
> +			ret = -EINVAL;
> +
> +		ret = ltr390_set_gain(data, val);
> +		break;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val2 != 0)
> +			ret = -EINVAL;
> +
> +		ret = ltr390_set_int_time(data, val);
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
Use early returns.

> +}
> +
> +static const struct iio_info ltr390_info = {
> +	.attrs = &ltr390_attribute_group,
> +	.read_raw = ltr390_read_raw,
> +	.write_raw = ltr390_write_raw,
>  };
>  
>  static int ltr390_probe(struct i2c_client *client)
> @@ -139,11 +352,18 @@ static int ltr390_probe(struct i2c_client *client)
>  				     "regmap initialization failed\n");
>  
>  	data->client = client;
> +	/* default value of int time from pg: 15 of the datasheet */
I'd spell out integration in the comment.

> +	data->int_time_us = 100000;
> +	/* default value of gain from pg: 16 of the datasheet */
> +	data->gain = 3;
> +	/* default mode for ltr390 is ALS mode */
> +	data->mode = LTR390_SET_ALS_MODE;
> +
>  	mutex_init(&data->lock);
>  
>  	indio_dev->info = &ltr390_info;
> -	indio_dev->channels = &ltr390_channel;
> -	indio_dev->num_channels = 1;
> +	indio_dev->channels = ltr390_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ltr390_channels);
>  	indio_dev->name = "ltr390";
>  
>  	ret = regmap_read(data->regmap, LTR390_PART_ID, &part_number);
> @@ -161,8 +381,7 @@ static int ltr390_probe(struct i2c_client *client)
>  	/* Wait for the registers to reset before proceeding */
>  	usleep_range(1000, 2000);
>  
> -	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
> -			      LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
> +	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
>  
> @@ -189,6 +408,7 @@ static struct i2c_driver ltr390_driver = {
>  	.probe = ltr390_probe,
>  	.id_table = ltr390_id,
>  };
> +
Lack of space is intentional to keep the macro closely coupled to what
it applies to.

>  module_i2c_driver(ltr390_driver);
>  
>  MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");


