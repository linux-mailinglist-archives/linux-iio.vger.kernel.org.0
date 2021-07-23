Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC16E3D3E39
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 19:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhGWQaS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 12:30:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3479 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGWQaS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 12:30:18 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWbFp63Jyz6H77w;
        Sat, 24 Jul 2021 01:01:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 23 Jul 2021 19:10:49 +0200
Received: from localhost (10.210.170.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 18:10:48 +0100
Date:   Fri, 23 Jul 2021 18:10:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
CC:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Dragos.Bogdan@analog.com>,
        <Darius.Berghe@analog.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: accel: Add driver support for ADXL355
Message-ID: <20210723181022.000032bd@Huawei.com>
In-Reply-To: <20210722062155.32998-3-puranjay12@gmail.com>
References: <20210722062155.32998-1-puranjay12@gmail.com>
        <20210722062155.32998-3-puranjay12@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.238]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Jul 2021 11:51:54 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> ADXL355 is 3-axis MEMS Accelerometer. It offers low noise density,
> low 0g offset drift, low power with selectable measurement ranges.
> It also features programmable high-pass and low-pass filters.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adxl354_adxl355.pdf
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
+CC Mark Brown for a regmap /spi question.

@Mark.  This has come up a few times recently.  Are we now safe to assume
that regmap will always copy data when used with SPI and hence we no
longer need to ensure DMA safe buffers?   

I'm fairly sure we used to need to be careful about this but some of the
value formatting stuff seems to have resulted in bounce buffers in all the
paths I can think of.

@Puranjay, Various other minor things inline.

> ---
>  MAINTAINERS                      |   7 +
>  drivers/iio/accel/Kconfig        |  29 ++
>  drivers/iio/accel/Makefile       |   3 +
>  drivers/iio/accel/adxl355.h      |  79 +++++
>  drivers/iio/accel/adxl355_core.c | 536 +++++++++++++++++++++++++++++++
>  drivers/iio/accel/adxl355_i2c.c  |  63 ++++
>  drivers/iio/accel/adxl355_spi.c  |  66 ++++
>  7 files changed, 783 insertions(+)
>  create mode 100644 drivers/iio/accel/adxl355.h
>  create mode 100644 drivers/iio/accel/adxl355_core.c
>  create mode 100644 drivers/iio/accel/adxl355_i2c.c
>  create mode 100644 drivers/iio/accel/adxl355_spi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd7aff0c1..461f2a192 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -586,6 +586,13 @@ W:	http://ez.analog.com/community/linux-device-drivers
>  F:	Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
>  F:	drivers/input/misc/adxl34x.c
>  
> +ADXL355 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> +M:	Puranjay Mohan <puranjay12@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	drivers/iio/accel/adxl34x.c
> +F:	Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml

You added it to trivial-devices but this will be back!

