Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD18B1AF2F1
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 19:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDRRyV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 13:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgDRRyV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 13:54:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA89221D6C;
        Sat, 18 Apr 2020 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587232458;
        bh=ZXo55fd+Qj3Xus0usE9CEaVr3NnnYMOSpYAG3NCIwCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tPkUcGcQ6klmKArM50+s5SgWJXCLj4DzizbZE5s2ghoTXkNL/ih+n2eF2d6KqP4v+
         a9xWSzxNEd+lDnn4abvFs46qXKsL4sNgFCLO65fZVZlg5cZl+aG7kvHffoyJiNwwWe
         X2KamEScD28TV6v3A3yn0a/qwaddCQbBnr9esEik=
Date:   Sat, 18 Apr 2020 18:54:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: accel: Add driver for wsen-itds accelerometer
 sensor
Message-ID: <20200418185413.07f13afc@archlinux>
In-Reply-To: <20200415065535.7753-4-saravanan@linumiz.com>
References: <20200415065535.7753-1-saravanan@linumiz.com>
        <20200415065535.7753-4-saravanan@linumiz.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Apr 2020 08:55:34 +0200
Saravanan Sekar <saravanan@linumiz.com> wrote:

> Add an iio driver for the wurth elektronic wsen-itds 3-axis accelerometer.
> The driver supports the acceleration, temperature data reading and
> supports configuring of output data rate, operating mode and scale.
>=20
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>

There is a bunch of non standard looking ABI in here.  Without documentation
it is hard to review that (and docs are required anyway!)

Note that any new ABI that doesn't have good defaults is pretty much breaki=
ng
all existing userspace code. So if at all possible don't introduce any.
Sometimes that's a case of picking a sensible option for most usecase
and ignoring the many fun features of a device that no-one will use.
Sometimes it's a question of mapping to existing ABI if at all possible.

