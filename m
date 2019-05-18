Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D57E2234C
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 12:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfERKmu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 06:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbfERKmt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 06:42:49 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC1C20872;
        Sat, 18 May 2019 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558176168;
        bh=1L76VzoZcgtueq+kY6nvr0nLie3bjrPa6ipmxd5KFKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qeQ9jgmlV6IdjLqpmwbBgbYuXRlmPsGofU1U+SnTKCpPVH96zqtyZb3j4MFsdLEob
         PjDbHRcnsuDsuEwjxQTphvhikKirERYdGfVqpsribnzVOow3NgivJ1ESPjqCIImDu3
         lWBuAhHYjx+v+IaDdGqzNLkqNlR8GTa6qHc6SdJ0=
Date:   Sat, 18 May 2019 11:42:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, lars@metafoo.de, knaack.h@gmx.de
Subject: Re: [PATCH v3 1/3] iio: Add driver for Infineon DPS310
Message-ID: <20190518114244.3899ddd4@archlinux>
In-Reply-To: <1557945677-12838-2-git-send-email-eajames@linux.ibm.com>
References: <1557945677-12838-1-git-send-email-eajames@linux.ibm.com>
        <1557945677-12838-2-git-send-email-eajames@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 May 2019 13:41:15 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> From: Joel Stanley <joel@jms.id.au>
>=20
> The DPS310 is a temperature and pressure sensor. It can be accessed over
> i2c and SPI.
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
Hi Eddie,

One spacing issue in the Kconfig file otherwise I think this looks good.

However, Joel, I would definitely prefer it if you took a look and ideally
provided a Signed-off-by as we need the Developer Certificate of Origin
stuff to be clearly correct.

Thanks,

