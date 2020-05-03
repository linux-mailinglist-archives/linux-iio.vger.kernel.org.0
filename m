Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F9E1C2C71
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 14:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgECMmO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 08:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728774AbgECMmN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 08:42:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC8602075B;
        Sun,  3 May 2020 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588509731;
        bh=HImBjos/xe5+Uv40GH5W9jjZ+IfHanCZoxvwJaFc29c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HrQrtN5iIAdDn1uCwn4Mvp1uYkd+cDiVKvWGFFoYf7Eikg0p7PJynfrr3/H30BPTM
         CcZ8z9PVoV9NakQGYjC7OEdyaV54Brv91X7dNSUw7NpjNpi09uMMUpcBfX3m2/WtB8
         D71r1xzCJhOmmnovBBrYuhBbW8AbnT4XirgdjHEU=
Date:   Sun, 3 May 2020 13:42:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v2 2/4] iio: accel: Add driver for wsen-itds
 accelerometer sensor
Message-ID: <20200503134207.1233613a@archlinux>
In-Reply-To: <20200429133943.18298-3-saravanan@linumiz.com>
References: <20200429133943.18298-1-saravanan@linumiz.com>
        <20200429133943.18298-3-saravanan@linumiz.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Apr 2020 15:39:41 +0200
Saravanan Sekar <saravanan@linumiz.com> wrote:

> Add an iio driver for the wurth elektronic wsen-itds 3-axis accelerometer.
> The driver supports the acceleration, temperature data reading and
> supports configuring of output data rate, operating mode and scale.
>=20
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>

+CC Alex. This one has some unusual buffer handling please, sanity check
that it isn't going to cause problem for your core rework.

Various comments inline. Note I left the ABI discussion for the documentati=
on
patch.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/Kconfig     |  14 +
>  drivers/iio/accel/Makefile    |   1 +
>  drivers/iio/accel/wsen-itds.c | 947 ++++++++++++++++++++++++++++++++++
>  3 files changed, 962 insertions(+)
>  create mode 100644 drivers/iio/accel/wsen-itds.c
>=20
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 5d91a6dda894..ad96ba2a9e38 100644
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
> +	  The sensor provides 3-axis Acceleration, Temperature data and
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
> index 000000000000..d7bc961176c3
> --- /dev/null
> +++ b/drivers/iio/accel/wsen-itds.c
> @@ -0,0 +1,947 @@
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
> +#include <linux/cache.h>
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
> +#define ITDS_FIFO_MODE_BYPASS		0
> +#define ITDS_FIFO_MODE_FIFO		BIT(5)
> +#define	ITDS_DEVICE_ID			0x44
> +#define	ITDS_ACCL_FIFO_SIZE		32
> +
> +#define ITDS_ACC_CHAN(_axis, _idx) {					\
> +	.type =3D IIO_ACCEL,						\
> +	.modified =3D 1,							\
> +	.channel2 =3D IIO_MOD_##_axis,					\
> +	.address =3D ITDS_REG_##_axis##_OUT_L,				\
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
> +	ITDS_OP_MODE_LOW_POWER,
> +	ITDS_OP_MODE_NORMAL =3D BIT(0),
> +	ITDS_OP_MODE_HIGH_PERFORMANCE =3D BIT(1),
> +	ITDS_OP_MODE_SINGLE_SHOT =3D BIT(2),
> +	ITDS_OP_MODE_MAX =3D 4

Odd mix of bitmap and a max value. That's hard to read so don't do it.
Given the value 3 is missing, and you are using this max to set the size
of an array I guess aligns with this below, things will not work as expecte=
d...

