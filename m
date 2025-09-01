Return-Path: <linux-iio+bounces-23605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC13FB3EE62
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3CA17ADD0
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EE62E6CDE;
	Mon,  1 Sep 2025 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPgpxqIV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FA45C0B;
	Mon,  1 Sep 2025 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756754370; cv=none; b=juRXHqlimqJrCqlrwLYMOx8VBiFVJ7WWxxzsvGQbKo6f7IvVZDfADgxupR27wNb8FTYDo2fvQM7mGeIKTIlPYJ6svxtYdt7kEqiQuqMXH6Q2gw6wsHjHilfGr/dnd05qhxyUWof/8Sa1GSf/NslNRhB++WZXGOJY+59NAN8Uw8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756754370; c=relaxed/simple;
	bh=XmU8E5jnQukUXW2+gmg6bIrjgBsf50ZKmzuD0mgxAv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlcVB67X3H2EJJiPbz47QzeuZj2bSweJ9jjfBUqE+f7Uif79zJDJ+vk8GTX840aneLToCVa0XCxheZzTxBNXf8MOnNaHf6C4nuUv1qUpU+6lXVUSnFlJPS7nEOXp+tSXd3HdrgjAwIVoEMnGMhdNERPrK5t8bUNkNIYBr3Y63os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPgpxqIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419B5C4CEF0;
	Mon,  1 Sep 2025 19:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756754369;
	bh=XmU8E5jnQukUXW2+gmg6bIrjgBsf50ZKmzuD0mgxAv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NPgpxqIVRmS9Bv7PJAzpv1bmQxhkqN76fwWr840TxBhVwsMfjdaYYdXCirnj5rtOr
	 ZVdnVj84WKm6vXyORbgrXRxiSwbKUkTOV+dMHNPWSx+sAFkxRI1SrROyk3f5xGJRHS
	 A3wg7qZTs7+j652aHpUG9FTwgXAGelvZn8F+7nHC4feKzeylZXWYOB708yg/33hhKP
	 S8ib4OmX+/+mwqEevaTZOAXCiZCjyMWQn50MvKSj6bsSke8zkKiC43n7l1cZ7eof0o
	 v7ROXfyV1o7u0XllP4t0g/ysNp3Cv4o3fQx/L/C6W7EmyX+WwLisJCkU8rul4bvhDi
	 NQ5J/VjIBl2Gw==
Date: Mon, 1 Sep 2025 20:19:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 2/5] iio: imu: add inv_icm20948
Message-ID: <20250901201919.30a8f93d@jic23-huawei>
In-Reply-To: <20250831-icm20948-v1-2-1fe560a38de4@gmail.com>
References: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com>
	<20250831-icm20948-v1-2-1fe560a38de4@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Aug 2025 00:12:46 +0530
Bharadwaj Raju <bharadwaj.raju777@gmail.com> wrote:

> Core parts of the new ICM20948 driver.
> 
> Add register definitions, probing, setup, and an IIO device for
> reading the onboard temperature sensor.
> 
> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Hi Bharadwaj,

I see you've already gotten some reviews on this so I'll take only
a fairly quick look.  I may also overlap somewhat with the other reviewers.

Biggest question is I'm not seeing why you need an IIO device just
for the on die (and that is important vs on board) temperature sensor.

Jonathan

> ---
>  drivers/iio/imu/Kconfig                          |   1 +
>  drivers/iio/imu/Makefile                         |   1 +
>  drivers/iio/imu/inv_icm20948/Kconfig             |  17 ++++
>  drivers/iio/imu/inv_icm20948/Makefile            |   8 ++
>  drivers/iio/imu/inv_icm20948/inv_icm20948.h      |  47 +++++++++
>  drivers/iio/imu/inv_icm20948/inv_icm20948_core.c | 122 +++++++++++++++++++++++
>  drivers/iio/imu/inv_icm20948/inv_icm20948_i2c.c  |  48 +++++++++
>  drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c | 108 ++++++++++++++++++++
>  8 files changed, 352 insertions(+)
> 
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index 15612f0f189b5114deb414ef840339678abdc562..d59e5b0087398cfbd2719ca914fd147ab067155f 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -109,6 +109,7 @@ config KMX61
>  	  be called kmx61.
>  
>  source "drivers/iio/imu/inv_icm42600/Kconfig"
> +source "drivers/iio/imu/inv_icm20948/Kconfig"

