Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FC74BAC3B
	for <lists+linux-iio@lfdr.de>; Thu, 17 Feb 2022 23:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243098AbiBQWFY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Feb 2022 17:05:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbiBQWFX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Feb 2022 17:05:23 -0500
X-Greylist: delayed 408 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 14:05:05 PST
Received: from ns.pmeerw.net (ns.pmeerw.net [IPv6:2001:1b60:2:23:1033:103:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51A8403FC
        for <linux-iio@vger.kernel.org>; Thu, 17 Feb 2022 14:05:05 -0800 (PST)
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 22312E0613; Thu, 17 Feb 2022 22:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1645135094; bh=95C9aAJ35gmihKBCpXTUmWPkMkrla3ToaQ/SvI4nc+Y=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=fKgbCfYRukfM1kqS4BRf2pJUKmWKJ3Qj2zC+cxDyEWlWM8G0pK2RYLlnStaLuKCpJ
         Ch9oBbHj6uSEaODrTMwziyYLDE6R0ECuGQmeUIX7bNMYs5JBN+zCNec6bj17kwRyZA
         jVfQzfsKJ16vL1wB9FbwEcDkhQN9jEfl22gCA42s=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 1DD41E0373;
        Thu, 17 Feb 2022 22:58:14 +0100 (CET)
Date:   Thu, 17 Feb 2022 22:58:14 +0100 (CET)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Andrea Merello <andrea.merello@gmail.com>
cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v3 07/13] iio: imu: add Bosch Sensortec BNO055 core driver
In-Reply-To: <20220217162710.33615-8-andrea.merello@gmail.com>
Message-ID: <ba1b2d78-bf4a-ec6d-88b8-76bbf2ff5e3e@pmeerw.net>
References: <20220217162710.33615-1-andrea.merello@gmail.com> <20220217162710.33615-8-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 17 Feb 2022, Andrea Merello wrote:

nice work, minor comments below

> This patch adds a core driver for the BNO055 IMU from Bosch. This IMU
> can be connected via both serial and I2C busses; separate patches will
> add support for them.
> 
> The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> that provides raw data from the said internal sensors, and a couple of
> "fusion" modes (i.e. the IMU also do calculations in order to provide
> euler angles, quaternions, linear acceleration and gravity measurements).
> 
> In fusion modes the AMG data is still available (with some calibration
> refinements done by the IMU), but certain settings such as low pass
> filters cut-off frequency and sensors ranges are fixed, while in AMG mode
> they can be customized; this is why AMG mode can still be interesting.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>  drivers/iio/imu/Kconfig         |    1 +
>  drivers/iio/imu/Makefile        |    1 +
>  drivers/iio/imu/bno055/Kconfig  |    4 +
>  drivers/iio/imu/bno055/Makefile |    3 +
>  drivers/iio/imu/bno055/bno055.c | 1612 +++++++++++++++++++++++++++++++
>  drivers/iio/imu/bno055/bno055.h |   12 +
>  6 files changed, 1633 insertions(+)
>  create mode 100644 drivers/iio/imu/bno055/Kconfig
>  create mode 100644 drivers/iio/imu/bno055/Makefile
>  create mode 100644 drivers/iio/imu/bno055/bno055.c
>  create mode 100644 drivers/iio/imu/bno055/bno055.h
> 
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index 001ca2c3ff95..f1d7d4b5e222 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -52,6 +52,7 @@ config ADIS16480
>  	  ADIS16485, ADIS16488 inertial sensors.
>  
>  source "drivers/iio/imu/bmi160/Kconfig"
> +source "drivers/iio/imu/bno055/Kconfig"
>  
>  config FXOS8700
>  	tristate
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> index c82748096c77..6eb612034722 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -15,6 +15,7 @@ adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_buffer.o
>  obj-$(CONFIG_IIO_ADIS_LIB) += adis_lib.o
>  
>  obj-y += bmi160/
> +obj-y += bno055/
>  
>  obj-$(CONFIG_FXOS8700) += fxos8700_core.o
>  obj-$(CONFIG_FXOS8700_I2C) += fxos8700_i2c.o
> diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
> new file mode 100644
> index 000000000000..d0ab3221fba5
> --- /dev/null
> +++ b/drivers/iio/imu/bno055/Kconfig
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config BOSCH_BNO055_IIO
> +	tristate
> diff --git a/drivers/iio/imu/bno055/Makefile b/drivers/iio/imu/bno055/Makefile
> new file mode 100644
> index 000000000000..56cc4de60a7e
> --- /dev/null
> +++ b/drivers/iio/imu/bno055/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_BOSCH_BNO055_IIO) += bno055.o
> diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
> new file mode 100644
> index 000000000000..881d08277356
> --- /dev/null
> +++ b/drivers/iio/imu/bno055/bno055.c
> @@ -0,0 +1,1612 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IIO driver for Bosch BNO055 IMU
> + *
> + * Copyright (C) 2021 Istituto Italiano di Tecnologia
> + * Electronic Design Laboratory
> + * Written by Andrea Merello <andrea.merello@iit.it>
> + *
> + * Portions of this driver are taken from the BNO055 driver patch
> + * from Vlad Dogaru which is Copyright (c) 2016, Intel Corporation.
> + *
> + * This driver is also based on BMI160 driver, which is:
> + *	Copyright (c) 2016, Intel Corporation.
> + *	Copyright (c) 2019, Martin Kelly.
> + */
> +
> +#include <linux/bitmap.h>
> +#include <linux/clk.h>
> +#include <linux/bitfield.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/firmware.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/util_macros.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include "bno055.h"
> +
> +#define BNO055_FW_NAME "bno055-caldata"
> +#define BNO055_FW_EXT ".dat"
> +#define BNO055_FW_UID_NAME BNO055_FW_NAME "-%*phN" BNO055_FW_EXT
> +#define BNO055_FW_GENERIC_NAME (BNO055_FW_NAME BNO055_FW_EXT)
> +
> +/* common registers */
> +#define BNO055_PAGESEL_REG		0x7
> +
> +/* page 0 registers */
> +#define BNO055_CHIP_ID_REG		0x0
> +#define BNO055_CHIP_ID_MAGIC 0xA0
> +#define BNO055_SW_REV_LSB_REG		0x4
> +#define BNO055_SW_REV_MSB_REG		0x5
> +#define BNO055_ACC_DATA_X_LSB_REG	0x8
> +#define BNO055_ACC_DATA_Y_LSB_REG	0xA
> +#define BNO055_ACC_DATA_Z_LSB_REG	0xC
> +#define BNO055_MAG_DATA_X_LSB_REG	0xE
> +#define BNO055_MAG_DATA_Y_LSB_REG	0x10
> +#define BNO055_MAG_DATA_Z_LSB_REG	0x12
> +#define BNO055_GYR_DATA_X_LSB_REG	0x14
> +#define BNO055_GYR_DATA_Y_LSB_REG	0x16
> +#define BNO055_GYR_DATA_Z_LSB_REG	0x18
> +#define BNO055_EUL_DATA_X_LSB_REG	0x1A
> +#define BNO055_EUL_DATA_Y_LSB_REG	0x1C
> +#define BNO055_EUL_DATA_Z_LSB_REG	0x1E
> +#define BNO055_QUAT_DATA_W_LSB_REG	0x20
> +#define BNO055_LIA_DATA_X_LSB_REG	0x28
> +#define BNO055_LIA_DATA_Y_LSB_REG	0x2A
> +#define BNO055_LIA_DATA_Z_LSB_REG	0x2C
> +#define BNO055_GRAVITY_DATA_X_LSB_REG	0x2E
> +#define BNO055_GRAVITY_DATA_Y_LSB_REG	0x30
> +#define BNO055_GRAVITY_DATA_Z_LSB_REG	0x32
> +#define BNO055_SCAN_CH_COUNT ((BNO055_GRAVITY_DATA_Z_LSB_REG - BNO055_ACC_DATA_X_LSB_REG) / 2)
> +#define BNO055_TEMP_REG			0x34
> +#define BNO055_CALIB_STAT_REG		0x35
> +#define BNO055_CALIB_STAT_MASK GENMASK(1, 0)
> +#define BNO055_CALIB_STAT_MAGN_SHIFT 0
> +#define BNO055_CALIB_STAT_ACCEL_SHIFT 2
> +#define BNO055_CALIB_STAT_GYRO_SHIFT 4
> +#define BNO055_CALIB_STAT_SYS_SHIFT 6
> +#define BNO055_SYS_ERR_REG		0x3A
> +#define BNO055_POWER_MODE_REG		0x3E
> +#define BNO055_POWER_MODE_NORMAL 0
> +#define BNO055_SYS_TRIGGER_REG		0x3F
> +#define BNO055_SYS_TRIGGER_RST_SYS BIT(5)
> +#define BNO055_SYS_TRIGGER_CLK_SEL BIT(7)
> +#define BNO055_OPR_MODE_REG		0x3D
> +#define BNO055_OPR_MODE_CONFIG 0x0
> +#define BNO055_OPR_MODE_AMG 0x7
> +#define BNO055_OPR_MODE_FUSION_FMC_OFF 0xB
> +#define BNO055_OPR_MODE_FUSION 0xC
> +#define BNO055_UNIT_SEL_REG		0x3B
> +/* Android orientation mode means: pitch value decreases turning clockwise */
> +#define BNO055_UNIT_SEL_ANDROID BIT(7)
> +#define BNO055_UNIT_SEL_GYR_RPS BIT(1)
> +#define BNO055_CALDATA_START		0x55
> +#define BNO055_CALDATA_END		0x6A
> +#define BNO055_CALDATA_LEN 22
> +
> +/*
> + * The difference in address between the register that contains the
> + * value and the register that contains the offset.  This applies for
> + * accel, gyro and magn channels.
> + */
> +#define BNO055_REG_OFFSET_ADDR		0x4D
> +
> +/* page 1 registers */
> +#define PG1(x) ((x) | 0x80)

