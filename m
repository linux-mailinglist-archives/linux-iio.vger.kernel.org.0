Return-Path: <linux-iio+bounces-23606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19991B3EE72
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59E8202789
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF3A324B33;
	Mon,  1 Sep 2025 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSjwRMrB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E224418E;
	Mon,  1 Sep 2025 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755099; cv=none; b=iHHwCR86ClW8JdGUTvDEy8Zjh/YokND7Amen7rEv/bVG7dwmLqiTV3Xug78103a0+0MIOFyOShxf+EPwVY8Q20+8O4Ey0vHpCnaQaOfWC3gBS5grk/GDJDjI0APRMdKJutMXgoTTilZ5HGmC7hlFPUdgWXBYUoDwRNTID4hQP7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755099; c=relaxed/simple;
	bh=NTby/5qv9UMJZy8xJodO3NSu50NvsjG5wh6DJg4/YSc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSfM7ZnazhcHiraU5RSMNgcG9Fu+Cnv3u+he0D1UOsgHcpj+6kzWByE6WROTwRRRjk8uXlzu2W/DRHXco0/EQ/Oh6BLSXm86i1jLF18QxFMTAlMBIPMXw/ZDYndVM2E1s6IehW86wS4DM4WZewhHOv2rZEOhjXrQgsFxrr4S0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSjwRMrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45148C4CEF0;
	Mon,  1 Sep 2025 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756755099;
	bh=NTby/5qv9UMJZy8xJodO3NSu50NvsjG5wh6DJg4/YSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lSjwRMrB4TaWH3NYpLGS3tdlJt1/rmgkCyhu8164qj4+LIoVy8kdz3nILOwlRAw5D
	 Wl7A6fEg8y4dtePUhZmStTlgWITtPvgJnZ5wgbKEtSMLmDsa3TYz8e3Xwr8XNTBhws
	 dUfhuSm5P5eeAmDdyELaHWd1QS5WWtNrVBSmJ+pDkxznVdHJF5++9Ceoi1rXPu4USP
	 l+ydk/628BT+BFv6YLDLvka7WWK8aXdZhu2gcnD9w7F/9OoY0bfr0vrMeKuxXplq+D
	 NOrHJ4N03fWN7pOGTWSkgoh7mhwVuELNmuJr0zgHN8amBIdeOskOYB0SjNCRZD72av
	 sL7RU0m0ZM8jg==
Date: Mon, 1 Sep 2025 20:31:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 3/5] iio: imu: icm20948: add support for gyroscope
Message-ID: <20250901203129.6a5e2e09@jic23-huawei>
In-Reply-To: <20250831-icm20948-v1-3-1fe560a38de4@gmail.com>
References: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com>
	<20250831-icm20948-v1-3-1fe560a38de4@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Aug 2025 00:12:47 +0530
Bharadwaj Raju <bharadwaj.raju777@gmail.com> wrote:

> Add support for reading the gyroscope, which is exposed as another IIO
> device under the icm20948 driver.
> 
> For now, the only configuration supported is changing the full-scale
> range.
> 
> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>

Some questions on earlier patch follow through to here.

Also check your patches for the sort of reformatting you have here.
It's both wrong and if it were correct it should have been in the
earlier patch.

Jonathan

> ---
>  drivers/iio/imu/inv_icm20948/Makefile            |   1 +
>  drivers/iio/imu/inv_icm20948/inv_icm20948.h      |  78 ++++--
>  drivers/iio/imu/inv_icm20948/inv_icm20948_core.c |  55 ++--
>  drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c | 343 +++++++++++++++++++++++
>  4 files changed, 432 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm20948/Makefile b/drivers/iio/imu/inv_icm20948/Makefile
> index c508c2dc3eee2c32be20067e3e0868a203d8aa1a..88a37be159e1d6f575da1c070c84ac94cd963020 100644
> --- a/drivers/iio/imu/inv_icm20948/Makefile
> +++ b/drivers/iio/imu/inv_icm20948/Makefile
> @@ -3,6 +3,7 @@
>  obj-$(CONFIG_INV_ICM20948) += inv-icm20948.o
>  inv-icm20948-y += inv_icm20948_core.o
>  inv-icm20948-y += inv_icm20948_temp.o
> +inv-icm20948-y += inv_icm20948_gyro.o
>  
>  obj-$(CONFIG_INV_ICM20948_I2C) += inv-icm20948-i2c.o
>  inv-icm20948-i2c-y += inv_icm20948_i2c.o
> diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948.h b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
> index f9830645fbe96fd02eef7c54d1e5908647d5a0fe..ca2513114378cdcba5bc315fc94cd61f930b4dfa 100644
> --- a/drivers/iio/imu/inv_icm20948/inv_icm20948.h
> +++ b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
> @@ -3,45 +3,83 @@
>   * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
>   */
>  

