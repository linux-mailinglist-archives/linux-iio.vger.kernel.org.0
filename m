Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 515731A751
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 11:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfEKJwP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 05:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbfEKJwP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 05:52:15 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47FDB2173B;
        Sat, 11 May 2019 09:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557568333;
        bh=l0FFzZCbOn5k5kyyaZrKmaYqRLaHqOAs9dmv+VBJZEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IB6mfQW0c3sFPhserhd8S1h7szNSTarz208t42DhvPCbNBS13/8gGqSJo/6y5qil9
         V7TGIwAytxTLwmBGp1ivb3dkEScNd37c/JSnj1kMWNNG9KcF6gPQo6SI3Y1/qVEC+4
         73uGPq/Krfs0MWu96qrkjzXmsJ8O/FBQVp8drxxA=
Date:   Sat, 11 May 2019 10:52:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Eddie James <eajames@linux.ibm.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@jms.id.au
Subject: Re: [PATCH 1/3] iio: Add driver for Infineon DPS310
Message-ID: <20190511105208.2b69e89d@archlinux>
In-Reply-To: <c27fadfa-ddd7-9fa6-89bf-92e47a570716@linux.vnet.ibm.com>
References: <1557176315-29401-1-git-send-email-eajames@linux.ibm.com>
        <1557176315-29401-2-git-send-email-eajames@linux.ibm.com>
        <alpine.DEB.2.21.1905062304280.717@vps.pmeerw.net>
        <c27fadfa-ddd7-9fa6-89bf-92e47a570716@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 May 2019 11:01:36 -0500
Eddie James <eajames@linux.vnet.ibm.com> wrote:

