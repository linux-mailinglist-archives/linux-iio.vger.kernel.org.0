Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6BAB186DE3
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 15:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbgCPOzC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 10:55:02 -0400
Received: from www381.your-server.de ([78.46.137.84]:47118 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731539AbgCPOzB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 10:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vvDbqRwSbUmV4RDLv6R6kVEx+mMcqdMXeLyElgMDDK0=; b=L492P+R3DUTyCEQe9+7bZy4NzB
        6ikWZsT62teIV64hYgFXblWpa/Nbh6hMXGl21OVJSTdO9E6ETx/gwes4eOhtvzEMjj02HW0KysPs8
        W6x2HQ5ldoLciA7E1cr3s3Ty43CuCeOgn+TH89qW/+kQdumaGJLsVVs8YJK0rX5v9ok5jmOpeu/QV
        Yy/09a4KHhM5iRd3l1jD8FYbM7jhzDr0TgTLB5C8WT5JKJvOI1rBz6Xy4cHWNKANaT+AW+thpWGcc
        LCY+YRhQni2NAKL/oRZY4x6pU+6chdu6ZPgd5n4ucEZzPogDwvPbBWGHFJ7Mp7EEA7WoaDXgj8xoB
        AqWRBk1A==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jDr8s-0005xO-6B; Mon, 16 Mar 2020 15:54:58 +0100
Received: from [93.104.121.61] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jDr8r-000Baf-RS; Mon, 16 Mar 2020 15:54:58 +0100
Subject: Re: [PATCH v2] iio: accel: Add support for the Bosch-Sensortec BMI088
To:     Mike Looijmans <mike.looijmans@topic.nl>, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     knaack.h@gmx.de, pmeerw@pmeerw.net
References: <20200315120238.18c10af0@archlinux>
 <20200313140415.20266-1-mike.looijmans@topic.nl>
 <20200316073208.19715-1-mike.looijmans@topic.nl>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <46bec9b8-28ee-6fd3-f615-2b8db43626aa@metafoo.de>
Date:   Mon, 16 Mar 2020 15:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316073208.19715-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25753/Mon Mar 16 14:05:55 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/16/20 8:32 AM, Mike Looijmans wrote:
> The BMI088 is a combined module with both accelerometer and gyroscope.
> This adds the accelerometer driver support for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.
Looks very good, a few comments inline.
> [...]
> +static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int *val)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	u8 value[2];
> +	unsigned int temp;
> +
> +	mutex_lock(&data->mutex);
> +
> +	/* Read temp reg MSB */
> +	ret = regmap_bulk_read(data->regmap, BMI088_ACCEL_REG_TEMP,
> +			       &value, sizeof(value));
> +	if (ret < 0) {
> +		dev_err(dev, "Error reading BMI088_ACCEL_REG_TEMP\n");
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	}
> +	temp = (unsigned int)value[0] << 3;
> +	temp |= (value[1] >> 5);
> +
> +	if (temp > 1023)
> +		*val = temp - 2028;

I would be highly surprised if this is not supposed to be 2048.

If it is you can simplify the expression to be able to work without the 
conditional by using

*val = sign_extend32(temp, 11);

I believe it is 11, better double check.