Alphabetical/numeric order.

>  source "drivers/iio/imu/inv_mpu6050/Kconfig"
>  
>  config SMI240
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> index e901aea498d37e5897e8b71268356a19eac2cb59..79e49bae59038c1ca1d54a64cf49b6ca5f57cb0b 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_FXOS8700_I2C) += fxos8700_i2c.o
>  obj-$(CONFIG_FXOS8700_SPI) += fxos8700_spi.o
>  
>  obj-y += inv_icm42600/
> +obj-y += inv_icm20948/

here as well.

>  obj-y += inv_mpu6050/
>  
>  obj-$(CONFIG_KMX61) += kmx61.o

> diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948.h b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..f9830645fbe96fd02eef7c54d1e5908647d5a0fe
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> + */
> +
> +#ifndef INV_ICM20948_H_
> +#define INV_ICM20948_H_
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/err.h>
> +
> +/* accel takes 20ms, gyro takes 35ms to wake from full-chip sleep */
> +#define INV_ICM20948_SLEEP_WAKEUP_MS 35
> +
> +#define INV_ICM20948_REG_BANK_SEL 0x7F
> +#define INV_ICM20948_BANK_SEL_MASK GENMASK(5, 4)
> +
> +#define INV_ICM20948_REG_WHOAMI 0x0000
> +#define INV_ICM20948_WHOAMI 0xEA
> +
> +#define INV_ICM20948_REG_FIFO_RW 0x0072
> +
> +#define INV_ICM20948_REG_PWR_MGMT_1 0x0006
> +#define INV_ICM20948_PWR_MGMT_1_DEV_RESET BIT(7)
> +#define INV_ICM20948_PWR_MGMT_1_SLEEP BIT(6)
> +
> +#define INV_ICM20948_REG_TEMP_DATA 0x0039
> +
> +extern const struct regmap_config inv_icm20948_regmap_config;
> +
> +struct inv_icm20948_state {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct iio_dev *temp_dev;
> +	struct mutex lock;

Lock scope needs to always have a comment. What 'data' is this protecting
from concurrent accesses?

> +};
> +
> +extern int inv_icm20948_core_probe(struct regmap *regmap);
> +
> +struct iio_dev *inv_icm20948_temp_init(struct inv_icm20948_state *state);
> +
> +#endif
> diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ee9e4159cffa261f0326b146a4b3df2cbfbd7697
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c

> +
> +static int inv_icm20948_setup(struct inv_icm20948_state *state)
> +{
> +	guard(mutex)(&state->lock);
> +
As below.
> +	int reported_whoami;
> +	int ret = regmap_read(state->regmap, INV_ICM20948_REG_WHOAMI,
> +			      &reported_whoami);
> +	if (ret)
> +		return ret;
> +	if (reported_whoami != INV_ICM20948_WHOAMI) {
> +		dev_err(state->dev, "invalid whoami %d, expected %d\n",
> +			reported_whoami, INV_ICM20948_WHOAMI);

This breaks fallback compatibles used in device tree to support
newer parts that the driver has not yet been updated for, as long
as they are backwards compatible with older ones.
We still have some old drivers with hard checks like this, but current
practice is to at most print a message and then carry on anyway.

> +		return -ENODEV;
> +	}
> +
> +	ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
> +				INV_ICM20948_PWR_MGMT_1_DEV_RESET,
> +				INV_ICM20948_PWR_MGMT_1_DEV_RESET);
> +	if (ret)
> +		return ret;
> +	msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
> +
> +	ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
> +				INV_ICM20948_PWR_MGMT_1_SLEEP, 0);
> +	if (ret)
> +		return ret;
> +	msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
> +
> +	state->temp_dev = inv_icm20948_temp_init(state);
> +	if (IS_ERR(state->temp_dev))
> +		return PTR_ERR(state->temp_dev);
> +
> +	return 0;
> +}
> +
> +int inv_icm20948_core_probe(struct regmap *regmap)
> +{
> +	struct device *dev = regmap_get_device(regmap);
> +
> +	struct inv_icm20948_state *state;
> +
> +	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);

Given question on why you need separate struct iio_dev instances below
I suspect this will change a lot and we won't end up with another state
structure here.

> +	if (!state)
> +		return -ENOMEM;
> +
> +	state->regmap = regmap;
> +	state->dev = dev;
> +
> +	mutex_init(&state->lock);
	ret = devm_mutex_init()
	if (ret)
		return ret;

