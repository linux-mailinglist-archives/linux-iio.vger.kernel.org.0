Return-Path: <linux-iio+bounces-19906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAE9AC35BE
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 18:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26717173E08
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E491F76A5;
	Sun, 25 May 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqcEvGmg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C72F3D69;
	Sun, 25 May 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748191927; cv=none; b=q2VtujClzsr0d52lJG0U4J1DQ5xHSvt54Up2jED4uc9GMCzkcg+lHfaLr9LDExdsRRThiXVZWhKPVoBkgPDzM3yQSW12zJGbPCsLX7WoW8EhvucCCq6rnsET4Ox3FOUA125j3DV3eMO+e22A2UB7rWNDCeHgMHGuDnjEkOccKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748191927; c=relaxed/simple;
	bh=JeQmpBPTwA7Dr62HaWCXHkUEBxWQNmz1QUkMx+PAlfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2GUIVYP4+pQmYqldMFhFUzOCS40trPmzMNrtftJK3+CtUmIV6mpz661WgmKr5rj/aLER0wpGiXhUF5YF/8J/NTJy9kzKF54cYgI4LrmGnYLap/kI7jPLbGZgVJEt9+EQXl1AHqR6EeceDuymLz5u+0jC8Lz8+wkjpvhZAeVCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqcEvGmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D60C4CEEA;
	Sun, 25 May 2025 16:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748191927;
	bh=JeQmpBPTwA7Dr62HaWCXHkUEBxWQNmz1QUkMx+PAlfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MqcEvGmgvM/kz33R00wQz5nPF91UuisgspsrA3zEOc1q7aU1qUWo7M0poseBNMkdN
	 Ta3x3G2JbGQtmz9h5FKRPtmiKNf2fi9N9XcLpUqUa05FrFPn+07YpGhpLzJdp5G6TO
	 SKJbmfFt5x96eSOSXOuxYj4T3/ZYzh2AT2GD93ZZrU1QAYvJeA9Lgvvt1nJn2HjBps
	 gv3BNX3/hflN0fUWjzMmMxzSXTWtO1/+i7Odu+M/1D4qaLXV2oYnP6PRITltqF2eWU
	 9+a3B9Iz16FESUSpuRBphzVW/gGPl8G54fxmnaKLp1RBTjZtvVbraz5hrv0CHiyg/V
	 LV0xg95f8Corw==
Date: Sun, 25 May 2025 17:51:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Jianping.Shen@de.bosch.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Christian.Lorenz3@de.bosch.com>, <Ulrike.Frauendorf@de.bosch.com>,
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v2 2/2] iio: imu: smi330: Add driver
Message-ID: <20250525175157.2446f878@jic23-huawei>
In-Reply-To: <20250513150028.42775-3-Jianping.Shen@de.bosch.com>
References: <20250513150028.42775-1-Jianping.Shen@de.bosch.com>
	<20250513150028.42775-3-Jianping.Shen@de.bosch.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 17:00:28 +0200
<Jianping.Shen@de.bosch.com> wrote:

> From: Jianping Shen <Jianping.Shen@de.bosch.com>
> 
> Add the iio driver for bosch imu smi330. The smi330 is a combined
> three axis angular rate and three axis acceleration sensor.
> 
> Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>

Hi.  

Much more manageable! In general it looks pretty good.
The build files though are not how we'd do this sort of configuration
in the kernel.  You have to remember that many builds are for generic
distros.  They can't require a rebuild to change the bus or interrupt
number, we need to have everything available and figure out what to
use depending on what the firmware tells is us present.

Various other comments inline.

Jonathan

> diff --git a/drivers/iio/imu/smi330/Kconfig b/drivers/iio/imu/smi330/Kconfig
> new file mode 100644
> index 00000000000..1298c59a74a
> --- /dev/null
> +++ b/drivers/iio/imu/smi330/Kconfig
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# SMI330 IMU driver
> +#
> +
> +config SMI330
> +	tristate "Bosch Sensor SMI330 Inertial Measurement Unit"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Enable support for the Bosch SMI330 IMU.
> +
> +	  The driver supports different operation modes like polling,
> +	  data ready or fifo mode and advanced features like no-motion,
> +	  no-motion, any-motion or tilt detection.
> +
> +if SMI330
> +
> +choice
> +	prompt "Select communication interface"