> +	else
> +		*val = temp;
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return IIO_VAL_INT;
> +}
> [...]
> +static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int *val, int *val2, long mask)
> +{
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int range;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			return bmi088_accel_get_temp(data, val);
> +		case IIO_ACCEL:
> +			if (iio_buffer_enabled(indio_dev))
> +				return -EBUSY;

I think there is a race condition here. If the buffer is enabled after 
the check undefined behavior might occur. Jonathan already mentioned it 
in his review. Best is to use iio_device_{claim,release}_direct_mode().

> +
> +			ret = regmap_read(data->regmap,
> +				BMI088_ACCEL_REG_ACC_RANGE, &range);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = bmi088_accel_get_axis(data, chan, val);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val = (*val * 3 * 980 * (0x01 << range)) >> 15;
> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> [...]
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
> +		ret = bmi088_accel_set_bw(data, val, val2);
> +		mutex_unlock(&data->mutex);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("12.5 25 50 100 200 400 800 1600");
> +
> +static struct attribute *bmi088_accel_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group bmi088_accel_attrs_group = {
> +	.attrs = bmi088_accel_attributes,
> +};
> +
> +#define BMI088_ACCEL_CHANNEL(_axis, bits) {				\
> +	.type = IIO_ACCEL,						\
> +	.modified = 1,							\
> +	.channel2 = IIO_MOD_##_axis,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.scan_index = AXIS_##_axis,					\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = (bits),					\
> +		.storagebits = 16,					\
> +		.shift = 16 - (bits),					\
> +		.endianness = IIO_LE,					\
> +	},								\
> +}
> +
> +#define BMI088_ACCEL_CHANNELS(bits) {					\
> +	{								\
> +		.type = IIO_TEMP,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +				      BIT(IIO_CHAN_INFO_SCALE) |	\
> +				      BIT(IIO_CHAN_INFO_OFFSET),	\
> +		.scan_index = -1,					\
> +	},								\
> +	BMI088_ACCEL_CHANNEL(X, bits),					\
> +	BMI088_ACCEL_CHANNEL(Y, bits),					\
> +	BMI088_ACCEL_CHANNEL(Z, bits),					\
> +	IIO_CHAN_SOFT_TIMESTAMP(3),					\
> +}
> +
> +static const struct iio_chan_spec bmi088_accel_channels[] =
> +	BMI088_ACCEL_CHANNELS(16);
> +
> +static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
> +	[0] = {
> +		.name = "BMI088A",
> +		.chip_id = 0x1E,
> +		.channels = bmi088_accel_channels,
> +		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
> +		.scale_table = { {9610, BMI088_ACCEL_RANGE_3G},
> +				 {19122, BMI088_ACCEL_RANGE_6G},
> +				 {38344, BMI088_ACCEL_RANGE_12G},
> +				 {76590, BMI088_ACCEL_RANGE_24G} },
> +		},
> +};
> +
> +static const struct iio_info bmi088_accel_info = {
> +	.attrs		= &bmi088_accel_attrs_group,
> +	.read_raw	= bmi088_accel_read_raw,
> +	.write_raw	= bmi088_accel_write_raw,
> +};
> +
> +static const unsigned long bmi088_accel_scan_masks[] = {
> +				BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
> +				0};
> +
> +
> +
> +#ifdef CONFIG_PM
> +static int bmi088_accel_set_power_state(struct bmi088_accel_data *data,
> +	bool on)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	if (on) {
> +		ret = pm_runtime_get_sync(dev);
> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		ret = pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	if (ret < 0) {
> +		dev_err(dev, "Failed: %s(%d)\n", __func__, on);
> +		if (on)
> +			pm_runtime_put_noidle(dev);
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int bmi088_accel_set_power_state(struct bmi088_accel_data *data,
> +	bool on)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static int bmi088_accel_chip_init(struct bmi088_accel_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret, i;
> +	unsigned int val;
> +
> +	/* Do a dummy read (of chip ID), to enable SPI interface */
> +	regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID, &val);
> +
> +	/*
> +	 * Reset chip to get it in a known good state. A delay of 1ms after
> +	 * reset is required according to the data sheet
> +	 */
> +	regmap_write(data->regmap, BMI088_ACCEL_REG_RESET,
> +		     BMI088_ACCEL_RESET_VAL);
> +	usleep_range(1000, 2000);
> +
> +	/* Do a dummy read (of chip ID), to enable SPI interface after reset */
> +	regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID, &val);
> +
> +	/* Read chip ID */
> +	ret = regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID, &val);
> +	if (ret < 0) {
> +		dev_err(dev, "Error: Reading chip id\n");
> +		return ret;
> +	}
> +
> +	/* Validate chip ID */
> +	dev_dbg(dev, "Chip Id %x\n", val);
> +	for (i = 0; i < ARRAY_SIZE(bmi088_accel_chip_info_tbl); i++) {
> +		if (bmi088_accel_chip_info_tbl[i].chip_id == val) {
> +			data->chip_info = &bmi088_accel_chip_info_tbl[i];
> +			break;
> +		}
> +	}
> +
> +	if (!data->chip_info) {
> +		dev_err(dev, "Invalid chip %x\n", val);
> +		return -ENODEV;
> +	}
> +
> +	/* Set Active mode (and wait for 5ms) */
> +	ret = bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(5000, 10000);
> +
> +	/* Enable accelerometer */
> +	ret = bmi088_accel_enable(data, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set Bandwidth */
> +	ret = bmi088_accel_set_bw(data, BMI088_ACCEL_MODE_ODR_100,
> +		BMI088_ACCEL_MODE_OSR_NORMAL);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set Default Range */
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_RANGE,
> +			   BMI088_ACCEL_RANGE_6G);
> +	if (ret < 0) {
> +		dev_err(dev, "Error writing ACC_RANGE\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
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
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_init(&data->mutex);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->channels = data->chip_info->channels;
> +	indio_dev->num_channels = data->chip_info->num_channels;
> +	indio_dev->name = name ? name : data->chip_info->name;
Considering that chip_info is chosen by the product ID register, 
regardless of what the compatible string was, maybe it is best to always 
use chip_info->name here.
> +	indio_dev->available_scan_masks = bmi088_accel_scan_masks;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &bmi088_accel_info;
>
> diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
> new file mode 100644
> index 000000000000..920e146f07d3
> --- /dev/null
> +++ b/drivers/iio/accel/bmi088-accel-spi.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
> + *  - BMI088
> + *
> + * Copyright (c) 2018, Topic Embedded Products
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/acpi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +
> +#include "bmi088-accel.h"
> +
> +int bmi088_regmap_spi_write(void *context, const void *data, size_t count)
> +{
> +	struct spi_device *spi = context;
> +	u8 buf[count];
> +
> +	memcpy(buf, data, count);
> +
> +	dev_dbg(&spi->dev, "Write val: %x to reg: %x\n", buf[1], buf[0]);
> +
> +	/*
> +	 * The SPI register address (= full register address without bit 7)
> +	 * and the write command (bit7 = RW = '0')
> +	 */
> +	buf[0] &= ~0x80;
> +
> +	return spi_write(spi, buf, count);
> +}
> +
> +int bmi088_regmap_spi_read(void *context, const void *reg,
> +				size_t reg_size, void *val, size_t val_size)
> +{
> +	struct spi_device *spi = context;
> +	u8 addr[reg_size + 1];
I believe there is an effort to eliminate variable length arrays that 
are placed on the stack from the kernel. reg_size should have a very 
small upper limit you should be able to get away with a statically sized 
array.
> +
> +	addr[0] = *(u8 *)reg;
> +
> +	dev_dbg(&spi->dev, "Read reg: %x\n", addr[0]);
> +
> +	addr[0] |= 0x80; /* bit7 = RW = '1' */
> +
> +	/* Do a write of 2 to mimic the dummy byte (see datasheet) */
> +	return spi_write_then_read(spi, addr, sizeof(addr), val, val_size);
> +}
[...]


