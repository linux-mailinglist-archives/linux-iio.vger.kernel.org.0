Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EE71CE0F7
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 18:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgEKQuc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 12:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgEKQub (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 May 2020 12:50:31 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2648BC061A0C;
        Mon, 11 May 2020 09:50:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id di6so4815480qvb.10;
        Mon, 11 May 2020 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fOl/eG2h718tSCREnWRWFvf6/9gzpZjOaIUY7+985g=;
        b=aFIxNTpFMm0WOq96jYZCy5CQ8jkNSX2E1oBFjGSOSMAmE9rwLH7DP/u9wDZFdkCr/p
         VdjBj2v07Ly66sQOatAU3b8o+LxRE4babPbD3XE/qIbtH9/PEzJzM723jaYvnDC91cBm
         1LMMElrPrvCIdSJiwv37wzOYvrTQTQOq2AP8z46pXjLYhHwNdspICnqoQAJ7XXD7mhf9
         K/CPad5df44oZAYAZLRsV2LhYP3W/q9MO5FFb/O1/QnNaIFfQ/YiBRfoKlqs67RcWY6B
         QUbfuJ48ocUS2A7QTfc3kV41XDaP54rjiPjMZjUtC8yudsxeCsXMkYClrj3gOz8Zen/l
         h29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fOl/eG2h718tSCREnWRWFvf6/9gzpZjOaIUY7+985g=;
        b=QWf5tmNHHKhIcJtaow4mGuKOZmCx9Nq7ZYL3EpwnUSlMUYPICCqWfSz2Tdq+/gZG6r
         9+MBee3oaMRi0hxqDcar5N8a38Q5b9Zpd8BFpulRyNNMIZ/u8Qh57aT5I/9GuwX7YDy8
         +dH8deyj8Hb81n9qzvOAsfLHDnXcUaJWVvtUtvuK6J1POux75kNjM5N9R8X/0U7/cctm
         brgRDjTz4lQOSZsUdAYtssMQqhbM6JwoNZxoKZSiBV7C++l0i7zbi1dDxTgjJxE1JbsA
         O5PqtTuWh8KN0Vq53mIk5Ka2w76O6VvMKdTul8lXRo7xLSRouAblzdzYf/vYeLqU8VwM
         BuDg==
X-Gm-Message-State: AGi0Pua+4knjIkvGzyXXeI2HA4gbhqQA3mTTdx/gXY2rDotKGDGO6fML
        S3i6o6b+xpy+dmKbLD9t7ilqr6uDafU=
X-Google-Smtp-Source: APiQypK8VPrhltvJcE1G/6TndY8VlNFQqumMTn6N96/ldvdoVEr0U6XuUPOsUyvRlj9Y1uotCmuMZw==
X-Received: by 2002:ad4:4d44:: with SMTP id m4mr12071487qvm.236.1589215829006;
        Mon, 11 May 2020 09:50:29 -0700 (PDT)
Received: from walkerma-glaptop.roam.corp.google.com ([96.75.216.153])
        by smtp.gmail.com with ESMTPSA id o31sm5066085qto.64.2020.05.11.09.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 09:50:28 -0700 (PDT)
Date:   Mon, 11 May 2020 09:50:24 -0700
From:   Matthew Walker <mattofak@gmail.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        jic23@kernel.org, linux-kernel@vger.kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, John FitzSimons <jfitzsim@google.com>
Subject: Re: [PATCH v5 2/2] iio: accel: Add support for the Bosch-Sensortec
 BMI088
Message-ID: <20200511095024.69425879@walkerma-glaptop.roam.corp.google.com>
In-Reply-To: <20200324080309.12171-2-mike.looijmans@topic.nl>
References: <20200324080309.12171-1-mike.looijmans@topic.nl>
        <20200324080309.12171-2-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Mike,

Thanks for doing this work. I've been reviewing it with the intention
of bringing it into my organizations embedded platform, and had some
comments for you if you're still looking to improve upon things.

A big question I have for you right at the start however is why are you
locking around some but not all of the regmap calls? I couldn't figure
out why you need locking at all given that regmap contains its own
locks. The best concept I could come up with is that there is some race
between the power management code and regmap, but I'm not seeing it.

On Tue, 24 Mar 2020 09:03:08 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The BMI088 is a combined module with both accelerometer and gyroscope.
> This adds the accelerometer driver support for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Remove unused typedefs and variables
>     Fix error return when iio_device_register fails
> v3: Processed comments from Jonathan Cameron and Lars-Peter Clausen
>     implement runtime PM (tested by code tracing) and sleep
>     fix scale and offset factors for accel and temperature and
>     return raw values instead of pre-scaled ones
>     Use iio_device_{claim,release}_direct_mode
>     Remove unused code and structs
>     Use a cache-aligned buffer for bulk read
>     Configure and enable caching register values    
> v4: Remove unused #include directives
>     Remove unused #defines for event and irq
>     Replace (ret < 0) with (ret) for all regmap calls
>     Consistent checking of IO errors in probe and init
>     Removed #ifdef CONFIG_PM guard
>     Use bitops for set_frequency instead of loop with shift
>     s/__s16/s16/g
>     Remove excess blank lines
>     Don't return -EAGAIN in pm_runtime
> v5: Add includes and forward defines in header
>     BIT(7) instead of 0x80
>     Reset already sets defaults, do not set them again
>     Remove now unused bmi088_accel_set_bw
>     Remove unused AXIS_MAX
>     Use MASK define for ODR setting
>     Explain buffer use and alignment
>     Split bmi088_accel_set_power_state into "on" and "off" parts
>     Cosmetic changes to improve readability
> 
>  drivers/iio/accel/Kconfig             |  17 +
>  drivers/iio/accel/Makefile            |   2 +
>  drivers/iio/accel/bmi088-accel-core.c | 610
> ++++++++++++++++++++++++++ drivers/iio/accel/bmi088-accel-spi.c  |
> 85 ++++ drivers/iio/accel/bmi088-accel.h      |  18 +
>  5 files changed, 732 insertions(+)
>  create mode 100644 drivers/iio/accel/bmi088-accel-core.c
>  create mode 100644 drivers/iio/accel/bmi088-accel-spi.c
>  create mode 100644 drivers/iio/accel/bmi088-accel.h
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 5d91a6dda894..7ed9c82b731b 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -151,6 +151,23 @@ config BMC150_ACCEL_SPI
>  	tristate
>  	select REGMAP_SPI
>  
> +config BMI088_ACCEL
> +	tristate "Bosch BMI088 Accelerometer Driver"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select REGMAP
> +	select BMI088_ACCEL_SPI
> +	help
> +	  Say yes here to build support for the Bosch BMI088
> accelerometer. +
> +	  This is a combo module with both accelerometer and
> gyroscope.
> +	  This driver is only implementing accelerometer part, which
> has
> +	  its own address and register map.
> +
> +config BMI088_ACCEL_SPI
> +	tristate
> +	select REGMAP_SPI
> +
>  config DA280
>  	tristate "MiraMEMS DA280 3-axis 14-bit digital accelerometer
> driver" depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 3a051cf37f40..f44613103ae5 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -19,6 +19,8 @@ obj-$(CONFIG_BMA400_I2C) += bma400_i2c.o
>  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
>  obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
>  obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
> +obj-$(CONFIG_BMI088_ACCEL) += bmi088-accel-core.o
> +obj-$(CONFIG_BMI088_ACCEL_SPI) += bmi088-accel-spi.o
>  obj-$(CONFIG_DA280)	+= da280.o
>  obj-$(CONFIG_DA311)	+= da311.o
>  obj-$(CONFIG_DMARD06)	+= dmard06.o
> diff --git a/drivers/iio/accel/bmi088-accel-core.c
> b/drivers/iio/accel/bmi088-accel-core.c new file mode 100644
> index 000000000000..c1d9a8ba2f46
> --- /dev/null
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -0,0 +1,610 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * 3-axis accelerometer driver supporting following Bosch-Sensortec
> chips:
> + *  - BMI088
> + *
> + * Copyright (c) 2018-2020, Topic Embedded Products
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/acpi.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/regmap.h>
> +#include <asm/unaligned.h>
> +
> +#include "bmi088-accel.h"
> +
> +#define BMI088_ACCEL_REG_CHIP_ID			0x00
> +#define BMI088_ACCEL_REG_ERROR				0x02
> +
> +#define BMI088_ACCEL_REG_INT_STATUS			0x1D
> +#define BMI088_ACCEL_INT_STATUS_BIT_DRDY		BIT(7)
> +
> +#define BMI088_ACCEL_REG_RESET				0x7E
> +#define BMI088_ACCEL_RESET_VAL				0xB6
> +
> +#define BMI088_ACCEL_REG_PWR_CTRL			0x7D
> +#define BMI088_ACCEL_REG_PWR_CONF			0x7C
> +
> +#define BMI088_ACCEL_REG_INT_MAP_DATA			0x58
> +#define BMI088_ACCEL_INT_MAP_DATA_BIT_INT1_DRDY		BIT(2)
> +#define BMI088_ACCEL_INT_MAP_DATA_BIT_INT2_FWM		BIT(5)
> +
> +#define BMI088_ACCEL_REG_INT1_IO_CONF			0x53
> +#define BMI088_ACCEL_INT1_IO_CONF_BIT_ENABLE_OUT	BIT(3)
> +#define BMI088_ACCEL_INT1_IO_CONF_BIT_LVL		BIT(1)
> +
> +#define BMI088_ACCEL_REG_INT2_IO_CONF			0x54
> +#define BMI088_ACCEL_INT2_IO_CONF_BIT_ENABLE_OUT	BIT(3)
> +#define BMI088_ACCEL_INT2_IO_CONF_BIT_LVL		BIT(1)
> +
> +#define BMI088_ACCEL_REG_ACC_CONF			0x40
> +#define BMI088_ACCEL_MODE_ODR_MASK			0x0f
> +
> +#define BMI088_ACCEL_REG_ACC_RANGE			0x41
> +#define BMI088_ACCEL_RANGE_3G				0x00
> +#define BMI088_ACCEL_RANGE_6G				0x01
> +#define BMI088_ACCEL_RANGE_12G				0x02
> +#define BMI088_ACCEL_RANGE_24G				0x03
> +
> +#define BMI088_ACCEL_REG_TEMP				0x22
> +#define BMI088_ACCEL_REG_TEMP_SHIFT			5
> +#define BMI088_ACCEL_TEMP_UNIT				125
> +#define BMI088_ACCEL_TEMP_OFFSET			23000
> +
> +#define BMI088_ACCEL_REG_XOUT_L				0x12
> +#define BMI088_ACCEL_AXIS_TO_REG(axis) \
> +	(BMI088_ACCEL_REG_XOUT_L + (axis * 2))
> +
> +#define BMI088_ACCEL_MAX_STARTUP_TIME_US		1000
> +#define BMI088_AUTO_SUSPEND_DELAY_MS			2000
> +
> +#define BMI088_ACCEL_REG_FIFO_STATUS			0x0E
> +#define BMI088_ACCEL_REG_FIFO_CONFIG0			0x48
> +#define BMI088_ACCEL_REG_FIFO_CONFIG1			0x49
> +#define BMI088_ACCEL_REG_FIFO_DATA			0x3F
> +#define BMI088_ACCEL_FIFO_LENGTH			100
> +
> +#define BMI088_ACCEL_FIFO_MODE_FIFO			0x40
> +#define BMI088_ACCEL_FIFO_MODE_STREAM			0x80
> +
> +enum bmi088_accel_axis {
> +	AXIS_X,
> +	AXIS_Y,
> +	AXIS_Z,
> +};
> +
> +enum bmi088_power_modes {
> +	BMI088_ACCEL_MODE_ACTIVE,
> +	BMI088_ACCEL_MODE_SUSPEND,
> +};

It seems like these could be defined as per register 0x7C; then you can
avoid the secondary lookup / ternary in bmi088_accel_set_mode().

> +
> +/* Available OSR (over sampling rate) sets the 3dB cut-off frequency
> */ +enum bmi088_osr_modes {
> +	BMI088_ACCEL_MODE_OSR_NORMAL = 0xA,
> +	BMI088_ACCEL_MODE_OSR_2 = 0x9,
> +	BMI088_ACCEL_MODE_OSR_4 = 0x8,
> +};
> +
> +/* Available ODR (output data rates) in Hz */
> +enum bmi088_odr_modes {
> +	BMI088_ACCEL_MODE_ODR_12_5 = 0x5,
> +	BMI088_ACCEL_MODE_ODR_25 = 0x6,
> +	BMI088_ACCEL_MODE_ODR_50 = 0x7,
> +	BMI088_ACCEL_MODE_ODR_100 = 0x8,
> +	BMI088_ACCEL_MODE_ODR_200 = 0x9,
> +	BMI088_ACCEL_MODE_ODR_400 = 0xa,
> +	BMI088_ACCEL_MODE_ODR_800 = 0xb,
> +	BMI088_ACCEL_MODE_ODR_1600 = 0xc,
> +};
> +
> +struct bmi088_scale_info {
> +	int scale;
> +	u8 reg_range;
> +};
> +
> +struct bmi088_accel_chip_info {
> +	const char *name;
> +	u8 chip_id;
> +	const struct iio_chan_spec *channels;
> +	int num_channels;
> +};
> +
> +struct bmi088_accel_data {
> +	struct regmap *regmap;
> +	struct mutex mutex;
> +	const struct bmi088_accel_chip_info *chip_info;
> +	u8 buffer[2] ____cacheline_aligned; /* shared DMA safe
> buffer */ +};
> +
> +static const struct regmap_range bmi088_volatile_ranges[] = {
> +	/* All registers below 0x40 are volatile, except the CHIP
> ID. */
> +	regmap_reg_range(BMI088_ACCEL_REG_ERROR, 0x3f),
> +	/* Mark the RESET as volatile too, it is self-clearing */
> +	regmap_reg_range(BMI088_ACCEL_REG_RESET,
> BMI088_ACCEL_REG_RESET), +};
> +
> +static const struct regmap_access_table bmi088_volatile_table = {
> +	.yes_ranges	= bmi088_volatile_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(bmi088_volatile_ranges),
> +};
> +
> +const struct regmap_config bmi088_regmap_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x7E,
> +	.volatile_table = &bmi088_volatile_table,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +EXPORT_SYMBOL_GPL(bmi088_regmap_conf);

This might benefit from a rd_noinc_table defined for the FIFO read
register.

> +
> +static int bmi088_accel_set_power_state_on(struct bmi088_accel_data
> *data) +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmi088_accel_set_power_state_off(struct bmi088_accel_data
> *data) +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	pm_runtime_mark_last_busy(dev);
> +	ret = pm_runtime_put_autosuspend(dev);
> +
> +	return ret < 0 ? ret : 0;

I'm not an expert in the power management code, but I traced this and
the only consumer of this call is iio set_trigger_state which only
cares if the output is less than 0. Thoughts on just returning ret
directly?

> +}
> +
> +/*
> + * The register ACC_PWR_CTRL enables and disables the accelerometer
> and the
> + * temperature sensor.
> + */
> +static int bmi088_accel_enable(struct bmi088_accel_data *data, bool
> on_off) +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned int val = on_off ? 0x4 : 0x0;
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CTRL,
> val);
> +	if (ret) {
> +		dev_err(dev, "Error writing ACC_PWR_CTRL reg\n");
> +		return ret;
> +	}
> +	/* Datasheet recommends to wait at least 5ms before
> communication */
> +	usleep_range(5000, 6000);
> +
> +	return 0;
> +}
> +
> +/* In suspend mode, only the accelerometer is powered down. */
> +static int bmi088_accel_set_mode(struct bmi088_accel_data *data,
> +				enum bmi088_power_modes mode)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned int val = mode == BMI088_ACCEL_MODE_SUSPEND ? 0x3 :
> 0x0;