Why one or the other?  Normal solution is to build 3 modules.
1 per bus, and 1 core one.  Then set the dependencies up so
that the bits you need are loaded and not anything unused.

> +	help
> +	  Choose communication interface for the sensor.
> +
> +	  Make sure the sensor is connected accordingly.
> +	  SPI and I2C are not supported at the same time,
> +	  choose either SPI or I2C to build the driver.
> +
> +	config SMI330_SPI
> +		bool "Enable SPI connection"
> +		depends on SPI
> +		select REGMAP_SPI
> +		help
> +		  Enables SPI communication interface.
> +
> +		  Make sure the sensor is connected to the SPI bus.
> +		  To specifiy further parameters like max frequency
> +		  use the device tree.
> +
> +	config SMI330_I2C
> +		bool "Enable I2C connection"
> +		depends on I2C
> +		select REGMAP_I2C
> +		help
> +		  Enables I2C communication interface.
> +
> +		  Make sure the sensor is connected to the I2C bus.
> +		  To specifiy further parameters like the address
> +		  use the device tree.
> +endchoice
> +
> +choice
> +	prompt "Map data interrupt"
> +	default SMI330_IRQ_DATA_INT1

So we never do this sort of build time choice.  If we did then we'd
have a driver that was only useable on a particular system which tends
to break the concept of linux distributions etc.  The driver needs to
make a choice on which interrupt line to used. Obviously that incorporates
which interrupt-names are set in DT.

> +	help
> +	  Map data interrupt to INT1 or INT2.
> +
> +	  NONE: data interrupt disabled
> +	  INT1: data interrupt mapped to INT1
> +	  INT2: data interrupt mapped to INT2
> +
> +	config SMI330_IRQ_DATA_NONE
> +		bool "NONE"
> +		help
> +		  Data interrupt disabled.
> +
> +		  In this mode only polling is possible.
> +		  To activate data ready of fifo mode choose
> +		  INT1 or INT2.
> +
> +	config SMI330_IRQ_DATA_INT1
> +		bool "INT1"
> +		help
> +		  Data interrupt mapped to INT1.
> +
> +		  In this mode data ready is the default mode.
> +		  The interrupt is triggered when new data is available.
> +		  When fifo watermark is set, fifo mode is activated.
> +		  The interrupt is triggered when fifo watermark level is reached.
> +
> +	config SMI330_IRQ_DATA_INT2
> +		bool "INT2"
> +		help
> +		  Data interrupt mapped to INT2.
> +
> +		  In this mode data ready is the default mode.
> +		  The interrupt is triggered when new data is available.
> +		  When fifo watermark is set, fifo mode is activated.
> +		  The interrupt is triggered when fifo watermark level is reached.
> +endchoice
> +
> +endif  # SMI330
> diff --git a/drivers/iio/imu/smi330/Makefile b/drivers/iio/imu/smi330/Makefile
> new file mode 100644
> index 00000000000..3dfb98f6345
> --- /dev/null
> +++ b/drivers/iio/imu/smi330/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_SMI330) += smi330.o
> +smi330-$(CONFIG_SMI330) := smi330_core.o
> +smi330-$(CONFIG_SMI330_I2C) += smi330_i2c.o
> +smi330-$(CONFIG_SMI330_SPI) += smi330_spi.o
> diff --git a/drivers/iio/imu/smi330/smi330.h b/drivers/iio/imu/smi330/smi330.h
> new file mode 100644
> index 00000000000..c7de934df8d
> --- /dev/null
> +++ b/drivers/iio/imu/smi330/smi330.h
> @@ -0,0 +1,249 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Robert Bosch GmbH.
> + */
> +#ifndef _SMI330_H
> +#define _SMI330_H
> +
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>

> +#define SMI330_FEATURE_DATA_STATUS_TX_READY_MASK BIT(1)