>  
>  extern int inv_icm20948_core_probe(struct regmap *regmap);
>  
>  struct iio_dev *inv_icm20948_temp_init(struct inv_icm20948_state *state);
> +struct iio_dev *inv_icm20948_gyro_init(struct inv_icm20948_state *state);
>  
> -#endif
> + #endif
> diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
> index ee9e4159cffa261f0326b146a4b3df2cbfbd7697..eb4f940de7013bf4ddeb69b6380a60fbde49964a 100644
> --- a/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
> +++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
>   */
>  
> -#include "inv_icm20948.h"
> + #include "inv_icm20948.h"

Definitely not.
Please run checkpatch.pl over each patch in turn.

>  
>  static const struct regmap_range_cfg inv_icm20948_regmap_ranges[] = {
>  	{
> @@ -66,36 +66,41 @@ EXPORT_SYMBOL_NS_GPL(inv_icm20948_regmap_config, "IIO_ICM20948");
>  
>  static int inv_icm20948_setup(struct inv_icm20948_state *state)
>  {
> -	guard(mutex)(&state->lock);
> -
> -	int reported_whoami;
> -	int ret = regmap_read(state->regmap, INV_ICM20948_REG_WHOAMI,
> -			      &reported_whoami);
> -	if (ret)
> -		return ret;
> -	if (reported_whoami != INV_ICM20948_WHOAMI) {
> -		dev_err(state->dev, "invalid whoami %d, expected %d\n",
> -			reported_whoami, INV_ICM20948_WHOAMI);
> -		return -ENODEV;
> +	scoped_guard(mutex, &state->lock) {
> +		int reported_whoami;
> +		int ret = regmap_read(state->regmap, INV_ICM20948_REG_WHOAMI,
> +				      &reported_whoami);
> +		if (ret)
> +			return ret;
> +		if (reported_whoami != INV_ICM20948_WHOAMI) {
> +			dev_err(state->dev, "invalid whoami %d, expected %d\n",
> +				reported_whoami, INV_ICM20948_WHOAMI);
> +			return -ENODEV;
> +		}
> +
> +		ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
> +					INV_ICM20948_PWR_MGMT_1_DEV_RESET,
> +					INV_ICM20948_PWR_MGMT_1_DEV_RESET);
> +		if (ret)
> +			return ret;
> +		msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
> +
> +		ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
> +					INV_ICM20948_PWR_MGMT_1_SLEEP, 0);
> +		if (ret)
> +			return ret;
> +
> +		msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
>  	}
>  
> -	ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
> -				INV_ICM20948_PWR_MGMT_1_DEV_RESET,
> -				INV_ICM20948_PWR_MGMT_1_DEV_RESET);
> -	if (ret)
> -		return ret;
> -	msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
> -
> -	ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
> -				INV_ICM20948_PWR_MGMT_1_SLEEP, 0);
> -	if (ret)
> -		return ret;
> -	msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
> -

If this change makes sense it should be in the earlier patch.
Don't add code that you then move around later.

> diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2d4d598eb21c8ce98d4ee3c72504554ab49ea596
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> + */
> +
> +#include <linux/bits.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#include "inv_icm20948.h"
> +
> +/* IIO int + nano format */
> +static const int inv_icm20948_gyro_scale[] = {
> +	/* 250 dps == 0.000133158 rad/s per LSB */
> +	[2 * INV_ICM20948_GYRO_FS_250] = 0,
> +	[2 * INV_ICM20948_GYRO_FS_250 + 1] = 133158,
> +	/* 500 dps == 0.000266316 rad/s per LSB */
> +	[2 * INV_ICM20948_GYRO_FS_500] = 0,
> +	[2 * INV_ICM20948_GYRO_FS_500 + 1] = 266316,
> +	/* 1000 dps == 0.000532632 rad/s per LSB */
> +	[2 * INV_ICM20948_GYRO_FS_1000] = 0,
> +	[2 * INV_ICM20948_GYRO_FS_1000 + 1] = 532632,
> +	/* 2000 dps == 0.001065264 rad/s per LSB */
> +	[2 * INV_ICM20948_GYRO_FS_1000] = 0,
> +	[2 * INV_ICM20948_GYRO_FS_1000 + 1] = 1065264,
> +};
> +
> +/* Calibration bias, IIO range format int + nano */
> +/* raw value -2**15 to +2**15, 0.0305 dps per LSB step */

Use multiline comment format.
/*
 * Calibration bias...
 * raw value...
 */