> +
>  ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index cceda3cec..9a65353a4 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -61,6 +61,35 @@ config ADXL345_SPI
>  	  will be called adxl345_spi and you will also get adxl345_core
>  	  for the core module.
>  
> +config ADXL355
> +	tristate
> +
> +config ADXL355_I2C
> +	tristate "Analog Devices ADXL355 3-Axis Digital Accelerometer I2C Driver"
> +	depends on I2C
> +	select ADXL355
> +	select REGMAP_I2C
> +	help
> +	  Say Y here if you want to build support for the Analog Devices
> +	  ADXL355 3-axis digital accelerometer.
Help text should mention i2c support for... 
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called adxl355_i2c and you will also get adxl355_core
> +	  for the core module.
> +
> +config ADXL355_SPI
> +	tristate "Analog Devices ADXL355 3-Axis Digital Accelerometer SPI Driver"
> +	depends on SPI
> +	select ADXL355
> +	select REGMAP_SPI
> +	help
> +	  Say Y here if you want to build support for the Analog Devices
> +	  ADXL355 3-axis digital accelerometer.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called adxl355_spi and you will also get adxl355_core
> +	  for the core module.
> +
>  config ADXL372
>  	tristate
>  	select IIO_BUFFER
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 32cd1342a..0e4721d2d 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -9,6 +9,9 @@ obj-$(CONFIG_ADIS16209) += adis16209.o
>  obj-$(CONFIG_ADXL345) += adxl345_core.o
>  obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
>  obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
> +obj-$(CONFIG_ADXL355) += adxl355_core.o
> +obj-$(CONFIG_ADXL355_I2C) += adxl355_i2c.o
> +obj-$(CONFIG_ADXL355_SPI) += adxl355_spi.o
>  obj-$(CONFIG_ADXL372) += adxl372.o
>  obj-$(CONFIG_ADXL372_I2C) += adxl372_i2c.o
>  obj-$(CONFIG_ADXL372_SPI) += adxl372_spi.o
> diff --git a/drivers/iio/accel/adxl355.h b/drivers/iio/accel/adxl355.h
> new file mode 100644
> index 000000000..e0b1e697f
> --- /dev/null
> +++ b/drivers/iio/accel/adxl355.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * ADXL355 3-Axis Digital Accelerometer
> + *
> + * Copyright (c) 2021 Puranjay Mohan <puranjay12@gmail.com>
> + */
> +
> +#ifndef _ADXL355_H_
> +#define _ADXL355_H_
> +
> +#include <linux/regmap.h>
> +
> +/* ADXL355 Register Definitions */
> +#define ADXL355_DEVID_AD	0x00
> +#define ADXL355_DEVID_MST	0x01
> +#define ADXL355_PARTID		0x02
> +#define ADXL355_REVID		0x03
> +#define ADXL355_STATUS		0x04
> +#define ADXL355_FIFO_ENTRIES	0x05
> +#define ADXL355_TEMP2		0x06
> +#define ADXL355_XDATA3		0x08
> +#define ADXL355_YDATA3		0x0B
> +#define ADXL355_ZDATA3		0x0E
> +#define ADXL355_FIFO_DATA	0x11
> +#define ADXL355_OFFSET_X_H	0x1E
> +#define ADXL355_OFFSET_Y_H	0x20
> +#define ADXL355_OFFSET_Z_H	0x22
> +#define ADXL355_ACT_EN		0x24
> +#define ADXL355_ACT_THRESH_H	0x25
> +#define ADXL355_ACT_THRESH_L	0x26
> +#define ADXL355_ACT_COUNT	0x27
> +#define ADXL355_FILTER		0x28
> +#define ADXL355_FIFO_SAMPLES	0x29
> +#define ADXL355_INT_MAP		0x2A
> +#define ADXL355_SYNC		0x2B
> +#define ADXL355_RANGE		0x2C
> +#define ADXL355_POWER_CTL	0x2D
> +#define ADXL355_SELF_TEST	0x2E
> +#define ADXL355_RESET		0x2F
> +
> +#define ADXL355_DEVID_AD_VAL	0xAD
> +#define ADXL355_DEVID_MST_VAL	0x1D
> +#define ADXL355_PARTID_VAL	0xED
> +#define ADXL355_REVID_VAL	0x01
> +#define ADXL355_RESET_CODE	0x52
> +
> +#define ADXL355_POWER_CTL_MODE_MSK	GENMASK(1, 0)
> +
> +#define ADXL355_FILTER_ODR_MSK			GENMASK(3, 0)
> +#define ADXL355_FILTER_ODR_MODE(x)		((x) & 0xF)

FIELD_PREP() at the point where it's called and drop the ODR_MODE() define
here as doesn't add anything on
FIELD_PREP(ADXL355_FILTER_ODR_MSK, odr)


> +#define ADXL355_FILTER_HPF_MSK			GENMASK(6, 4)
> +#define ADXL355_FILTER_HPF_MODE(x)		(((x) & 0x7) << 4)

As above, use FIELD_PREP and drop this macro.

