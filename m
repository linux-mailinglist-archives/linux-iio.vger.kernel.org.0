Return-Path: <linux-iio+bounces-23609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6055B3EE83
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E922008B8
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C8F32ED4A;
	Mon,  1 Sep 2025 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0iYBfwv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D619C560;
	Mon,  1 Sep 2025 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755665; cv=none; b=AG840toZpie8YnK3Gf/d9h2O9+D3KfjBgvW03GrSGW2zfLisicz4aBO5eWUTuZJkHO0ckHzNK4w8eN7saNKpDp+XcGV+H1TaXC9bRKX09feW4WEdu+jmMbjHGZ7a4ShtMtNIsPaBqRZGIAABNyDOyjPOJnJaffbyWkNkMuBjngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755665; c=relaxed/simple;
	bh=wOOOkXIryu8rOSbBi5Cjd3s24L10n/BjeLfojfJtkuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ims8Es1H3kzF5tYCc/K0LmW6zho5dT2yPNvpRmuvyj2e67hePjFmzD0RLBeTY7tiaHwJmbFPWIm55G7vPWgnwFsEM7hP7zwnWviEj1fRiNbSoNLyS0OVskWLXHCLHrAl8D+MSlbwMapjG4gBoLmpHRtmMdG/2+vmHHDgfMDX0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0iYBfwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978E8C4CEF5;
	Mon,  1 Sep 2025 19:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756755664;
	bh=wOOOkXIryu8rOSbBi5Cjd3s24L10n/BjeLfojfJtkuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f0iYBfwvkiq5BPWCcodZSg0DRF130UuefySDD90q7vbit8anK7a0jXVz2IgTM4Of8
	 PcaUO8zjyW27vwe5oNL5tYqUYGBMxq9fB8WMqxzt97eHnm4Rm5smuuowufGtZ+AdYW
	 ZdOvFvBWgCS+E2a2ruoi2hI67rFkEzzOFiTadEJOPbVAdjd8SZ3ifICkJDLjgWLoIR
	 j4G+bR5qgUZKCYbeEpSW5LBWmWBTjc2QPwxFLzQVMLyLt977LI7Ivk6wQ5eND8qa82
	 uUJayNPZCnMc0DUoEP72og8MtczWD/j91T6hGZ4JMmGHGQf7R3boGVjTihHGzrc8GB
	 EA/Do2w5WpQzA==
Date: Mon, 1 Sep 2025 20:40:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 5/5] iio: imu: icm20948: add runtime power management
 support
Message-ID: <20250901204055.106e6f42@jic23-huawei>
In-Reply-To: <20250831-icm20948-v1-5-1fe560a38de4@gmail.com>
References: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com>
	<20250831-icm20948-v1-5-1fe560a38de4@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Aug 2025 00:12:49 +0530
Bharadwaj Raju <bharadwaj.raju777@gmail.com> wrote:

> Implement runtime power management support for the ICM20948
> sensor. The device autosuspends after 2 seconds of idle time.

This is an unusual feature to bring in at this point in developing
a driver, but fair enough if you want to it doesn't hurt!

Anyhow, various comments inline and requests for more information.

Jonathan


> 
> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> ---
>  drivers/iio/imu/inv_icm20948/Makefile             |  1 +
>  drivers/iio/imu/inv_icm20948/inv_icm20948.h       |  7 +++
>  drivers/iio/imu/inv_icm20948/inv_icm20948_core.c  |  3 +-
>  drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c  | 28 ++++++---
>  drivers/iio/imu/inv_icm20948/inv_icm20948_power.c | 73 +++++++++++++++++++++++
>  drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c  | 15 +++--
>  6 files changed, 114 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm20948/Makefile b/drivers/iio/imu/inv_icm20948/Makefile
> index 88a37be159e1d6f575da1c070c84ac94cd963020..0a17ad1c003e6a93f3431f7a998e56cdf975d245 100644
> --- a/drivers/iio/imu/inv_icm20948/Makefile
> +++ b/drivers/iio/imu/inv_icm20948/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_INV_ICM20948) += inv-icm20948.o
>  inv-icm20948-y += inv_icm20948_core.o
>  inv-icm20948-y += inv_icm20948_temp.o
>  inv-icm20948-y += inv_icm20948_gyro.o
> +inv-icm20948-y += inv_icm20948_power.o
>  
>  obj-$(CONFIG_INV_ICM20948_I2C) += inv-icm20948-i2c.o
>  inv-icm20948-i2c-y += inv_icm20948_i2c.o
> diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948.h b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
> index ca2513114378cdcba5bc315fc94cd61f930b4dfa..194dcccabc2162334779b285320187c7ff1f5236 100644
> --- a/drivers/iio/imu/inv_icm20948/inv_icm20948.h
> +++ b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
> @@ -13,10 +13,13 @@
>   #include <linux/i2c.h>
>   #include <linux/iio/iio.h>
>   #include <linux/err.h>
> + #include <linux/pm_runtime.h>
>  
>  /* accel takes 20ms, gyro takes 35ms to wake from full-chip sleep */
>   #define INV_ICM20948_SLEEP_WAKEUP_MS 35
>  
> + #define INV_ICM20948_SUSPEND_DELAY_MS 2000
I'd just use the value inline.  It should only be in one place
and the meaning of the value there is well understood by reviewers.