BNO055_ prefix missing

> +#define BNO055_ACC_CONFIG_REG		PG1(0x8)
> +#define BNO055_ACC_CONFIG_LPF_MASK GENMASK(4, 2)
> +#define BNO055_ACC_CONFIG_RANGE_MASK GENMASK(1, 0)
> +#define BNO055_MAG_CONFIG_REG		PG1(0x9)
> +#define BNO055_MAG_CONFIG_HIGHACCURACY 0x18
> +#define BNO055_MAG_CONFIG_ODR_MASK GENMASK(2, 0)
> +#define BNO055_GYR_CONFIG_REG		PG1(0xA)
> +#define BNO055_GYR_CONFIG_RANGE_MASK GENMASK(2, 0)
> +#define BNO055_GYR_CONFIG_LPF_MASK GENMASK(5, 3)
> +#define BNO055_GYR_AM_SET_REG		PG1(0x1F)
> +#define BNO055_UID_LOWER_REG		PG1(0x50)
> +#define BNO055_UID_HIGHER_REG		PG1(0x5F)
> +#define BNO055_UID_LEN 16
> +
> +struct bno055_sysfs_attr {
> +	int *vals;
> +	int len;
> +	int *fusion_vals;
> +	int *hw_xlate;
> +	int type;
> +};
> +
> +#define BNO055_ATTR_VALS(...)		\
> +	.vals = (int[]){ __VA_ARGS__},	\
> +	.len = ARRAY_SIZE(((int[]){__VA_ARGS__}))
> +
> +static struct bno055_sysfs_attr bno055_acc_lpf = {
> +	BNO055_ATTR_VALS(7, 810000, 15, 630000,
> +			 31, 250000, 62, 500000, 125, 0,
> +			 250, 0, 500, 0, 1000, 0),
> +	.fusion_vals = (int[]){62, 500000},
> +	.type = IIO_VAL_INT_PLUS_MICRO
> +};
> +
> +static struct bno055_sysfs_attr bno055_acc_range = {
> +		     /* G:   2,    4,    8,    16 */
> +	BNO055_ATTR_VALS(1962, 3924, 7848, 15696),
> +	.fusion_vals = (int[]){3924}, /* 4G */
> +	.type = IIO_VAL_INT
> +};
> +
> +/*
> + * Theoretically the IMU should return data in a given (i.e. fixed) unit
> + * regardless the range setting. This happens for the accelerometer, but not for
> + * the gyroscope; the gyroscope range setting affects the scale.
> + * This is probably due to this[0] bug.
> + * For this reason we map the internal range setting onto the standard IIO scale
> + * attribute for gyro.
> + * Since the bug[0] may be fixed in future, we check for the IMU FW version and
> + * eventually warn the user.
> + * Currently we just't don't care about "range" attributes for gyro.

typo: just't

> + *
> + * [0]  https://community.bosch-sensortec.com/t5/MEMS-sensors-forum/BNO055-Wrong-sensitivity-resolution-in-datasheet/td-p/10266
> + */
> +static struct bno055_sysfs_attr bno055_gyr_scale = {
> +	/*
> +	 * dps = hwval * (dps_range/2^15)
> +	 * rps = hwval * (rps_range/2^15)
> +	 *     = hwval * (dps_range/(2^15 * k))
> +	 * where k is rad-to-deg factor
> +	 */
> +	BNO055_ATTR_VALS(125, 1877467, 250, 1877467,
> +			 500, 1877467, 1000, 1877467,
> +			 2000, 1877467),
> +	.fusion_vals = (int[]){1, 900},
> +	.hw_xlate = (int[]){4, 3, 2, 1, 0},
> +	.type = IIO_VAL_FRACTIONAL
> +};
> +
> +static struct bno055_sysfs_attr bno055_gyr_lpf = {
> +	BNO055_ATTR_VALS(12, 23, 32, 47, 64, 116, 230, 523),
> +	.fusion_vals = (int[]){32},
> +	.hw_xlate = (int[]){5, 4, 7, 3, 6, 2, 1, 0},
> +	.type = IIO_VAL_INT
> +};
> +
> +static struct bno055_sysfs_attr bno055_mag_odr = {
> +	BNO055_ATTR_VALS(2, 6, 8, 10, 15, 20, 25, 30),
> +	.fusion_vals = (int[]){20},
> +	.type = IIO_VAL_INT
> +};
> +
> +struct bno055_priv {
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct clk *clk;
> +	int operation_mode;
> +	int xfer_burst_break_thr;
> +	struct mutex lock;
> +	u8 uid[BNO055_UID_LEN];
> +	struct gpio_desc *reset_gpio;
> +	bool sw_reset;
> +	struct {
> +		__le16 chans[BNO055_SCAN_CH_COUNT];
> +		s64 timestamp __aligned(8);
> +	} buf;
> +};
> +
> +static bool bno055_regmap_volatile(struct device *dev, unsigned int reg)
> +{
> +	/* data and status registers */
> +	if (reg >= BNO055_ACC_DATA_X_LSB_REG && reg <= BNO055_SYS_ERR_REG)
> +		return true;
> +
> +	/* when in fusion mode, config is updated by chip */
> +	if (reg == BNO055_MAG_CONFIG_REG ||
> +	    reg == BNO055_ACC_CONFIG_REG ||
> +	    reg == BNO055_GYR_CONFIG_REG)
> +		return true;
> +
> +	/* calibration data may be updated by the IMU */
> +	if (reg >= BNO055_CALDATA_START && reg <= BNO055_CALDATA_END)
> +		return true;

I'd suggest a newline here (similarly elsewhere)

> +	return false;
> +}
> +
> +static bool bno055_regmap_readable(struct device *dev, unsigned int reg)
> +{
> +	/* unnamed PG0 reserved areas */
> +	if ((reg < PG1(0) && reg > BNO055_CALDATA_END) ||
> +	    reg == 0x3C)
> +		return false;
> +
> +	/* unnamed PG1 reserved areas */
> +	if (reg > PG1(BNO055_UID_HIGHER_REG) ||
> +	    (reg < PG1(BNO055_UID_LOWER_REG) && reg > PG1(BNO055_GYR_AM_SET_REG)) ||
> +	    reg == PG1(0xE) ||
> +	    (reg < PG1(BNO055_PAGESEL_REG) && reg >= PG1(0x0)))
> +		return false;
> +	return true;
> +}
> +
> +static bool bno055_regmap_writeable(struct device *dev, unsigned int reg)
> +{
> +	/*
> +	 * Unreadable registers are indeed reserved; there are no WO regs
> +	 * (except for a single bit in SYS_TRIGGER register)
> +	 */
> +	if (!bno055_regmap_readable(dev, reg))
> +		return false;
> +
> +	/* data and status registers */
> +	if (reg >= BNO055_ACC_DATA_X_LSB_REG && reg <= BNO055_SYS_ERR_REG)
> +		return false;
> +
> +	/* IDs areas */

probably 'ID area'?

> +	if (reg < BNO055_PAGESEL_REG ||
> +	    (reg <= BNO055_UID_HIGHER_REG && reg >= BNO055_UID_LOWER_REG))
> +		return false;
> +
> +	return true;
> +}
> +
> +static const struct regmap_range_cfg bno055_regmap_ranges[] = {
> +	{
> +		.range_min = 0,
> +		.range_max = 0x7f * 2,
> +		.selector_reg = BNO055_PAGESEL_REG,
> +		.selector_mask = GENMASK(7, 0),
> +		.selector_shift = 0,
> +		.window_start = 0,
> +		.window_len = 0x80
> +	},
> +};
> +
> +const struct regmap_config bno055_regmap_config = {
> +	.name = "bno055",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.ranges = bno055_regmap_ranges,
> +	.num_ranges = 1,
> +	.volatile_reg = bno055_regmap_volatile,
> +	.max_register = 0x80 * 2,
> +	.writeable_reg = bno055_regmap_writeable,
> +	.readable_reg = bno055_regmap_readable,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +EXPORT_SYMBOL_GPL(bno055_regmap_config);
> +
> +/* must be called in configuration mode */
> +int bno055_calibration_load(struct bno055_priv *priv, const u8 *data, int len)
> +{
> +	if (len != BNO055_CALDATA_LEN) {
> +		dev_dbg(priv->dev, "Invalid calibration file size %zu (expected %d)",

why %zu? len is int

> +			len, BNO055_CALDATA_LEN);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(priv->dev, "loading cal data: %*ph", BNO055_CALDATA_LEN, data);
> +	return regmap_bulk_write(priv->regmap, BNO055_CALDATA_START,
> +				 data, BNO055_CALDATA_LEN);
> +}
> +
> +static int bno055_operation_mode_do_set(struct bno055_priv *priv,
> +					int operation_mode)
> +{
> +	int ret;
> +
> +	ret = regmap_write(priv->regmap, BNO055_OPR_MODE_REG,
> +			   operation_mode);
> +	if (ret)
> +		return ret;
> +
> +	msleep(20);
> +
> +	return 0;
> +}
> +
> +static int bno055_system_reset(struct bno055_priv *priv)
> +{
> +	int ret;
> +
> +	if (priv->reset_gpio) {
> +		gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +		usleep_range(5000, 10000);
> +		gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +	} else {
> +		if (!priv->sw_reset)
> +			return 0;
> +
> +		ret = regmap_write(priv->regmap, BNO055_SYS_TRIGGER_REG,
> +				   BNO055_SYS_TRIGGER_RST_SYS);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	regcache_drop_region(priv->regmap, 0x0, 0xff);
> +	usleep_range(650000, 700000);
> +
> +	return 0;
> +}
> +
> +static int bno055_init(struct bno055_priv *priv, const u8 *caldata, int len)
> +{
> +	int ret;
> +
> +	ret = bno055_operation_mode_do_set(priv, BNO055_OPR_MODE_CONFIG);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, BNO055_POWER_MODE_REG,
> +			   BNO055_POWER_MODE_NORMAL);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, BNO055_SYS_TRIGGER_REG,
> +			   priv->clk ? BNO055_SYS_TRIGGER_CLK_SEL : 0);
> +	if (ret)
> +		return ret;
> +
> +	/* use standard SI units */
> +	ret = regmap_write(priv->regmap, BNO055_UNIT_SEL_REG,
> +			   BNO055_UNIT_SEL_ANDROID | BNO055_UNIT_SEL_GYR_RPS);
> +	if (ret)
> +		return ret;
> +
> +	if (caldata) {
> +		ret = bno055_calibration_load(priv, caldata, len);
> +		if (ret)
> +			dev_warn(priv->dev, "failed to load calibration data with error %d",
> +				 ret);
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t bno055_operation_mode_set(struct bno055_priv *priv,
> +					 int operation_mode)
> +{
> +	u8 caldata[BNO055_CALDATA_LEN];
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +
> +	ret = bno055_operation_mode_do_set(priv, BNO055_OPR_MODE_CONFIG);
> +	if (ret)
> +		goto exit;
> +
> +	if (operation_mode == BNO055_OPR_MODE_FUSION ||
> +	    operation_mode == BNO055_OPR_MODE_FUSION_FMC_OFF) {
> +		/* for entering fusiod mode, reset the chip to clear the algo state */

typo: fusiod

> +		ret = regmap_bulk_read(priv->regmap, BNO055_CALDATA_START, caldata,
> +				       BNO055_CALDATA_LEN);
> +		if (ret)
> +			goto exit;
> +
> +		ret = bno055_system_reset(priv);
> +		if (ret)
> +			return ret;

goto exit; 
here as well?

> +
> +		ret = bno055_init(priv, caldata, BNO055_CALDATA_LEN);
> +		if (ret)
> +			goto exit;
> +	}
> +
> +	ret = bno055_operation_mode_do_set(priv, operation_mode);
> +	if (ret)
> +		goto exit;
> +
> +	priv->operation_mode = operation_mode;

suggest a newline

> +exit:
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}
> +
> +static void bno055_uninit(void *arg)
> +{
> +	struct bno055_priv *priv = arg;
> +
> +	/* stop the IMU */
> +	bno055_operation_mode_do_set(priv, BNO055_OPR_MODE_CONFIG);
> +}
> +
> +#define BNO055_CHANNEL(_type, _axis, _index, _address, _sep, _sh, _avail) {	\
> +	.address = _address,							\
> +	.type = _type,								\
> +	.modified = 1,								\
> +	.channel2 = IIO_MOD_##_axis,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | (_sep),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | (_sh),		\
> +	.info_mask_shared_by_type_available = _avail,				\
> +	.scan_index = _index,							\
> +	.scan_type = {								\
> +		.sign = 's',							\
> +		.realbits = 16,							\
> +		.storagebits = 16,						\
> +		.endianness = IIO_LE,						\
> +		.repeat = IIO_MOD_##_axis == IIO_MOD_QUATERNION ? 4 : 0		\
> +	},									\
> +}
> +
> +/* scan indexes follow DATA register order */
> +enum bmi160_scan_axis {
> +	BNO055_SCAN_ACCEL_X,
> +	BNO055_SCAN_ACCEL_Y,
> +	BNO055_SCAN_ACCEL_Z,
> +	BNO055_SCAN_MAGN_X,
> +	BNO055_SCAN_MAGN_Y,
> +	BNO055_SCAN_MAGN_Z,
> +	BNO055_SCAN_GYRO_X,
> +	BNO055_SCAN_GYRO_Y,
> +	BNO055_SCAN_GYRO_Z,
> +	BNO055_SCAN_YAW,
> +	BNO055_SCAN_ROLL,
> +	BNO055_SCAN_PITCH,
> +	BNO055_SCAN_QUATERNION,
> +	BNO055_SCAN_LIA_X,
> +	BNO055_SCAN_LIA_Y,
> +	BNO055_SCAN_LIA_Z,
> +	BNO055_SCAN_GRAVITY_X,
> +	BNO055_SCAN_GRAVITY_Y,
> +	BNO055_SCAN_GRAVITY_Z,
> +	BNO055_SCAN_TIMESTAMP,
> +};
> +
> +static const struct iio_chan_spec bno055_channels[] = {
> +	/* accelerometer */
> +	BNO055_CHANNEL(IIO_ACCEL, X, BNO055_SCAN_ACCEL_X,
> +		       BNO055_ACC_DATA_X_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> +		       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> +		       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)),
> +	BNO055_CHANNEL(IIO_ACCEL, Y, BNO055_SCAN_ACCEL_Y,
> +		       BNO055_ACC_DATA_Y_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> +		       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> +		       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)),
> +	BNO055_CHANNEL(IIO_ACCEL, Z, BNO055_SCAN_ACCEL_Z,
> +		       BNO055_ACC_DATA_Z_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> +		       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> +		       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)),
> +	/* gyroscope */
> +	BNO055_CHANNEL(IIO_ANGL_VEL, X, BNO055_SCAN_GYRO_X,
> +		       BNO055_GYR_DATA_X_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> +		       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> +		       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
> +		       BIT(IIO_CHAN_INFO_SCALE)),
> +	BNO055_CHANNEL(IIO_ANGL_VEL, Y, BNO055_SCAN_GYRO_Y,
> +		       BNO055_GYR_DATA_Y_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> +		       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> +		       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
> +		       BIT(IIO_CHAN_INFO_SCALE)),
> +	BNO055_CHANNEL(IIO_ANGL_VEL, Z, BNO055_SCAN_GYRO_Z,
> +		       BNO055_GYR_DATA_Z_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> +		       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> +		       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
> +		       BIT(IIO_CHAN_INFO_SCALE)),
> +	/* magnetometer */
> +	BNO055_CHANNEL(IIO_MAGN, X, BNO055_SCAN_MAGN_X,
> +		       BNO055_MAG_DATA_X_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> +		       BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ)),
> +	BNO055_CHANNEL(IIO_MAGN, Y, BNO055_SCAN_MAGN_Y,
> +		       BNO055_MAG_DATA_Y_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> +		       BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ)),
> +	BNO055_CHANNEL(IIO_MAGN, Z, BNO055_SCAN_MAGN_Z,
> +		       BNO055_MAG_DATA_Z_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> +		       BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ)),
> +	/* euler angle */
> +	BNO055_CHANNEL(IIO_ROT, YAW, BNO055_SCAN_YAW,
> +		       BNO055_EUL_DATA_X_LSB_REG, 0, 0, 0),
> +	BNO055_CHANNEL(IIO_ROT, ROLL, BNO055_SCAN_ROLL,
> +		       BNO055_EUL_DATA_Y_LSB_REG, 0, 0, 0),
> +	BNO055_CHANNEL(IIO_ROT, PITCH, BNO055_SCAN_PITCH,
> +		       BNO055_EUL_DATA_Z_LSB_REG, 0, 0, 0),
> +	/* quaternion */
> +	BNO055_CHANNEL(IIO_ROT, QUATERNION, BNO055_SCAN_QUATERNION,
> +		       BNO055_QUAT_DATA_W_LSB_REG, 0, 0, 0),
> +
> +	/* linear acceleration */
> +	BNO055_CHANNEL(IIO_ACCEL, LINEAR_X, BNO055_SCAN_LIA_X,
> +		       BNO055_LIA_DATA_X_LSB_REG, 0, 0, 0),
> +	BNO055_CHANNEL(IIO_ACCEL, LINEAR_Y, BNO055_SCAN_LIA_Y,
> +		       BNO055_LIA_DATA_Y_LSB_REG, 0, 0, 0),
> +	BNO055_CHANNEL(IIO_ACCEL, LINEAR_Z, BNO055_SCAN_LIA_Z,
> +		       BNO055_LIA_DATA_Z_LSB_REG, 0, 0, 0),
> +
> +	/* gravity vector */
> +	BNO055_CHANNEL(IIO_GRAVITY, X, BNO055_SCAN_GRAVITY_X,
> +		       BNO055_GRAVITY_DATA_X_LSB_REG, 0, 0, 0),
> +	BNO055_CHANNEL(IIO_GRAVITY, Y, BNO055_SCAN_GRAVITY_Y,
> +		       BNO055_GRAVITY_DATA_Y_LSB_REG, 0, 0, 0),
> +	BNO055_CHANNEL(IIO_GRAVITY, Z, BNO055_SCAN_GRAVITY_Z,
> +		       BNO055_GRAVITY_DATA_Z_LSB_REG, 0, 0, 0),
> +
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.scan_index = -1
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(BNO055_SCAN_TIMESTAMP),
> +};
> +
> +static int bno055_get_regmask(struct bno055_priv *priv, int *val, int *val2,
> +			      int reg, int mask, struct bno055_sysfs_attr *attr)
> +{
> +	const int shift = __ffs(mask);
> +	int hwval, idx;
> +	int ret;
> +	int i;
> +
> +	ret = regmap_read(priv->regmap, reg, &hwval);
> +	if (ret)
> +		return ret;
> +
> +	idx = (hwval & mask) >> shift;
> +	if (attr->hw_xlate)
> +		for (i = 0; i < attr->len; i++)
> +			if (attr->hw_xlate[i] == idx) {
> +				idx = i;
> +				break;
> +			}
> +	if (attr->type == IIO_VAL_INT) {
> +		*val = attr->vals[idx];
> +	} else { /* IIO_VAL_INT_PLUS_MICRO or IIO_VAL_FRACTIONAL */
> +		*val = attr->vals[idx * 2];
> +		*val2 = attr->vals[idx * 2 + 1];
> +	}
> +
> +	return attr->type;
> +}
> +
> +static int bno055_set_regmask(struct bno055_priv *priv, int val, int val2,
> +			      int reg, int mask, struct bno055_sysfs_attr *attr)
> +{
> +	const int shift = __ffs(mask);
> +	int best_delta;
> +	int req_val;
> +	int tbl_val;
> +	bool first;
> +	int delta;
> +	int hwval;
> +	int ret;
> +	int len;
> +	int i;
> +
> +	/*
> +	 * The closest value the HW supports is only one in fusion mode,
> +	 * and it is autoselected, so don't do anything, just return OK,
> +	 * as the closest possible value has been (virtually) selected
> +	 */
> +	if (priv->operation_mode != BNO055_OPR_MODE_AMG)
> +		return 0;
> +
> +	len = attr->len;
> +
> +	/*
> +	 * We always get a request in INT_PLUS_MICRO, but we
> +	 * take care of the micro part only when we really have
> +	 * non-integer tables. This prevents 32-bit overflow with
> +	 * larger integers contained in integer tables.
> +	 */
> +	req_val = val;
> +	if (attr->type != IIO_VAL_INT) {
> +		if (val > 2147)
> +			val = 2147;
> +		len /= 2;
> +		req_val = val * 1000000 + val2;
> +	}
> +
> +	first = true;
> +	for (i = 0; i < len; i++) {
> +		switch (attr->type) {
> +		case IIO_VAL_INT:
> +			tbl_val = attr->vals[i];
> +			break;
> +		case IIO_VAL_INT_PLUS_MICRO:
> +			WARN_ON(attr->vals[i * 2] > 2147);
> +			tbl_val = attr->vals[i * 2] * 1000000 +
> +				attr->vals[i * 2 + 1];
> +			break;
> +		case IIO_VAL_FRACTIONAL:
> +			WARN_ON(attr->vals[i * 2] > 4294);
> +			tbl_val = attr->vals[i * 2] * 1000000 /
> +				attr->vals[i * 2 + 1];
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		delta = abs(tbl_val - req_val);
> +		if (first || delta < best_delta) {
> +			best_delta = delta;
> +			hwval = i;
> +			first = false;
> +		}
> +	}
> +
> +	if (attr->hw_xlate)
> +		hwval = attr->hw_xlate[hwval];
> +
> +	ret = bno055_operation_mode_do_set(priv, BNO055_OPR_MODE_CONFIG);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, reg, mask, hwval << shift);
> +	if (ret)
> +		return ret;
> +
> +	return bno055_operation_mode_do_set(priv, BNO055_OPR_MODE_AMG);
> +}
> +
> +static int bno055_read_simple_chan(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   int *val, int *val2, long mask)
> +{
> +	struct bno055_priv *priv = iio_priv(indio_dev);
> +	__le16 raw_val;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_bulk_read(priv->regmap, chan->address,
> +				       &raw_val, sizeof(raw_val));
> +		if (ret < 0)
> +			return ret;
> +		*val = (s16)le16_to_cpu(raw_val);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (priv->operation_mode != BNO055_OPR_MODE_AMG) {
> +			*val = 0;
> +		} else {
> +			ret = regmap_bulk_read(priv->regmap,
> +					       chan->address +
> +					       BNO055_REG_OFFSET_ADDR,
> +					       &raw_val, sizeof(raw_val));
> +			if (ret < 0)
> +				return ret;
> +			/*
> +			 * IMU reports sensor offests; IIO wants correction
> +			 * offset, thus we need the 'minus' here.
> +			 */
> +			*val = -(s16)le16_to_cpu(raw_val);
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1;
> +		switch (chan->type) {
> +		case IIO_GRAVITY:
> +			/* Table 3-35: 1 m/s^2 = 100 LSB */
> +		case IIO_ACCEL:
> +			/* Table 3-17: 1 m/s^2 = 100 LSB */
> +			*val2 = 100;
> +			break;
> +		case IIO_MAGN:
> +			/*
> +			 * Table 3-19: 1 uT = 16 LSB.  But we need
> +			 * Gauss: 1G = 0.1 uT.
> +			 */
> +			*val2 = 160;
> +			break;
> +		case IIO_ANGL_VEL:
> +			/*
> +			 * Table 3-22: 1 Rps = 900 LSB
> +			 * .. but this is not exactly true. See comment at the
> +			 * beginning of this file.
> +			 */
> +			if (priv->operation_mode != BNO055_OPR_MODE_AMG) {
> +				*val = bno055_gyr_scale.fusion_vals[0];
> +				*val2 = bno055_gyr_scale.fusion_vals[1];
> +				return IIO_VAL_FRACTIONAL;
> +			}
> +
> +			return bno055_get_regmask(priv, val, val2,
> +						  BNO055_GYR_CONFIG_REG,
> +						  BNO055_GYR_CONFIG_RANGE_MASK,
> +						  &bno055_gyr_scale);
> +			break;
> +		case IIO_ROT:
> +			/* Table 3-28: 1 degree = 16 LSB */
> +			*val2 = 16;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return IIO_VAL_FRACTIONAL;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (chan->type != IIO_MAGN)
> +			return -EINVAL;
> +		else
> +			return bno055_get_regmask(priv, val, val2,
> +						  BNO055_MAG_CONFIG_REG,
> +						  BNO055_MAG_CONFIG_ODR_MASK,
> +						  &bno055_mag_odr);
> +
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			return bno055_get_regmask(priv, val, val2,
> +						  BNO055_GYR_CONFIG_REG,
> +						  BNO055_GYR_CONFIG_LPF_MASK,
> +						  &bno055_gyr_lpf);
> +		case IIO_ACCEL:
> +			return bno055_get_regmask(priv, val, val2,
> +						  BNO055_ACC_CONFIG_REG,
> +						  BNO055_ACC_CONFIG_LPF_MASK,
> +						  &bno055_acc_lpf);
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +int bno055_sysfs_attr_avail(struct bno055_priv *priv, struct bno055_sysfs_attr *attr,
> +			    const int **vals, int *length)
> +{
> +	if (priv->operation_mode != BNO055_OPR_MODE_AMG) {
> +		/* locked when fusion enabled */
> +		*vals = attr->fusion_vals;
> +		if (attr->type == IIO_VAL_INT)
> +			*length = 1;
> +		else
> +			*length = 2; /* IIO_VAL_INT_PLUS_MICRO or IIO_VAL_FRACTIONAL*/
> +	} else {
> +		*vals = attr->vals;
> +		*length = attr->len;
> +	}
> +
> +	return attr->type;
> +}
> +
> +static int bno055_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
> +{
> +	struct bno055_priv *priv = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			*type = bno055_sysfs_attr_avail(priv, &bno055_gyr_scale,
> +							vals, length);
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			*type = bno055_sysfs_attr_avail(priv, &bno055_gyr_lpf,
> +							vals, length);
> +			return IIO_AVAIL_LIST;
> +		case IIO_ACCEL:
> +			*type = bno055_sysfs_attr_avail(priv, &bno055_acc_lpf,
> +							vals, length);
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		switch (chan->type) {
> +		case IIO_MAGN:
> +			*type = bno055_sysfs_attr_avail(priv, &bno055_mag_odr,
> +							vals, length);
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bno055_read_temp_chan(struct iio_dev *indio_dev, int *val)
> +{
> +	struct bno055_priv *priv = iio_priv(indio_dev);
> +	unsigned int raw_val;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, BNO055_TEMP_REG, &raw_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Tables 3-36 and 3-37: one byte of priv, signed, 1 LSB = 1C.
> +	 * ABI wants milliC.
> +	 */
> +	*val = raw_val * 1000;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int bno055_read_quaternion(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int size, int *vals, int *val_len,
> +				  long mask)
> +{
> +	struct bno055_priv *priv = iio_priv(indio_dev);
> +	__le16 raw_vals[4];
> +	int i, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (size < 4)
> +			return -EINVAL;
> +		ret = regmap_bulk_read(priv->regmap,
> +				       BNO055_QUAT_DATA_W_LSB_REG,
> +				       raw_vals, sizeof(raw_vals));
> +		if (ret < 0)
> +			return ret;
> +		for (i = 0; i < 4; i++)
> +			vals[i] = (s16)le16_to_cpu(raw_vals[i]);
> +		*val_len = 4;
> +		return IIO_VAL_INT_MULTIPLE;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Table 3-31: 1 quaternion = 2^14 LSB */
> +		if (size < 2)
> +			return -EINVAL;
> +		vals[0] = 1;
> +		vals[1] = 1 << 14;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int _bno055_read_raw_multi(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int size, int *vals, int *val_len,
> +				  long mask)
> +{
> +	switch (chan->type) {
> +	case IIO_MAGN:
> +	case IIO_ACCEL:
> +	case IIO_ANGL_VEL:
> +	case IIO_GRAVITY:
> +		if (size < 2)
> +			return -EINVAL;
> +		*val_len = 2;
> +		return bno055_read_simple_chan(indio_dev, chan,
> +					       &vals[0], &vals[1],
> +					       mask);
> +	case IIO_TEMP:
> +		*val_len = 1;
> +		return bno055_read_temp_chan(indio_dev, &vals[0]);
> +	case IIO_ROT:
> +		/*
> +		 * Rotation is exposed as either a quaternion or three
> +		 * Euler angles.
> +		 */
> +		if (chan->channel2 == IIO_MOD_QUATERNION)
> +			return bno055_read_quaternion(indio_dev, chan,
> +						      size, vals,
> +						      val_len, mask);
> +		if (size < 2)
> +			return -EINVAL;
> +		*val_len = 2;
> +		return bno055_read_simple_chan(indio_dev, chan,
> +					       &vals[0], &vals[1],
> +					       mask);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bno055_read_raw_multi(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int size, int *vals, int *val_len,
> +				 long mask)
> +{
> +	struct bno055_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +	ret = _bno055_read_raw_multi(indio_dev, chan, size,
> +				     vals, val_len, mask);
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}
> +
> +static int _bno055_write_raw(struct iio_dev *iio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct bno055_priv *priv = iio_priv(iio_dev);
> +
> +	switch (chan->type) {
> +	case IIO_MAGN:
> +		switch (mask) {
> +		case IIO_CHAN_INFO_SAMP_FREQ:
> +			return bno055_set_regmask(priv, val, val2,
> +						  BNO055_MAG_CONFIG_REG,
> +						  BNO055_MAG_CONFIG_ODR_MASK,
> +						  &bno055_mag_odr);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_ACCEL:
> +		switch (mask) {
> +		case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +			return bno055_set_regmask(priv, val, val2,
> +						  BNO055_ACC_CONFIG_REG,
> +						  BNO055_ACC_CONFIG_LPF_MASK,
> +						  &bno055_acc_lpf);
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_ANGL_VEL:
> +		switch (mask) {
> +		case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +			return bno055_set_regmask(priv, val, val2,
> +						  BNO055_GYR_CONFIG_REG,
> +						  BNO055_GYR_CONFIG_LPF_MASK,
> +						  &bno055_gyr_lpf);
> +		case IIO_CHAN_INFO_SCALE:
> +			return bno055_set_regmask(priv, val, val2,
> +						  BNO055_GYR_CONFIG_REG,
> +						  BNO055_GYR_CONFIG_RANGE_MASK,
> +						  &bno055_gyr_scale);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bno055_write_raw(struct iio_dev *iio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct bno055_priv *priv = iio_priv(iio_dev);
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +	ret = _bno055_write_raw(iio_dev, chan, val, val2, mask);
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t in_accel_range_raw_available_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int len = 0;
> +	int i;
> +
> +	if (priv->operation_mode != BNO055_OPR_MODE_AMG)
> +		return sysfs_emit(buf, "%d\n", bno055_acc_range.fusion_vals[0]);
> +
> +	for (i = 0; i < bno055_acc_range.len; i++)
> +		len += sysfs_emit_at(buf, len, "%d%c", bno055_acc_range.vals[i],
> +				     (i == bno055_acc_range.len - 1) ? '\n' : ' ');
> +	return len;
> +}
> +
> +static ssize_t bno055_fusion_enable_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sysfs_emit(buf, "%d\n",
> +			  priv->operation_mode != BNO055_OPR_MODE_AMG);
> +}
> +
> +static ssize_t bno055_fusion_enable_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t len)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int ret = 0;
> +
> +	if (sysfs_streq(buf, "0")) {
> +		ret = bno055_operation_mode_set(priv, BNO055_OPR_MODE_AMG);
> +	} else {
> +		/*
> +		 * Coming from AMG means the FMC was off, just switch to fusion
> +		 * but don't change anything that doesn't belong to us (i.e let.

typo: no . at the end

> +		 * FMC stay off.
> +		 * Coming from any other fusion mode means we don't need to do
> +		 * anything.
> +		 */
> +		if (priv->operation_mode == BNO055_OPR_MODE_AMG)
> +			ret = bno055_operation_mode_set(priv, BNO055_OPR_MODE_FUSION_FMC_OFF);
> +	}
> +	if (ret)
> +		return ret;
> +	return len;
> +}
> +
> +static ssize_t bno055_fmc_enable_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sysfs_emit(buf, "%d\n",
> +			  priv->operation_mode == BNO055_OPR_MODE_FUSION);
> +}
> +
> +static ssize_t bno055_fmc_enable_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int ret;
> +
> +	if (sysfs_streq(buf, "0")) {
> +		if (priv->operation_mode == BNO055_OPR_MODE_FUSION) {
> +			ret = bno055_operation_mode_set(priv, BNO055_OPR_MODE_FUSION_FMC_OFF);
> +			if (ret)
> +				return ret;
> +		}
> +	} else {
> +		if (priv->operation_mode == BNO055_OPR_MODE_AMG)
> +			return -EINVAL;
> +
> +		if (priv->operation_mode != BNO055_OPR_MODE_FUSION) {
> +			ret = bno055_operation_mode_set(priv, BNO055_OPR_MODE_FUSION);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return len;
> +}
> +
> +static ssize_t bno055_in_accel_range_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int val;
> +	int ret;
> +
> +	ret = bno055_get_regmask(priv, &val, NULL,
> +				 BNO055_ACC_CONFIG_REG,
> +				 BNO055_ACC_CONFIG_RANGE_MASK,
> +				 &bno055_acc_range);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", val);
> +}
> +
> +static ssize_t bno055_in_accel_range_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t len)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	unsigned long val;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&priv->lock);
> +	ret = bno055_set_regmask(priv, val, 0,
> +				 BNO055_ACC_CONFIG_REG,
> +				 BNO055_ACC_CONFIG_RANGE_MASK,
> +				 &bno055_acc_range);
> +	mutex_unlock(&priv->lock);
> +
> +	return ret ?: len;
> +}
> +
> +static ssize_t bno055_get_calib_status(struct device *dev, char *buf, int which)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int calib;
> +	int ret;
> +	int val;
> +
> +	if (priv->operation_mode == BNO055_OPR_MODE_AMG ||
> +	    (priv->operation_mode == BNO055_OPR_MODE_FUSION_FMC_OFF &&
> +	     which == BNO055_CALIB_STAT_MAGN_SHIFT)) {
> +		calib = 0;
> +	} else {
> +		mutex_lock(&priv->lock);
> +		ret = regmap_read(priv->regmap, BNO055_CALIB_STAT_REG, &val);
> +		mutex_unlock(&priv->lock);
> +
> +		if (ret)
> +			return -EIO;
> +
> +		calib = ((val >> which) & BNO055_CALIB_STAT_MASK) + 1;
> +	}
> +
> +	return sysfs_emit(buf, "%d\n", calib);
> +}
> +
> +static ssize_t serial_number_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sysfs_emit(buf, "%*ph\n", BNO055_UID_LEN, priv->uid);
> +}
> +
> +static ssize_t calibration_data_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	u8 data[BNO055_CALDATA_LEN];
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +	ret = bno055_operation_mode_do_set(priv, BNO055_OPR_MODE_CONFIG);
> +	if (ret)
> +		goto unlock;
> +
> +	ret = regmap_bulk_read(priv->regmap, BNO055_CALDATA_START, data,
> +			       BNO055_CALDATA_LEN);
> +	if (ret)
> +		goto unlock;
> +
> +	ret = bno055_operation_mode_do_set(priv, priv->operation_mode);
> +	if (ret)
> +		goto unlock;
> +
> +	memcpy(buf, data, BNO055_CALDATA_LEN);
> +
> +	ret = BNO055_CALDATA_LEN;
> +unlock:
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}
> +
> +static ssize_t sys_calibration_auto_status_show(struct device *dev,
> +						struct device_attribute *a,
> +						char *buf)
> +{
> +	return bno055_get_calib_status(dev, buf, BNO055_CALIB_STAT_SYS_SHIFT);
> +}
> +
> +static ssize_t in_accel_calibration_auto_status_show(struct device *dev,
> +						     struct device_attribute *a,
> +						     char *buf)
> +{
> +	return bno055_get_calib_status(dev, buf, BNO055_CALIB_STAT_ACCEL_SHIFT);
> +}
> +
> +static ssize_t in_gyro_calibration_auto_status_show(struct device *dev,
> +						    struct device_attribute *a,
> +						    char *buf)
> +{
> +	return bno055_get_calib_status(dev, buf, BNO055_CALIB_STAT_GYRO_SHIFT);
> +}
> +
> +static ssize_t in_magn_calibration_auto_status_show(struct device *dev,
> +						    struct device_attribute *a,
> +						    char *buf)
> +{
> +	return bno055_get_calib_status(dev, buf, BNO055_CALIB_STAT_MAGN_SHIFT);
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +int bno055_debugfs_reg_access(struct iio_dev *iio_dev, unsigned int reg,
> +			      unsigned int writeval, unsigned int *readval)
> +{
> +	struct bno055_priv *priv = iio_priv(iio_dev);
> +
> +	if (readval)
> +		return regmap_read(priv->regmap, reg, readval);
> +	else
> +		return regmap_write(priv->regmap, reg, writeval);
> +}
> +
> +static ssize_t bno055_show_fw_version(struct file *file, char __user *userbuf,
> +				      size_t count, loff_t *ppos)
> +{
> +	struct bno055_priv *priv = file->private_data;
> +	int rev, ver;
> +	char *buf;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, BNO055_SW_REV_LSB_REG, &rev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(priv->regmap, BNO055_SW_REV_MSB_REG, &ver);
> +	if (ret)
> +		return ret;
> +
> +	buf = kasprintf(GFP_KERNEL, "ver: 0x%x, rev: 0x%x\n", ver, rev);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations bno055_fw_version_ops = {
> +	.open = simple_open,
> +	.read = bno055_show_fw_version,
> +	.llseek = default_llseek,
> +	.owner = THIS_MODULE,
> +};
> +
> +static void bno055_debugfs_init(struct iio_dev *iio_dev)
> +{
> +	struct bno055_priv *priv = iio_priv(iio_dev);
> +
> +	debugfs_create_file("firmware_version", 0400,
> +			    iio_get_debugfs_dentry(iio_dev), priv,
> +			    &bno055_fw_version_ops);
> +}
> +#else
> +static void bno055_debugfs_init(struct iio_dev *iio_dev)
> +{
> +}
> +
> +int bno055_debugfs_reg_access(struct iio_dev *iio_dev, unsigned int reg,
> +			      unsigned int writeval, unsigned int *readval)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static IIO_DEVICE_ATTR(fusion_enable, 0644,
> +		       bno055_fusion_enable_show,
> +		       bno055_fusion_enable_store, 0);
> +
> +static IIO_DEVICE_ATTR(in_magn_calibration_fast_enable, 0644,
> +		       bno055_fmc_enable_show,
> +		       bno055_fmc_enable_store, 0);
> +
> +static IIO_DEVICE_ATTR(in_accel_range_raw, 0644,
> +		       bno055_in_accel_range_show,
> +		       bno055_in_accel_range_store, 0);
> +
> +static IIO_DEVICE_ATTR_RO(in_accel_range_raw_available, 0);
> +
> +static IIO_DEVICE_ATTR_RO(sys_calibration_auto_status, 0);
> +static IIO_DEVICE_ATTR_RO(in_accel_calibration_auto_status, 0);
> +static IIO_DEVICE_ATTR_RO(in_gyro_calibration_auto_status, 0);
> +static IIO_DEVICE_ATTR_RO(in_magn_calibration_auto_status, 0);
> +static IIO_DEVICE_ATTR_RO(calibration_data, 0);
> +
> +static IIO_DEVICE_ATTR_RO(serial_number, 0);
> +
> +static struct attribute *bno055_attrs[] = {
> +	&iio_dev_attr_in_accel_range_raw_available.dev_attr.attr,
> +	&iio_dev_attr_in_accel_range_raw.dev_attr.attr,
> +	&iio_dev_attr_fusion_enable.dev_attr.attr,
> +	&iio_dev_attr_in_magn_calibration_fast_enable.dev_attr.attr,
> +	&iio_dev_attr_sys_calibration_auto_status.dev_attr.attr,
> +	&iio_dev_attr_in_accel_calibration_auto_status.dev_attr.attr,
> +	&iio_dev_attr_in_gyro_calibration_auto_status.dev_attr.attr,
> +	&iio_dev_attr_in_magn_calibration_auto_status.dev_attr.attr,
> +	&iio_dev_attr_calibration_data.dev_attr.attr,
> +	&iio_dev_attr_serial_number.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group bno055_attrs_group = {
> +	.attrs = bno055_attrs,
> +};
> +
> +static const struct iio_info bno055_info = {
> +	.read_raw_multi = bno055_read_raw_multi,
> +	.read_avail = bno055_read_avail,
> +	.write_raw = bno055_write_raw,
> +	.attrs = &bno055_attrs_group,
> +	.debugfs_reg_access = bno055_debugfs_reg_access,
> +};
> +
> +/*
> + * Reads len samples from the HW, stores them in buf starting from buf_idx,
> + * and applies mask to cull (skip) unneeded samples.
> + * Updates buf_idx incrementing with the number of stored samples.
> + * Samples from HW are transferred into buf, then in-place copy on buf is
> + * performed in order to cull samples that need to be skipped.
> + * This avoids copies of the first samples until we hit the 1st sample to skip,
> + * and also avoids having an extra bounce buffer.
> + * buf must be able to contain len elements in spite of how many samples we are
> + * going to cull.
> + */
> +static int bno055_scan_xfer(struct bno055_priv *priv,
> +			    int start_ch, int len, unsigned long mask,
> +			    __le16 *buf, int *buf_idx)
> +{
> +	const int base = BNO055_ACC_DATA_X_LSB_REG;
> +	bool quat_in_read = false;
> +	int buf_base = *buf_idx;
> +	__le16 *dst, *src;
> +	int offs_fixup = 0;
> +	int xfer_len = len;
> +	int ret;
> +	int i, n;
> +
> +	if (!mask)
> +		return 0;
> +
> +	/*
> +	 * All chans are made up 1 16-bit sample, except for quaternion that is
> +	 * made up 4 16-bit values.
> +	 * For us the quaternion CH is just like 4 regular CHs.
> +	 * If our read starts past the quaternion make sure to adjust the
> +	 * starting offset; if the quaternion is contained in our scan then make
> +	 * sure to adjust the read len.
> +	 */
> +	if (start_ch > BNO055_SCAN_QUATERNION) {
> +		start_ch += 3;
> +	} else if ((start_ch <= BNO055_SCAN_QUATERNION) &&
> +		 ((start_ch + len) > BNO055_SCAN_QUATERNION)) {
> +		quat_in_read = true;
> +		xfer_len += 3;
> +	}
> +
> +	ret = regmap_bulk_read(priv->regmap,
> +			       base + start_ch * sizeof(__le16),
> +			       buf + buf_base,
> +			       xfer_len * sizeof(__le16));
> +	if (ret)
> +		return ret;
> +
> +	for_each_set_bit(i, &mask, len) {
> +		if (quat_in_read && ((start_ch + i) > BNO055_SCAN_QUATERNION))
> +			offs_fixup = 3;
> +
> +		dst = buf + *buf_idx;
> +		src = buf + buf_base + offs_fixup + i;
> +
> +		n = (start_ch + i == BNO055_SCAN_QUATERNION) ? 4 : 1;
> +
> +		if (dst != src)
> +			memcpy(dst, src, n * sizeof(__le16));
> +
> +		*buf_idx += n;
> +	}
> +	return 0;
> +}
> +
> +static irqreturn_t bno055_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio_dev = pf->indio_dev;
> +	struct bno055_priv *priv = iio_priv(iio_dev);
> +	int xfer_start, start, end, prev_end;
> +	unsigned long mask;
> +	int quat_extra_len;
> +	bool first = true;
> +	int buf_idx = 0;
> +	bool thr_hit;
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +
> +	/*
> +	 * Walk the bitmap and eventually perform several transfers.
> +	 * Bitmap ones-fileds that are separated by gaps <= xfer_burst_break_thr
> +	 * will be included in same transfer.
> +	 * Every time the bitmap contains a gap wider than xfer_burst_break_thr
> +	 * then we split the transfer, skipping the gap.
> +	 */
> +	for_each_set_bitrange(start, end, iio_dev->active_scan_mask,
> +			      iio_dev->masklength) {
> +		/*
> +		 * First transfer will start from the beginnig of the first
> +		 * ones-field in the bitmap
> +		 */
> +		if (first)
> +			xfer_start = start;
> +
> +		/*
> +		 * We found the next ones-field; check whether to include it in
> +		 * the current transfer or not (i.e. let's perform the current
> +		 * transfer and prepare for another one).
> +		 */
> +		if (!first) {
> +			/*
> +			 * In case the zeros-gap contains the quaternion bit,
> +			 * then its length is actually 4 words instead of 1
> +			 * (i.e. +3 wrt other channels).
> +			 */
> +			quat_extra_len = ((start > BNO055_SCAN_QUATERNION) &&
> +					  (prev_end <= BNO055_SCAN_QUATERNION)) ? 3 : 0;
> +
> +			/* If the gap is wider than xfer_burst_break_thr then.. */
> +			thr_hit = (start - prev_end + quat_extra_len) >
> +				priv->xfer_burst_break_thr;
> +
> +			/*
> +			 * .. transfer all the data up to the gap. Then set the
> +			 * next transfer start index at right after the gap
> +			 * (i.e. at the start of this ones-field).
> +			 */
> +			if (thr_hit) {
> +				mask = *iio_dev->active_scan_mask >> xfer_start;
> +				ret = bno055_scan_xfer(priv, xfer_start,
> +						       prev_end - xfer_start,
> +						       mask, priv->buf.chans, &buf_idx);
> +				if (ret)
> +					goto done;
> +				xfer_start = start;
> +			}
> +		}
> +		first = false;
> +		prev_end = end;
> +	}
> +
> +	/*
> +	 * We finished walking the bitmap; no more gaps to check for. Just
> +	 * perform the current transfer.
> +	 */
> +	mask = *iio_dev->active_scan_mask >> xfer_start;
> +	ret = bno055_scan_xfer(priv, xfer_start,
> +			       prev_end - xfer_start,
> +			       mask, priv->buf.chans, &buf_idx);
> +
> +	iio_push_to_buffers_with_timestamp(iio_dev, &priv->buf, pf->timestamp);
> +done:
> +	mutex_unlock(&priv->lock);
> +	iio_trigger_notify_done(iio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static void bno055_clk_disable(void *arg)
> +{
> +	clk_disable_unprepare((struct clk *)arg);
> +}
> +
> +int bno055_probe(struct device *dev, struct regmap *regmap,
> +		 int xfer_burst_break_thr, bool sw_reset)
> +{
> +	const struct firmware *caldata;
> +	struct bno055_priv *priv;
> +	const u8 *caldata_data = NULL;
> +	struct iio_dev *iio_dev;
> +	int caldata_size = 0;
> +	char *fw_name_buf;
> +	unsigned int val;
> +	int rev, ver;
> +	int ret;
> +
> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	iio_dev->name = "bno055";
> +	priv = iio_priv(iio_dev);
> +	mutex_init(&priv->lock);
> +	priv->regmap = regmap;
> +	priv->dev = dev;
> +	priv->xfer_burst_break_thr = xfer_burst_break_thr;
> +	priv->sw_reset = sw_reset;
> +
> +	priv->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio), "Failed to get reset GPIO");
> +
> +	priv->clk = devm_clk_get_optional(dev, "clk");
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get CLK");
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, bno055_clk_disable, priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	if (priv->reset_gpio) {
> +		usleep_range(5000, 10000);
> +		gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +		usleep_range(650000, 750000);
> +	} else {
> +		if (!sw_reset)
> +			dev_warn(dev, "No any usable reset metod; IMU may be unreliable");

typo: metod
maybe: "No usable reset method; ..."

> +	}
> +
> +	ret = regmap_read(priv->regmap, BNO055_CHIP_ID_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != BNO055_CHIP_ID_MAGIC) {
> +		dev_err(dev, "Unrecognized chip ID 0x%x", val);
> +		return -ENODEV;
> +	}
> +
> +	if (!priv->reset_gpio) {
> +		ret = bno055_system_reset(priv);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_read(priv->regmap, BNO055_SW_REV_LSB_REG, &rev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(priv->regmap, BNO055_SW_REV_MSB_REG, &ver);
> +	if (ret)
> +		return ret;
> +
> +	if (ver != 0x3 || rev != 0x11)
> +		dev_warn(dev, "Untested firmware version. Anglvel scale may not work as expected");
> +
> +	ret = regmap_bulk_read(priv->regmap, BNO055_UID_LOWER_REG,
> +			       priv->uid, BNO055_UID_LEN);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * This has nothing to do with the IMU firmware, this is for sensor
> +	 * calibration data.
> +	 */
> +	fw_name_buf = kasprintf(GFP_KERNEL,
> +				BNO055_FW_UID_NAME,
> +				BNO055_UID_LEN, priv->uid);
> +	if (!fw_name_buf)
> +		return -ENOMEM;
> +
> +	ret = request_firmware(&caldata, fw_name_buf, dev);
> +	kfree(fw_name_buf);
> +	if (ret)
> +		ret = request_firmware(&caldata, BNO055_FW_GENERIC_NAME, dev);
> +
> +	if (ret)
> +		dev_notice(dev, "Calibration file load failed. See instruction in kernel Documentation");
> +
> +	if (caldata) {
> +		caldata_data = caldata->data;
> +		caldata_size = caldata->size;
> +	}
> +	ret = bno055_init(priv, caldata_data, caldata_size);
> +	if (caldata)
> +		release_firmware(caldata);
> +	if (ret)
> +		return ret;
> +
> +	priv->operation_mode = BNO055_OPR_MODE_FUSION;
> +	ret = bno055_operation_mode_do_set(priv, priv->operation_mode);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, bno055_uninit, priv);
> +	if (ret)
> +		return ret;
> +
> +	iio_dev->channels = bno055_channels;
> +	iio_dev->num_channels = ARRAY_SIZE(bno055_channels);
> +	iio_dev->info = &bno055_info;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, iio_dev,
> +					      iio_pollfunc_store_time,
> +					      bno055_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, iio_dev);
> +	if (ret)
> +		return ret;
> +
> +	bno055_debugfs_init(iio_dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bno055_probe);
> +
> +MODULE_AUTHOR("Andrea Merello <andrea.merello@iit.it>");
> +MODULE_DESCRIPTION("Bosch BNO055 driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/imu/bno055/bno055.h b/drivers/iio/imu/bno055/bno055.h
> new file mode 100644
> index 000000000000..2ccb373c61cd
> --- /dev/null
> +++ b/drivers/iio/imu/bno055/bno055.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __BNO055_H__
> +#define __BNO055_H__
> +
> +#include <linux/regmap.h>
> +
> +struct device;
> +int bno055_probe(struct device *dev, struct regmap *regmap,
> +		 int xfer_burst_break_thr, bool sw_reset);
> +extern const struct regmap_config bno055_regmap_config;
> +
> +#endif
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