> +
> +/*
> + * The datasheet defines an intercept of 1885 LSB at 25 degC
> + * and a slope of -9.05 LSB/C. The following formula can be used to find the
> + * temperature:
> + * Temp = ((RAW - 1885)/(-9.05)) + 25 but this doesn't follow the format of
> + * the IIO which is Temp = (RAW + OFFSET) * SCALE. Hence using some rearranging
> + * we get the scale as -110.49723 and offset as -2111.25
> + */
> +#define TEMP_SCALE_VAL -110
> +#define TEMP_SCALE_VAL2 497238
> +#define TEMP_OFFSET_VAL -2111
> +#define TEMP_OFFSET_VAL2 250000
> +
> +/*
> + * At +/- 2g with 20-bit resolution, scale is given in datasheet as
> + * 3.9ug/LSB = 0.0000039 * 9.80665 = 0.00003824593 m/s^2
> + */
> +#define ADXL355_NSCALE	38245
> +
> +extern const struct regmap_access_table adxl355_readable_regs_tbl;
> +
> +extern const struct regmap_access_table adxl355_writeable_regs_tbl;
> +
> +int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> +		       const char *name);
> +#endif /* _ADXL355_H_ */
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> new file mode 100644
> index 000000000..fa0370d41
> --- /dev/null
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -0,0 +1,536 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADXL355 3-Axis Digital Accelerometer IIO core driver
> + *
> + * Copyright (c) 2021 Puranjay Mohan <puranjay12@gmail.com>
> + *
> + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adxl354_adxl355.pdf
> + */
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/limits.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "adxl355.h"
> +
> +static const struct regmap_range adxl355_read_reg_range[] = {
> +	regmap_reg_range(ADXL355_DEVID_AD, ADXL355_FIFO_DATA),
> +	regmap_reg_range(ADXL355_OFFSET_X_H, ADXL355_SELF_TEST)
> +};
> +
> +const struct regmap_access_table adxl355_readable_regs_tbl = {
> +	.yes_ranges = adxl355_read_reg_range,
> +	.n_yes_ranges = ARRAY_SIZE(adxl355_read_reg_range),
> +};
> +EXPORT_SYMBOL_GPL(adxl355_readable_regs_tbl);
> +
> +static const struct regmap_range adxl355_write_reg_range[] = {
> +	regmap_reg_range(ADXL355_OFFSET_X_H, ADXL355_RESET)
> +};
> +
> +const struct regmap_access_table adxl355_writeable_regs_tbl = {
> +	.yes_ranges = adxl355_write_reg_range,
> +	.n_yes_ranges = ARRAY_SIZE(adxl355_write_reg_range),
> +};
> +EXPORT_SYMBOL_GPL(adxl355_writeable_regs_tbl);
> +
> +enum adxl355_op_mode {
> +	ADXL355_MEASUREMENT,
> +	ADXL355_STANDBY,
> +	ADXL355_TEMP_OFF
> +};
> +
> +enum adxl355_odr {
> +	ADXL355_ODR_4000HZ,
> +	ADXL355_ODR_2000HZ,
> +	ADXL355_ODR_1000HZ,
> +	ADXL355_ODR_500HZ,
> +	ADXL355_ODR_250HZ,
> +	ADXL355_ODR_125HZ,
> +	ADXL355_ODR_62_5HZ,
> +	ADXL355_ODR_31_25HZ,
> +	ADXL355_ODR_15_625HZ,
> +	ADXL355_ODR_7_813HZ,
> +	ADXL355_ODR_3_906HZ
> +};
> +
> +enum adxl355_hpf_3db {
> +	ADXL355_HPF_OFF,

Hmm. I guess 0 for a high pass filter cut off more or less
corresponds to off...


> +	ADXL355_HPF_24_7,
> +	ADXL355_HPF_6_2084,
> +	ADXL355_HPF_1_5545,
> +	ADXL355_HPF_0_3862,
> +	ADXL355_HPF_0_0954,
> +	ADXL355_HPF_0_0238
> +};
> +
> +static const int adxl355_odr_table[][2] = {
> +	[0] = {4000, 0},
> +	[1] = {2000, 0},
> +	[2] = {1000, 0},
> +	[3] = {500, 0},
> +	[4] = {250, 0},
> +	[5] = {125, 0},
> +	[6] = {62, 500000},
> +	[7] = {31, 250000},
> +	[8] = {15, 625000},
> +	[9] = {7, 813000},
> +	[10] = {3, 906000}
> +};
> +
> +static const int adxl355_hpf_3db_multipliers[] = {
> +	0,
> +	247000,
> +	62084,
> +	15545,
> +	3862,
> +	954,
> +	238
> +};
> +
> +struct adxl355_data {
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct mutex lock; /* lock to protect op_mode */
> +	enum adxl355_op_mode op_mode;
> +	enum adxl355_odr odr;
> +	enum adxl355_hpf_3db hpf_3db;
> +	int x_calibbias;
> +	int y_calibbias;
> +	int z_calibbias;
> +	int adxl355_hpf_3db_table[7][2];
> +};
> +
> +static int adxl355_set_op_mode(struct adxl355_data *data,
> +			       enum adxl355_op_mode op_mode)
> +{
> +	int ret;
> +
> +	if (data->op_mode == op_mode)
> +		return 0;
> +
> +	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL,
> +				 ADXL355_POWER_CTL_MODE_MSK, op_mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->op_mode = op_mode;
> +
> +	return ret;
> +}
> +
> +static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
> +{
> +	int i;
> +	u64 rem;
> +	u64 div;
> +	u32 multiplier;
> +	u64 odr = mul_u64_u32_shr(adxl355_odr_table[data->odr][0], 1000000, 0) +
> +					adxl355_odr_table[data->odr][1];
> +
> +	for (i = 0; i < ARRAY_SIZE(adxl355_hpf_3db_multipliers); i++) {
> +		multiplier = adxl355_hpf_3db_multipliers[i];
> +		div = div64_u64_rem(mul_u64_u32_shr(odr, multiplier, 0),
> +				    100000000000000UL, &rem);
> +
> +		data->adxl355_hpf_3db_table[i][0] = div;
> +		data->adxl355_hpf_3db_table[i][1] = div_u64(rem, 100000000);
> +	}
> +}
> +
> +static int adxl355_setup(struct adxl355_data *data)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, ADXL355_DEVID_AD, &regval);
> +	if (ret < 0)
As regmap functions return 0 on success, it's slightly nicer to use