> +};
> +
> +enum itds_odr {
> +	ITDS_ODR_0,
> +	ITDS_ODR_1_6,
> +	ITDS_ODR_12_5,
> +	ITDS_ODR_25,
> +	ITDS_ODR_50,
> +	ITDS_ODR_100,
> +	ITDS_ODR_200,
> +	ITDS_ODR_400,
> +	ITDS_ODR_800,
> +	ITDS_ODR_1600,
> +	ITDS_ODR_MAX
> +};
> +
> +struct itds_info {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct iio_trigger *trig;
> +	struct regulator *vdd_supply;
> +	struct regulator *vddio_supply;
> +	struct mutex mutex; /* itds info struct member */
> +	int64_t timestamp;
> +	int64_t old_timestamp;
> +	unsigned int scale;
> +	enum itds_operating_mode op_mode;
> +	u8 fifo_threshold;
> +	bool is_hwfifo_enabled;
> +};
> +
> +struct itds_sample_freqency {
> +	int val;
> +	int val2;
> +};
> +
> +static const char *operating_mode[ITDS_OP_MODE_MAX] =3D {
> +	"lowpower",
> +	"normal",
> +	"high_perf",
> +	"single_shot"
> +};
> +
> +static const struct itds_sample_freqency itds_sample_freq[ITDS_ODR_MAX] =
=3D {
> +	{0}, {1, 600000}, {12, 500000}, {25}, {50}, {100}, {200},
> +	{400}, {800}, {1600}
> +};
> +
> +static const unsigned long itds_scan_masks[] =3D {0x7, 0};
> +
> +/* 2g, 4g, 8g, 16g */
> +static const unsigned int itds_sensitivity_scale[][4] =3D {
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
> +	bool hp_mode;
> +
> +	hp_mode =3D !!(info->op_mode & ITDS_OP_MODE_HIGH_PERFORMANCE);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(itds_sensitivity_scale[0]); i++)
> +		len +=3D sprintf(buf + len, "%d ",
> +					itds_sensitivity_scale[hp_mode][i]);
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
> +	int start, end;
> +	bool hp_mode;
> +
> +	hp_mode =3D !!(info->op_mode & ITDS_OP_MODE_HIGH_PERFORMANCE);
> +	if (hp_mode) {
> +		start =3D ITDS_ODR_12_5;
> +		end =3D ITDS_ODR_1600;
> +	} else {
> +		start =3D ITDS_ODR_1_6;
> +		end =3D ITDS_ODR_200;
> +	}
> +
> +	for (i =3D start; i <=3D end; i++) {
> +		len +=3D sprintf(buf + len, "%d.%d ", itds_sample_freq[i].val,
> +					 itds_sample_freq[i].val2);
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
> +	__le16 tempval;
> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_STATUS_DETECT, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (!(regval & ITDS_EVENT_DRDY_T))
> +		return -EAGAIN;
> +
> +	ret =3D regmap_bulk_read(info->regmap, ITDS_REG_TEMP_L,
> +				   &tempval, sizeof(tempval));
> +	if (ret) {
> +		dev_err(info->dev, "failed to read TEMP reg\n");
> +		return ret;
> +	}
> +
> +	tempval =3D tempval >> 4;
> +	regval =3D sign_extend32(le16_to_cpu(tempval), 11);
> +	*val =3D regval * 625;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int itds_get_accel(struct itds_info *info,
> +			  const struct iio_chan_spec *chan,
> +			  int *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +	__le16 rval;
> +
> +	if ((chan->channel2 !=3D IIO_MOD_X) &&
> +	    (chan->channel2 !=3D IIO_MOD_Y) &&
> +	    (chan->channel2 !=3D IIO_MOD_Z)) {
> +		dev_err(info->dev, "invalid axis modifier\n");

Given this is a paranoid check anyway, I'd argue the print
is excessive..  You can't get here unless we have a bug.

> +		return -EINVAL;
> +	}
> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_CTRL1, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* data won't available in power down */
> +	if (!(regval & ITDS_MASK_ODR))

How did you get here in power down mode?  Sounds like a bug.
If someone is reading you should be powered up, or power up
when they try to read.

> +		return -EINVAL;
> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_STATUS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (!(regval & ITDS_EVENT_DRDY))
> +		return -EAGAIN;
> +
> +	ret =3D regmap_bulk_read(info->regmap, chan->address, &rval,
> +			       sizeof(rval));
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&info->mutex);
> +
> +	if (info->op_mode & ITDS_OP_MODE_HIGH_PERFORMANCE ||
> +	    info->op_mode & ITDS_OP_MODE_NORMAL) {
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
> +	int start, end;
> +	bool hp_mode;
> +
> +	hp_mode =3D !!(info->op_mode & ITDS_OP_MODE_HIGH_PERFORMANCE);
> +	if (hp_mode) {
> +		start =3D ITDS_ODR_12_5;
> +		end =3D ITDS_ODR_1600;
> +	} else {
> +		start =3D ITDS_ODR_1_6;
> +		end =3D ITDS_ODR_200;
> +	}
> +
> +	for (i =3D start; i <=3D end; i++) {
> +		if ((val =3D=3D itds_sample_freq[i].val) &&
> +		    (val2 =3D=3D itds_sample_freq[i].val2)) {
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
> +	bool hp_mode;
> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_CTRL1, &rval);
> +	if (ret)
> +		return ret;
> +
> +	rval =3D (rval & ITDS_MASK_ODR) >> 4;
> +	hp_mode =3D !!(info->op_mode & ITDS_OP_MODE_HIGH_PERFORMANCE);
> +
> +	if (rval) {
> +		if (hp_mode && (rval < ITDS_ODR_12_5))
> +			rval =3D ITDS_ODR_12_5;
> +		else if (!hp_mode && (rval > ITDS_ODR_200))
> +			rval =3D ITDS_ODR_200;
> +	}
> +
> +	*val =3D itds_sample_freq[rval].val;
> +	*val2 =3D itds_sample_freq[rval].val2;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int itds_set_scale(struct itds_info *info, int val)
> +{
> +	int i, ret =3D -EINVAL;
> +	bool hp_mode;
> +
> +	mutex_lock(&info->mutex);
> +	hp_mode =3D !!(info->op_mode & ITDS_OP_MODE_HIGH_PERFORMANCE);
> +	for (i =3D 0; i < ARRAY_SIZE(itds_sensitivity_scale[0]); i++) {
> +		if (val =3D=3D itds_sensitivity_scale[hp_mode][i])
> +			break;
> +	}
> +
> +	if (i =3D=3D ARRAY_SIZE(itds_sensitivity_scale[0]))
> +		goto ret_unlock;
> +
> +	ret =3D regmap_update_bits(info->regmap, ITDS_REG_CTRL6,
> +				 ITDS_MASK_SCALE, i << 4);
> +	if (ret)
> +		goto ret_unlock;
> +
> +	info->scale =3D 1000 * itds_sensitivity_scale[hp_mode][i];
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
> +	bool hp_mode;
> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_CTRL6, &rval);
> +	if (ret)
> +		return ret;
> +
> +	rval =3D (rval & ITDS_MASK_SCALE) >> 4;
> +	hp_mode =3D !!(info->op_mode & ITDS_OP_MODE_HIGH_PERFORMANCE);
> +	info->scale =3D 1000 * itds_sensitivity_scale[hp_mode][rval];
> +
> +	return 0;
> +}
> +
> +static int itds_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +	unsigned int enable;
> +	int ret;
> +
> +	enable =3D state ? ITDS_MASK_INT_FIFOTH : 0;
> +	ret =3D regmap_update_bits(info->regmap, ITDS_REG_CTRL4,
> +				 ITDS_MASK_INT_FIFOTH,
> +				 enable);
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
> +	uint64_t sample_period, ts_per_data;
> +	unsigned int rval;
> +	int ret, i;
> +	/* 3x16 bits data + 1x16 padding + timestamp 64 bits */
> +	__le16 buffer[8] ____cacheline_aligned;

Doesn't work.  Look at what the macro does.   This needs to be on
the heap, not the stack.  It is extremely difficult to force
any alignment on the stack beyond that of individual elements.

So like most other IIO drivers, just add that buffer to your
info structure.

Also if you would need to zero it each time to avoid leaking arbitary
kernel memory.  If it's in the info structure the worst that can happen
is you leak previous samples and those are unlikely to be sensitive info ;)

We have a few cases of this leak and alignment problems to clean up based
on the adis16475 review thread.

Note however, this is using i2c which doesn't require dma safe buffers.
So the alignment we need is most likely 8 not a cacheline.

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
> +	if (!samples)
> +		return 0;
> +
> +	samples =3D samples < count ? samples : count;
> +
> +	sample_period =3D info->timestamp - info->old_timestamp;
> +	do_div(sample_period, samples);
> +	ts_per_data =3D info->timestamp - (samples - 1) * sample_period;
> +
> +	for (i =3D 0; i < samples; i++) {
> +		ret =3D regmap_raw_read(info->regmap, ITDS_REG_X_OUT_L,
> +				      buffer, 3 * sizeof(__le16));
> +		if (ret)
> +			return i;
> +
> +		iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +						   ts_per_data);
> +		ts_per_data +=3D sample_period;
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
> +	for (i =3D 0; i < ITDS_OP_MODE_MAX; i++) {
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
> +static IIO_DEVICE_ATTR(operating_mode, 0644, itds_accel_get_operating_mo=
de,
> +		       itds_accel_set_operating_mode, 0);
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
> +		info->old_timestamp =3D info->timestamp;
> +		info->timestamp =3D iio_get_time_ns(indio_dev);
> +		return IRQ_WAKE_THREAD;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int itds_accel_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct itds_info *info =3D iio_priv(indio_dev);
> +
> +	if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED)
> +		iio_triggered_buffer_predisable(indio_dev);
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
> +	int ret;
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
> +		return ret;
> +
> +	ret =3D regmap_update_bits(info->regmap, ITDS_REG_FIFO_CTRL,
> +				 ITDS_MASK_FIFOMODE,
> +				 ITDS_FIFO_MODE_FIFO);
> +	if (ret)
> +		return ret;
> +
> +	info->is_hwfifo_enabled =3D true;
> +	if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED)
> +		iio_triggered_buffer_postenable(indio_dev);
> +
> +	return 0;
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
> +		if (chan->type =3D=3D IIO_ACCEL) {
> +			ret =3D iio_device_claim_direct_mode(indio_dev);
> +			if (ret)
> +				return ret;
> +
> +			ret =3D itds_get_accel(info, chan, val);
> +			iio_device_release_direct_mode(indio_dev);
> +		} else {
> +			ret =3D itds_get_temp(info, val);
> +		}
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