> +
> +enum {
> +	SMI330_SCAN_ACCEL_X,
> +	SMI330_SCAN_ACCEL_Y,
> +	SMI330_SCAN_ACCEL_Z,
> +	SMI330_SCAN_GYRO_X,
> +	SMI330_SCAN_GYRO_Y,
> +	SMI330_SCAN_GYRO_Z,
> +	SMI330_TEMP_OBJECT,
> +	SMI330_SCAN_TIMESTAMP,
> +};
> +
> +enum smi330_accel_range {
> +	SMI330_ACCEL_RANGE_2G = U8_C(0x00),

Given size of values, we don't care if they are signed or not.
So = 0x00 should be same things in practice.

Whilst the definition is there in the kernel it's never used.
So drop those throughout.


> +	SMI330_ACCEL_RANGE_4G = U8_C(0x01),
> +	SMI330_ACCEL_RANGE_8G = U8_C(0x02),
> +	SMI330_ACCEL_RANGE_16G = U8_C(0x03)
> +};

> +
> +enum smi330_operation_mode {
> +	SMI330_IDLE,
> +	SMI330_DATA_READY,
> +};
> +
> +enum smi330_sensor {
> +	SMI330_ACCEL,
> +	SMI330_GYRO,
> +};
> +
> +enum smi330_sensor_conf_select {
> +	SMI330_ODR,
> +	SMI330_RANGE,
> +	SMI330_BW,
> +	SMI330_AVG_NUM,
> +};
> +
> +enum smi330_int_out {
> +	SMI330_INT_DISABLED,
> +	SMI330_INT_1,
> +	SMI330_INT_2,
> +};
> +
> +struct smi330_sysfs_attr {
> +	int *reg_vals;
> +	int *vals;
> +	int len;
> +	int type;
> +	int mask;
> +};
> +
> +struct smi330_cfg {
> +	enum smi330_operation_mode op_mode;
> +	enum smi330_int_out data_irq;
> +};
> +
> +struct smi330_data {
> +	struct regmap *regmap;
> +	struct smi330_cfg cfg;
> +	s64 current_timestamp;
> +	atomic64_t irq_timestamp;
> +	struct iio_trigger *trig;
> +	/*
> +	 * Ensure natural alignment for timestamp if present.
> +	 * Channel size: 2 bytes.
> +	 * Max length needed: 2 * 3 channels + temp channel + 2 bytes padding + 8 byte ts.
> +	 * If fewer channels are enabled, less space may be needed, as
> +	 * long as the timestamp is still aligned to 8 bytes.
There is a nice new macro for this that will go upstream in the merge window
that should start today:
IIO_DECLARE_BUFFER_WITH_TS()

It ends up somewhat self documenting allowing most of the comments to be dropped
in cases similar to this one.


> +	 */
> +	s16 buf[12] __aligned(8);
> +};

> diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
> new file mode 100644
> index 00000000000..d82f3f4eeb3
> --- /dev/null
> +++ b/drivers/iio/imu/smi330/smi330_core.c
> @@ -0,0 +1,824 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2025 Robert Bosch GmbH.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>

Is this using anything from cleanup.h?

> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_irq.h>

Shouldn't need an of specific headers for a driver like this.
property.h should be included.

> +#include <linux/regmap.h>
> +#include <linux/string.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#include "smi330.h"
> +
> +// clang-format off

As below. Fine to have these locally but these markings shouldn't
be in the submission.

> +
> +#define SMI330_TEMP_CHANNEL(_index) {			\
> +	.type = IIO_TEMP,				\
> +	.modified = 1,					\
> +	.channel2 = IIO_MOD_TEMP_OBJECT,		\

This is only normally done when we have something like an infraread sensor
and need to distinguish between local temperature at the sensor and that
of the object it is pointed at.  For an on chip sensor, not modified
is how we normally do it.

> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
> +		BIT(IIO_CHAN_INFO_OFFSET) |		\
> +		BIT(IIO_CHAN_INFO_SCALE),		\
> +	.scan_index = _index,				\
> +	.scan_type = {					\
> +		.sign = 's',				\
> +		.realbits = 16,				\
> +		.storagebits = 16,			\
> +		.endianness = IIO_LE,			\
> +	},						\
> +}
> +
> +// clang-format on

This shouldn't be in a submission.