Jonathan
> ---
>  MAINTAINERS                   |   6 +
>  drivers/iio/pressure/Kconfig  |  10 +
>  drivers/iio/pressure/Makefile |   1 +
>  drivers/iio/pressure/dps310.c | 468 ++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 485 insertions(+)
>  create mode 100644 drivers/iio/pressure/dps310.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7345e45..ea31027 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7760,6 +7760,12 @@ W:	http://industrypack.sourceforge.net
>  S:	Maintained
>  F:	drivers/ipack/
> =20
> +INFINEON DPS310 Driver
> +M:	Eddie James <eajames@linux.ibm.com>
> +L:	linux-iio@vger.kernel.org
> +F:	drivers/iio/pressure/dps310.c
> +S:	Maintained
> +
>  INFINIBAND SUBSYSTEM
>  M:	Doug Ledford <dledford@redhat.com>
>  M:	Jason Gunthorpe <jgg@mellanox.com>
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index efeb89f..681a1cc 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -52,6 +52,16 @@ config IIO_CROS_EC_BARO
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called cros_ec_baro.
> =20
> +config DPS310
> +       tristate "Infineon DPS310 pressure and temperature sensor"
> +       depends on I2C
> +       select REGMAP_I2C
> +       help
Mixture of spaces and tabs here it seems. Please match the rest of the file
(which is hopefully consistent!).
> +	 Support for the Infineon DPS310 digital barometric pressure sensor.
> +
> +	 This driver can also be built as a module.  If so, the module will be
> +	 called dps310.
> +
>  config HID_SENSOR_PRESS
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index c2058d7..d8f5ace 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_BMP280) +=3D bmp280.o
>  bmp280-objs :=3D bmp280-core.o bmp280-regmap.o
>  obj-$(CONFIG_BMP280_I2C) +=3D bmp280-i2c.o
>  obj-$(CONFIG_BMP280_SPI) +=3D bmp280-spi.o
> +obj-$(CONFIG_DPS310) +=3D dps310.o
>  obj-$(CONFIG_IIO_CROS_EC_BARO) +=3D cros_ec_baro.o
>  obj-$(CONFIG_HID_SENSOR_PRESS)   +=3D hid-sensor-press.o
>  obj-$(CONFIG_HP03) +=3D hp03.o
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> new file mode 100644
> index 0000000..9acfccb
> --- /dev/null
> +++ b/drivers/iio/pressure/dps310.c
> @@ -0,0 +1,468 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright IBM Corp 2019
> +/*
> + * The DPS310 is a barometric pressure and temperature sensor.
> + * Currently only reading a single temperature is supported by
> + * this driver.
> + *
> + * https://www.infineon.com/dgdl/?fileId=3D5546d462576f34750157750826c42=
242
> + *
> + * Temperature calculation:
> + *   c0 * 0.5 + c1 * T_raw / kT =C2=B0C
> + *
> + * TODO:
> + *  - Pressure sensor readings
> + *  - Optionally support the FIFO
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define DPS310_DEV_NAME		"dps310"
> +
> +#define DPS310_PRS_B0		0x00
> +#define DPS310_PRS_B1		0x01
> +#define DPS310_PRS_B2		0x02
> +#define DPS310_TMP_B0		0x03
> +#define DPS310_TMP_B1		0x04
> +#define DPS310_TMP_B2		0x05
> +#define DPS310_PRS_CFG		0x06
> +#define DPS310_TMP_CFG		0x07
> +#define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
> +#define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
> +#define  DPS310_TMP_EXT		BIT(7)
> +#define DPS310_MEAS_CFG		0x08
> +#define  DPS310_MEAS_CTRL_BITS	GENMASK(2, 0)
> +#define   DPS310_PRS_EN		BIT(0)
> +#define   DPS310_TEMP_EN	BIT(1)
> +#define   DPS310_BACKGROUND	BIT(2)
> +#define  DPS310_PRS_RDY		BIT(4)
> +#define  DPS310_TMP_RDY		BIT(5)
> +#define  DPS310_SENSOR_RDY	BIT(6)
> +#define  DPS310_COEF_RDY	BIT(7)
> +#define DPS310_CFG_REG		0x09
> +#define  DPS310_INT_HL		BIT(7)
> +#define  DPS310_TMP_SHIFT_EN	BIT(3)
> +#define  DPS310_PRS_SHIFT_EN	BIT(4)
> +#define  DPS310_FIFO_EN		BIT(5)
> +#define  DPS310_SPI_EN		BIT(6)
> +#define DPS310_RESET		0x0c
> +#define  DPS310_RESET_MAGIC	0x09
> +#define DPS310_COEF_BASE	0x10
> +#define DPS310_COEF_SRC		0x28
> +
> +/* Make sure sleep time is <=3D 20ms for usleep_range */
> +#define DPS310_POLL_SLEEP_US(t)		min(20000, (t) / 8)
> +/* Silently handle error in rate value here */
> +#define DPS310_POLL_TIMEOUT_US(rc)	((rc) <=3D 0 ? 1000000 : 1000000 / (r=
c))
> +
> +#define DPS310_PRS_BASE		DPS310_PRS_B0
> +#define DPS310_TMP_BASE		DPS310_TMP_B0
> +
> +/*
> + * These values (defined in the spec) indicate how to scale the raw regi=
ster
> + * values for each level of precision available.
> + */
> +static const int scale_factors[] =3D {
> +	 524288,
> +	1572864,
> +	3670016,
> +	7864320,
> +	 253952,
> +	 516096,
> +	1040384,
> +	2088960,
> +};
> +
> +struct dps310_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct mutex lock;	/* Lock for sequential HW access functions */
> +
> +	s32 c0, c1;
> +	s32 temp_raw;
> +};
> +
> +static const struct iio_chan_spec dps310_channels[] =3D {
> +	{
> +		.type =3D IIO_TEMP,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +};
> +
> +/* To be called after checking the COEF_RDY bit in MEAS_CFG */
> +static int dps310_get_temp_coef(struct dps310_data *data)
> +{
> +	int rc;
> +	u8 coef[3];
> +	u32 c0, c1;
> +
> +	/*
> +	 * Read temperature calibration coefficients c0 and c1 from the
> +	 * COEF register. The numbers are 12-bit 2's compliment numbers
> +	 */
> +	rc =3D regmap_bulk_read(data->regmap, DPS310_COEF_BASE, coef,
> +			      sizeof(coef));
> +	if (rc < 0)
> +		return rc;
> +
> +	c0 =3D (coef[0] << 4) | (coef[1] >> 4);
> +	data->c0 =3D sign_extend32(c0, 11);
> +
> +	c1 =3D ((coef[1] & GENMASK(3, 0)) << 8) | coef[2];
> +	data->c1 =3D sign_extend32(c1, 11);
> +
> +	return 0;
> +}
> +
> +static int dps310_get_temp_precision(struct dps310_data *data)
> +{
> +	int rc;
> +	int val;
> +
> +	rc =3D regmap_read(data->regmap, DPS310_TMP_CFG, &val);
> +	if (rc < 0)
> +		return rc;
> +
> +	/*
> +	 * Scale factor is bottom 4 bits of the register, but 1111 is
> +	 * reserved so just grab bottom three
> +	 */
> +	return BIT(val & GENMASK(2, 0));
> +}
> +
> +/* Called with lock held */
> +static int dps310_set_temp_precision(struct dps310_data *data, int val)
> +{
> +	int rc;
> +	u8 shift_en;
> +
> +	if (val < 0 || val > 128)
> +		return -EINVAL;
> +
> +	shift_en =3D val >=3D 16 ? DPS310_TMP_SHIFT_EN : 0;
> +	rc =3D regmap_write_bits(data->regmap, DPS310_CFG_REG,
> +			       DPS310_TMP_SHIFT_EN, shift_en);
> +	if (rc)
> +		return rc;
> +
> +	return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
> +				  DPS310_TMP_PRC_BITS, ilog2(val));
> +}
> +
> +/* Called with lock held */
> +static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
> +{
> +	u8 val;
> +
> +	if (freq < 0 || freq > 128)
> +		return -EINVAL;
> +
> +	val =3D ilog2(freq) << 4;
> +
> +	return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
> +				  DPS310_TMP_RATE_BITS, val);
> +}
> +
> +static int dps310_get_temp_samp_freq(struct dps310_data *data)
> +{
> +	int rc;
> +	int val;
> +
> +	rc =3D regmap_read(data->regmap, DPS310_TMP_CFG, &val);
> +	if (rc < 0)
> +		return rc;
> +
> +	return BIT((val & DPS310_TMP_RATE_BITS) >> 4);
> +}
> +
> +static int dps310_get_temp_k(struct dps310_data *data)
> +{
> +	int rc =3D dps310_get_temp_precision(data);
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	return scale_factors[ilog2(rc)];
> +}
> +
> +static int dps310_read_temp(struct dps310_data *data)
> +{
> +	int rc;
> +	int rate;
> +	int ready;
> +	int timeout;
> +	s32 raw;
> +	u8 val[3];
> +
> +	if (mutex_lock_interruptible(&data->lock))
> +		return -EINTR;
> +
> +	rate =3D dps310_get_temp_samp_freq(data);
> +	timeout =3D DPS310_POLL_TIMEOUT_US(rate);
> +
> +	/* Poll for sensor readiness; base the timeout upon the sample rate. */
> +	rc =3D regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> +				      ready & DPS310_TMP_RDY,
> +				      DPS310_POLL_SLEEP_US(timeout), timeout);
> +	if (rc < 0)
> +		goto done;
> +
> +	rc =3D regmap_bulk_read(data->regmap, DPS310_TMP_BASE, val, sizeof(val)=
);
> +	if (rc < 0)
> +		goto done;
> +
> +	raw =3D (val[0] << 16) | (val[1] << 8) | val[2];
> +	data->temp_raw =3D sign_extend32(raw, 23);
> +
> +done:
> +	mutex_unlock(&data->lock);
> +	return rc;
> +}
> +
> +static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case DPS310_PRS_CFG:
> +	case DPS310_TMP_CFG:
> +	case DPS310_MEAS_CFG:
> +	case DPS310_CFG_REG:
> +	case DPS310_RESET:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool dps310_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case DPS310_PRS_B0:
> +	case DPS310_PRS_B1:
> +	case DPS310_PRS_B2:
> +	case DPS310_TMP_B0:
> +	case DPS310_TMP_B1:
> +	case DPS310_TMP_B2:
> +	case DPS310_MEAS_CFG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int dps310_write_raw(struct iio_dev *iio,
> +			    struct iio_chan_spec const *chan, int val,
> +			    int val2, long mask)
> +{
> +	int rc;
> +	struct dps310_data *data =3D iio_priv(iio);
> +
> +	if (chan->type !=3D IIO_TEMP)
> +		return -EINVAL;
> +
> +	if (mutex_lock_interruptible(&data->lock))
> +		return -EINTR;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		rc =3D dps310_set_temp_samp_freq(data, val);
> +		break;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		rc =3D dps310_set_temp_precision(data, val);
> +		break;
> +
> +	default:
> +		rc =3D -EINVAL;
> +		break;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +	return rc;
> +}
> +
> +static int dps310_calculate_temp(struct dps310_data *data)
> +{
> +	s64 c0;
> +	s64 t;
> +	int kt =3D dps310_get_temp_k(data);
> +
> +	if (kt < 0)
> +		return kt;
> +
> +	/* Obtain inverse-scaled offset */
> +	c0 =3D div_s64((s64)kt * (s64)data->c0, 2);
> +
> +	/* Add the offset to the unscaled temperature */
> +	t =3D c0 + ((s64)data->temp_raw * (s64)data->c1);
> +
> +	/* Convert to milliCelsius and scale the temperature */
> +	return (int)div_s64(t * 1000LL, kt);
> +}
> +
> +static int dps310_read_raw(struct iio_dev *iio,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct dps310_data *data =3D iio_priv(iio);
> +	int rc;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		rc =3D dps310_get_temp_samp_freq(data);
> +		if (rc < 0)
> +			return rc;
> +
> +		*val =3D rc;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_PROCESSED:
> +		rc =3D dps310_read_temp(data);
> +		if (rc)
> +			return rc;
> +
> +		rc =3D dps310_calculate_temp(data);
> +		if (rc < 0)
> +			return rc;
> +
> +		*val =3D rc;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		rc =3D dps310_get_temp_precision(data);
> +		if (rc < 0)
> +			return rc;
> +
> +		*val =3D rc;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static void dps310_reset(void *action_data)
> +{
> +	struct dps310_data *data =3D action_data;
> +
> +	regmap_write(data->regmap, DPS310_RESET, DPS310_RESET_MAGIC);
> +}
> +
> +static const struct regmap_config dps310_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.writeable_reg =3D dps310_is_writeable_reg,
> +	.volatile_reg =3D dps310_is_volatile_reg,
> +	.cache_type =3D REGCACHE_RBTREE,
> +	.max_register =3D DPS310_COEF_SRC,
> +};
> +
> +static const struct iio_info dps310_info =3D {
> +	.read_raw =3D dps310_read_raw,
> +	.write_raw =3D dps310_write_raw,
> +};
> +
> +static int dps310_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct dps310_data *data;
> +	struct iio_dev *iio;
> +	int rc, ready;
> +
> +	iio =3D devm_iio_device_alloc(&client->dev,  sizeof(*data));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(iio);
> +	data->client =3D client;
> +	mutex_init(&data->lock);
> +
> +	iio->dev.parent =3D &client->dev;
> +	iio->name =3D id->name;
> +	iio->channels =3D dps310_channels;
> +	iio->num_channels =3D ARRAY_SIZE(dps310_channels);
> +	iio->info =3D &dps310_info;
> +	iio->modes =3D INDIO_DIRECT_MODE;
> +
> +	data->regmap =3D devm_regmap_init_i2c(client, &dps310_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
> +	/* Register to run the device reset when the device is removed */
> +	rc =3D devm_add_action_or_reset(&client->dev, dps310_reset, data);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Set up external (MEMS) temperature sensor in single sample, one
> +	 * measurement per second mode
> +	 */
> +	rc =3D regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Temp shift is disabled when PRC <=3D 8 */
> +	rc =3D regmap_write_bits(data->regmap, DPS310_CFG_REG,
> +			       DPS310_TMP_SHIFT_EN, 0);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* MEAS_CFG doesn't update correctly unless first written with 0 */
> +	rc =3D regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> +			       DPS310_MEAS_CTRL_BITS, 0);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Turn on temperature measurement in the background */
> +	rc =3D regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> +			       DPS310_MEAS_CTRL_BITS,
> +			       DPS310_TEMP_EN | DPS310_BACKGROUND);
> +	if (rc < 0)
> +		return rc;
> +
> +	/*
> +	 * Calibration coefficients required for reporting temperature.
> +	 * They are available 40ms after the device has started
> +	 */
> +	rc =3D regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> +				      ready & DPS310_COEF_RDY, 10000, 40000);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc =3D dps310_get_temp_coef(data);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc =3D devm_iio_device_register(&client->dev, iio);
> +	if (rc)
> +		return rc;
> +
> +	i2c_set_clientdata(client, iio);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id dps310_id[] =3D {
> +	{ DPS310_DEV_NAME, 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, dps310_id);
> +
> +static struct i2c_driver dps310_driver =3D {
> +	.driver =3D {
> +		.name =3D DPS310_DEV_NAME,
> +	},
> +	.probe =3D dps310_probe,
> +	.id_table =3D dps310_id,
> +};
> +module_i2c_driver(dps310_driver);
> +
> +MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
> +MODULE_DESCRIPTION("Infineon DPS310 pressure and temperature sensor");
> +MODULE_LICENSE("GPL v2");

