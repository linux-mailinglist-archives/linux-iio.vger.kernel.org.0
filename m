Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351A33EC9ED
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 17:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhHOPX6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 11:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhHOPX6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 11:23:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1F2661209;
        Sun, 15 Aug 2021 15:23:25 +0000 (UTC)
Date:   Sun, 15 Aug 2021 16:26:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: accel: Add driver support for ADXL313
Message-ID: <20210815162624.36b39b59@jic23-huawei>
In-Reply-To: <69f3b83eaf31d657cdb522839dc0102384d50681.1628713039.git.lucas.p.stankus@gmail.com>
References: <cover.1628713039.git.lucas.p.stankus@gmail.com>
        <69f3b83eaf31d657cdb522839dc0102384d50681.1628713039.git.lucas.p.stankus@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Aug 2021 18:18:02 -0300
Lucas Stankus <lucas.p.stankus@gmail.com> wrote:

> ADXL313 is a small, thin, low power, 3-axis accelerometer with high
> resolution measurement up to +/-4g. It includes an integrated 32-level
> FIFO and has activity and inactivity sensing capabilities.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Hi Lucas,

I took another close look at this and I would like you to not use scan_index
as you are here.  It has a meaning tightly coupled to 'scans' which only exist
as a concept once you have buffered mode. The preferred way to get channel
specific values is to use addr and add a level of indirection (so a lookup
structure of some type).  A few more trivial things to add to what Andy raised
inline below.

Jonathan


...

> +#endif /* _ADXL313_H_ */
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> new file mode 100644
> index 000000000000..8f3d4f5281c4
> --- /dev/null
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -0,0 +1,331 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADXL313 3-Axis Digital Accelerometer
> + *
> + * Copyright (c) 2021 Lucas Stankus <lucas.p.stankus@gmail.com>
> + *
> + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "adxl313.h"
> +
> +const struct regmap_range adxl313_readable_reg_range[] = {
> +	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_XID),
> +	regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
> +	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> +	regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
> +	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_FIFO_STATUS)
> +};
> +
> +const struct regmap_access_table adxl313_readable_regs_table = {
> +	.yes_ranges = adxl313_readable_reg_range,
> +	.n_yes_ranges = ARRAY_SIZE(adxl313_readable_reg_range)
> +};
> +EXPORT_SYMBOL_GPL(adxl313_readable_regs_table);
> +
> +const struct regmap_range adxl313_writable_reg_range[] = {
> +	regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
> +	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> +	regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
> +	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_INT_MAP),
> +	regmap_reg_range(ADXL313_REG_DATA_FORMAT, ADXL313_REG_DATA_FORMAT),
> +	regmap_reg_range(ADXL313_REG_FIFO_CTL, ADXL313_REG_FIFO_CTL)
> +};
> +
> +const struct regmap_access_table adxl313_writable_regs_table = {
> +	.yes_ranges = adxl313_writable_reg_range,
> +	.n_yes_ranges = ARRAY_SIZE(adxl313_writable_reg_range)
> +};
> +EXPORT_SYMBOL_GPL(adxl313_writable_regs_table);
> +
> +struct adxl313_data {
> +	struct regmap	*regmap;
> +	struct mutex	lock; /* lock to protect transf_buf */
> +	__le16		transf_buf ____cacheline_aligned;
> +};
> +
> +static const int adxl313_odr_freqs[][2] = {
> +	[0] = { 6, 250000 },
> +	[1] = { 12, 500000 },
> +	[2] = { 25, 0 },
> +	[3] = { 50, 0 },
> +	[4] = { 100, 0 },
> +	[5] = { 200, 0 },
> +	[6] = { 400, 0 },
> +	[7] = { 800, 0 },
> +	[8] = { 1600, 0 },
> +	[9] = { 3200, 0 },
> +};
> +
> +#define ADXL313_ACCEL_CHANNEL(index, addr, axis) {			\
> +	.type = IIO_ACCEL,						\
> +	.address = addr,						\
> +	.modified = 1,							\
> +	.channel2 = IIO_MOD_##axis,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_CALIBBIAS),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.info_mask_shared_by_type_available =				\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
> +	.scan_index = index,						\

I'm not in general keen on seeing scan_index being set in a driver that isn't providing
a buffer.  Whilst some of the scan_type can have valid meaning without buffering,
scan_index should not.

The use you are making of it here, should use addr.  So put a channel enum value
into addr and use that to look up both the _raw address to read and anything else
channel specific.  That will give more consistent code than you currently have
with a mixture of addr and scan_index being used depending on the particular
thing being read about the channel.

> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 13,						\
> +		.storagebits = 16,					\
> +		.endianness = IIO_LE,					\

sign, storagebits and endianness are things that are only likely to matter once buffered
supported is added (where they relect the datalayout).  For now please drop setting
them at all.