> +
> +static const struct iio_chan_spec smi330_channels[] = {
> +	SMI330_ACCEL_CHANNEL(IIO_ACCEL, X, SMI330_SCAN_ACCEL_X),
> +	SMI330_ACCEL_CHANNEL(IIO_ACCEL, Y, SMI330_SCAN_ACCEL_Y),
> +	SMI330_ACCEL_CHANNEL(IIO_ACCEL, Z, SMI330_SCAN_ACCEL_Z),
> +	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, X, SMI330_SCAN_GYRO_X),
> +	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, Y, SMI330_SCAN_GYRO_Y),
> +	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, Z, SMI330_SCAN_GYRO_Z),
> +	SMI330_TEMP_CHANNEL(SMI330_TEMP_OBJECT),
> +	IIO_CHAN_SOFT_TIMESTAMP(SMI330_SCAN_TIMESTAMP),
> +};
> +
> +static const struct smi330_sysfs_attr smi330_accel_scale_attr = {
> +	.reg_vals = (int[]){ SMI330_ACCEL_RANGE_2G, SMI330_ACCEL_RANGE_4G,
> +			     SMI330_ACCEL_RANGE_8G, SMI330_ACCEL_RANGE_16G },

Do we need the (int[]) part here?

> +	.vals = (int[]){ 0, 61035, 0, 122070, 0, 244140, 0, 488281 },
> +	.len = 8,
> +	.type = IIO_VAL_INT_PLUS_NANO,
> +	.mask = SMI330_CFG_RANGE_MASK
> +};
> +
> +static const struct smi330_sysfs_attr smi330_gyro_scale_attr = {
> +	.reg_vals = (int[]){ SMI330_GYRO_RANGE_125, SMI330_GYRO_RANGE_250,
> +			     SMI330_GYRO_RANGE_500 },
> +	.vals = (int[]){ 0, 3814697, 0, 7629395, 0, 15258789 },
> +	.len = 6,
> +	.type = IIO_VAL_INT_PLUS_NANO,
> +	.mask = SMI330_CFG_RANGE_MASK
> +};
> +
> +static const struct smi330_sysfs_attr smi330_average_attr = {
> +	.reg_vals = (int[]){ SMI330_AVG_NUM_1, SMI330_AVG_NUM_2,
> +			     SMI330_AVG_NUM_4, SMI330_AVG_NUM_8,
> +			     SMI330_AVG_NUM_16, SMI330_AVG_NUM_32,
> +			     SMI330_AVG_NUM_64 },
> +	.vals = (int[]){ 1, 2, 4, 8, 16, 32, 64 },
> +	.len = 7,
> +	.type = IIO_VAL_INT,
> +	.mask = SMI330_CFG_AVG_NUM_MASK
> +};
> +
> +static const struct smi330_sysfs_attr smi330_bandwidth_attr = {
> +	.reg_vals = (int[]){ SMI330_BW_2, SMI330_BW_4 },
> +	.vals = (int[]){ 2, 4 },
> +	.len = 2,
> +	.type = IIO_VAL_INT,
> +	.mask = SMI330_CFG_BW_MASK
> +};
> +
> +static const struct smi330_sysfs_attr smi330_odr_attr = {

I'm not sure the sysfs_attr bit is appropriate. These will also be used
by other paths such as the in kernel IIO interfaces.

> +	.reg_vals = (int[]){ SMI330_ODR_12_5_HZ, SMI330_ODR_25_HZ,
> +			     SMI330_ODR_50_HZ, SMI330_ODR_100_HZ,
> +			     SMI330_ODR_200_HZ, SMI330_ODR_400_HZ,
> +			     SMI330_ODR_800_HZ, SMI330_ODR_1600_HZ,
> +			     SMI330_ODR_3200_HZ, SMI330_ODR_6400_HZ },
> +	.vals = (int[]){ 12, 25, 50, 100, 200, 400, 800, 1600, 3200, 6400 },
> +	.len = 10,
> +	.type = IIO_VAL_INT,
> +	.mask = SMI330_CFG_ODR_MASK
> +};

> +static irqreturn_t smi330_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct smi330_data *data = iio_priv(indio_dev);
> +	int ret, sample, chan;
> +	int i = 0;
> +
> +	/* Ignore if buffer disabled */