If other channel types don't have an offset they shouldn't
register one or call this function.  Hence that check should either
be resulting in an error return for !=3D IIO_TEMP (if you are feeling paran=
oid)
or not there at all.

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
> +	.predisable =3D itds_accel_buffer_predisable,
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
> +static void itds_regulator_disable(void *data)
> +{
> +	struct itds_info *info =3D data;
> +
> +	regmap_update_bits(info->regmap, ITDS_REG_CTRL7, ITDS_MASK_INT_EN, 0);
> +	regmap_update_bits(info->regmap, ITDS_REG_CTRL1, ITDS_MASK_MODE, 0);

Every step in here is the result of a different part of probe. Hence
you register a separate callback for each one so that we don't have
to mess around cleaning up 'parts' of it on an error in probe.

Key thing is that you don't want a reviewer to have to think
'are there any race conditions in here'.  Right now btw you have paths with
unbalanced enable and disable of regulators..

> +	if (!IS_ERR_OR_NULL(info->vdd_supply))
> +		regulator_disable(info->vdd_supply);
> +
> +	if (!IS_ERR_OR_NULL(info->vddio_supply))
> +		regulator_disable(info->vddio_supply);
> +}
> +
> +static int itds_probe(struct i2c_client *client)
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

I'm still really not happy with this. =20

