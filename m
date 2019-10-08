Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06EA2CFD83
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2019 17:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfJHPXt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Oct 2019 11:23:49 -0400
Received: from ns.pmeerw.net ([84.19.176.117]:57590 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJHPXt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Oct 2019 11:23:49 -0400
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 54B10E0654; Tue,  8 Oct 2019 17:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1570548226; bh=QOre1B/a4O3wnBpIkKWDKo6xA+rQg4cwuQib8eUyphU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=X6zNwuiM+2dxwI96Wc5CeFzwXVqG1kCIh1H8hrwvuulJsNqwY3iapj1oTwLB6R6A/
         3VdSUz8DC7SZ3HFC85lLXH/C6mAFqSKwnStlbv7lKQWJEuBS8Qx3iZ0HsCreyMoahK
         IWtzMK33eDQRiDxDi3TU1iPngL5+pOh94+i76yVw=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 2D856E02B7;
        Tue,  8 Oct 2019 17:23:46 +0200 (CEST)
Date:   Tue, 8 Oct 2019 17:23:46 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Dan Robertson <dan@dlrobertson.com>
cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: (bma400) add driver for the BMA400
In-Reply-To: <20191006093754.61a12172@archlinux>
Message-ID: <alpine.DEB.2.21.1910081706050.10949@vps.pmeerw.net>
References: <20190925013941.20431-1-dan@dlrobertson.com>        <20190925013941.20431-2-dan@dlrobertson.com> <20191006093754.61a12172@archlinux>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 6 Oct 2019, Jonathan Cameron wrote:

> On Wed, 25 Sep 2019 01:39:41 +0000
> Dan Robertson <dan@dlrobertson.com> wrote:
> 
> > Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
> > The driver supports reading from the acceleration and temperature
> > registers. The driver also supports reading and configuring the output data
> > rate, oversampling ratio, and scale.

some more comments (on top of Jonathan's)
 
> > Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> Hi Dan,
> 
> So my first thought was that Bosch have been moderately good at keeping their
> interfaces consistent across generations.   Seems not this time from
> a quick look!
> 
> Minor stuff inline.  Quite a bit of it is stylistic rather than functional.
> I'm a lazy maintainer and tend to end up reading a lot of code so want to
> think as little as possible ;)
> 
> I'd also expect a modern driver to have DT bindings.  Might let that go if
> it was being used with ACPI but neither is true here.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/accel/Kconfig       |  19 +
> >  drivers/iio/accel/Makefile      |   2 +
> >  drivers/iio/accel/bma400.h      |  74 +++
> >  drivers/iio/accel/bma400_core.c | 862 ++++++++++++++++++++++++++++++++
> >  drivers/iio/accel/bma400_i2c.c  |  54 ++
> >  5 files changed, 1011 insertions(+)
> >  create mode 100644 drivers/iio/accel/bma400.h
> >  create mode 100644 drivers/iio/accel/bma400_core.c
> >  create mode 100644 drivers/iio/accel/bma400_i2c.c
> > 
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index 9b9656ce37e6..cca6727e037e 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -112,6 +112,25 @@ config BMA220
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called bma220_spi.
> >  
> > +config BMA400
> > +	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
> > +	depends on I2C
> > +	select REGMAP
> > +	select BMA400_I2C if (I2C)
> > +	help
> > +	  Say Y here if you want to build a driver for the Bosch BMA400
> > +	  triaxial acceleration sensor.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called bma400_core and you will also get
> > +	  bma400_i2c for I2C
> > +
> > +config BMA400_I2C
> > +	tristate
> > +	depends on BMA400
> > +	depends on I2C
> > +	select REGMAP_I2C
> > +
> >  config BMC150_ACCEL
> >  	tristate "Bosch BMC150 Accelerometer Driver"
> >  	select IIO_BUFFER
> > diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> > index 56bd0215e0d4..3a051cf37f40 100644
> > --- a/drivers/iio/accel/Makefile
> > +++ b/drivers/iio/accel/Makefile
> > @@ -14,6 +14,8 @@ obj-$(CONFIG_ADXL372_I2C) += adxl372_i2c.o
> >  obj-$(CONFIG_ADXL372_SPI) += adxl372_spi.o
> >  obj-$(CONFIG_BMA180) += bma180.o
> >  obj-$(CONFIG_BMA220) += bma220_spi.o
> > +obj-$(CONFIG_BMA400) += bma400_core.o
> > +obj-$(CONFIG_BMA400_I2C) += bma400_i2c.o
> >  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
> >  obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
> >  obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
> > diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> > new file mode 100644
> > index 000000000000..7fa92bc457f6
> > --- /dev/null
> > +++ b/drivers/iio/accel/bma400.h
> > @@ -0,0 +1,74 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * bma400.h - Register constants and other forward declarations
> > + *            needed by the bma400 sources.
> > + *
> > + * Copyright 2019 Dan Robertson <dan@dlrobertson.com>
> > + *
> 
> Blank line not needed.
> 
> > + */
> > +
> > +#include <linux/regmap.h>
> > +
> > +/*
> > + * Read-Only Registers
> > + */
> > +
> > +/* Status and ID registers */
> > +#define BMA400_CHIP_ID_REG      0x00
> > +#define BMA400_ERR_REG          0x02
> > +#define BMA400_STATUS_REG       0x03
> > +
> > +/* Acceleration registers */
> > +#define BMA400_X_AXIS_LSB_REG   0x04
> > +#define BMA400_X_AXIS_MSB_REG   0x05
> > +#define BMA400_Y_AXIS_LSB_REG   0x06
> > +#define BMA400_Y_AXIS_MSB_REG   0x07
> > +#define BMA400_Z_AXIS_LSB_REG   0x08
> > +#define BMA400_Z_AXIS_MSB_REG   0x09
> > +
> > +/* Sensort time registers */

Sensor time

> > +#define BMA400_SENSOR_TIME0     0x0a
> > +#define BMA400_SENSOR_TIME1     0x0b
> > +#define BMA400_SENSOR_TIME2     0x0c
> > +
> > +/* Event and interrupt registers */
> > +#define BMA400_EVENT_REG        0x0d
> > +#define BMA400_INT_STAT0_REG    0x0e
> > +#define BMA400_INT_STAT1_REG    0x0f
> > +#define BMA400_INT_STAT2_REG    0x10
> > +
> > +/* Temperature register */
> > +#define BMA400_TEMP_DATA_REG    0x11
> > +
> > +/* FIFO length and data registers */
> > +#define BMA400_FIFO_LENGTH0_REG 0x12
> > +#define BMA400_FIFO_LENGTH1_REG 0x13
> > +#define BMA400_FIFO_DATA_REG    0x14
> > +
> > +/* Step count registers */
> > +#define BMA400_STEP_CNT0_REG    0x15
> > +#define BMA400_STEP_CNT1_REG    0x16
> > +#define BMA400_STEP_CNT3_REG    0x17
> > +#define BMA400_STEP_STAT_REG    0x18
> > +
> > +/*
> > + * Read-write configuration registers
> > + */
> > +#define BMA400_ACC_CONFIG0_REG  0x19
> > +#define BMA400_ACC_CONFIG1_REG  0x1a
> > +#define BMA400_ACC_CONFIG2_REG  0x1b
> > +#define BMA400_CMD_REG          0x7e
> > +
> > +/* Chip ID of BMA 400 devices found in the chip ID register. */
> > +#define BMA400_ID_REG_VAL       0x90
> > +
> > +/* The softreset command */
> > +#define BMA400_SOFTRESET_CMD    0xb6
> > +
> > +extern const struct regmap_config bma400_regmap_config;
> > +
> > +int bma400_probe(struct device *dev,
> > +		 struct regmap *regmap,
> > +		 const char *name);
> > +
> > +int bma400_remove(struct device *dev);
> > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > new file mode 100644
> > index 000000000000..55fe2f220c30
> > --- /dev/null
> > +++ b/drivers/iio/accel/bma400_core.c
> > @@ -0,0 +1,862 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * bma400-core.c - Core IIO driver for Bosch BMA400 triaxial acceleration

bma400_core.c (underscore)

> > + *                 sensor. Used by bma400-i2c.
> > + *
> > + * Copyright 2019 Dan Robertson <dan@dlrobertson.com>
> > + *
> > + * TODO:
> > + *  - Support for power management
> > + *  - Support events and interrupts
> > + *  - Create channel the step count
> > + *  - Create channel for sensor time
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/bitops.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#include "bma400.h"
> > +
> > +/*
> > + * The G-range selection may be one of 2g, 4g, 8, or 16g. The scale may
> > + * be selected with the acc_range bits of the ACC_CONFIG1 register.
> > + */
> > +const int bma400_scale_table[] = { 38344, 76590, 153277, 306457 };

static?

> > +
> > +struct bma400_sample_freq {
> > +	int hz;
> > +	int micro_hz;
> > +};
> > +
> > +/* See the ACC_CONFIG1 section of the datasheet */
> > +const struct bma400_sample_freq bma400_sample_freqs[] = {

static?

> > +	{ .hz = 12, .micro_hz = 500000 },
> > +	{ .hz = 25, .micro_hz = 0 },
> > +	{ .hz = 50, .micro_hz = 0 },
> > +	{ .hz = 100, .micro_hz = 0 },
> > +	{ .hz = 200, .micro_hz = 0 },
> > +	{ .hz = 400, .micro_hz = 0 },
> > +	{ .hz = 800, .micro_hz = 0 },
> > +};
> > +
> > +/* See the ACC_CONFIG0 section of the datasheet */
> > +enum bma400_power_mode {
> > +	POWER_MODE_SLEEP   = 0x00,
> > +	POWER_MODE_LOW     = 0x01,
> > +	POWER_MODE_NORMAL  = 0x02,
> > +	POWER_MODE_INVALID = 0x03,
> > +};
> > +
> > +struct bma400_data {
> > +	struct device *dev;
> > +	struct mutex mutex; /* data register lock */
> > +	struct iio_mount_matrix orientation;
> > +	struct regmap *regmap;
> > +	enum bma400_power_mode power_mode;
> > +	const struct bma400_sample_freq *sample_freq;
> > +	int oversampling_ratio;
> > +	int scale;
> > +};
> > +
> > +static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case BMA400_CHIP_ID_REG:
> > +	case BMA400_ERR_REG:
> > +	case BMA400_STATUS_REG:
> > +	case BMA400_X_AXIS_LSB_REG:
> > +	case BMA400_X_AXIS_MSB_REG:
> > +	case BMA400_Y_AXIS_LSB_REG:
> > +	case BMA400_Y_AXIS_MSB_REG:
> > +	case BMA400_Z_AXIS_LSB_REG:
> > +	case BMA400_Z_AXIS_MSB_REG:
> > +	case BMA400_SENSOR_TIME0:
> > +	case BMA400_SENSOR_TIME1:
> > +	case BMA400_SENSOR_TIME2:
> > +	case BMA400_EVENT_REG:
> > +	case BMA400_INT_STAT0_REG:
> > +	case BMA400_INT_STAT1_REG:
> > +	case BMA400_INT_STAT2_REG:
> > +	case BMA400_TEMP_DATA_REG:
> > +	case BMA400_FIFO_LENGTH0_REG:
> > +	case BMA400_FIFO_LENGTH1_REG:
> > +	case BMA400_FIFO_DATA_REG:
> > +	case BMA400_STEP_CNT0_REG:
> > +	case BMA400_STEP_CNT1_REG:
> > +	case BMA400_STEP_CNT3_REG:
> > +	case BMA400_STEP_STAT_REG:
> > +		return false;
> > +	default:
> > +		return true;
> > +	}
> > +}
> > +
> > +static bool bma400_is_volatile_reg(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case BMA400_ERR_REG:
> > +	case BMA400_STATUS_REG:
> > +	case BMA400_X_AXIS_LSB_REG:
> > +	case BMA400_X_AXIS_MSB_REG:
> > +	case BMA400_Y_AXIS_LSB_REG:
> > +	case BMA400_Y_AXIS_MSB_REG:
> > +	case BMA400_Z_AXIS_LSB_REG:
> > +	case BMA400_Z_AXIS_MSB_REG:
> > +	case BMA400_SENSOR_TIME0:
> > +	case BMA400_SENSOR_TIME1:
> > +	case BMA400_SENSOR_TIME2:
> > +	case BMA400_EVENT_REG:
> > +	case BMA400_INT_STAT0_REG:
> > +	case BMA400_INT_STAT1_REG:
> > +	case BMA400_INT_STAT2_REG:
> > +	case BMA400_TEMP_DATA_REG:
> > +	case BMA400_FIFO_LENGTH0_REG:
> > +	case BMA400_FIFO_LENGTH1_REG:
> > +	case BMA400_FIFO_DATA_REG:
> > +	case BMA400_STEP_CNT0_REG:
> > +	case BMA400_STEP_CNT1_REG:
> > +	case BMA400_STEP_CNT3_REG:
> > +	case BMA400_STEP_STAT_REG:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +const struct regmap_config bma400_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.max_register = BMA400_CMD_REG,
> > +	.cache_type = REGCACHE_RBTREE,
> > +	.writeable_reg = bma400_is_writable_reg,
> > +	.volatile_reg = bma400_is_volatile_reg,
> > +};
> > +EXPORT_SYMBOL(bma400_regmap_config);
> > +
> > +static const struct iio_mount_matrix *
> > +bma400_accel_get_mount_matrix(const struct iio_dev *indio_dev,
> > +			      const struct iio_chan_spec *chan)
> > +{
> > +	struct bma400_data *data = iio_priv(indio_dev);
> > +
> > +	return &data->orientation;
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
> > +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma400_accel_get_mount_matrix),
> > +	{ }
> > +};
> > +
> > +#define BMA400_ACC_CHANNEL(_axis) { \
> > +	.type = IIO_ACCEL, \
> > +	.modified = 1, \
> > +	.channel2 = IIO_MOD_##_axis, \
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> > +		BIT(IIO_CHAN_INFO_SCALE) | \
> > +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> > +	.ext_info = bma400_ext_info \