If the buffer is disabled you shouldn't get here except in some corner
case races where we typically don't care (get one extra sample
for instance as the buffer is going down).  So why is this needed here?
Is it blocking a race that causes problems?

> +	if (!iio_buffer_enabled(indio_dev))
> +		return 0;
> +
> +	if (data->cfg.op_mode == SMI330_IDLE)
> +		data->current_timestamp = iio_get_time_ns(indio_dev);

Add a comment on why IDLE op mode means we need a timestamp here.
Is this a different race?

> +
> +	if (*indio_dev->active_scan_mask == SMI330_ALL_CHAN_MSK) {
> +		ret = regmap_bulk_read(data->regmap, SMI330_ACCEL_X_REG,
> +				       data->buf, ARRAY_SIZE(smi330_channels));
> +		if (ret)
> +			goto out;
> +	} else {
> +		iio_for_each_active_channel(indio_dev, chan) {
> +			ret = regmap_read(data->regmap,
> +					  SMI330_ACCEL_X_REG + chan, &sample);

Given there is always a trade off between the efficiency of a bulk read
and reading just the channels enabled, we often just set available_scan_masks,
read the lot and let the IIO core worry about resorting the data as needed.

For example, if you want all but 1 channel that is almost certainly quicker
and that is more likely to be the common case than you want 1 channel
only using the buffer.

So I'd like some more explanation here on why this path is needed.

> +			if (ret)
> +				goto out;
> +			data->buf[i++] = sample;
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
> +					   data->current_timestamp);
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t smi330_irq_thread_handler(int irq, void *indio_dev_)
> +{
> +	int ret, int_stat;
> +	s16 int_status[2] = { 0 };
> +	struct iio_dev *indio_dev = indio_dev_;
> +	struct smi330_data *data = iio_priv(indio_dev);
> +
> +	data->current_timestamp = atomic64_read(&data->irq_timestamp);
> +
> +	ret = regmap_bulk_read(data->regmap, SMI330_INT1_STATUS_REG, int_status,
> +			       2);

For cases like this that go just over 80 chars, it's fine to do so.

> +	if (ret)
> +		return IRQ_NONE;
> +
> +	int_stat = int_status[0] | int_status[1];
> +
> +	if (FIELD_GET(SMI330_INT_STATUS_ACC_DRDY_MASK, int_stat) ||
> +	    FIELD_GET(SMI330_INT_STATUS_GYR_DRDY_MASK, int_stat)) {

So you have separate data ready signals?  That might need to be handled
via multiple buffers depending on why that is the case.

> +		iio_trigger_poll_nested(data->trig);
> +	}

No {} for single statement block like this one.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t smi330_irq_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct smi330_data *data = iio_priv(indio_dev);
> +
> +	atomic64_set(&data->irq_timestamp, iio_get_time_ns(indio_dev));

Why do you need the atomic here? If there is a top half / thread race
then you could get garbage data anyway. 

> +
> +	return IRQ_WAKE_THREAD;
> +}

> +static int smi330_setup_irq(struct device *dev, struct iio_dev *indio_dev,
> +			    int irq, enum smi330_int_out irq_num)
> +{
> +	int ret, irq_type;
> +	bool open_drain, active_high, latch;
> +	struct smi330_data *data = iio_priv(indio_dev);
> +	struct irq_data *desc;
> +	struct fwnode_handle *fwnode;
> +
> +	desc = irq_get_irq_data(irq);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	irq_type = irqd_get_trigger_type(desc);
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_RISING:
> +		latch = false;
> +		active_high = true;
> +		break;
> +	case IRQF_TRIGGER_HIGH:
> +		latch = true;
> +		active_high = true;
> +		break;
> +	case IRQF_TRIGGER_FALLING:
> +		latch = false;
> +		active_high = false;
> +		break;
> +	case IRQF_TRIGGER_LOW:
> +		latch = true;
> +		active_high = false;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	fwnode = dev_fwnode(dev);
> +	if (!fwnode)
> +		return -ENODEV;
> +
> +	open_drain = fwnode_property_read_bool(fwnode, "drive-open-drain");
Where they are available use device_property_read_bool() etc rather than the fwnode
variants. Available for most things.

> +
> +	ret = smi330_set_int_pin_config(data, irq_num, active_high, open_drain,
> +					latch);
> +	if (ret)
> +		return ret;
> +
> +	return devm_request_threaded_irq(dev, irq, smi330_irq_handler,
> +					 smi330_irq_thread_handler, irq_type,
> +					 indio_dev->name, indio_dev);
> +}
> +
> +static int smi330_register_irq(struct device *dev, struct iio_dev *indio_dev)
> +{
> +	int ret, irq;
> +	struct smi330_data *data = iio_priv(indio_dev);
> +	struct smi330_cfg *cfg = &data->cfg;
> +	struct fwnode_handle *fwnode;
> +
> +	fwnode = dev_fwnode(dev);
> +	if (!fwnode)
> +		return -ENODEV;
> +
> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq > 0) {
> +		ret = smi330_setup_irq(dev, indio_dev, irq, SMI330_INT_1);
> +		if (ret)
> +			return ret;
> +	} else if (cfg->data_irq == SMI330_INT_1) {

Good. So you have the right detection code.  Just drop this check on it
matching a build option.  May also be no purpose in setting up
both interrupts ifyou are only going to use 1 of them.

> +		return -ENODEV;
> +	}
> +
> +	irq = fwnode_irq_get_byname(fwnode, "INT2");
> +	if (irq > 0) {
> +		ret = smi330_setup_irq(dev, indio_dev, irq, SMI330_INT_2);
> +		if (ret)
> +			return ret;
> +	} else if (cfg->data_irq == SMI330_INT_2) {
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

> +static int smi330_dev_init(struct smi330_data *data)
> +{
> +	int ret, chip_id, val, mode;
> +	struct device *dev = regmap_get_device(data->regmap);
> +
> +	ret = regmap_read(data->regmap, SMI330_CHIP_ID_REG, &chip_id);
> +	if (ret)
> +		return ret;
> +
> +	chip_id &= 0x00FF;
> +
> +	if (chip_id != SMI330_CHIP_ID)
> +		dev_info(dev, "Unknown chip id: 0x%04x\n", chip_id);
> +
> +	ret = regmap_read(data->regmap, SMI330_ERR_REG, &val);
> +	if (ret || FIELD_GET(SMI330_ERR_FATAL_MASK, val))
Don't 'eat' error values.

	if (ret)
		return ret;

	if (FIELD_GET(SMI330_ERR_FATAL_MASK, val))
		return dev_err_probe() to tell us what happened.
	
> +		return -ENODEV;
> +
> +	ret = regmap_read(data->regmap, SMI330_STATUS_REG, &val);
> +	if (ret || FIELD_GET(SMI330_STATUS_POR_MASK, val) == 0)

Same here. Split the conditions so we don't eat potentially useful
error return value.

> +		return -ENODEV;
> +
> +	mode = FIELD_PREP(SMI330_CFG_MODE_MASK, SMI330_MODE_NORMAL);
> +
> +	ret = regmap_update_bits(data->regmap, SMI330_ACCEL_CFG_REG,
> +				 SMI330_CFG_MODE_MASK, mode);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap, SMI330_GYRO_CFG_REG,
> +				  SMI330_CFG_MODE_MASK, mode);
> +}
> +
> +int smi330_core_probe(struct device *dev, struct regmap *regmap)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev;
> +	struct smi330_data *data;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);