> +
>   #define INV_ICM20948_REG_BANK_SEL 0x7F
>   #define INV_ICM20948_BANK_SEL_MASK GENMASK(5, 4)
>  
> @@ -46,6 +49,8 @@
>  
>  extern const struct regmap_config inv_icm20948_regmap_config;
>  
> +extern const struct dev_pm_ops inv_icm20948_pm_ops;
> +
>  enum inv_icm20948_gyro_fs {
>  	INV_ICM20948_GYRO_FS_250 = 0,
>  	INV_ICM20948_GYRO_FS_500 = 1,
> @@ -82,4 +87,6 @@ extern int inv_icm20948_core_probe(struct regmap *regmap);
>  struct iio_dev *inv_icm20948_temp_init(struct inv_icm20948_state *state);
>  struct iio_dev *inv_icm20948_gyro_init(struct inv_icm20948_state *state);
>  
> +int inv_icm20948_pm_setup(struct inv_icm20948_state *state);
> +
>   #endif
> diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
> index eb4f940de7013bf4ddeb69b6380a60fbde49964a..e6e670d96e40c3663e55d1545b52f609603a02ed 100644
> --- a/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
> +++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
> @@ -101,7 +101,7 @@ static int inv_icm20948_setup(struct inv_icm20948_state *state)
>  	if (IS_ERR(state->gyro_dev))
>  		return PTR_ERR(state->gyro_dev);
>  
> -	return 0;
> +	return inv_icm20948_pm_setup(state);
>  }
>  
>  int inv_icm20948_core_probe(struct regmap *regmap)
> @@ -113,6 +113,7 @@ int inv_icm20948_core_probe(struct regmap *regmap)
>  	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
>  	if (!state)
>  		return -ENOMEM;
> +	dev_set_drvdata(dev, state);
>  
>  	state->regmap = regmap;
>  	state->dev = dev;
> diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c
> index 2d4d598eb21c8ce98d4ee3c72504554ab49ea596..9cefb47a46b1a323202aa84f0de647d7b7b89728 100644
> --- a/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c
> +++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c