Various other comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/Kconfig     |  14 +
>  drivers/iio/accel/Makefile    |   1 +
>  drivers/iio/accel/wsen-itds.c | 978 ++++++++++++++++++++++++++++++++++
>  3 files changed, 993 insertions(+)
>  create mode 100644 drivers/iio/accel/wsen-itds.c
>=20
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 5d91a6dda894..9fbefc94e33e 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -450,4 +450,18 @@ config STK8BA50
>  	  Choosing M will build the driver as a module. If so, the module
>  	  will be called stk8ba50.
> =20
> +config WSEN_ITDS
> +	tristate "Wurth Elektronik WSEN-ITDS 3-Axis Accelerometer Driver"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to build support for the WSEN-ITDS 3-axis
> +	  accelerometer.
> +
> +	  The sensor provies 3-axis Acceleration, Tempreature data and
> +	  application specific features like tap, 6D Orinetation, Free-fall
> +	  Motion, Activity etc
> +
>  endmenu
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 3a051cf37f40..942cab3e1d16 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -61,3 +61,4 @@ st_accel-$(CONFIG_IIO_BUFFER) +=3D st_accel_buffer.o
> =20
>  obj-$(CONFIG_IIO_ST_ACCEL_I2C_3AXIS) +=3D st_accel_i2c.o
>  obj-$(CONFIG_IIO_ST_ACCEL_SPI_3AXIS) +=3D st_accel_spi.o
> +obj-$(CONFIG_WSEN_ITDS) +=3D wsen-itds.o
> diff --git a/drivers/iio/accel/wsen-itds.c b/drivers/iio/accel/wsen-itds.c
> new file mode 100644
> index 000000000000..0846fb28a1b9
> --- /dev/null
> +++ b/drivers/iio/accel/wsen-itds.c
> @@ -0,0 +1,978 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * WSEN-ITDS 3-axis accel sensor driver
> + *
> + * Copyright 2020 Linumiz
> + *
> + * Author: Saravanan Sekar <saravanan@linumiz.com>
> + *
> + * TODO : events - 6D, Orientation, Free-fall, Tap, Motion
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +#define	ITDS_REG_TEMP_L			0x0d
> +#define	ITDS_REG_DEV_ID			0x0f
> +#define	ITDS_REG_CTRL1			0x20
> +#define	ITDS_REG_CTRL2			0x21
> +#define	ITDS_REG_CTRL3			0x22
> +#define	ITDS_REG_CTRL4			0x23
> +#define	ITDS_REG_CTRL5			0x24
> +#define	ITDS_REG_CTRL6			0x25
> +#define	ITDS_REG_STATUS			0x27
> +#define	ITDS_REG_X_OUT_L		0x28
> +#define	ITDS_REG_Y_OUT_L		0x2a
> +#define	ITDS_REG_Z_OUT_L		0x2c
> +#define	ITDS_REG_FIFO_CTRL		0x2e
> +#define	ITDS_REG_FIFO_SAMPLES		0x2f
> +#define	ITDS_REG_STATUS_DETECT		0x37
> +#define	ITDS_REG_WAKEUP_EVENT		0x38
> +#define	ITDS_REG_CTRL7			0x3f
> +
> +#define	ITDS_MASK_SCALE			GENMASK(5, 4)
> +#define	ITDS_MASK_BDU_INC_ADD		GENMASK(3, 2)
> +#define	ITDS_MASK_FIFOTH		GENMASK(4, 0)
> +#define	ITDS_MASK_FIFOMODE		GENMASK(7, 5)
> +#define	ITDS_MASK_MODE			GENMASK(3, 0)
> +#define	ITDS_MASK_SAMPLES_COUNT		GENMASK(5, 0)
> +#define	ITDS_MASK_ODR			GENMASK(7, 4)
> +#define	ITDS_MASK_INT_DRDY		BIT(0)
> +#define	ITDS_MASK_INT_FIFOTH		BIT(1)
> +#define	ITDS_MASK_INT_EN		BIT(5)
> +
> +#define	ITDS_EVENT_DRDY			BIT(0)
> +#define	ITDS_EVENT_DRDY_T		BIT(6)
> +#define	ITDS_EVENT_FIFO_TH		BIT(7)
> +#define	ITDS_DEVICE_ID			0x44
> +#define	ITDS_ACCL_FIFO_SIZE		32
> +
> +#define ITDS_ACC_CHAN(_axis, _idx) {					\
> +	.type =3D IIO_ACCEL,						\
> +	.modified =3D 1,							\
> +	.channel2 =3D IIO_MOD_##_axis,					\
> +	.scan_index =3D _idx,						\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +				BIT(IIO_CHAN_INFO_SCALE),		\
> +	.scan_type =3D {							\
> +		.sign =3D 's',						\
> +		.realbits =3D 14,						\
> +		.storagebits =3D 16,					\
> +		.shift =3D 2,						\
> +		.endianness =3D IIO_LE,					\
> +	},								\
> +}
> +
> +enum itds_operating_mode {
> +	ITDS_MODE_LOW_POWER,
> +	ITDS_MODE_NORMAL =3D BIT(0),
> +	ITDS_MODE_HIGH_PERFORMANCE =3D BIT(1),
> +	ITDS_MODE_SINGLE_SHOT =3D BIT(2),
> +	ITDS_MODE_INVALID =3D 4

INVALID is the same as SINGLE_SHOT BIT(2) =3D=3D 4

Why is this a bitmap anyway?  You can't take more than one value
at a time I think?
> +};
> +
> +enum itds_fifo_mode {
> +	ITDS_MODE_BYPASS,
> +	ITDS_MODE_FIFO,
> +	ITDS_MODE_CONTINUES,
> +	ITDS_MODE_CONTINUES_TO_FIFO,
> +	ITDS_MODE_BYPASS_TO_CONTINUES,

Some of these have no standard representation in IIO. I would not
support them in initial driver.  If there are real usecases we can
work out later how to provide generic interfaces for them.

> +	ITDS_MODE_END
> +};
> +
> +struct itds_info {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct iio_trigger *trig;
> +	struct regulator *vdd_supply;
> +	struct regulator *vddio_supply;
> +	unsigned int scale;
> +	enum itds_operating_mode op_mode;
> +	enum itds_fifo_mode fifo_mode;
> +	struct mutex mutex;

All locks need documentation of what they are specifically protecting.

> +	int64_t timestamp;
> +	u8 fifo_threshold;
> +	bool is_hwfifo_enabled;
> +};
> +
> +struct itds_samp_freq {
> +	int val;
> +	int val2;
> +};
> +
> +struct itds_fifo_modes {
> +	char *str;
> +	int rval;
> +};
> +
> +static const char *operating_mode[ITDS_MODE_INVALID] =3D {
> +	"lowpower",
> +	"normal",
> +	"high_perf",
> +	"single_shot"

All of these should be implicit rather than directly controlled.
It will be a bit fiddly and you will fail to expose some of the
subtle nature fo the tradeoffs, but on the plus side userspace
can take advantage of the driver without having the user know=20
exactly what the datasheet says.

> +};
> +
> +static const struct itds_samp_freq sample_freq[][10] =3D {

prefix sample_freq.  That could easily turn up in a header and cause
us trouble sometime in the future.

> +	{
> +		{0}, {1, 600000}, {12, 500000}, {25}, {50},
> +		{100}, {200}, {200}, {200}, {200}

0 is a bit pointless - I'd not expose that at all.
Also not a lot of point in exposing the multiple 200's .

> +	},
> +
> +	/* high performance mode */
> +	{

Is there an advantage in going to high performance mode for
less than 400?  Seems noise is better from datasheet but
at cost of some power.  You may want to expose less of
these subtle features in order to get a useable driver.
Perhaps so optional hint controls could be used to allow
the really interested to tweak the balance between power
and noise where the frequencies overlap.

> +		{0}, {12, 500000}, {12, 500000}, {25}, {50},
> +		{100}, {200}, {400}, {800}, {1600}
> +	}
> +};
> +
> +static const unsigned long itds_scan_masks[] =3D {0x7, 0};
> +
> +/* 2g, 4g, 8g, 16g */
> +unsigned int sensitivity_scale[][4] =3D {
> +	{976, 1952, 3904, 7808},
> +
> +	/* high performance mode */
> +	{244, 488, 976, 1952}
> +};
> +
> +static const struct iio_chan_spec itds_channels[] =3D {
> +	ITDS_ACC_CHAN(X, 0),
> +	ITDS_ACC_CHAN(Y, 1),
> +	ITDS_ACC_CHAN(Z, 2),
> +	{
> +		.type =3D IIO_TEMP,
> +		.scan_index =3D 3,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
> +				 BIT(IIO_CHAN_INFO_OFFSET),
> +	}
> +};
> +
> +static struct itds_fifo_modes fifo_modes[ITDS_MODE_END] =3D {

No userspace is going to have a clue how to set these. You need to
link them in some fashion to standard concepts in IIO.

> +	{"bypass", 0},
> +	{"fifo", 1},
> +	{"continues", 3},
> +	{"continues_fifo", 4},
> +	{"bypass_continues", 6},
> +};
> +
> +static struct regmap_config itds_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D 0x3f,
> +};
> +
> +static ssize_t itds_accel_scale_avail(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	int len =3D 0, i;
> +	bool mode;
> +
> +	mode =3D !!(info->op_mode & ITDS_MODE_HIGH_PERFORMANCE);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(sensitivity_scale[0]); i++)
> +		len +=3D sprintf(buf + len, "%d ", sensitivity_scale[mode][i]);
> +
> +	buf[len - 1] =3D '\n';
> +
> +	return len;
> +}
> +
> +static ssize_t itds_samp_freq_avail(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	int len =3D 0, i;
> +	bool mode;
> +
> +	mode =3D !!(info->op_mode & ITDS_MODE_HIGH_PERFORMANCE);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(sample_freq[0]); i++) {
> +		len +=3D sprintf(buf + len, "%d.%d ", sample_freq[mode][i].val,
> +					 sample_freq[mode][i].val2);
> +	}
> +	buf[len - 1] =3D '\n';
> +
> +	return len;
> +}
> +
> +static int itds_get_temp(struct itds_info *info, int *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +	__le16 rval;
> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_STATUS_DETECT, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (!(regval & ITDS_EVENT_DRDY_T))
> +		return -EAGAIN;
> +
> +	ret =3D regmap_bulk_read(info->regmap, ITDS_REG_TEMP_L,
> +				   &rval, sizeof(rval));
> +	if (ret) {
> +		dev_err(info->dev, "failed to read TEMP reg\n");
> +		return ret;
> +	}
> +
> +	rval  =3D rval >> 4;
> +	regval =3D sign_extend32(le16_to_cpu(rval), 11);
> +	*val =3D regval * 625;

This already got comment on but should be fine as a scale value and
actually return the raw value.

> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int itds_get_accel(struct itds_info *info,
> +			  const struct iio_chan_spec *chan,
> +			  int *val)
> +{
> +	unsigned int regval;
> +	int reg, ret;
> +	__le16 rval;
> +
> +	if (info->is_hwfifo_enabled)
> +		return -EBUSY;

Given you enable the fifo along with the buffer a simple
iio_device_claim_direct_mode will give you race free protection
of this.

> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_STATUS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (!(regval & ITDS_EVENT_DRDY))
> +		return -EAGAIN;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg =3D ITDS_REG_X_OUT_L;
> +		break;
> +	case IIO_MOD_Y:
> +		reg =3D ITDS_REG_Y_OUT_L;
> +		break;
> +	case IIO_MOD_Z:
> +		reg =3D ITDS_REG_Z_OUT_L;
> +		break;
> +	default:
> +		dev_err(info->dev, "invalid axis modifier\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D regmap_bulk_read(info->regmap, reg, &rval, sizeof(rval));

bulk_read into a non dma safe buffer is a bad idea.  May
be fine on your platform but there are all sorts of fun hardware
types out that this will break.

> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&info->mutex);
> +
> +	if (info->op_mode & ITDS_MODE_HIGH_PERFORMANCE ||
> +	    info->op_mode & ITDS_MODE_NORMAL) {
> +		rval =3D rval >> chan->scan_type.shift;
> +		*val =3D sign_extend32(le16_to_cpu(rval),
> +				     chan->scan_type.realbits - 1);
> +	} else {
> +		rval =3D rval >> (chan->scan_type.shift + 2);
> +		*val =3D sign_extend32(le16_to_cpu(rval),
> +				     chan->scan_type.realbits - 3);
> +	}
> +
> +	mutex_unlock(&info->mutex);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int itds_set_odr(struct itds_info *info, int val, int val2)
> +{
> +	int ret, i;
> +	bool mode;
> +
> +	mode =3D !!(info->op_mode & ITDS_MODE_HIGH_PERFORMANCE);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(sample_freq[0]); i++) {
> +		if ((val =3D=3D sample_freq[mode][i].val) &&
> +		    (val2 =3D=3D sample_freq[mode][i].val2)) {
> +
> +			ret =3D regmap_update_bits(info->regmap, ITDS_REG_CTRL1,
> +						 ITDS_MASK_ODR, i << 4);
> +			return ret;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int itds_get_odr(struct itds_info *info, int *val, int *val2)
> +{
> +	int ret;
> +	unsigned int rval;
> +	bool mode;
> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_CTRL1, &rval);
> +	if (ret)
> +		return ret;
> +
> +	rval =3D (rval & ITDS_MASK_ODR) >> 4;
> +	mode =3D !!(info->op_mode & ITDS_MODE_HIGH_PERFORMANCE);
> +	*val =3D sample_freq[mode][rval].val;
> +	*val2 =3D sample_freq[mode][rval].val2;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int itds_set_scale(struct itds_info *info, int val)
> +{
> +	int i, ret =3D -EINVAL;
> +	bool mode;
> +
> +	mutex_lock(&info->mutex);
> +	mode =3D !!(info->op_mode & ITDS_MODE_HIGH_PERFORMANCE);
> +	for (i =3D 0; i < ARRAY_SIZE(sensitivity_scale[0]); i++) {
> +		if (val =3D=3D sensitivity_scale[mode][i])
> +			break;
> +	}
> +
> +	if (i =3D=3D ARRAY_SIZE(sensitivity_scale[0]))
> +		goto ret_unlock;
> +
> +	ret =3D regmap_update_bits(info->regmap, ITDS_REG_CTRL6,
> +				 ITDS_MASK_SCALE, i << 4);
> +	if (ret)
> +		goto ret_unlock;
> +
> +	info->scale =3D 1000 * sensitivity_scale[mode][i];
> +
> +ret_unlock:
> +	mutex_unlock(&info->mutex);
> +	return ret;
> +}
> +
> +static int itds_get_scale(struct itds_info *info)
> +{
> +	int ret;
> +	unsigned int rval;
> +	bool mode;
> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_CTRL6, &rval);
> +	if (ret)
> +		return ret;
> +
> +	rval =3D (rval & ITDS_MASK_SCALE) >> 4;
> +	mode =3D !!(info->op_mode & ITDS_MODE_HIGH_PERFORMANCE);
> +	info->scale =3D 1000 * sensitivity_scale[mode][rval];
> +
> +	return 0;
> +}
> +
> +int itds_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	unsigned int enable;
> +	int ret;
> +
> +	enable =3D state ? ITDS_MASK_INT_EN : 0;
> +	ret =3D regmap_update_bits(info->regmap, ITDS_REG_CTRL7,
> +				 ITDS_MASK_INT_EN, enable);

Enabling and disabling global interrupts seems like a bad idea.  Perhaps
just fiddle with the mask to make this more adaptable as you add
more of the interrupt types?

> +	if (ret)
> +		dev_err(info->dev, "interrupt en/dis fail %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int itds_fifo_flush(struct iio_dev *indio_dev, unsigned int count)
> +{
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	struct device *dev =3D info->dev;
> +	unsigned int rval;
> +	int ret, i;
> +	/* 3x16 bits data + timestamp 64 bits */

Timestamp needs to be 64 bit aligned...

> +	__le16 buffer[7];
> +	u8 samples;
> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_FIFO_SAMPLES, &rval);
> +	if (ret < 0) {
> +		dev_err(dev, "FIFO count err %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!(rval & ITDS_EVENT_FIFO_TH))
> +		return 0;
> +
> +	samples =3D rval & ITDS_MASK_SAMPLES_COUNT;
> +	if (!count)
> +		return 0;
> +
> +	samples =3D samples < count ? samples : count;
> +	for (i =3D 0; i < samples; i++) {
> +		ret =3D regmap_raw_read(info->regmap, ITDS_REG_X_OUT_L,
> +				      buffer, 3 * sizeof(u16));

Doing a raw_read means your buffer needs to be DMA safe (for spi)
It's not.

Look at the __cacheline_aligned tricks used in other drivers.
Note there is no generally safe way to do DMA to the stack so
don't.


> +		if (ret)
> +			return i;
> +
> +		iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +						   info->timestamp);

The problem here is that timestamp is going to be wrong for any but the
sample that resulted in the interrupt.=20

If you are running off the dataready trigger then you 'should' only get
one sample here as long at the capture is keeping up.  For other
modes you can either not report the timestamp at all, or do some
approximation of working it out. There are various drivers doing this
with various levels of attempting to smooth the numbers out.


> +	}
> +
> +	return samples;
> +}
> +
> +static ssize_t itds_accel_get_fifo_threshold(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	int wm;
> +
> +	mutex_lock(&info->mutex);
> +	wm =3D info->fifo_threshold;
> +	mutex_unlock(&info->mutex);
> +
> +	return sprintf(buf, "%d\n", wm);
> +}
> +
> +static int itds_accel_set_fifo_threshold(struct iio_dev *indio_dev,
> +					 unsigned int val)
> +{
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +
> +	if (val >=3D ITDS_ACCL_FIFO_SIZE)
> +		val =3D ITDS_ACCL_FIFO_SIZE - 1;
> +
> +	mutex_lock(&info->mutex);
> +	info->fifo_threshold =3D val;
> +	mutex_unlock(&info->mutex);
> +
> +	return 0;
> +}
> +
> +static ssize_t itds_accel_set_fifo_mode(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t count)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	int i;
> +
> +	mutex_lock(&info->mutex);
> +
> +	for (i =3D 0; i < ITDS_MODE_END; i++) {
> +		if (!strcmp(buf, fifo_modes[i].str)) {
> +			info->fifo_mode =3D i;
> +			goto ret_unlock;
> +		}
> +	}
> +	count =3D -EINVAL;
> +
> +ret_unlock:
> +	mutex_unlock(&info->mutex);
> +	return count;
> +}
> +
> +static ssize_t itds_accel_get_fifo_mode(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	int mode;
> +
> +	mutex_lock(&info->mutex);
> +	mode =3D info->fifo_mode;
> +	mutex_unlock(&info->mutex);
> +
> +	return sprintf(buf, "%s\n", fifo_modes[mode].str);
> +}
> +
> +static int itds_set_operating_mode(struct itds_info *info,
> +				enum itds_operating_mode mode)
> +{
> +	int ret;
> +
> +	ret =3D regmap_update_bits(info->regmap, ITDS_REG_CTRL1,
> +				 ITDS_MASK_MODE, 1 << mode);
> +	if (!ret) {
> +		info->op_mode =3D mode;
> +
> +		/* update scale according to new operating mode */
> +		itds_get_scale(info);
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t itds_accel_set_operating_mode(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf,
> +					     size_t count)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	int ret =3D -EINVAL;
> +	int i;
> +
> +	mutex_lock(&info->mutex);
> +
> +	for (i =3D 0; i < ITDS_MODE_INVALID; i++) {
> +		if (!strcmp(buf, operating_mode[i])) {
> +			ret =3D itds_set_operating_mode(info, i);
> +			if (!ret)
> +				ret =3D count;
> +
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&info->mutex);
> +	return ret;
> +}
> +
> +static ssize_t itds_accel_get_operating_mode(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	int mode;
> +
> +	mutex_lock(&info->mutex);
> +	mode =3D info->op_mode;
> +	mutex_unlock(&info->mutex);
> +
> +	return sprintf(buf, "%s\n", operating_mode[mode]);
> +}
> +
> +static ssize_t itds_accel_get_fifo_state(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	bool is_enabled;
> +
> +	mutex_lock(&info->mutex);
> +	is_enabled =3D info->is_hwfifo_enabled;
> +	mutex_unlock(&info->mutex);
> +
> +	return sprintf(buf, "%d\n", is_enabled);
> +}
> +
> +static IIO_CONST_ATTR(hwfifo_threshold_min, "1");
> +static IIO_CONST_ATTR(hwfifo_threshold_max, __stringify(ITDS_ACCL_FIFO_S=
IZE));
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +		       itds_accel_get_fifo_state, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_threshold, 0444,
> +		       itds_accel_get_fifo_threshold, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_mode, 0644, itds_accel_get_fifo_mode,
> +			itds_accel_set_fifo_mode, 0);
> +static IIO_DEVICE_ATTR(operating_mode, 0644, itds_accel_get_operating_mo=
de,
> +		       itds_accel_set_operating_mode, 0);

This is not standard ABI, so to even discuss this properly we need ABI docs
in Documentation/ABI/testing/sysfs-bus-iio-wsen-itds


> +static IIO_DEVICE_ATTR(in_accel_samp_freq_available, 0444,
> +		       itds_samp_freq_avail, NULL, 0);
> +static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
> +		       itds_accel_scale_avail, NULL, 0);
> +
> +static struct attribute *itds_accel_fifo_attributes[] =3D {
> +	&iio_const_attr_hwfifo_threshold_min.dev_attr.attr,
> +	&iio_const_attr_hwfifo_threshold_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_threshold.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_mode.dev_attr.attr,
> +	&iio_dev_attr_operating_mode.dev_attr.attr,
> +	&iio_dev_attr_in_accel_samp_freq_available.dev_attr.attr,
> +	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group itds_attrs_group =3D {
> +	.attrs =3D itds_accel_fifo_attributes,
> +};
> +
> +static irqreturn_t itds_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +
> +	if (info->is_hwfifo_enabled)
> +		itds_fifo_flush(indio_dev, ITDS_ACCL_FIFO_SIZE);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t itds_accel_irq_thread_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	unsigned int rval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_STATUS, &rval);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	if (rval & ITDS_EVENT_FIFO_TH)
> +		iio_trigger_poll_chained(info->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t itds_accel_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +
> +	if (info->is_hwfifo_enabled) {
> +		info->timestamp =3D iio_get_time_ns(indio_dev);

Note this trigger 'may' be used by other devices

> +		return IRQ_WAKE_THREAD;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int itds_accel_buffer_postdisable(struct iio_dev *indio_dev)

Something is missbalanced as postdisable should undo what happens
in preenable not postenable as I think it does here.

> +{
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +
> +	if (!info->is_hwfifo_enabled)
> +		return 0;

I'm fairly sure you can't get here without that being true..

> +
> +	regmap_update_bits(info->regmap, ITDS_REG_FIFO_CTRL,
> +				 ITDS_MASK_FIFOTH | ITDS_MASK_FIFOMODE, 0);
> +	regmap_update_bits(info->regmap, ITDS_REG_CTRL4,
> +				 ITDS_MASK_INT_FIFOTH, 0);
> +
> +	info->is_hwfifo_enabled =3D false;
> +
> +	return 0;
> +}
> +
> +static int itds_accel_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	unsigned int rval;
> +	int ret =3D 0;

Always set so no need to initialize.

> +
> +	if (info->is_hwfifo_enabled)

Given this is function is only path that can cause that to happen
it looks to me like you can't get here with it being true.

> +		return 0;
> +
> +	if (!info->fifo_mode)
> +		return -EINVAL;
> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_CTRL1, &rval);
> +	if (ret)
> +		return ret;
> +
> +	if (!(rval & ITDS_MASK_ODR))
> +		return -EINVAL;
> +
> +	ret =3D regmap_update_bits(info->regmap, ITDS_REG_FIFO_CTRL,
> +				 ITDS_MASK_FIFOTH, info->fifo_threshold);
> +	if (ret)
> +		goto out_err;
> +
> +	ret =3D regmap_update_bits(info->regmap, ITDS_REG_FIFO_CTRL,
> +				 ITDS_MASK_FIFOMODE,
> +				 fifo_modes[info->fifo_mode].rval << 5);
> +	if (ret)
> +		goto out_err;
> +
> +	info->is_hwfifo_enabled =3D true;
> +	ret =3D regmap_update_bits(info->regmap, ITDS_REG_CTRL4,
> +				 ITDS_MASK_INT_FIFOTH,
> +				 ITDS_MASK_INT_FIFOTH);
> +	if (ret)
> +		goto disable_fifo;
> +
> +	if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED)
> +		iio_triggered_buffer_postenable(indio_dev);
> +
> +	return 0;
> +
> +disable_fifo:
> +	regmap_update_bits(info->regmap, ITDS_REG_FIFO_CTRL,
> +				 ITDS_MASK_FIFOTH | ITDS_MASK_FIFOMODE, 0);
> +
> +out_err:
> +	return ret;
> +}
> +
> +static int itds_read_raw(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan, int *val,
> +			 int *val2, long mask)
> +{
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type =3D=3D IIO_ACCEL)
> +			ret =3D itds_get_accel(info, chan, val);
> +		else
> +			ret =3D itds_get_temp(info, val);
> +		return ret;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 0;
> +		if (chan->type =3D=3D IIO_ACCEL)
> +			*val2 =3D info->scale;
> +		else
> +			*val2 =3D 100;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret =3D itds_get_odr(info, val, val2);
> +		return ret;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type =3D=3D IIO_TEMP)
> +			*val =3D 250000;
> +		else
> +			*val =3D 0;

If there is no offset we shouldn't expose the attribute in sysfs.
Hence this is probably an error path..

> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int itds_write_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int val, int val2, long mask)
> +{
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return itds_set_odr(info, val, val2);
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		return itds_set_scale(info, val);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_trigger_ops itds_trigger_ops =3D {
> +	.set_trigger_state =3D itds_set_trigger_state,
> +};
> +
> +static const struct iio_buffer_setup_ops itds_accel_buffer_ops =3D {
> +	.postenable =3D itds_accel_buffer_postenable,
> +	.predisable =3D iio_triggered_buffer_predisable,
> +	.postdisable =3D itds_accel_buffer_postdisable,
> +};
> +
> +static const struct iio_info itds_accel_info =3D {
> +	.attrs			=3D &itds_attrs_group,
> +	.read_raw		=3D itds_read_raw,
> +	.write_raw		=3D itds_write_raw,
> +	.hwfifo_flush_to_buffer =3D itds_fifo_flush,
> +	.hwfifo_set_watermark	=3D itds_accel_set_fifo_threshold,
> +};
> +
> +static int itds_probe(struct i2c_client *client, const struct i2c_device=
_id *id)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct itds_info *info;
> +	struct regmap *regmap;
> +	unsigned int rval;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap =3D devm_regmap_init_i2c(client, &itds_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "Failed to allocate regmap!\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	info =3D iio_priv(indio_dev);
> +	info->regmap =3D regmap;
> +	info->dev =3D dev;
> +	i2c_set_clientdata(client, indio_dev);
> +	mutex_init(&info->mutex);
> +
> +	info->vdd_supply =3D devm_regulator_get_optional(dev, "vdd");
> +	info->vddio_supply =3D devm_regulator_get_optional(dev, "vddio");

Not the aren't optional.  You may not have specified them (in which case
the regulator framework will provide stubs on the assumption they are
connected but just not described),  but if the thing has no power it has
no power.

> +
> +	if (!IS_ERR_OR_NULL(info->vdd_supply) &&
> +	    !IS_ERR_OR_NULL(info->vddio_supply)) {
> +
> +		ret =3D regulator_set_voltage(info->vdd_supply, 1700000, 3600000);
> +		if (ret)
> +			goto out_err;
> +
> +		ret =3D regulator_set_voltage(info->vddio_supply,
> +						 1200000, 3700000);

Ah. This is why you are being very protective of your regulators.
They are stubbed out if regulator framework isn't built (return 0)

Now if they are simply not specified then I'm not totally sure what
happens.  I suspect simply dropping them from here and relying on
valid configuration is the best plan.

> +		if (ret)
> +			goto out_err;
> +
> +		ret =3D regulator_enable(info->vdd_supply);

Enable is fine for a stub regulator (it's a noop) so these don't need
protecting.

> +		if (ret) {
> +			dev_err(dev, "Failed to enable vdd: %d\n", ret);
> +			goto out_err;
> +		}
> +
> +		ret =3D regulator_enable(info->vddio_supply);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable vddio: %d\n", ret);
> +			goto out_disable_vdd;
> +		}
> +
> +		/* chip boot sequence takes 20ms */
> +		usleep_range(20000, 21000);
> +	}
> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_DEV_ID, &rval);
> +	if (ret && (rval !=3D ITDS_DEVICE_ID)) {
> +		dev_info(dev, "err %d device id %X not matched\n", ret, rval);
> +		goto out_disable_vddio;
> +	}
> +
> +	ret =3D regmap_update_bits(info->regmap, ITDS_REG_CTRL2,
> +				 ITDS_MASK_BDU_INC_ADD, ITDS_MASK_BDU_INC_ADD);
> +	if (ret) {
> +		dev_err(dev, "unable to set block data update!\n");
> +		goto out_disable_vddio;
> +	}
> +
> +	ret =3D regmap_update_bits(info->regmap, ITDS_REG_WAKEUP_EVENT, 0xff, 0=
);
> +	if (ret) {
> +		dev_err(dev, "disable wakeup event fail!\n");
> +		goto out_disable_vddio;
> +	}
> +
> +	indio_dev->name =3D dev_name(dev);
> +	indio_dev->dev.parent =3D dev;
> +	indio_dev->channels =3D itds_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(itds_channels);
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->available_scan_masks =3D itds_scan_masks;
> +	indio_dev->info =3D &itds_accel_info;
> +
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      NULL,
> +					      itds_trigger_handler,
> +					      &itds_accel_buffer_ops);
> +	if (ret) {
> +		dev_err(dev, "unable to setup iio triggered buffer\n");
> +		goto out_disable_vddio;
> +	}
> +
> +	if (client->irq > 0) {
> +		ret =3D devm_request_threaded_irq(dev, client->irq,
> +						itds_accel_irq_handler,
> +						itds_accel_irq_thread_handler,
> +						IRQF_TRIGGER_RISING,
> +						"itds_event", indio_dev);
> +		if (ret) {
> +			dev_err(dev, "unable to request IRQ\n");
> +			goto out_disable_vddio;
> +		}
> +
> +		info->trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d",
> +					indio_dev->name, indio_dev->id);
> +		if (!info->trig) {
> +			ret =3D -ENOMEM;
> +			goto out_disable_vddio;
> +		}
> +
> +		info->trig->dev.parent =3D dev;
> +		info->trig->ops =3D &itds_trigger_ops;
> +		iio_trigger_set_drvdata(info->trig, indio_dev);
> +		indio_dev->trig =3D iio_trigger_get(info->trig);
> +
> +		ret =3D devm_iio_trigger_register(dev, info->trig);
> +		if (ret)
> +			goto out_disable_vddio;
> +	}
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "IIO device register fail: %d\n", ret);
> +		goto out_disable_vddio;
> +	}
> +
> +	dev_set_drvdata(dev, indio_dev);