Is this used for now?  If not drop it until you need it.

> +	data->regmap = regmap;
> +
> +	if (IS_ENABLED(CONFIG_SMI330_IRQ_DATA_INT1))

Those don't belong in Kconfig - we should be getting this from
firmware (DT / ACPI etc)  If both interrupts are available
it should be up to the driver to decide how they are used, not
a build option (or firmware).

> +		data->cfg.data_irq = SMI330_INT_1;
> +	else if (IS_ENABLED(CONFIG_SMI330_IRQ_DATA_INT2))
> +		data->cfg.data_irq = SMI330_INT_2;
> +	else
> +		data->cfg.data_irq = SMI330_INT_DISABLED;
> +
> +	ret = smi330_soft_reset(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Soft reset failed\n");
> +
> +	indio_dev->channels = smi330_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(smi330_channels);
> +	indio_dev->name = "smi330";
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;

Should be no need to set INDIO_BUFFER_SOFTWARE - it is set as part
of registering buffers.  In this case in devm_iio_triggered_buffer_setup_ext()


> +	indio_dev->info = &smi330_info;
> +
> +	data->cfg.op_mode = SMI330_IDLE;
> +
> +	ret = smi330_dev_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Init failed\n");
> +
> +	if (data->cfg.data_irq != SMI330_INT_DISABLED) {

Needs to be based on firmware providing an interrupt or not.

> +		ret = smi330_register_irq(dev, indio_dev);
> +		if (ret)
> +			return dev_err_probe(
> +				dev, ret,
Put those parameters on previous line.
> +				"Register IRQ failed - check Kconfig and devicetree\n");
That indent is fine given long line.

> +

> +		data->trig = devm_iio_trigger_alloc(dev, "%s-drdy-trigger",
> +						    indio_dev->name);
> +		if (!data->trig)
> +			return -ENOMEM;
> +
> +		data->trig->ops = &smi330_trigger_ops;
> +		iio_trigger_set_drvdata(data->trig, data);
> +
> +		ret = devm_iio_trigger_register(dev, data->trig);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "IIO register trigger failed\n");
> +
> +		/*
> +		 * Set default operation mode to data ready.
> +		 */

		/* Set default operation mode to data ready */

> +		indio_dev->trig = iio_trigger_get(data->trig);
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
> +						  iio_pollfunc_store_time,
> +						  smi330_trigger_handler,
> +						  IIO_BUFFER_DIRECTION_IN, NULL,
> +						  NULL);