As suggested above, if the enum was defined with the values already
set, then this ternary could be removed.

> +	int ret;
> +
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CONF,
> val);
> +	if (ret) {
> +		dev_err(dev, "Error writing ACCEL_PWR_CONF reg\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmi088_accel_get_sample_freq(struct bmi088_accel_data
> *data,
> +					int *val, int *val2)
> +{
> +	unsigned int value;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
> +			  &value);
> +	if (ret)
> +		return ret;
> +
> +	value &= BMI088_ACCEL_MODE_ODR_MASK;
> +	if (value == BMI088_ACCEL_MODE_ODR_12_5) {
> +		*val = 12;
> +		*val2 = 500000;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +	} else {
> +		*val = 25 << (value - BMI088_ACCEL_MODE_ODR_25);
> +		*val2 = 0;
> +		ret = IIO_VAL_INT;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bmi088_accel_set_sample_freq(struct bmi088_accel_data
> *data, int val) +{
> +	unsigned int value;
> +
> +	if (val < 12 || val > 1600)
> +		return -EINVAL;
> +
> +	value = fls(val) + 1;
> +
> +	return regmap_update_bits(data->regmap,
> BMI088_ACCEL_REG_ACC_CONF,
> +				  BMI088_ACCEL_MODE_ODR_MASK, value);
> +}
> +
> +static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int
> *val) +{
> +	int ret;
> +	s16 temp;
> +
> +	mutex_lock(&data->mutex);
> +
> +	ret = regmap_bulk_read(data->regmap, BMI088_ACCEL_REG_TEMP,
> +			       &data->buffer, sizeof(__be16));
> +	/* data->buffer is cacheline aligned */
> +	temp = be16_to_cpu(*(__be16 *)data->buffer);
> +
> +	mutex_unlock(&data->mutex);
> +
> +	if (ret)
> +		return ret;
> +
> +	*val = temp >> BMI088_ACCEL_REG_TEMP_SHIFT;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int bmi088_accel_get_axis(struct bmi088_accel_data *data,
> +				 struct iio_chan_spec const *chan,
> +				 int *val)
> +{
> +	int ret;
> +	s16 raw_val;
> +
> +	mutex_lock(&data->mutex);
> +
> +	ret = bmi088_accel_set_power_state_on(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_read(data->regmap,
> +
> BMI088_ACCEL_AXIS_TO_REG(chan->scan_index),
> +			       data->buffer, sizeof(__le16));
> +	raw_val = le16_to_cpu(*(__le16 *)data->buffer);
> +
> +	bmi088_accel_set_power_state_off(data);
> +
> +	mutex_unlock(&data->mutex);
> +
> +	if (ret)
> +		return ret;
> +
> +	*val = raw_val;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int *val, int *val2, long mask)
> +{
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			return bmi088_accel_get_temp(data, val);
> +		case IIO_ACCEL:
> +			ret =
> iio_device_claim_direct_mode(indio_dev);
> +			if (ret)
> +				return ret;
> +
> +			ret = bmi088_accel_get_axis(data, chan, val);
> +			iio_device_release_direct_mode(indio_dev);
> +			if (ret)
> +				return ret;
> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			/* Offset applies before scale */
> +			*val =
> BMI088_ACCEL_TEMP_OFFSET/BMI088_ACCEL_TEMP_UNIT;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			/* 0.125 degrees per LSB */
> +			*val = BMI088_ACCEL_TEMP_UNIT;
> +			return IIO_VAL_INT;
> +		case IIO_ACCEL:
> +			ret = regmap_read(data->regmap,
> +
> BMI088_ACCEL_REG_ACC_RANGE, val);
> +			if (ret)
> +				return ret;
> +
> +			*val2 = 15 - (*val & 0x3);
> +			*val = 3 * 980;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->mutex);
> +		ret = bmi088_accel_get_sample_freq(data, val, val2);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int val, int val2, long mask)
> +{
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->mutex);
> +		ret = bmi088_accel_set_sample_freq(data, val);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("12.5 25 50 100 200 400 800
> 1600"); +
> +static struct attribute *bmi088_accel_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group bmi088_accel_attrs_group = {
> +	.attrs = bmi088_accel_attributes,
> +};
> +
> +#define BMI088_ACCEL_CHANNEL(_axis) {
> 	\
> +	.type = IIO_ACCEL,
> 	\
> +	.modified = 1,
> 		\
> +	.channel2 = IIO_MOD_##_axis,
> 	\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> 	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)
> |		\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
> 	\
> +	.scan_index = AXIS_##_axis,
> 	\ +}
> +
> +static const struct iio_chan_spec bmi088_accel_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.scan_index = -1,
> +	},
> +	BMI088_ACCEL_CHANNEL(X),
> +	BMI088_ACCEL_CHANNEL(Y),
> +	BMI088_ACCEL_CHANNEL(Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static const struct bmi088_accel_chip_info
> bmi088_accel_chip_info_tbl[] = {
> +	[0] = {
> +		.name = "bmi088a",
> +		.chip_id = 0x1E,
> +		.channels = bmi088_accel_channels,
> +		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
> +	},
> +};
> +
> +static const struct iio_info bmi088_accel_info = {
> +	.attrs		= &bmi088_accel_attrs_group,
> +	.read_raw	= bmi088_accel_read_raw,
> +	.write_raw	= bmi088_accel_write_raw,
> +};
> +
> +static const unsigned long bmi088_accel_scan_masks[] = {
> +	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
> +	0
> +};
> +
> +static int bmi088_accel_chip_init(struct bmi088_accel_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret, i;
> +	unsigned int val;
> +
> +	/* Do a dummy read to enable SPI interface, won't harm I2C */
> +	regmap_read(data->regmap, BMI088_ACCEL_REG_INT_STATUS, &val);
> +
> +	/*
> +	 * Reset chip to get it in a known good state. A delay of
> 1ms after
> +	 * reset is required according to the data sheet
> +	 */
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_RESET,
> +			   BMI088_ACCEL_RESET_VAL);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 2000);
> +
> +	/* Do a dummy read again after a reset to enable the SPI
> interface */
> +	regmap_read(data->regmap, BMI088_ACCEL_REG_INT_STATUS, &val);
> +
> +	/* Read chip ID */
> +	ret = regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID,
> &val);
> +	if (ret) {
> +		dev_err(dev, "Error: Reading chip id\n");
> +		return ret;
> +	}
> +
> +	/* Validate chip ID */
> +	for (i = 0; i < ARRAY_SIZE(bmi088_accel_chip_info_tbl); i++)
> {
> +		if (bmi088_accel_chip_info_tbl[i].chip_id == val) {
> +			data->chip_info =
> &bmi088_accel_chip_info_tbl[i];
> +			break;
> +		}
> +	}
> +	if (i == ARRAY_SIZE(bmi088_accel_chip_info_tbl)) {
> +		dev_err(dev, "Invalid chip %x\n", val);
> +		return -ENODEV;
> +	}
> +
> +	/* Enable accelerometer after reset */
> +	return bmi088_accel_enable(data, true);
> +}
> +
> +int bmi088_accel_core_probe(struct device *dev, struct regmap
> *regmap,
> +	int irq, const char *name, bool block_supported)
> +{
> +	struct bmi088_accel_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +
> +	data->regmap = regmap;
> +
> +	ret = bmi088_accel_chip_init(data);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&data->mutex);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->channels = data->chip_info->channels;
> +	indio_dev->num_channels = data->chip_info->num_channels;
> +	indio_dev->name = name ? name : data->chip_info->name;
> +	indio_dev->available_scan_masks = bmi088_accel_scan_masks;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &bmi088_accel_info;
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev,
> BMI088_AUTO_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		dev_err(dev, "Unable to register iio device\n");
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(bmi088_accel_core_probe);
> +
> +int bmi088_accel_core_remove(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
> +
> +	mutex_lock(&data->mutex);
> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bmi088_accel_core_remove);
> +
> +/* When going into system sleep, put the chip in power down */
> +static int __maybe_unused bmi088_accel_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
> +	bmi088_accel_enable(data, false);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused bmi088_accel_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +	bmi088_accel_enable(data, true);
> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +/* For runtime PM put the chip in suspend mode */
> +static int __maybe_unused bmi088_accel_runtime_suspend(struct device
> *dev) +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	return bmi088_accel_set_mode(data,
> BMI088_ACCEL_MODE_SUSPEND); +}
> +
> +static int __maybe_unused bmi088_accel_runtime_resume(struct device
> *dev) +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(BMI088_ACCEL_MAX_STARTUP_TIME_US,
> +		     BMI088_ACCEL_MAX_STARTUP_TIME_US * 2);
> +
> +	return 0;
> +}
> +
> +const struct dev_pm_ops bmi088_accel_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(bmi088_accel_suspend,
> bmi088_accel_resume)
> +	SET_RUNTIME_PM_OPS(bmi088_accel_runtime_suspend,
> +			   bmi088_accel_runtime_resume, NULL)
> +};
> +EXPORT_SYMBOL_GPL(bmi088_accel_pm_ops);
> +
> +MODULE_AUTHOR("Niek van Agt <niek.van.agt@topicproducts.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("BMI088 accelerometer driver (core)");
> diff --git a/drivers/iio/accel/bmi088-accel-spi.c
> b/drivers/iio/accel/bmi088-accel-spi.c new file mode 100644
> index 000000000000..7794090b8e6d
> --- /dev/null
> +++ b/drivers/iio/accel/bmi088-accel-spi.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * 3-axis accelerometer driver supporting following Bosch-Sensortec
> chips:
> + *  - BMI088
> + *
> + * Copyright (c) 2018-2020, Topic Embedded Products
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +
> +#include "bmi088-accel.h"
> +
> +int bmi088_regmap_spi_write(void *context, const void *data, size_t
> count) +{
> +	struct spi_device *spi = context;
> +
> +	/* Write register is same as generic SPI */
> +	return spi_write(spi, data, count);
> +}
> +
> +int bmi088_regmap_spi_read(void *context, const void *reg,
> +				size_t reg_size, void *val, size_t
> val_size) +{
> +	struct spi_device *spi = context;
> +	u8 addr[2];
> +
> +	addr[0] = *(u8 *)reg;
> +	addr[0] |= BIT(7); /* Set RW = '1' */
> +	addr[1] = 0; /* Read requires a dummy byte transfer */
> +
> +	return spi_write_then_read(spi, addr, sizeof(addr), val,
> val_size); +}
> +
> +static struct regmap_bus bmi088_regmap_bus = {
> +	.write = bmi088_regmap_spi_write,
> +	.read = bmi088_regmap_spi_read,
> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> +};
> +
> +static int bmi088_accel_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +	regmap = devm_regmap_init(&spi->dev, &bmi088_regmap_bus,
> +			spi, &bmi088_regmap_conf);
> +
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to initialize spi
> regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq,
> id->name,
> +				       true);
> +}
> +
> +static int bmi088_accel_remove(struct spi_device *spi)
> +{
> +	return bmi088_accel_core_remove(&spi->dev);
> +}
> +
> +static const struct spi_device_id bmi088_accel_id[] = {
> +	{"bmi088_accel", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, bmi088_accel_id);
> +
> +static struct spi_driver bmi088_accel_driver = {
> +	.driver = {
> +		.name	= "bmi088_accel_spi",
> +		.pm	= &bmi088_accel_pm_ops,
> +	},
> +	.probe		= bmi088_accel_probe,
> +	.remove		= bmi088_accel_remove,
> +	.id_table	= bmi088_accel_id,
> +};
> +module_spi_driver(bmi088_accel_driver);
> +
> +MODULE_AUTHOR("Niek van Agt <niek.van.agt@topicproducts.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("BMI088 accelerometer driver (SPI)");
> diff --git a/drivers/iio/accel/bmi088-accel.h
> b/drivers/iio/accel/bmi088-accel.h new file mode 100644
> index 000000000000..5c25f16b672c
> --- /dev/null
> +++ b/drivers/iio/accel/bmi088-accel.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef BMI088_ACCEL_H
> +#define BMI088_ACCEL_H
> +
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +struct device;
> +
> +extern const struct regmap_config bmi088_regmap_conf;
> +extern const struct dev_pm_ops bmi088_accel_pm_ops;
> +
> +int bmi088_accel_core_probe(struct device *dev, struct regmap
> *regmap, int irq,
> +			    const char *name, bool block_supported);
> +int bmi088_accel_core_remove(struct device *dev);
> +
> +#endif /* BMI088_ACCEL_H */