You set clientdata above which I believe boils down to the same thing.

> +
> +	return 0;
> +
> +out_disable_vddio:
> +	if (!IS_ERR_OR_NULL(info->vddio_supply))

As below. there is no means of getting here where that condition matters
and it isn't safe to call regulator_disable (unless you have a bug :)

> +		regulator_disable(info->vddio_supply);
> +
> +out_disable_vdd:
> +	if (!IS_ERR_OR_NULL(info->vdd_supply))
> +		regulator_disable(info->vdd_supply);
> +
> +out_err:

No point in an gotos to here, just return directly where they occur.

> +	return ret;
> +}
> +
> +static int itds_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +
This immediately tells me you have a race condition.  The user interface
is removed when iio_device_register is unwound.  That happens 'after'
the end of remove when the managed cleanup occurs.  Hence you've turned
the power off but may still get reads from userspace.

You can't mix things that use managed cleanup with those that don't.
So 2 options.

Either call iio_device_register and then call iio_device_unregister at the
start of remove.. Or use devm_add_action_or_reset to add handlers for the
3 actions you need to do in remove immediately after their partner action
is done in probe.  Then you can get rid of the remove function entirely
and everything will be unwound automatically.

> +	regmap_update_bits(info->regmap, ITDS_REG_CTRL1, ITDS_MASK_MODE, 0);
> +	if (!IS_ERR_OR_NULL(info->vdd_supply))
> +		regulator_disable(info->vdd_supply);