I think you can just use devm_iio_triggered_buffer_setup() and reduce which
parameters you need to set.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "IIO buffer setup failed\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Register IIO device failed\n");
> +
> +	return 0;
> +}

Blank line here.

> +MODULE_AUTHOR("Stefan Gutmann <stefan.gutmann@de.bosch.com>");
> +MODULE_AUTHOR("Roman Huber <roman.huber@de.bosch.com>");
> +MODULE_AUTHOR("Filip Andrei <Andrei.Filip@ro.bosch.com>");
> +MODULE_AUTHOR("Drimbarean Avram Andrei <Avram-Andrei.Drimbarean@ro.bosch.com>");
> +MODULE_DESCRIPTION("Bosch SMI330 driver");
> +MODULE_LICENSE("Dual BSD/GPL");

> diff --git a/drivers/iio/imu/smi330/smi330_i2c.c b/drivers/iio/imu/smi330/smi330_i2c.c
> new file mode 100644
> index 00000000000..bd837003ab6
> --- /dev/null
> +++ b/drivers/iio/imu/smi330/smi330_i2c.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2025 Robert Bosch GmbH.
> + */
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include "smi330.h"
> +
> +#define I2C_XFER_MAX_RETRY 10
> +#define I2C_WRITE_DELAY_TIME 10

Rename these to scope to driver SMI330_I2C_... to avoid long term name clashes
that can occur with generic names.

> +
> +#define NUM_DUMMY_BYTES 2
> +#define SMI330_I2C_MAX_RX_BUFFER_SIZE (NUM_DUMMY_BYTES + 32)

Why 32? 