>  
>  static int inv_icm20948_gyro_read_sensor(struct inv_icm20948_state *state,
> @@ -99,23 +103,25 @@ static int inv_icm20948_gyro_read_sensor(struct inv_icm20948_state *state,
>  		return -EINVAL;
>  	}
>  
> +	pm_runtime_get_sync(state->dev);
> +
>  	__be16 raw;
>  	int ret = regmap_bulk_read(state->regmap, reg, &raw, sizeof(raw));
>  
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	*val = (s16)be16_to_cpu(raw);
>  
> -	return 0;
> +out:
> +	pm_runtime_put_autosuspend(state->dev);

A common thing to do when runtime pm is involved is to have a wrapper function
around the main code.  That wrapper then deals with runtime pm, but lets you
use direct returns in the inner function, which tends to improve readability.

> +	return ret;
>  }
>  
>  static int inv_icm20948_gyro_read_calibbias(struct inv_icm20948_state *state,
>  					    struct iio_chan_spec const *chan,
>  					    int *val, int *val2)
>  {
> -	guard(mutex)(&state->lock);
> -
>  	unsigned int reg;
>  
>  	switch (chan->channel2) {
> @@ -133,8 +139,11 @@ static int inv_icm20948_gyro_read_calibbias(struct inv_icm20948_state *state,
>  	}
>  
>  	__be16 offset_raw;
> +
> +	pm_runtime_get_sync(state->dev);
>  	int ret = regmap_bulk_read(state->regmap, reg, &offset_raw,
>  				   sizeof(offset_raw));
> +	pm_runtime_put_autosuspend(state->dev);
>  
>  	if (ret)
>  		return ret;
> @@ -216,8 +225,6 @@ static int inv_icm20948_write_calibbias(struct inv_icm20948_state *state,
>  					struct iio_chan_spec const *chan,
>  					int val, int val2)
>  {
> -	guard(mutex)(&state->lock);
> -
>  	unsigned int reg;
>  
>  	switch (chan->channel2) {
> @@ -246,8 +253,13 @@ static int inv_icm20948_write_calibbias(struct inv_icm20948_state *state,
>  	s16 offset = clamp(offset64, (s64)S16_MIN, (s64)S16_MAX);
>  	__be16 offset_write = cpu_to_be16(offset);
>  
> -	return regmap_bulk_write(state->regmap, reg, &offset_write,
> +	pm_runtime_get_sync(state->dev);
> +	mutex_lock(&state->lock);
> +	int ret = regmap_bulk_write(state->regmap, reg, &offset_write,
>  				 sizeof(offset_write));
> +	mutex_unlock(&state->lock);
> +	pm_runtime_put_autosuspend(state->dev);
> +	return ret;
>  }
>  
>  static int inv_icm20948_gyro_write_raw(struct iio_dev *gyro_dev,
> diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_power.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_power.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1281a5e5acb539cd3f91ca8ed8d52371f330b60a
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_power.c

Don't have a separate file for this. It is not that much code so much more
obvious to just have it in the core file.

> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> + */
> +
> +#include "inv_icm20948.h"
> +
> +static int inv_icm20948_suspend(struct device *dev)
> +{
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
> +	struct inv_icm20948_state *state = dev_get_drvdata(dev);
> +
> +	guard(mutex)(&state->lock);

What data is this mutex protecting here?  Regmap has it's own locks
internally and I'm not immediately sure what else needs to be protected
against races.

> +
> +	return regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
> +				 INV_ICM20948_PWR_MGMT_1_SLEEP,
> +				 INV_ICM20948_PWR_MGMT_1_SLEEP);
> +}
> +
> +static int inv_icm20948_resume(struct device *dev)
> +{
> +	struct inv_icm20948_state *state = dev_get_drvdata(dev);
> +
> +	guard(mutex)(&state->lock);
> +
> +	pm_runtime_disable(state->dev);
> +	pm_runtime_set_active(state->dev);
> +	pm_runtime_enable(state->dev);

Which device is this on?  I'd not expect to typically see runtime pm state
manipulated in runtime pm ops for another device. The parent /child relationships
etc (more complex options exist) should deal with that.
> +
> +	int ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
> +				    INV_ICM20948_PWR_MGMT_1_SLEEP, 0);
> +	if (ret)
> +		return ret;
> +
> +	msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
> +
> +	return 0;
> +}
> +
> +static void inv_icm20948_pm_disable(void *data)
> +{
> +	struct device *dev = data;
> +
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +}
> +
> +int inv_icm20948_pm_setup(struct inv_icm20948_state *state)
> +{
> +	struct device *dev = state->dev;
> +
> +	guard(mutex)(&state->lock);
> +
> +	int ret;
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret)
> +		return ret;
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, INV_ICM20948_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_put(dev);
> +
> +	return devm_add_action_or_reset(dev, inv_icm20948_pm_disable, dev);
> +}
> +
> +EXPORT_NS_GPL_DEV_PM_OPS(inv_icm20948_pm_ops, IIO_ICM20948) = {
> +	SYSTEM_SLEEP_PM_OPS(inv_icm20948_suspend, inv_icm20948_resume)
> +	RUNTIME_PM_OPS(inv_icm20948_suspend, inv_icm20948_resume, NULL)
If you want to use runtime pm ops for both this is not how it is done.
See DEFINE_RUNTIME_DEV_PM_OPS()

> +};
> diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c
> index 916053740cc5acda0316c76504d4086eff5ec7f0..6e17b3719301d6d7f005d545587f558fcadd2f40 100644
> --- a/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c
> +++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c
> @@ -24,17 +24,24 @@ static const struct iio_chan_spec
>  static int inv_icm20948_temp_read_sensor(struct inv_icm20948_state *state,
>  					 s16 *temp)
>  {
> -	guard(mutex)(&state->lock);
> +	int ret;
> +
> +	pm_runtime_get_sync(state->dev);
> +	mutex_lock(&state->lock);
>  
>  	__be16 raw;
> -	int ret = regmap_bulk_read(state->regmap, INV_ICM20948_REG_TEMP_DATA,
> +	ret = regmap_bulk_read(state->regmap, INV_ICM20948_REG_TEMP_DATA,
>  				   &raw, sizeof(raw));
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	*temp = __be16_to_cpu(raw);
> +	ret = 0;
>  
> -	return 0;
> +out:
> +	mutex_unlock(&state->lock);
> +	pm_runtime_put_autosuspend(state->dev);
> +	return ret;
>  }
>  
>  static int inv_icm20948_temp_read_raw(struct iio_dev *temp_dev,
> 