There should be no way of getting here that need that IS_ERR_OR_NULL protec=
tion.
Either:
1) you have regulators built in which case even without one being specified=
 you'll
get a stub regulator and all will be fine.
2) you don't have regulators built in which case regulator_disable is a no-=
op
and it won't matter if you call it.
3) regulator is there and correctly enabled in which case you obviously want
to call the disable.

> +
> +	if (!IS_ERR_OR_NULL(info->vddio_supply))
> +		regulator_disable(info->vddio_supply);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id itds_of_match[] =3D {
> +	{ .compatible =3D "we,wsen-itds"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, itds_of_match);
> +
> +static const struct i2c_device_id itds_id[] =3D {
> +	{ "wsen-itds", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, itds_id);
> +
> +static struct i2c_driver itds_driver =3D {
> +	.driver =3D {
> +		.name =3D "wsen-itds",
> +		.of_match_table =3D of_match_ptr(itds_of_match),

Don't use of_patch_ptr - it prevents ACPI PRP0001 and to do
it you would need ifdef protections on the table
https://www.kernel.org/doc/html/latest/firmware-guide/acpi/enumeration.html=
?highlight=3DPRP0001


		.of_match_table =3D itds_of_match, is fine.

> +	},
> +	.probe		=3D itds_probe,
> +	.remove		=3D itds_remove,
> +	.id_table	=3D itds_id,
> +};
> +module_i2c_driver(itds_driver);
> +
> +MODULE_AUTHOR("Saravanan Sekar <saravanan@linumiz.com>");
> +MODULE_DESCRIPTION("W=C3=BCrth Elektronik WSEN-ITDS 3-axis accel driver"=
);
> +MODULE_LICENSE("GPL");