The advantages of this are small, but it costs us little so
lets enable the lock debugging stuff that the destroy_mutex() this
will call enables.

> +
> +	return inv_icm20948_setup(state);
> +}

> diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_i2c.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_i2c.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..cf04d82e014a2497592c9a15bbde6e36f431dd56
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_i2c.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/property.h>
> +
> +#include "inv_icm20948.h"
> +
> +static int inv_icm20948_probe(struct i2c_client *client)
> +{
> +	struct regmap *regmap =
> +		devm_regmap_init_i2c(client, &inv_icm20948_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return inv_icm20948_core_probe(regmap);
> +}
> +
> +static const struct i2c_device_id inv_icm20948_id[] = { { "icm20948" }, {} };

static const struct i2c_device_id inv_icm20948_id[] = {
	{ "icm20948" },
	{ }
};

> +MODULE_DEVICE_TABLE(i2c, inv_icm20948_id);
> +
> +static const struct of_device_id inv_icm20948_of_matches[] = {
> +	{ .compatible = "invensense,icm20948" },
> +	{}
Trivial style preference that I'm trying to generalize
across IIO for
	{ }
> +};
> +MODULE_DEVICE_TABLE(of, inv_icm20948_of_matches);

> diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..916053740cc5acda0316c76504d4086eff5ec7f0
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> + */
> +
> +#include <linux/bits.h>
> +
> +#include <linux/iio/iio.h>

Andy covered the need to follow include what you use principles for includes.

> +
> +#include "inv_icm20948.h"
> +
> +static const struct iio_chan_spec
> +	inv_icm20948_temp_chan = { .type = IIO_TEMP,
> +				   .info_mask_separate =
> +					   BIT(IIO_CHAN_INFO_RAW) |
> +					   BIT(IIO_CHAN_INFO_OFFSET) |
> +					   BIT(IIO_CHAN_INFO_SCALE),
> +				   .scan_index = 0,
> +				   .scan_type = {
> +					   .sign = 's',
> +					   .realbits = 16,
> +				   } };
> +
Preferred format is something like this.
static const struct iio_chan_spec inv_icm20948_temp_chan = {
	.type = IIO_TEMP,
	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
			      BIT(IIO_CHAN_INFO_OFFSET) |
			      BIT(IIO_CHAN_INFO_SCALE),
	.scan_index = 0,
	.scan_type = {
		.sign = 's',
		.realbits = 16,
	},
};
Note the trailing comma on scan_type that will make this easier to extent
in future.

> +
> +static int inv_icm20948_temp_read_raw(struct iio_dev *temp_dev,
> +				      struct iio_chan_spec const *chan,
> +				      int *val, int *val2, long mask)
> +{
> +	struct inv_icm20948_state *state = iio_device_get_drvdata(temp_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(temp_dev))
> +			return -EBUSY;
> +		s16 temp;
> +		int ret = inv_icm20948_temp_read_sensor(state, &temp);

As already pointed out we normally don't mix declarations and code.
There is an exception for cleanup.h cases but that doesn't apply here.

> +
> +		if (ret)
> +			return ret;
> +		iio_device_release_direct(temp_dev);
> +		*val = temp;
> +		return IIO_VAL_INT;

> +}

> +struct iio_dev *inv_icm20948_temp_init(struct inv_icm20948_state *state)
> +{
> +	struct iio_dev *temp_dev = devm_iio_device_alloc(state->dev, 0);
> +
> +	if (!temp_dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	iio_device_set_drvdata(temp_dev, state);
> +
> +	temp_dev->name = "icm20948-temp";
> +	temp_dev->info = &inv_icm20948_temp_info;
> +	temp_dev->modes = INDIO_DIRECT_MODE;
> +	temp_dev->channels = &inv_icm20948_temp_chan;
> +	temp_dev->num_channels = 1;
> +
> +	int ret = devm_iio_device_register(state->dev, temp_dev);

It's unusual for it to make sense to register a separate iio device instance for the
temperature sensor in an IMU.  They tend to be there only to allow
temperature compensation based on measures of die temperature.
Why does it make sense for this device?  There are a few reasons
I could think of that might justify it but I took at quick read
of the datasheet and I can't see a reason to split it up at all. Looks
like one iio_dev will do for the whole thing.

Jonathan



> +
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return temp_dev;
> +}
> 