> +static const int inv_icm20948_gyro_calibbias_range[] = {
> +	-17, 443239423, /* min */
> +	0,   532325, /* step */
> +	+17, 443239423, /* max */
> +};
> +
> +#define INV_ICM20948_GYRO_CHAN(_dir) \
> +	{		\
> +		.type = IIO_ANGL_VEL,		\
> +		.modified = 1,		\
> +		.channel2 = IIO_MOD_##_dir,		\
> +		.info_mask_separate =		\
> +		  BIT(IIO_CHAN_INFO_RAW) |		\
> +		  BIT(IIO_CHAN_INFO_CALIBBIAS),		\
> +		.info_mask_shared_by_type =		\
> +		  BIT(IIO_CHAN_INFO_SCALE),		\
> +		.info_mask_shared_by_type_available =		\
> +		  BIT(IIO_CHAN_INFO_SCALE) |		\
> +		  BIT(IIO_CHAN_INFO_CALIBBIAS),		\
> +		.info_mask_shared_by_all =		\
> +		  BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +		.info_mask_shared_by_all_available =		\
> +		  BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +		.scan_index = INV_ICM20948_GYRO_SCAN_##_dir,		\
> +		.scan_type = {		\
> +			.sign = 's',		\
> +			.realbits = 16,		\
> +			.endianness = IIO_BE,		\
> +		},		\
> +	}

See example in previous patch (or pretty much any drivers in tree)
for how to format these.


> +
> +static int inv_icm20948_write_calibbias(struct inv_icm20948_state *state,
> +					struct iio_chan_spec const *chan,
> +					int val, int val2)
> +{
> +	guard(mutex)(&state->lock);
> +
> +	unsigned int reg;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg = INV_ICM20948_REG_GYRO_USER_OFFSET_X;
> +		break;
> +	case IIO_MOD_Y:
> +		reg = INV_ICM20948_REG_GYRO_USER_OFFSET_Y;
> +		break;
> +	case IIO_MOD_Z:
> +		reg = INV_ICM20948_REG_GYRO_USER_OFFSET_Z;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	s64 bias = (s64)val * 100000000L + val2;
> +	s64 val64 = bias * 180;
> +
> +	if (val64 >= 0)
> +		val64 -= 180 / 2;
> +	else
> +		val64 += 180 / 2;
> +
> +	s64 offset64 = div_s64(val64, 95818576L);
> +	s16 offset = clamp(offset64, (s64)S16_MIN, (s64)S16_MAX);
> +	__be16 offset_write = cpu_to_be16(offset);

Declarations at top of scope.

> +
> +	return regmap_bulk_write(state->regmap, reg, &offset_write,
> +				 sizeof(offset_write));

I think you only support i2c so far. When adding SPI we should be using
DMA safe buffers for bulk accesses.  Look at how we do __aligned(IIO_DMA_MINALIGN)
in many IIO drivers.  Separate heap allocations will give you what is needed
as an alternative but stack variables are never suitable.

> +}
> +
> +static int inv_icm20948_gyro_write_raw(struct iio_dev *gyro_dev,
> +				       struct iio_chan_spec const *chan,
> +				       int val, int val2, long mask)
> +{
> +	struct inv_icm20948_state *state = iio_device_get_drvdata(gyro_dev);
> +

no blank line here.

> +	int ret;
> +
> +	if (chan->type != IIO_ANGL_VEL)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (!iio_device_claim_direct(gyro_dev))
> +			return -EBUSY;
> +		ret = inv_icm20948_gyro_write_scale(state, val, val2);
> +		iio_device_release_direct(gyro_dev);
> +		return ret;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (!iio_device_claim_direct(gyro_dev))
> +			return -EBUSY;
> +		ret = inv_icm20948_write_calibbias(state, chan, val, val2);
> +		iio_device_release_direct(gyro_dev);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +struct iio_dev *inv_icm20948_gyro_init(struct inv_icm20948_state *state)
> +{
> +	struct iio_dev *gyro_dev = devm_iio_device_alloc(state->dev, 0);

Look at what that second parameter is for and how we use iio_priv()
extensively in IIo drivers.

> +
> +	if (!gyro_dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	iio_device_set_drvdata(gyro_dev, state);
The above IIO priv comment will probably mean this can go away.

> +
> +	gyro_dev->name = "icm20948-gyro";
> +	gyro_dev->info = &inv_icm20948_gyro_info;
> +	gyro_dev->modes = INDIO_DIRECT_MODE;
> +	gyro_dev->channels = inv_icm20948_gyro_channels;
> +	gyro_dev->num_channels = ARRAY_SIZE(inv_icm20948_gyro_channels);
> +
> +	int ret = devm_iio_device_register(state->dev, gyro_dev);

As with the temperature sensor I'm not yet setting any justification for
there being more than one iio device for the whole sensor.  There are reasons
to do that, but why does that apply for this device?  It is the last
option when we can't do anything else, not where we start from when
consider the design.

> +
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	state->gyro_conf =
> +		devm_kzalloc(state->dev, sizeof(*state->gyro_conf), GFP_KERNEL);

This should be using iio_priv and if you do have a pointer in the parent state
it should be to the struct iio_dev *gyro_dev, not this.  Currently you have
one of those as well which is unnecessary.

> +	if (!state->gyro_conf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	state->gyro_conf->fsr = INV_ICM20948_GYRO_FS_250;
> +	ret = inv_icm20948_gyro_apply_config(state);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return gyro_dev;
> +}
> 