> +	},								\
> +}
> +
> +static const struct iio_chan_spec adxl313_channels[] = {
> +	ADXL313_ACCEL_CHANNEL(0, ADXL313_REG_DATAX, X),
> +	ADXL313_ACCEL_CHANNEL(1, ADXL313_REG_DATAY, Y),
> +	ADXL313_ACCEL_CHANNEL(2, ADXL313_REG_DATAZ, Z),
> +};
> +
> +static int adxl313_set_odr(struct adxl313_data *data,
> +			   unsigned int freq1, unsigned int freq2)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(adxl313_odr_freqs); i++) {
> +		if (adxl313_odr_freqs[i][0] == freq1 &&
> +		    adxl313_odr_freqs[i][1] == freq2)
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(adxl313_odr_freqs))
> +		return -EINVAL;
> +
> +	return regmap_update_bits(data->regmap, ADXL313_REG_BW_RATE,
> +				  ADXL313_RATE_MSK,
> +				  FIELD_PREP(ADXL313_RATE_MSK,
> +					     ADXL313_RATE_BASE + i));
> +}
> +
> +static int adxl313_read_axis(struct adxl313_data *data,
> +			     struct iio_chan_spec const *chan)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret = regmap_bulk_read(data->regmap,
> +			       chan->address,
> +			       &data->transf_buf, 2);
sizeof(data->trasf_buf)
> +	if (ret)
> +		goto unlock_ret;
> +
> +	ret = le16_to_cpu(data->transf_buf);
> +
> +unlock_ret:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   const int **vals, int *type, int *length,
> +				   long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = (const int *)adxl313_odr_freqs;
> +		*length = ARRAY_SIZE(adxl313_odr_freqs) * 2;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adxl313_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	unsigned int regval;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = adxl313_read_axis(data, chan);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Scale for any g range is given in datasheet as
> +		 * 1024 LSB/g = 0.0009765625 * 9.80665 = 0.009576806640625 m/s^2
> +		 */
> +		*val = 0;
> +		*val2 = 9576806;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret = regmap_read(data->regmap,
> +				  ADXL313_REG_OFS_AXIS(chan->scan_index),
As mentioned above, don't use scan_index for this purpose.   There is no particular
reason the scan_index for a given channel won't be changed in future as part of some layout
optimization etc.  addr is for this purpose and often contains an enum value to that
gives a driver specific index of channels, then used to do things like you are doing here.

> +				  &regval);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
> +		 * factor at full resolution
> +		 */
> +		*val = sign_extend32(regval, 7) * 4;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = regmap_read(data->regmap, ADXL313_REG_BW_RATE, &regval);
> +		if (ret)
> +			return ret;
> +
> +		ret = FIELD_GET(ADXL313_RATE_MSK, regval) - ADXL313_RATE_BASE;
> +		*val = adxl313_odr_freqs[ret][0];
> +		*val2 = adxl313_odr_freqs[ret][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adxl313_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		/*
> +		 * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
> +		 * factor at full resolution
> +		 */
> +		if (clamp_val(val, -128 * 4, 127 * 4) != val)
> +			return -EINVAL;
> +
> +		return regmap_write(data->regmap,
> +				    ADXL313_REG_OFS_AXIS(chan->scan_index),
> +				    val / 4);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return adxl313_set_odr(data, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info adxl313_info = {
> +	.read_raw	= adxl313_read_raw,
> +	.write_raw	= adxl313_write_raw,
> +	.read_avail	= adxl313_read_freq_avail
> +};
> +
> +static int adxl313_setup(struct device *dev, struct adxl313_data *data,
> +			 int (*interface_specific_setup)(struct device *,
> +							 struct regmap *))
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	/* Ensures the device is in a consistent state after start up */
> +	ret = regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
> +			   ADXL313_SOFT_RESET);
> +	if (ret)
> +		return ret;
> +
> +	if (interface_specific_setup) {
> +		ret = interface_specific_setup(dev, data->regmap);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_read(data->regmap, ADXL313_REG_DEVID0, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (regval != ADXL313_DEVID0) {
> +		dev_err(dev, "Invalid manufacturer ID: 0x%02x\n", regval);
> +		return -ENODEV;
> +	}
> +
> +	ret = regmap_read(data->regmap, ADXL313_REG_DEVID1, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (regval != ADXL313_DEVID1) {
> +		dev_err(dev, "Invalid mems ID: 0x%02x\n", regval);
> +		return -ENODEV;
> +	}
> +
> +	ret = regmap_read(data->regmap, ADXL313_REG_PARTID, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (regval != ADXL313_PARTID) {
> +		dev_err(dev, "Invalid device ID: 0x%02x\n", regval);
> +		return -ENODEV;
> +	}
> +
> +	/* Sets the range to +/- 4g */
> +	ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
> +				 ADXL313_RANGE_MSK,
> +				 FIELD_PREP(ADXL313_RANGE_MSK,
> +					    ADXL313_RANGE_4G));
> +	if (ret)
> +		return ret;
> +
> +	/* Enables full resolution */
> +	ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
> +				 ADXL313_FULL_RES, ADXL313_FULL_RES);
> +	if (ret)
> +		return ret;
> +
> +	/* Enables measurement mode */
> +	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
> +				  ADXL313_POWER_CTL_MSK,
> +				  ADXL313_MEASUREMENT_MODE);
> +}
> +
> +int adxl313_core_probe(struct device *dev,
> +		       struct regmap *regmap,
> +		       const char *name,
> +		       int (*interface_specific_setup)(struct device *,
> +						       struct regmap *))
> +{
> +	struct adxl313_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->regmap = regmap;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = name;
> +	indio_dev->info = &adxl313_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = adxl313_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adxl313_channels);
> +
> +	ret = adxl313_setup(dev, data, interface_specific_setup);
> +	if (ret) {
> +		dev_err(dev, "ADXL313 setup failed\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_GPL(adxl313_core_probe);
> +
> +MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
> +MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer core driver");
> +MODULE_LICENSE("GPL v2");



> diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
> new file mode 100644
> index 000000000000..4d625b1753a5
> --- /dev/null
> +++ b/drivers/iio/accel/adxl313_spi.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADXL313 3-Axis Digital Accelerometer
> + *
> + * Copyright (c) 2021 Lucas Stankus <lucas.p.stankus@gmail.com>
> + *
> + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
> + */
> +
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>

Seeing as you are going to be doing a v4, please add explicit includes
 for mod_devicetable.h which contains the of_device_id struct definition.
Same for the i2c driver.

> +
> +#include "adxl313.h"
> +
...