> +
> +struct smi330_i2c_priv {
> +	struct i2c_client *i2c;
> +	u8 rx_buffer[SMI330_I2C_MAX_RX_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);

Unless we explicitly tell it otherwise I2C subsystem assumes that it doesn't have
a DMA safe buffer and bounces everything if needed.  Here I think we
should probably just rely on that.

> +};
> +
> +static int smi330_regmap_i2c_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	struct smi330_i2c_priv *priv = context;
> +	int ret, retry;
> +
> +	/*
> +	 * SMI330 I2C read frame:
> +	 * <Slave address[6:0], RnW> <x, Register address[6:0]>
> +	 * <Slave address[6:0], RnW> <Dummy[7:0]> <Dummy[7:0]> <Data_0[7:0]> <Data_1[15:8]>...
> +	 *                                                     <Data_N[7:0]> <Data_N[15:8]>
> +	 * Remark: Slave address is not considered part of the frame in the following definitions
> +	 */
> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = priv->i2c->addr,
> +			.flags = priv->i2c->flags,
> +			.len = reg_size,
> +			.buf = (u8 *)reg_buf,
> +		},
> +		{
> +			.addr = priv->i2c->addr,
> +			.flags = priv->i2c->flags | I2C_M_RD,
> +			.len = NUM_DUMMY_BYTES + val_size,
> +			.buf = priv->rx_buffer,
> +		},
> +	};
> +
> +	for (retry = 0; retry < I2C_XFER_MAX_RETRY; retry++) {

For retries, it's good to document why you think this might fail and why 10 is
a reasonable number.  Mostly we assume i2c is a reliable transport and
wouldn't have retries like this.


> +		ret = i2c_transfer(priv->i2c->adapter, msgs, ARRAY_SIZE(msgs));
> +		if (ret > 0)
> +			break;
> +
> +		usleep_range(I2C_WRITE_DELAY_TIME * 1000,
> +			     I2C_WRITE_DELAY_TIME * 1000);
> +	}
> +
> +	if (retry >= I2C_XFER_MAX_RETRY) {
> +		dev_err(&priv->i2c->adapter->dev, "Xfer error");
> +		return -EIO;
> +	}
> +
> +	memcpy(val_buf, priv->rx_buffer + NUM_DUMMY_BYTES, val_size);
> +
> +	return 0;
> +}

...

> +
> +static struct i2c_driver smi330_i2c_driver = {
> +	.probe = smi330_i2c_probe,
> +	.id_table = smi330_i2c_device_id,
> +	.driver = { .of_match_table = smi330_of_match,
I'd prefer the more common style of
	.driver = {
		.of_match_table = smi330_of_match,
		.name = "smi330_i2c",
	},

> +		    .name = "smi330_i2c",
> +	},
> +};
> +module_i2c_driver(smi330_i2c_driver);
> diff --git a/drivers/iio/imu/smi330/smi330_spi.c b/drivers/iio/imu/smi330/smi330_spi.c
> new file mode 100644
> index 00000000000..93672744452
> --- /dev/null
> +++ b/drivers/iio/imu/smi330/smi330_spi.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2025 Robert Bosch GmbH.
> + */
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "smi330.h"
> +
> +static int smi330_regmap_spi_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	struct spi_device *spi = context;
> +
> +	return spi_write_then_read(spi, reg_buf, reg_size, val_buf, val_size);
> +}
> +
> +static int smi330_regmap_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	struct spi_device *spi = context;
> +	u8 *data_buff = (u8 *)data;
> +
> +	data_buff[1] = data_buff[0];

This is unusual enough I'd like some explanatory comments.
This, I think, effectively reverses the effect of pad_bits.

So I assume that you need that for the read callback?

Given you are using spi_write_then_read() maybe it would be
easier to use a local variable in there for reg_buf and do the
padding there instead of making the core regmap add padding
only to remove it again here?


> +	return spi_write(spi, data_buff + 1, count - 1);
> +}
> +
> +static const struct regmap_bus smi330_regmap_bus = {
> +	.read = smi330_regmap_spi_read,
> +	.write = smi330_regmap_spi_write,
> +	.read_flag_mask = 0x80,
> +};
> +
> +static const struct regmap_config smi330_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.pad_bits = 8,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +static int smi330_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init(&spi->dev, &smi330_regmap_bus, &spi->dev,
> +				  &smi330_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
> +				     "Failed to initialize SPI Regmap\n");
> +
> +	return smi330_core_probe(&spi->dev, regmap);
> +}
...
> +
> +static struct spi_driver smi330_spi_driver = {
> +	.probe = smi330_spi_probe,
> +	.id_table = smi330_spi_device_id,
> +	.driver = { .of_match_table = smi330_of_match,
> +		    .name = "smi330_spi",
> +	},
Same as i2c above for formatting.
> +};
> +module_spi_driver(smi330_spi_driver);