if (ret) for error detection.

This bring greater consistency when you do the
return at the end of this function for example. It's not immediately
obvious that can't return a positive value so why let that through there
and not here?

> +		return ret;
> +
> +	if (regval != ADXL355_DEVID_AD_VAL) {
> +		dev_err(data->dev, "Invalid ADI ID 0x%02x\n", regval);
> +		return -ENODEV;
> +	}
> +
> +	ret = regmap_read(data->regmap, ADXL355_DEVID_MST, &regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (regval != ADXL355_DEVID_MST_VAL) {
> +		dev_err(data->dev, "Invalid MEMS ID 0x%02x\n", regval);
> +		return -ENODEV;
> +	}
> +
> +	ret = regmap_read(data->regmap, ADXL355_PARTID, &regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (regval != ADXL355_PARTID_VAL) {
> +		dev_err(data->dev, "Invalid DEV ID 0x%02x\n", regval);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Perform a software reset to make sure the device is in a consistent
> +	 * state after start up.
> +	 */
> +	ret = regmap_write(data->regmap, ADXL355_RESET, ADXL355_RESET_CODE);
> +	if (ret < 0)
> +		return ret;
> +
> +	adxl355_fill_3db_frequency_table(data);
> +
> +	return adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> +}
> +
> +static int adxl355_get_temp_data(struct adxl355_data *data,
> +				 u8 addr, __be16 *out)
> +{
> +	return regmap_bulk_read(data->regmap, addr, out, sizeof(*out));
> +}
> +
> +static int adxl355_read_axis(struct adxl355_data *data, u8 addr)
> +{
> +	__be32 regval;
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, addr, &regval, 3);
> +	if (ret < 0)
> +		return ret;
> +
> +	return be32_to_cpu(regval) >> 8;
> +}
> +
> +static int adxl355_find_match(const int (*freq_tbl)[2], const int n,
> +			      const int val, const int val2)
> +{
> +	int i;
> +
> +	for (i = 0; i < n; i++) {
> +		if (freq_tbl[i][0] == val && freq_tbl[i][1] == val2)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int adxl355_set_odr(struct adxl355_data *data,
> +			   enum adxl355_odr odr)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&data->lock);
> +
> +	if (data->odr == odr)
> +		goto out_unlock;
> +
> +	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	ret = regmap_update_bits(data->regmap, ADXL355_FILTER,
> +				 ADXL355_FILTER_ODR_MSK,
> +				 ADXL355_FILTER_ODR_MODE(odr));
> +	if (!ret) {
Please use the pattern.

	if (ret < 0)
		goto out_unlock;

	data->odr = odr...

for consistency with the cases above. It's always better to
have the error path out of line as it is what we tend to expect
when reading kernel code.

> +		data->odr = odr;
> +		adxl355_fill_3db_frequency_table(data);
> +	}
> +
> +out_unlock:
> +	ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static int adxl355_set_hpf_3db(struct adxl355_data *data,
> +			       enum adxl355_hpf_3db hpf)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&data->lock);
> +
> +	if (data->hpf_3db == hpf)
> +		goto out_unlock;
> +
> +	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	ret = regmap_update_bits(data->regmap, ADXL355_FILTER,
> +				 ADXL355_FILTER_HPF_MSK,
> +				 ADXL355_FILTER_HPF_MODE(hpf));
> +	if (!ret)
> +		data->hpf_3db = hpf;
> +
> +out_unlock:
> +	ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static int adxl355_set_calibbias(struct adxl355_data *data,
> +				 int scan_index, int calibbias)
> +{
> +	int ret = 0;
> +	__be16 reg = cpu_to_be16(calibbias);

Hmm. I'm a bit in two minds on whether we can always rely on regmap
now copying these buffers and hence avoiding the need for DMA safe buffers
when used with SPI.  It seems like it now does but that's no documented
and a fairly recent development. Anyhow, I went with just asking Mark
Brown - see top of email.

> +
> +	mutex_lock(&data->lock);
> +
> +	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	switch (scan_index) {
> +	case 0:
> +		ret = regmap_bulk_write(data->regmap, ADXL355_OFFSET_X_H,
> +					&reg, 2);
> +		if (ret < 0)
> +			goto out_unlock;
> +		data->x_calibbias = calibbias;
> +		break;
> +	case 1:
> +		ret = regmap_bulk_write(data->regmap, ADXL355_OFFSET_Y_H,
> +					&reg, 2);
> +		if (ret < 0)
> +			goto out_unlock;
> +		data->y_calibbias = calibbias;
> +		break;
> +	case 2:
> +		ret = regmap_bulk_write(data->regmap, ADXL355_OFFSET_Z_H,
> +					&reg, 2);
> +		if (ret < 0)
> +			goto out_unlock;
> +		data->z_calibbias = calibbias;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +out_unlock:
> +	ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static int adxl355_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct adxl355_data *data = iio_priv(indio_dev);
> +	int ret;
> +	__be16 out;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			ret = adxl355_get_temp_data(data, chan->address, &out);
> +			if (ret < 0)
> +				return ret;
> +			*val = be16_to_cpu(out);
> +
> +			return IIO_VAL_INT;
> +		case IIO_ACCEL:
> +			ret = adxl355_read_axis(data, chan->address);
> +			if (ret < 0)
> +				return ret;
> +			*val = sign_extend32(ret >> (chan->scan_type.shift),
> +					     chan->scan_type.realbits - 1);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = TEMP_SCALE_VAL;
> +			*val2 = TEMP_SCALE_VAL2;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_ACCEL:
> +			*val = 0;
> +			*val2 = ADXL355_NSCALE;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = TEMP_OFFSET_VAL;
> +		*val2 = TEMP_OFFSET_VAL2;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (chan->scan_index == 0)
> +			*val = data->x_calibbias;
> +		else if (chan->scan_index == 1)

scan_index is perhaps not as 'obvious' to match on as channel2?
If you use the modifier enum it will be obviously X maps to
x_calibbias etc.

> +			*val = data->y_calibbias;
> +		else
> +			*val = data->z_calibbias;
> +		*val = sign_extend32(*val, 15);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = adxl355_odr_table[data->odr][0];
> +		*val2 = adxl355_odr_table[data->odr][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +		*val = data->adxl355_hpf_3db_table[data->hpf_3db][0];
> +		*val2 = data->adxl355_hpf_3db_table[data->hpf_3db][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	return -EINVAL;
One of the static analyzers tends to moan if a switch doesn't cover
all possible values.  To avoid that and because it's tidy anyway
I would add 
	default:
		return -EINVAL;

within the switch statement and drop this external one.
That also matches the way you did it for the nested switch statements
above.
	
> +}
> +
> +static int adxl355_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct adxl355_data *data = iio_priv(indio_dev);
> +	int odr_idx, hpf_idx, calibbias;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		odr_idx = adxl355_find_match(adxl355_odr_table,
> +					     ARRAY_SIZE(adxl355_odr_table),
> +					     val, val2);
> +		if (odr_idx < 0)
> +			return odr_idx;
> +
> +		return adxl355_set_odr(data, odr_idx);
> +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +		hpf_idx = adxl355_find_match(data->adxl355_hpf_3db_table,
> +					ARRAY_SIZE(data->adxl355_hpf_3db_table),
> +					     val, val2);
> +		if (hpf_idx < 0)
> +			return hpf_idx;
> +
> +		return adxl355_set_hpf_3db(data, hpf_idx);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		calibbias = clamp_t(int, val, S16_MIN, S16_MAX);
> +
> +		return adxl355_set_calibbias(data, chan->scan_index, calibbias);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adxl355_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	struct adxl355_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = (const int *)adxl355_odr_table;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		/* Values are stored in a 2D matrix */
> +		*length = ARRAY_SIZE(adxl355_odr_table) * 2;
> +
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +		*vals = (const int *)(data->adxl355_hpf_3db_table);
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		/* Values are stored in a 2D matrix */
> +		*length = ARRAY_SIZE(data->adxl355_hpf_3db_table) * 2;
> +
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const unsigned long adxl355_avail_scan_masks[] = {
> +	GENMASK(3, 0),
> +	0
> +};

This is only relevant if you are support IIO buffered modes which I can't
yet see in the driver.

> +
> +static const struct iio_info adxl355_info = {
> +	.read_raw	= adxl355_read_raw,
> +	.write_raw	= adxl355_write_raw,
> +	.read_avail	= &adxl355_read_avail
> +};
> +
> +#define ADXL355_ACCEL_CHANNEL(index, reg, axis) {			\
> +	.type = IIO_ACCEL,						\
> +	.address = reg,							\
> +	.modified = 1,							\
> +	.channel2 = IIO_MOD_##axis,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_CALIBBIAS),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
> +	.info_mask_shared_by_type_available =				\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
> +		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
> +	.scan_index = index,						\

Only makes sense if you are supporting buffered mode as otherwise there
isn't really any such thing as a 'scan'.

> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 20,						\
> +		.storagebits = 32,					\
> +		.shift = 4,						\
> +		.endianness = IIO_BE,					\

This is mostly about buffered mode as well.

> +	}								\
> +}
> +
> +static const struct iio_chan_spec adxl355_channels[] = {
> +	ADXL355_ACCEL_CHANNEL(0, ADXL355_XDATA3, X),
> +	ADXL355_ACCEL_CHANNEL(1, ADXL355_YDATA3, Y),
> +	ADXL355_ACCEL_CHANNEL(2, ADXL355_ZDATA3, Z),
> +	{
> +		.type = IIO_TEMP,
> +		.address = ADXL355_TEMP2,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.scan_index = 3,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 12,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +		},
> +	}
> +};
> +
> +int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> +		       const char *name)
> +{
> +	struct adxl355_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->regmap = regmap;
> +	data->dev = dev;
> +	data->op_mode = ADXL355_STANDBY;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = name;
> +	indio_dev->info = &adxl355_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = adxl355_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adxl355_channels);
> +	indio_dev->available_scan_masks = adxl355_avail_scan_masks;
> +
> +	ret = adxl355_setup(data);
> +	if (ret < 0) {
> +		dev_err(dev, "ADXL355 setup failed\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_GPL(adxl355_core_probe);
> +
> +MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
> +MODULE_DESCRIPTION("ADXL355 3-Axis Digital Accelerometer core driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
> new file mode 100644
> index 000000000..6b84d8df2
> --- /dev/null
> +++ b/drivers/iio/accel/adxl355_i2c.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADXL355 3-Axis Digital Accelerometer I2C driver
> + *
> + * Copyright (c) 2021 Puranjay Mohan <puranjay12@gmail.com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "adxl355.h"
> +
> +static const struct regmap_config adxl355_i2c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x2F,
> +	.rd_table = &adxl355_readable_regs_tbl,
> +	.wr_table = &adxl355_writeable_regs_tbl
> +};
> +
> +static int adxl355_i2c_probe(struct i2c_client *client)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &adxl355_i2c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return adxl355_core_probe(&client->dev, regmap, client->name);
> +}
> +
> +static const struct i2c_device_id adxl355_i2c_id[] = {
> +	{ "adxl355", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, adxl355_i2c_id);
> +
> +static const struct of_device_id adxl355_of_match[] = {
> +	{ .compatible = "adi,adxl355" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, adxl355_of_match);
> +
> +static struct i2c_driver adxl355_i2c_driver = {
> +	.driver = {
> +		.name	= "adxl355_i2c",
> +		.of_match_table = adxl355_of_match,
> +	},
> +	.probe_new	= adxl355_i2c_probe,
> +	.id_table	= adxl355_i2c_id,
> +};
> +
> +module_i2c_driver(adxl355_i2c_driver);
> +
> +MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
> +MODULE_DESCRIPTION("ADXL355 3-Axis Digital Accelerometer I2C driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/adxl355_spi.c b/drivers/iio/accel/adxl355_spi.c
> new file mode 100644
> index 000000000..108d1b308
> --- /dev/null
> +++ b/drivers/iio/accel/adxl355_spi.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADXL355 3-Axis Digital Accelerometer SPI driver
> + *
> + * Copyright (c) 2021 Puranjay Mohan <puranjay12@gmail.com>
> + */
> +
> +#include <linux/module.h>

Also good to include mod_devicetable.h directly as well
given the use of struct of_device_id

> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "adxl355.h"
> +
> +static const struct regmap_config adxl355_spi_regmap_config = {
> +	.reg_bits = 7,
> +	.pad_bits = 1,
> +	.val_bits = 8,
> +	.read_flag_mask = BIT(0),
> +	.max_register = 0x2F,
> +	.rd_table = &adxl355_readable_regs_tbl,
> +	.wr_table = &adxl355_writeable_regs_tbl
> +};
> +
> +static int adxl355_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_spi(spi, &adxl355_spi_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return adxl355_core_probe(&spi->dev, regmap, id->name);
> +}
> +
> +static const struct spi_device_id adxl355_spi_id[] = {
> +	{ "adxl355", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(spi, adxl355_spi_id);
> +
> +static const struct of_device_id adxl355_of_match[] = {
> +	{ .compatible = "adi,adxl355" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, adxl355_of_match);
> +
> +static struct spi_driver adxl355_spi_driver = {
> +	.driver = {
> +		.name	= "adxl355_spi",
> +		.of_match_table = adxl355_of_match,
> +	},
> +	.probe		= adxl355_spi_probe,
> +	.id_table	= adxl355_spi_id,
> +};
> +
> +module_spi_driver(adxl355_spi_driver);
> +
> +MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
> +MODULE_DESCRIPTION("ADXL355 3-Axis Digital Accelerometer SPI driver");
> +MODULE_LICENSE("GPL v2");