They are not optional regulators, but we may not be able to set their
voltages.=20

I'd rather see us just handle the error case if that happens at the
set voltage stage.

> +
> +	if (!IS_ERR_OR_NULL(info->vdd_supply) &&
> +	    !IS_ERR_OR_NULL(info->vddio_supply)) {
> +
> +		ret =3D regulator_set_voltage(info->vdd_supply, 1700000, 3600000);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regulator_set_voltage(info->vddio_supply,
> +						 1200000, 3700000);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regulator_enable(info->vdd_supply);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable vdd: %d\n", ret);
> +			return ret;
> +		}

Should have a separate calls to devm_add_action_or_reset for each
regulator.  That way the code is 'obviously' correct and there is
no need to do manual cleanup in the error paths in probe.

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
> +	ret =3D devm_add_action_or_reset(dev, itds_regulator_disable, info);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(info->regmap, ITDS_REG_DEV_ID, &rval);
> +	if (ret) {
> +		dev_info(dev, "device id read err %d\n", ret);
> +		goto out_disable_vddio;
> +	}
> +
> +	if (rval !=3D ITDS_DEVICE_ID) {
> +		dev_info(dev, "device id %X not matched\n", rval);
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
> +
> +		ret =3D regmap_update_bits(info->regmap, ITDS_REG_CTRL7,
> +					 ITDS_MASK_INT_EN, ITDS_MASK_INT_EN);
> +		if (ret)
> +			goto out_disable_vddio;
> +	}
> +
> +	dev_set_drvdata(dev, indio_dev);
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "IIO device register fail: %d\n", ret);
> +		goto out_disable_vddio;
> +	}
> +
> +	return 0;
> +
> +out_disable_vddio:
> +	if (!IS_ERR_OR_NULL(info->vddio_supply))
> +		regulator_disable(info->vddio_supply);

You shouldn't need this error handling.  You have registered
the regulator disables with the device managed framework
so they'll be disabled automatically on error return from
the probe function.

> +
> +out_disable_vdd:
> +	if (!IS_ERR_OR_NULL(info->vdd_supply))
> +		regulator_disable(info->vdd_supply);
> +
> +	return ret;
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
So the id table is for old style probing from board files or
the sysfs interface.

Now, in current kernel we have i2c_of_match_device which
will successfully match a device against the bit after
the compatible in the of_table above.

So I haven't tested bit but I 'think' you are fine to drop
the itds_id table entirely.

(I came across this code in another review today so not totally sure
I'm right here ;)

> +};
> +MODULE_DEVICE_TABLE(i2c, itds_id);
> +
> +static struct i2c_driver itds_driver =3D {
> +	.driver =3D {
> +		.name =3D "wsen-itds",
> +		.of_match_table =3D itds_of_match,
> +	},
> +	.probe_new	=3D itds_probe,
> +	.id_table	=3D itds_id,
> +};
> +module_i2c_driver(itds_driver);
> +
> +MODULE_AUTHOR("Saravanan Sekar <saravanan@linumiz.com>");
> +MODULE_DESCRIPTION("W=C3=BCrth Elektronik WSEN-ITDS 3-axis accel driver"=
);
> +MODULE_LICENSE("GPL");