end with ,

> > +}
> > +
> > +static const struct iio_chan_spec bma400_channels[] = {
> > +	BMA400_ACC_CHANNEL(X),
> > +	BMA400_ACC_CHANNEL(Y),
> > +	BMA400_ACC_CHANNEL(Z),
> > +	{
> > +		.type = IIO_TEMP,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +	},
> > +};
> > +
> > +static int bma400_get_temp_reg(struct bma400_data *data, int *val, int *val2)
> > +{
> > +	int ret;
> > +	int host_temp;
> > +	unsigned int raw_temp;
> > +
> > +	if (data->power_mode == POWER_MODE_SLEEP)
> > +		return -EBUSY;
> > +
> > +	ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &raw_temp);
> > +
> > +	if (!ret) {
> Error path out of line, not the good one. See below.
> 
> > +		host_temp = sign_extend32(raw_temp, 7);
> > +		/*
> > +		 * The formula for the TEMP_DATA register in the datasheet
> > +		 * is: x * 0.5 + 23
> > +		 */
> > +		*val = (host_temp >> 1) + 23;
> > +		*val2 = (host_temp & 0x1) * 500000;
> > +		ret = IIO_VAL_INT_PLUS_MICRO;
> > +	}
> > +	return ret;
> > +}
> > +
> > +static int bma400_get_accel_reg(struct bma400_data *data,
> > +				const struct iio_chan_spec *chan,
> > +				int *val)
> > +{
> > +	int ret;
> > +	u16 lsb_reg;

the BMA400 seems to use 8-bit register addresses, u16 doesn't make sense 
here (either u8 or just int)

> > +	__le16 raw_accel = 0;
> 
> I don't think we need the assignment... Is there a compiler that
> can't figure that out?
> 
> > +
> > +	if (data->power_mode == POWER_MODE_SLEEP)
> > +		return -EBUSY;
> > +
> > +	switch (chan->channel2) {
> > +	case IIO_MOD_X:
> > +		lsb_reg = BMA400_X_AXIS_LSB_REG;
> > +		break;
> > +	case IIO_MOD_Y:
> > +		lsb_reg = BMA400_Y_AXIS_LSB_REG;
> > +		break;
> > +	case IIO_MOD_Z:
> > +		lsb_reg = BMA400_Z_AXIS_LSB_REG;
> > +		break;
> > +	default:
> > +		dev_err(data->dev, "invalid axis channel modifier");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* bulk read two registers, with the base being the LSB register */
> > +	ret = regmap_bulk_read(data->regmap, lsb_reg, &raw_accel, 2);

2 == sizeof(rawaccel)

> > +	if (!ret) {
> 
> Same point as below on error path out of line.
> 
> > +		*val = sign_extend32(le16_to_cpu(raw_accel), 11);
> > +		ret = IIO_VAL_INT;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int bma400_ready_for_cmd(struct bma400_data *data)
> > +{
> > +	unsigned int val;
> > +	int ret = regmap_read(data->regmap, BMA400_STATUS_REG, &val);
> > +
> > +	if (ret < 0 || !(val & 0x10))
> > +		return 0;
> > +
> > +	return 1;
> 
> Maybe... (up to you on this one as I'm not convinced this is better :)
> 
> 	if (ret < 0)
> 		return 0;
> 
> 	return (val & 0x10) ? 1 : 0;
> 
> Separates the error case from checking the parameter.

the magic 0x10 would benefit from a #define

> > +}
> > +
> > +static int bma400_softreset(struct bma400_data *data)
> > +{
> > +	int ret;
> > +
> > +	if (!bma400_ready_for_cmd(data))
> > +		return -EAGAIN;
> > +
> > +	ret = regmap_write(data->regmap, BMA400_CMD_REG,
> > +			   BMA400_SOFTRESET_CMD);
> > +	if (!ret) {
> As below, prefer the error path indented even if it costs a line or two of
> code.
> 	if (ret)
> 		return ret;
> 
> 	data->...
> > +		/* a softreset restores registers to their defaults */
> > +		data->power_mode = POWER_MODE_SLEEP;
> > +		data->sample_freq = NULL;
> > +		data->oversampling_ratio = -1;
> > +		data->scale = bma400_scale_table[0];
> > +	}
> > +	return ret;
> > +}
> > +
> > +static int bma400_get_acc_config0_reg(struct bma400_data *data)
> > +{
> 
> I'm unconvinced these wrappers add anything. Just do the regmap_read
> inline.
> 
> > +	int ret;
> > +	unsigned int val;
> > +
> > +	ret = regmap_read(data->regmap, BMA400_ACC_CONFIG0_REG,
> > +			  &val);
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "Failed read acc_config0");
> > +		return ret;
> > +	}
> > +
> > +	return val;
> > +}
> > +
> > +static int bma400_get_acc_config1_reg(struct bma400_data *data)
> > +{
> > +	int ret;
> > +	unsigned int val;
> > +
> > +	ret = regmap_read(data->regmap, BMA400_ACC_CONFIG1_REG,
> > +			  &val);
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "Failed read acc_config1");
> > +		return ret;
> > +	}
> > +
> > +	return val;
> > +}
> > +
> > +static int bma400_get_accel_output_data_rate(struct bma400_data *data)
> > +{
> > +	int acc_config1;
> > +	unsigned int odr;
> > +	int idx;
> > +
> > +	switch (data->power_mode) {
> > +	case POWER_MODE_LOW:
> > +		/*
> > +		 * Runs at a fixed rate in low-power mode. See section 4.3
> > +		 * in the datasheet.
> > +		 */
> > +		data->sample_freq = &bma400_sample_freqs[1];
> > +		return 0;
> > +	case POWER_MODE_NORMAL:
> > +		/*
> > +		 * In normal mode the ODR can be found in the ACC_CONFIG1
> > +		 * register.
> > +		 */
> > +		acc_config1 = bma400_get_acc_config1_reg(data);
> > +		if (acc_config1 < 0) {
> > +			data->sample_freq = NULL;
> > +			return acc_config1;
> > +		}
> > +
> > +		odr = (acc_config1 & 0x0f);
> > +		if (odr < 0x05 || odr > 0x0b) {
> > +			dev_err(data->dev, "invalid ODR=%x", odr);
> > +			data->sample_freq = NULL;
> > +			return -EINVAL;
> > +		}
> > +		idx = odr - 0x05;
> > +
> > +		data->sample_freq = &bma400_sample_freqs[idx];
> > +		return 0;
> > +	default:
> > +		data->sample_freq = NULL;
> > +		return 0;
> > +	}
> > +}
> > +
> > +static int bma400_get_accel_output_data_rate_idx(struct bma400_data *data,
> > +						 int hz, int uhz)
> > +{
> > +	int i;
> > +	const struct bma400_sample_freq *sample_freq;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(bma400_sample_freqs); ++i) {
> > +		sample_freq = &bma400_sample_freqs[i];
> > +		if (sample_freq->hz == hz &&
> > +		    sample_freq->micro_hz == uhz)
> > +			return i;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int bma400_set_accel_output_data_rate(struct bma400_data *data,
> > +					     int hz, int uhz)
> > +{
> > +	int acc_config1;
> > +	unsigned int odr;
> > +	int idx;
> > +	int ret;
> > +
> > +	idx = bma400_get_accel_output_data_rate_idx(data, hz, uhz);
> > +
> > +	if (idx < 0)
> > +		return idx;
> > +
> > +	acc_config1 = bma400_get_acc_config1_reg(data);
> > +
> > +	if (acc_config1 < 0)
> > +		return acc_config1;
> > +
> > +	/* preserve the range and normal mode osr */
> > +	odr = (0xf0 & acc_config1) | (idx + 0x5);
> > +
> > +	ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG, odr);
> > +	if (!ret)
> > +		data->sample_freq = &bma400_sample_freqs[idx];
> 
> I'd rather we kept error flow indented even if a bit longer. It means
> these fine error checks are handled the same as earlier ones and makes
> reviewing a little bit easier.
> 
> 	if (ret)
> 		return ret;
> 
> 	data->...
> 
> > +
> > +	return ret;
> > +}
> > +
> > +static int bma400_get_accel_oversampling_ratio(struct bma400_data *data)
> > +{
> > +	int acc_config;
> > +
> > +	/*
> > +	 * The oversampling ratio is stored in a different register
> > +	 * based on the power-mode. In normal mode the OSR is stored
> > +	 * in ACC_CONFIG1. In low-power mode it is stored in
> > +	 * ACC_CONFIG0.
> > +	 */
> > +	switch (data->power_mode) {
> > +	case POWER_MODE_LOW:
> > +		acc_config = bma400_get_acc_config0_reg(data);
> > +		if (acc_config < 0) {
> > +			data->oversampling_ratio = -1;
> > +			return acc_config;
> > +		}
> > +
> > +		data->oversampling_ratio = (acc_config & 0x60) >> 5;
> > +		return 0;
> > +	case POWER_MODE_NORMAL:
> > +		acc_config = bma400_get_acc_config1_reg(data);
> > +		if (acc_config < 0) {
> > +			data->oversampling_ratio = -1;
> > +			return acc_config;
> > +		}
> > +
> > +		data->oversampling_ratio = (acc_config & 0x30) >> 4;
> > +		return 0;
> > +	default:
> > +		data->oversampling_ratio = -1;
> > +		return 0;
> > +	}
> > +}
> > +
> > +static int bma400_set_accel_oversampling_ratio(struct bma400_data *data,
> > +					       int val)
> > +{
> > +	int ret;
> > +	int acc_config;
> > +
> > +	/* The oversampling ratio is a two bit field */
> > +	if (val & ~0x3)
> 
> Use a define for that mask. Then we don't need the comment.
> 
> > +		return -EINVAL;
> > +
> > +	/* The oversampling ratio is stored in a different register
> 
> Most of the kernel, including iio, use
> /*
>  * The...
>  * ..
>  */
> 
> > +	 * based on the power-mode.
> > +	 */
> > +	switch (data->power_mode) {
> > +	case POWER_MODE_LOW:
> > +		acc_config = bma400_get_acc_config0_reg(data);
> > +		if (acc_config < 0)
> > +			return acc_config;
> > +
> > +		ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
> > +				   (acc_config & 0x9f) | (val << 5));
> 
> Use defines for these masks.
> 
> > +		if (ret < 0)
> > +			dev_err(data->dev, "Failed to write out OSR");
> > +		else
> > +			data->oversampling_ratio = val;
> > +		break;
> > +	case POWER_MODE_NORMAL:
> > +		acc_config = bma400_get_acc_config1_reg(data);
> > +		if (acc_config < 0)
> > +			return acc_config;
> > +
> > +		ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG,
> > +				   (acc_config & 0xcf) | (val << 4));
> > +		if (ret < 0)
> > +			dev_err(data->dev, "Failed to write out OSR");
> > +		else
> > +			data->oversampling_ratio = val;
> Nicer (even if a little longer) to read as:
> 
> 		if (ret < 0) {
> 			dev_err(data->dev, "Failed to write out OSR");
> 			return ret;
> 		}
> 
> 		data->oversampling_ration = val;
> 
> 		return 0;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	return ret;
> 
> 
> > +}
> > +
> > +static int bma400_get_accel_scale(struct bma400_data *data)
> > +{
> > +	int idx;
> > +	int acc_config1 = bma400_get_acc_config1_reg(data);
> > +
> > +	if (acc_config1 < 0)
> > +		return acc_config1;
> > +
> > +	idx = (acc_config1 & 0xc0) >> 6;
> > +	if (idx < ARRAY_SIZE(bma400_scale_table)) {
> > +		data->scale = bma400_scale_table[idx];
> > +		return 0;
> 
> Preference for error path indented in cases where it doesn't
> make a substantial difference in code length.
> 
> 	if (idx >= ARRAY_SIZE(bma400_scale_table)
> 		return -EINVAL;
> 
> 	data->scale = bma400_scale_table[idx];
> 
> 	return 0;
> 
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> > +static int bma400_get_accel_scale_idx(struct bma400_data *data, int val)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(bma400_scale_table); ++i) {
> > +		if (bma400_scale_table[i] == val)
> > +			return i;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> > +static int bma400_set_accel_scale(struct bma400_data *data, unsigned int val)
> > +{
> > +	int ret;
> > +	int idx;
> > +	int acc_config1 = bma400_get_acc_config1_reg(data);
> > +
> > +	if (acc_config1 < 0)
> > +		return acc_config1;
> > +
> > +	idx = bma400_get_accel_scale_idx(data, val);
> > +
> > +	if (idx < 0)
> > +		return idx;
> > +
> > +	ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG,
> > +			   (acc_config1 & 0x3f) | (idx << 6));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	data->scale = val;
> > +	return 0;
> > +}
> > +
> > +static int bma400_get_power_mode(struct bma400_data *data)
> > +{
> > +	int ret;
> > +	unsigned int val;
> > +
> > +	ret = regmap_read(data->regmap, BMA400_STATUS_REG, &val);
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "Failed to read status register");
> > +		return ret;
> > +	}
> > +
> > +	data->power_mode = (val >> 1) & 0x03;
> 
> Blank line here and in similar cases helps readability (a tiny bit).
> 
> > +	return 0;
> > +}
> > +
> > +static int bma400_set_power_mode(struct bma400_data *data,
> > +				 enum bma400_power_mode mode)
> > +{
> > +	int ret;
> > +
> > +	ret = bma400_get_acc_config0_reg(data);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (data->power_mode == mode)
> > +		return 0;
> > +
> > +	if (mode == POWER_MODE_INVALID)
> > +		return -EINVAL;
> > +
> > +	/* Preserve the low-power oversample ratio etc */
> > +	ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
> > +			   mode | (ret & 0xfc));
> > +
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "Failed to write to power-mode");
> > +		return ret;
> > +	}
> > +
> > +	/* Update our cached power-mode */
> 
> Bit marginal on whether that comment adds anything not obvious from
> the code.  From a maintenance point of view, excess comments are
> just opportunities for rot. Hence we are generally only in favour
> of those that add significant value.
> 
> > +	data->power_mode = mode;
> > +
> > +	/*
> > +	 * Update our cached osr and odr based on the new
> > +	 * power-mode.
> > +	 */
> > +	bma400_get_accel_output_data_rate(data);
> > +	bma400_get_accel_oversampling_ratio(data);
> > +
> > +	return 0;
> > +}
> > +
> > +static int bma400_init(struct bma400_data *data)
> > +{
> > +	int ret;
> > +	unsigned int val;
> > +
> > +	/* Try to read chip_id register. It must return 0x90. */
> > +	ret = regmap_read(data->regmap, BMA400_CHIP_ID_REG, &val);
> > +
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "Failed to read chip id register: %x!", ret);
> > +		return ret;
> > +	} else if (val != BMA400_ID_REG_VAL) {
> > +		dev_err(data->dev, "CHIP ID MISMATCH: %x!", ret);
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret = bma400_get_power_mode(data);
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "Failed to get the initial power-mode!");
> > +		return ret;
> > +	}
> > +
> > +	if (data->power_mode != POWER_MODE_NORMAL) {
> > +		ret = bma400_set_power_mode(data, POWER_MODE_NORMAL);
> > +		if (ret < 0) {
> > +			dev_err(data->dev, "Failed to wake up the device!");
> > +			return ret;
> > +		}
> > +		/*
> > +		 * TODO: The datasheet waits 1500us here in the example, but
> > +		 * lists 2/ODR as the wakeup time.
> > +		 */
> > +		usleep_range(1500, 20000);
> > +	}
> > +
> > +	ret = bma400_get_accel_output_data_rate(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = bma400_get_accel_oversampling_ratio(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = bma400_get_accel_scale(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * Once the interrupt engine is supported we might use the
> > +	 * data_src_reg, but for now ensure this is set to the
> > +	 * variable ODR filter selectable by the sample frequency
> > +	 * channel.
> > +	 */
> > +	return regmap_write(data->regmap, BMA400_ACC_CONFIG2_REG, 0x00);
> > +}
> > +
> > +static ssize_t bma400_show_samp_freq_avail(struct device *dev,
> > +					   struct device_attribute *attr,
> > +					   char *buf)
> > +{
> > +	int i;
> > +	int len = 0;
> > +	const struct bma400_sample_freq *sample_freq;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(bma400_sample_freqs); ++i) {
> > +		sample_freq = &bma400_sample_freqs[i];
> > +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
> > +				 sample_freq->hz, sample_freq->micro_hz);
> > +	}
> > +
> > +	buf[len - 1] = '\n';
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t bma400_show_scale_avail(struct device *dev,
> > +				       struct device_attribute *attr,
> > +				       char *buf)
> As you are providing functions for it anyway, perhaps use the core
> functions to do this?
> See the docs for struct iio_info -> read_avail.
> 
> Not that many users yet as we added this for a few specific cases
> that needed to query these from in kernel users.
> 
> 
> > +{
> > +	int i;
> > +	int len = 0;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(bma400_scale_table); ++i)
> > +		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06d ",
> > +				 bma400_scale_table[i]);
> > +
> > +	buf[len - 1] = '\n';
> > +
> > +	return len;
> > +}
> > +
> > +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(bma400_show_samp_freq_avail);
> > +
> > +static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
> > +		       bma400_show_scale_avail, NULL, 0);
> > +
> > +static struct attribute *bma400_attributes[] = {
> > +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> > +	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group bma400_attrs_group = {
> > +	.attrs = bma400_attributes,
> > +};
> > +
> > +static int bma400_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan, int *val,
> > +			   int *val2, long mask)
> > +{
> > +	struct bma400_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		mutex_lock(&data->mutex);
> > +		ret = bma400_get_temp_reg(data, val, val2);
> > +		mutex_unlock(&data->mutex);
> > +		return ret;
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&data->mutex);
> > +		ret = bma400_get_accel_reg(data, chan, val);
> > +		mutex_unlock(&data->mutex);
> > +		return ret;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		switch (chan->type) {
> > +		case IIO_ACCEL:
> > +			if (!data->sample_freq)
> > +				return -EINVAL;
> > +
> > +			*val = data->sample_freq->hz;
> > +			if (!data->sample_freq->micro_hz)
> > +				return IIO_VAL_INT;
> > +
> > +			*val2 = data->sample_freq->micro_hz;
> > +			return IIO_VAL_INT_PLUS_MICRO;
> > +		case IIO_TEMP:
> > +			/*
> > +			 * Runs at a fixed sampling frequency. See Section 4.4
> > +			 * of the datasheet.
> > +			 */
> > +			*val = 6;
> > +			*val2 = 250000;
> > +			return IIO_VAL_INT_PLUS_MICRO;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = 0;
> > +		*val2 = data->scale;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +		/*
> > +		 * TODO: We could avoid this logic and returning -EINVAL here if
> > +		 * we set both the low-power and normal mode OSR registers when
> > +		 * we configure the device.
> > +		 */
> > +		if (data->oversampling_ratio < 0)
> > +			return -EINVAL;
> > +
> > +		*val = data->oversampling_ratio;
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int bma400_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int val, int val2,
> > +			    long mask)
> > +{
> > +	int ret;
> > +	struct bma400_data *data = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		/*
> > +		 * The sample frequency is readonly for the temperature
> > +		 * register and a fixed value in low-power mode.
> > +		 */
> > +		if (chan->type != IIO_ACCEL)
> > +			return -EINVAL;
> > +
> > +		mutex_lock(&data->mutex);
> > +		ret = bma400_set_accel_output_data_rate(data, val, val2);
> > +		mutex_unlock(&data->mutex);
> > +		return ret;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (val != 0)
> > +			return -EINVAL;
> > +
> > +		mutex_lock(&data->mutex);
> > +		ret = bma400_set_accel_scale(data, val2);
> > +		mutex_unlock(&data->mutex);
> > +		return ret;
> > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +		mutex_lock(&data->mutex);
> > +		ret = bma400_set_accel_oversampling_ratio(data, val);
> > +		mutex_unlock(&data->mutex);
> > +		return ret;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
> > +				    struct iio_chan_spec const *chan,
> > +				    long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_info bma400_info = {
> > +	.attrs             = &bma400_attrs_group,
> > +	.read_raw          = bma400_read_raw,
> > +	.write_raw         = bma400_write_raw,
> > +	.write_raw_get_fmt = bma400_write_raw_get_fmt,
> > +};
> > +
> > +int bma400_probe(struct device *dev,
> > +		 struct regmap *regmap,
> > +		 const char *name)
> > +{
> > +	int ret;
> > +	struct bma400_data *data;
> > +	struct iio_dev *indio_dev;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->regmap = regmap;
> > +	data->dev = dev;
> > +
> > +	ret = bma400_init(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = iio_read_mount_matrix(dev, "mount-matrix",
> > +				    &data->orientation);
> 
> Looks like the above will fit on one line..
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_init(&data->mutex);
> > +	indio_dev->dev.parent = dev;
> > +	indio_dev->name = name;
> > +	indio_dev->info = &bma400_info;
> > +	indio_dev->channels = bma400_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(bma400_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	dev_set_drvdata(dev, indio_dev);
> > +
> > +	ret = iio_device_register(indio_dev);
> > +	if (ret < 0) {
> > +		dev_err(dev, "unable to register iio device\n");
> > +		return ret;
> 
> Drop the return out of the if statement and no need for the return 0 below.

I'd also avoid the error message altogether

> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(bma400_probe);
> > +
> > +int bma400_remove(struct device *dev)
> > +{
> > +	int ret;
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct bma400_data *data = iio_priv(indio_dev);
> > +
> > +	mutex_lock(&data->mutex);
> > +	ret = bma400_softreset(data);
> > +	if (ret < 0) {
> > +		/*
> > +		 * If the softreset failed, try to put the device in
> > +		 * sleep mode, but still report the error.
> > +		 */
> > +		dev_err(data->dev, "Failed to reset the device");
> > +		bma400_set_power_mode(data, POWER_MODE_SLEEP);
> > +	}
> > +	mutex_unlock(&data->mutex);
> > +
> > +	iio_device_unregister(indio_dev);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(bma400_remove);
> > +
> > +MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
> > +MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
> > new file mode 100644
> > index 000000000000..227012a32e13
> > --- /dev/null
> > +++ b/drivers/iio/accel/bma400_i2c.c
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * bma400-i2c.c - I2C IIO driver for Bosch BMA400 triaxial acceleration sensor.
> > + *
> > + * Copyright 2019 Dan Robertson <dan@dlrobertson.com>
> > + *
> > + * I2C address is either 0x14 or 0x15 depending on SDO
> > + *
> 
> This blank line doesn't add anything (nitpick)
> 
> > + */
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/acpi.h>
> 
> Slight preference for alphabetical order.  Also why ACPI?
> 
> > +#include <linux/of.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "bma400.h"
> > +
> > +static int bma400_i2c_probe(struct i2c_client *client,
> > +			    const struct i2c_device_id *id)
> > +{
> > +	struct regmap *regmap;
> > +
> > +	regmap = devm_regmap_init_i2c(client,
> > +				      &bma400_regmap_config);
> > +
> > +	return bma400_probe(&client->dev, regmap, id->name);
> > +}
> > +
> > +static int bma400_i2c_remove(struct i2c_client *client)
> > +{
> > +	return bma400_remove(&client->dev);
> > +}
> > +
> > +static const struct i2c_device_id bma400_i2c_ids[] = {
> > +	{ "bma400", 0 },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, bma400_i2c_ids);
> > +
> 
> Good to have a of_device_id table as well from the start.
> There is a general (but slow) move to stop using the fallback
> to the i2c_device_id table.
> 
> > +static struct i2c_driver bma400_i2c_driver = {
> > +	.driver = {
> > +		.name = "bma400",
> > +	},
> > +	.probe    = bma400_i2c_probe,
> > +	.remove   = bma400_i2c_remove,
> > +	.id_table = bma400_i2c_ids,
> > +};
> > +
> > +module_i2c_driver(bma400_i2c_driver);
> > +
> > +MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
> > +MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor");
> > +MODULE_LICENSE("GPL");
> > 
> > 
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