> On 5/6/19 4:18 PM, Peter Meerwald-Stadler wrote:
> > On Mon, 6 May 2019, Eddie James wrote:
> > =20
> >> From: Joel Stanley <joel@jms.id.au> =20
> > some comments below =20
>=20
>=20
> Thanks for the quick review! Will get these in for v2, I did have a=20
> couple of questions below though.
>=20
> Eddie
>=20
>=20
> >    =20
> >> The DPS310 is a temperature and pressure sensor. It can be accessed ov=
er
> >> i2c and SPI.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> >> ---
> >>   MAINTAINERS                   |   6 +
> >>   drivers/iio/pressure/Kconfig  |  10 +
> >>   drivers/iio/pressure/Makefile |   1 +
> >>   drivers/iio/pressure/dps310.c | 429 ++++++++++++++++++++++++++++++++=
++++++++++
> >>   4 files changed, 446 insertions(+)
> >>   create mode 100644 drivers/iio/pressure/dps310.c
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index c61c49d..a91dfa9 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -7743,6 +7743,12 @@ W:	http://industrypack.sourceforge.net
> >>   S:	Maintained
> >>   F:	drivers/ipack/
> >>  =20
> >> +INFINEON DPS310 Driver
> >> +M:	Eddie James <eajames@linux.ibm.com>
> >> +L:	linux-iio@vger.kernel.org
> >> +F:	drivers/iio/pressure/dps310.c
> >> +S:	Maintained
> >> +
> >>   INFINIBAND SUBSYSTEM
> >>   M:	Doug Ledford <dledford@redhat.com>
> >>   M:	Jason Gunthorpe <jgg@mellanox.com>
> >> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconf=
ig
> >> index efeb89f..681a1cc 100644
> >> --- a/drivers/iio/pressure/Kconfig
> >> +++ b/drivers/iio/pressure/Kconfig
> >> @@ -52,6 +52,16 @@ config IIO_CROS_EC_BARO
> >>   	  To compile this driver as a module, choose M here: the module
> >>   	  will be called cros_ec_baro.
> >>  =20
> >> +config DPS310
> >> +       tristate "Infineon DPS310 pressure and temperature sensor"
> >> +       depends on I2C
> >> +       select REGMAP_I2C
> >> +       help
> >> +	 Support for the Infineon DPS310 digital barometric pressure sensor.
> >> +
> >> +	 This driver can also be built as a module.  If so, the module will =
be
> >> +	 called dps310.
> >> +
> >>   config HID_SENSOR_PRESS
> >>   	depends on HID_SENSOR_HUB
> >>   	select IIO_BUFFER
> >> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Make=
file
> >> index c2058d7..d8f5ace 100644
> >> --- a/drivers/iio/pressure/Makefile
> >> +++ b/drivers/iio/pressure/Makefile
> >> @@ -9,6 +9,7 @@ obj-$(CONFIG_BMP280) +=3D bmp280.o
> >>   bmp280-objs :=3D bmp280-core.o bmp280-regmap.o
> >>   obj-$(CONFIG_BMP280_I2C) +=3D bmp280-i2c.o
> >>   obj-$(CONFIG_BMP280_SPI) +=3D bmp280-spi.o
> >> +obj-$(CONFIG_DPS310) +=3D dps310.o
> >>   obj-$(CONFIG_IIO_CROS_EC_BARO) +=3D cros_ec_baro.o
> >>   obj-$(CONFIG_HID_SENSOR_PRESS)   +=3D hid-sensor-press.o
> >>   obj-$(CONFIG_HP03) +=3D hp03.o
> >> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps3=
10.c
> >> new file mode 100644
> >> index 0000000..21d5dcb
> >> --- /dev/null
> >> +++ b/drivers/iio/pressure/dps310.c
> >> @@ -0,0 +1,429 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +// Copyright IBM Corp 2019
> >> +/*
> >> + * The DPS310 is a barometric pressure and temperature sensor.
> >> + * Currently only reading a single temperature is supported by
> >> + * this driver.
> >> + *
> >> + * https://www.infineon.com/dgdl/?fileId=3D5546d462576f34750157750826=
c42242
> >> + *
> >> + * Temperature calculation:
> >> + *   c0 * 0.5 + c1 * T_raw / kT =C2=B0C
> >> + *
> >> + * TODO:
> >> + *  - Pressure sensor readings
> >> + *  - Optionally support the FIFO
> >> + */
> >> +
> >> +#include <linux/i2c.h>
> >> +#include <linux/module.h>
> >> +#include <linux/regmap.h>
> >> +
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/iio/sysfs.h>
> >> +
> >> +#define DPS310_PRS_B0		0x00
> >> +#define DPS310_PRS_B1		0x01
> >> +#define DPS310_PRS_B2		0x02
> >> +#define DPS310_TMP_B0		0x03
> >> +#define DPS310_TMP_B1		0x04
> >> +#define DPS310_TMP_B2		0x05
> >> +#define DPS310_PRS_CFG		0x06
> >> +#define DPS310_TMP_CFG		0x07
> >> +#define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
> >> +#define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
> >> +#define  DPS310_TMP_EXT		BIT(7)
> >> +#define DPS310_MEAS_CFG		0x08
> >> +#define  DPS310_MEAS_CTRL_BITS	GENMASK(2, 0)
> >> +#define   DPS310_PRS_EN		BIT(0)
> >> +#define   DPS310_TEMP_EN	BIT(1)
> >> +#define   DPS310_BACKGROUND	BIT(2)
> >> +#define  DPS310_PRS_RDY		BIT(4)
> >> +#define  DPS310_TMP_RDY		BIT(5)
> >> +#define  DPS310_SENSOR_RDY	BIT(6)
> >> +#define  DPS310_COEF_RDY	BIT(7)
> >> +#define DPS310_CFG_REG		0x09
> >> +#define  DPS310_INT_HL		BIT(7)
> >> +#define  DPS310_TMP_SHIFT_EN	BIT(3)
> >> +#define  DPS310_PRS_SHIFT_EN	BIT(4)
> >> +#define  DPS310_FIFO_EN		BIT(5)
> >> +#define  DPS310_SPI_EN		BIT(6)
> >> +#define DPS310_RESET		0x0c
> >> +#define  DPS310_RESET_MAGIC	(BIT(0) | BIT(3))
> >> +#define DPS310_COEF_BASE	0x10
> >> +
> >> +#define DPS310_PRS_BASE		DPS310_PRS_B0
> >> +#define DPS310_TMP_BASE		DPS310_TMP_B0
> >> +
> >> +#define DPS310_CALC_RATE(_n)	ilog2(_n)
> >> +#define DPS310_CALC_PRC(_n)	ilog2(_n)
> >> +
> >> +const int scale_factor[] =3D { =20
> > static
> > maybe plural, scale_factors?
> > maybe some comment would be good what these values relate to
> > =20
> >> +	 524288,
> >> +	1572864,
> >> +	3670016,
> >> +	7864320,
> >> +	 253952,
> >> +	 516096,
> >> +	1040384,
> >> +	2088960,
> >> +};
> >> +
> >> +struct dps310_data {
> >> +	struct i2c_client *client;
> >> +	struct regmap *regmap;
> >> +
> >> +	s32 c0, c1;
> >> +	s32 temp_raw;
> >> +};
> >> +
> >> +static const struct iio_chan_spec dps310_channels[] =3D {
> >> +	{
> >> +		.type =3D IIO_TEMP,
> >> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_OFFSET) |
> >> +			BIT(IIO_CHAN_INFO_SCALE) |
> >> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> >> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >> +			BIT(IIO_CHAN_INFO_RAW),
> >> +	},
> >> +};
> >> +
> >> +/* To be called after checking the TMP_RDY bit in MEAS_CFG */
> >> +static int dps310_get_temp_coef(struct dps310_data *data)
> >> +{
> >> +	struct regmap *regmap =3D data->regmap;
> >> +	u8 coef[3] =3D {0}; =20
> > initialization needed?
> > =20
> >> +	int r;
> >> +	u32 c0, c1;
> >> +
> >> +	/*
> >> +	 * Read temperature calibration coefficients c0 and c1 from the
> >> +	 * COEF register. The numbers are 12-bit 2's compliment numbers
> >> +	 */
> >> +	r =3D regmap_bulk_read(regmap, DPS310_COEF_BASE, coef, 3); =20
> > sizeof(coef) instead of 3
> > =20
> >> +	if (r < 0)
> >> +		return r;
> >> +
> >> +	c0 =3D (coef[0] << 4) | (coef[1] >> 4);
> >> +	data->c0 =3D sign_extend32(c0, 11);
> >> +
> >> +	c1 =3D ((coef[1] & GENMASK(3, 0)) << 8) | coef[2];
> >> +	data->c1 =3D sign_extend32(c1, 11);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int dps310_get_temp_precision(struct dps310_data *data)
> >> +{
> >> +	int val, r;
> >> +
> >> +	r =3D regmap_read(data->regmap, DPS310_TMP_CFG, &val);
> >> +	if (r < 0)
> >> +		return r;
> >> +
> >> +	/*
> >> +	 * Scale factor is bottom 4 bits of the register, but 1111 is
> >> +	 * reserved so just grab bottom three
> >> +	 */
> >> +	return BIT(val & GENMASK(2, 0));
> >> +}
> >> +
> >> +static int dps310_set_temp_precision(struct dps310_data *data, int va=
l)
> >> +{
> >> +	int ret;
> >> +	u8 shift_en;
> >> +
> >> +	if (val < 0 || val > 128)
> >> +		return -EINVAL;
> >> +
> >> +	shift_en =3D val >=3D 16 ? DPS310_TMP_SHIFT_EN : 0;
> >> +	ret =3D regmap_write_bits(data->regmap, DPS310_CFG_REG,
> >> +				DPS310_TMP_SHIFT_EN, shift_en);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
> >> +				  DPS310_TMP_PRC_BITS, DPS310_CALC_PRC(val));
> >> +}
> >> +
> >> +static int dps310_set_temp_samp_freq(struct dps310_data *data, int fr=
eq)
> >> +{
> >> +	u8 val;
> >> +
> >> +	if (freq < 0 || freq > 128)
> >> +		return -EINVAL;
> >> +
> >> +	val =3D DPS310_CALC_RATE(freq) << 4;
> >> +
> >> +	return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
> >> +				  DPS310_TMP_RATE_BITS, val);
> >> +}
> >> +
> >> +static int dps310_get_temp_samp_freq(struct dps310_data *data)
> >> +{
> >> +	int val, r;
> >> +
> >> +	r =3D regmap_read(data->regmap, DPS310_TMP_CFG, &val);
> >> +	if (r < 0)
> >> +		return r;
> >> +
> >> +	return BIT((val & DPS310_TMP_RATE_BITS) >> 4);
> >> +}
> >> +
> >> +static int dps310_get_temp_k(struct dps310_data *data)
> >> +{
> >> +	int r =3D dps310_get_temp_precision(data);
> >> +
> >> +	if (r < 0)
> >> +		return r;
> >> +
> >> +	return scale_factor[DPS310_CALC_PRC(r)];
> >> +}
> >> +
> >> +static int dps310_read_temp(struct dps310_data *data)
> >> +{
> >> +	struct device *dev =3D &data->client->dev;
> >> +	struct regmap *regmap =3D data->regmap;
> >> +	u8 val[3] =3D {0}; =20
> > initialization needed?
> > =20
> >> +	int r, ready;
> >> +	int T_raw;
> >> +
> >> +	r =3D regmap_read(regmap, DPS310_MEAS_CFG, &ready);
> >> +	if (r < 0)
> >> +		return r;
> >> +	if (!(ready & DPS310_TMP_RDY)) {
> >> +		dev_dbg(dev, "temperature not ready\n"); =20
> > most drivers wait for the results to become ready\ =20
>=20
>=20
> OK, this may have to wait up to a second then, since the background=20
> measurement rate can be as low as 1 HZ... I can base the timeout on the=20
> sample rate. Would that be OK?
Yes. I may be that we actually want to pick a my power hungry and faster
default to avoid any stupid userspace programs wondering why they
don't get an answer for 1 second.

>=20
>=20
> > =20
> >> +		return -EAGAIN;
> >> +	}
> >> +
> >> +	r =3D regmap_bulk_read(regmap, DPS310_TMP_BASE, val, 3); =20
> > sizeof(val)
> > =20
> >> +	if (r < 0)
> >> +		return r;
> >> +
> >> +	T_raw =3D (val[0] << 16) | (val[1] << 8) | val[2];
> >> +	data->temp_raw =3D sign_extend32(T_raw, 23);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static bool dps310_is_writeable_reg(struct device *dev, unsigned int =
reg)
> >> +{
> >> +	switch (reg) {
> >> +	case DPS310_PRS_CFG:
> >> +	case DPS310_TMP_CFG:
> >> +	case DPS310_MEAS_CFG:
> >> +	case DPS310_CFG_REG:
> >> +	case DPS310_RESET:
> >> +		return true;
> >> +	default:
> >> +		return false;
> >> +	}
> >> +}
> >> +
> >> +static bool dps310_is_volatile_reg(struct device *dev, unsigned int r=
eg)
> >> +{
> >> +	switch (reg) {
> >> +	case DPS310_PRS_B0:
> >> +	case DPS310_PRS_B1:
> >> +	case DPS310_PRS_B2:
> >> +	case DPS310_TMP_B0:
> >> +	case DPS310_TMP_B1:
> >> +	case DPS310_TMP_B2:
> >> +	case DPS310_MEAS_CFG:
> >> +		return true;
> >> +	default:
> >> +		return false;
> >> +	}
> >> +}
> >> +
> >> +static int dps310_write_raw(struct iio_dev *iio,
> >> +			    struct iio_chan_spec const *chan, int val,
> >> +			    int val2, long mask)
> >> +{
> >> +	struct dps310_data *data =3D iio_priv(iio);
> >> +
> >> +	if (chan->type !=3D IIO_TEMP)
> >> +		return -EINVAL;
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_SAMP_FREQ:
> >> +		return dps310_set_temp_samp_freq(data, val);
> >> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> >> +		return dps310_set_temp_precision(data, val);
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return -EINVAL; =20
> > not needed, dead code
> > =20
> >> +}
> >> +
> >> +static int dps310_read_raw(struct iio_dev *iio,
> >> +			   struct iio_chan_spec const *chan,
> >> +			   int *val, int *val2, long mask)
> >> +{
> >> +	struct dps310_data *data =3D iio_priv(iio);
> >> +	int ret;
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_SAMP_FREQ:
> >> +		*val =3D dps310_get_temp_samp_freq(data);
> >> +		return IIO_VAL_INT;
> >> +
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		ret =3D dps310_read_temp(data);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		*val =3D data->temp_raw * data->c1; =20
> > one could try to avoid the multipliation here and somehow mangle it into
> > _SCALE/_OFFSET =20
>=20
>=20
> Don't think it's worth it? Would have to divide the offset by c1 and=20
> then multiply by c1 again in the scale...

I think you are actually better just reporting as PROCESSED.

>=20
>=20
> > =20
> >> +		return IIO_VAL_INT;
> >> +
> >> +	case IIO_CHAN_INFO_OFFSET:
> >> +		ret =3D dps310_get_temp_k(data);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +
> >> +		*val =3D (data->c0 >> 1) * ret;
> >> +		return IIO_VAL_INT;
> >> +
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		ret =3D dps310_get_temp_k(data);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +
> >> +		*val =3D 1000; /* milliCelsius per Celsius */
> >> +		*val2 =3D ret;
> >> +		return IIO_VAL_FRACTIONAL;
> >> +
> >> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> >> +		*val =3D dps310_get_temp_precision(data);
> >> +		return IIO_VAL_INT;
> >> +
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return -EINVAL; =20
> > not needed, dead code
> > =20
> >> +}
> >> +
> >> +static const struct regmap_config dps310_regmap_config =3D {
> >> +	.reg_bits =3D 8,
> >> +	.val_bits =3D 8,
> >> +	.writeable_reg =3D dps310_is_writeable_reg,
> >> +	.volatile_reg =3D dps310_is_volatile_reg,
> >> +	.cache_type =3D REGCACHE_RBTREE,
> >> +	.max_register =3D 0x29,
> >> +};
> >> +
> >> +static const struct iio_info dps310_info =3D {
> >> +	.read_raw =3D dps310_read_raw,
> >> +	.write_raw =3D dps310_write_raw,
> >> +};
> >> +
> >> +static int dps310_probe(struct i2c_client *client,
> >> +			const struct i2c_device_id *id)
> >> +{
> >> +	struct dps310_data *data;
> >> +	struct iio_dev *iio;
> >> +	int r, ready;
> >> +
> >> +	iio =3D devm_iio_device_alloc(&client->dev,  sizeof(*data));
> >> +	if (!iio)
> >> +		return -ENOMEM;
> >> +
> >> +	data =3D iio_priv(iio);
> >> +	data->client =3D client;
> >> +
> >> +	iio->dev.parent =3D &client->dev;
> >> +	iio->name =3D id->name;
> >> +	iio->channels =3D dps310_channels;
> >> +	iio->num_channels =3D ARRAY_SIZE(dps310_channels);
> >> +	iio->info =3D &dps310_info;
> >> +	iio->modes =3D INDIO_DIRECT_MODE;
> >> +
> >> +	data->regmap =3D devm_regmap_init_i2c(client, &dps310_regmap_config);
> >> +	if (IS_ERR(data->regmap))
> >> +		return PTR_ERR(data->regmap);
> >> +
> >> +	/*
> >> +	 * Set up external (MEMS) temperature sensor in single sample, one
> >> +	 * measurement per second mode
> >> +	 */
> >> +	r =3D regmap_write(data->regmap, DPS310_TMP_CFG,
> >> +			 DPS310_TMP_EXT | DPS310_CALC_RATE(1) |
> >> +			 DPS310_CALC_PRC(1));
> >> +	if (r < 0)
> >> +		goto err;
> >> +
> >> +	/* Temp shift is disabled when PRC <=3D 8 */
> >> +	r =3D regmap_write_bits(data->regmap, DPS310_CFG_REG,
> >> +			      DPS310_TMP_SHIFT_EN, 0);
> >> +	if (r < 0)
> >> +		goto err;
> >> +
> >> +	/* Turn on temperature measurement in the background */
> >> +	r =3D regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> >> +			      DPS310_MEAS_CTRL_BITS,
> >> +			      DPS310_TEMP_EN | DPS310_BACKGROUND);
> >> +	if (r < 0)
> >> +		goto err;
> >> +
> >> +	/*
> >> +	 * Calibration coefficients required for reporting temperature.
> >> +	 * They are available 40ms after the device has started
> >> +	 */
> >> +	r =3D regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> >> +				     ready & DPS310_COEF_RDY, 10000, 40000);
> >> +	if (r < 0)
> >> +		goto err;
> >> +
> >> +	r =3D dps310_get_temp_coef(data);
> >> +	if (r < 0)
> >> +		goto err;
> >> +
> >> +	r =3D devm_iio_device_register(&client->dev, iio);
> >> +	if (r)
> >> +		goto err;
> >> +
> >> +	i2c_set_clientdata(client, iio);
> >> +
> >> +	dev_info(&client->dev, "%s: sensor '%s'\n", dev_name(&iio->dev),
> >> +		 client->name); =20
> > don't clutter the log
> > =20
> >> +
> >> +	return 0;
> >> +
> >> +err:
> >> +	regmap_write(data->regmap, DPS310_RESET, DPS310_RESET_MAGIC);
> >> +	return r;
> >> +}
> >> +
> >> +static int dps310_remove(struct i2c_client *client)
> >> +{
> >> +	struct dps310_data *data =3D i2c_get_clientdata(client);
> >> +
> >> +	return regmap_write(data->regmap, DPS310_RESET, DPS310_RESET_MAGIC);
> >> +}
> >> +
> >> +static const struct i2c_device_id dps310_id[] =3D {
> >> +	{ "dps310", 0 },
> >> +	{}
> >> +};
> >> +MODULE_DEVICE_TABLE(i2c, dps310_id);
> >> +
> >> +static const unsigned short normal_i2c[] =3D {
> >> +	0x77, 0x76, I2C_CLIENT_END
> >> +};
> >> +
> >> +static struct i2c_driver dps310_driver =3D {
> >> +	.driver =3D {
> >> +		.name =3D "dps310",
> >> +	},
> >> +	.probe =3D dps310_probe,
> >> +	.remove =3D dps310_remove,
> >> +	.address_list =3D normal_i2c,
> >> +	.id_table =3D dps310_id,
> >> +};
> >> +module_i2c_driver(dps310_driver);
> >> +
> >> +MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
> >> +MODULE_DESCRIPTION("Infineon DPS310 pressure and temperature sensor");
> >> +MODULE_LICENSE("GPL v2");
> >> =20
>=20

