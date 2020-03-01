Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A0F174F65
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 21:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgCAUE5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 15:04:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgCAUE4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 15:04:56 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83E4624697;
        Sun,  1 Mar 2020 20:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583093095;
        bh=0RUm9Kbnk/zf7uzLZ51pa0RCcaCg+/YqXa/6P9aRBNQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CCzseOoeg86OPf89RVpMy/rsMXMFh+0v103p5xHPxfaVeeZXv+YhhGfEMgn1ej4pw
         amqbiDwGHqK2/6oh9/0qBSLobWv+4Xh90zL6yFL2jaGr8+9ndLysJb6wibXJHlw3Ix
         lBxeu1eDUa47mDNg+XCc5PKXj0KQJMex/kWejy60=
Date:   Sun, 1 Mar 2020 20:04:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: icp10100: add driver for InvenSense
 ICP-101xx
Message-ID: <20200301200449.1e36bfbe@archlinux>
In-Reply-To: <20200221201123.23721-1-jmaneyrol@invensense.com>
References: <20200221201123.23721-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Feb 2020 21:11:23 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> InvenSense ICP-101xx sensors are a family of barometric pressure
> and temperature sensor.
>=20
> These devices are I2C only and use a specific protocol of
> commands/responses. Data transfer is secured by using crc8.
>=20
> Driver provides processed pressure and raw temperature data.
>=20
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Change log?  I'm lazy so always appreciate a reminder of what came up
in earlier reviews ;)

Still all looks good.  Applied to the togreg branch of iio.git and pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan


> ---
>  drivers/iio/pressure/Kconfig    |  11 +
>  drivers/iio/pressure/Makefile   |   1 +
>  drivers/iio/pressure/icp10100.c | 658 ++++++++++++++++++++++++++++++++
>  3 files changed, 670 insertions(+)
>  create mode 100644 drivers/iio/pressure/icp10100.c
>=20
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 9c2d9bf8f100..689b978db4f9 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -101,6 +101,17 @@ config HP03
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called hp03.
> =20
> +config ICP10100
> +	tristate "InvenSense ICP-101xx pressure and temperature sensor"
> +	depends on I2C
> +	select CRC8
> +	help
> +	  Say yes here to build support for InvenSense ICP-101xx barometric
> +	  pressure and temperature sensor.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called icp10100.
> +
>  config MPL115
>  	tristate
> =20
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index 5a79192d8cb5..083ae87ff48f 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_DPS310) +=3D dps310.o
>  obj-$(CONFIG_IIO_CROS_EC_BARO) +=3D cros_ec_baro.o
>  obj-$(CONFIG_HID_SENSOR_PRESS)   +=3D hid-sensor-press.o
>  obj-$(CONFIG_HP03) +=3D hp03.o
> +obj-$(CONFIG_ICP10100) +=3D icp10100.o
>  obj-$(CONFIG_MPL115) +=3D mpl115.o
>  obj-$(CONFIG_MPL115_I2C) +=3D mpl115_i2c.o
>  obj-$(CONFIG_MPL115_SPI) +=3D mpl115_spi.o
> diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10=
100.c
> new file mode 100644
> index 000000000000..3ce4dc2f77ee
> --- /dev/null
> +++ b/drivers/iio/pressure/icp10100.c
> @@ -0,0 +1,658 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 InvenSense, Inc.
> + *
> + * Driver for InvenSense ICP-1010xx barometric pressure and temperature =
sensor.
> + *
> + * Datasheet:
> + * http://www.invensense.com/wp-content/uploads/2018/01/DS-000186-ICP-10=
1xx-v1.2.pdf
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/crc8.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/log2.h>
> +#include <linux/math64.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/iio/iio.h>
> +
> +#define ICP10100_ID_REG_GET(_reg)	((_reg) & 0x003F)
> +#define ICP10100_ID_REG			0x08
> +#define ICP10100_RESPONSE_WORD_LENGTH	3
> +#define ICP10100_CRC8_WORD_LENGTH	2
> +#define ICP10100_CRC8_POLYNOMIAL	0x31
> +#define ICP10100_CRC8_INIT		0xFF
> +
> +enum icp10100_mode {
> +	ICP10100_MODE_LP,	/* Low power mode: 1x sampling */
> +	ICP10100_MODE_N,	/* Normal mode: 2x sampling */
> +	ICP10100_MODE_LN,	/* Low noise mode: 4x sampling */
> +	ICP10100_MODE_ULN,	/* Ultra low noise mode: 8x sampling */
> +	ICP10100_MODE_NB,
> +};
> +
> +struct icp10100_state {
> +	struct mutex lock;
> +	struct i2c_client *client;
> +	struct regulator *vdd;
> +	enum icp10100_mode mode;
> +	int16_t cal[4];
> +};
> +
> +struct icp10100_command {
> +	__be16 cmd;
> +	unsigned long wait_us;
> +	unsigned long wait_max_us;
> +	size_t response_word_nb;
> +};
> +
> +static const struct icp10100_command icp10100_cmd_soft_reset =3D {
> +	.cmd =3D cpu_to_be16(0x805D),
> +	.wait_us =3D 170,
> +	.wait_max_us =3D 200,
> +	.response_word_nb =3D 0,
> +};
> +
> +static const struct icp10100_command icp10100_cmd_read_id =3D {
> +	.cmd =3D cpu_to_be16(0xEFC8),
> +	.wait_us =3D 0,
> +	.response_word_nb =3D 1,
> +};
> +
> +static const struct icp10100_command icp10100_cmd_read_otp =3D {
> +	.cmd =3D cpu_to_be16(0xC7F7),
> +	.wait_us =3D 0,
> +	.response_word_nb =3D 1,
> +};
> +
> +static const struct icp10100_command icp10100_cmd_measure[] =3D {
> +	[ICP10100_MODE_LP] =3D {
> +		.cmd =3D cpu_to_be16(0x401A),
> +		.wait_us =3D 1800,
> +		.wait_max_us =3D 2000,
> +		.response_word_nb =3D 3,
> +	},
> +	[ICP10100_MODE_N] =3D {
> +		.cmd =3D cpu_to_be16(0x48A3),
> +		.wait_us =3D 6300,
> +		.wait_max_us =3D 6500,
> +		.response_word_nb =3D 3,
> +	},
> +	[ICP10100_MODE_LN] =3D {
> +		.cmd =3D cpu_to_be16(0x5059),
> +		.wait_us =3D 23800,
> +		.wait_max_us =3D 24000,
> +		.response_word_nb =3D 3,
> +	},
> +	[ICP10100_MODE_ULN] =3D {
> +		.cmd =3D cpu_to_be16(0x58E0),
> +		.wait_us =3D 94500,
> +		.wait_max_us =3D 94700,
> +		.response_word_nb =3D 3,
> +	},
> +};
> +
> +static const uint8_t icp10100_switch_mode_otp[] =3D
> +	{0xC5, 0x95, 0x00, 0x66, 0x9c};
> +
> +DECLARE_CRC8_TABLE(icp10100_crc8_table);
> +
> +static inline int icp10100_i2c_xfer(struct i2c_adapter *adap,
> +				    struct i2c_msg *msgs, int num)
> +{
> +	int ret;
> +
> +	ret =3D i2c_transfer(adap, msgs, num);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret !=3D num)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int icp10100_send_cmd(struct icp10100_state *st,
> +			     const struct icp10100_command *cmd,
> +			     __be16 *buf, size_t buf_len)
> +{
> +	size_t size =3D cmd->response_word_nb * ICP10100_RESPONSE_WORD_LENGTH;
> +	uint8_t data[16];
> +	uint8_t *ptr;
> +	uint8_t *buf_ptr =3D (uint8_t *)buf;
> +	struct i2c_msg msgs[2] =3D {
> +		{
> +			.addr =3D st->client->addr,
> +			.flags =3D 0,
> +			.len =3D 2,
> +			.buf =3D (uint8_t *)&cmd->cmd,
> +		}, {
> +			.addr =3D st->client->addr,
> +			.flags =3D I2C_M_RD,
> +			.len =3D size,
> +			.buf =3D data,
> +		},
> +	};
> +	uint8_t crc;
> +	unsigned int i;
> +	int ret;
> +
> +	if (size > sizeof(data))
> +		return -EINVAL;
> +
> +	if (cmd->response_word_nb > 0 &&
> +			(buf =3D=3D NULL || buf_len < (cmd->response_word_nb * 2)))
> +		return -EINVAL;
> +
> +	dev_dbg(&st->client->dev, "sending cmd %#x\n", be16_to_cpu(cmd->cmd));
> +
> +	if (cmd->response_word_nb > 0 && cmd->wait_us =3D=3D 0) {
> +		/* direct command-response without waiting */
> +		ret =3D icp10100_i2c_xfer(st->client->adapter, msgs,
> +					ARRAY_SIZE(msgs));
> +		if (ret)
> +			return ret;
> +	} else {
> +		/* transfer command write */
> +		ret =3D icp10100_i2c_xfer(st->client->adapter, &msgs[0], 1);
> +		if (ret)
> +			return ret;
> +		if (cmd->wait_us > 0)
> +			usleep_range(cmd->wait_us, cmd->wait_max_us);
> +		/* transfer response read if needed */
> +		if (cmd->response_word_nb > 0) {
> +			ret =3D icp10100_i2c_xfer(st->client->adapter, &msgs[1], 1);
> +			if (ret)
> +				return ret;
> +		} else {
> +			return 0;
> +		}
> +	}
> +
> +	/* process read words with crc checking */
> +	for (i =3D 0; i < cmd->response_word_nb; ++i) {
> +		ptr =3D &data[i * ICP10100_RESPONSE_WORD_LENGTH];
> +		crc =3D crc8(icp10100_crc8_table, ptr, ICP10100_CRC8_WORD_LENGTH,
> +			   ICP10100_CRC8_INIT);
> +		if (crc !=3D ptr[ICP10100_CRC8_WORD_LENGTH]) {
> +			dev_err(&st->client->dev, "crc error recv=3D%#x calc=3D%#x\n",
> +				ptr[ICP10100_CRC8_WORD_LENGTH], crc);
> +			return -EIO;
> +		}
> +		*buf_ptr++ =3D ptr[0];
> +		*buf_ptr++ =3D ptr[1];
> +	}
> +
> +	return 0;
> +}
> +
> +static int icp10100_read_cal_otp(struct icp10100_state *st)
> +{
> +	__be16 val;
> +	int i;
> +	int ret;
> +
> +	/* switch into OTP read mode */
> +	ret =3D i2c_master_send(st->client, icp10100_switch_mode_otp,
> +			      ARRAY_SIZE(icp10100_switch_mode_otp));
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D ARRAY_SIZE(icp10100_switch_mode_otp))
> +		return -EIO;
> +
> +	/* read 4 calibration values */
> +	for (i =3D 0; i < 4; ++i) {
> +		ret =3D icp10100_send_cmd(st, &icp10100_cmd_read_otp,
> +					&val, sizeof(val));
> +		if (ret)
> +			return ret;
> +		st->cal[i] =3D be16_to_cpu(val);
> +		dev_dbg(&st->client->dev, "cal[%d] =3D %d\n", i, st->cal[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int icp10100_init_chip(struct icp10100_state *st)
> +{
> +	__be16 val;
> +	uint16_t id;
> +	int ret;
> +
> +	/* read and check id */
> +	ret =3D icp10100_send_cmd(st, &icp10100_cmd_read_id, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +	id =3D ICP10100_ID_REG_GET(be16_to_cpu(val));
> +	if (id !=3D ICP10100_ID_REG) {
> +		dev_err(&st->client->dev, "invalid id %#x\n", id);
> +		return -ENODEV;
> +	}
> +
> +	/* read calibration data from OTP */
> +	ret =3D icp10100_read_cal_otp(st);
> +	if (ret)
> +		return ret;
> +
> +	/* reset chip */
> +	return icp10100_send_cmd(st, &icp10100_cmd_soft_reset, NULL, 0);
> +}
> +
> +static int icp10100_get_measures(struct icp10100_state *st,
> +				uint32_t *pressure, uint16_t *temperature)
> +{
> +	const struct icp10100_command *cmd;
> +	__be16 measures[3];
> +	int ret;
> +
> +	pm_runtime_get_sync(&st->client->dev);
> +
> +	mutex_lock(&st->lock);
> +	cmd =3D &icp10100_cmd_measure[st->mode];
> +	ret =3D icp10100_send_cmd(st, cmd, measures, sizeof(measures));
> +	mutex_unlock(&st->lock);
> +	if (ret)
> +		goto error_measure;
> +
> +	*pressure =3D (be16_to_cpu(measures[0]) << 8) |
> +			(be16_to_cpu(measures[1]) >> 8);
> +	*temperature =3D be16_to_cpu(measures[2]);
> +
> +	pm_runtime_mark_last_busy(&st->client->dev);
> +error_measure:
> +	pm_runtime_put_autosuspend(&st->client->dev);
> +	return ret;
> +}
> +
> +static uint32_t icp10100_get_pressure(struct icp10100_state *st,
> +				      uint32_t raw_pressure, uint16_t raw_temp)
> +{
> +	static int32_t p_calib[] =3D {45000, 80000, 105000};
> +	static int32_t lut_lower =3D 3670016;
> +	static int32_t lut_upper =3D 12058624;
> +	static int32_t inv_quadr_factor =3D 16777216;
> +	static int32_t offset_factor =3D 2048;
> +	int64_t val1, val2;
> +	int32_t p_lut[3];
> +	int32_t t, t_square;
> +	int64_t a, b, c;
> +	uint32_t pressure_mPa;
> +
> +	dev_dbg(&st->client->dev, "raw: pressure =3D %u, temp =3D %u\n",
> +		raw_pressure, raw_temp);
> +
> +	/* compute p_lut values */
> +	t =3D (int32_t)raw_temp - 32768;
> +	t_square =3D t * t;
> +	val1 =3D (int64_t)st->cal[0] * (int64_t)t_square;
> +	p_lut[0] =3D lut_lower + (int32_t)div_s64(val1, inv_quadr_factor);
> +	val1 =3D (int64_t)st->cal[1] * (int64_t)t_square;
> +	p_lut[1] =3D offset_factor * st->cal[3] +
> +			(int32_t)div_s64(val1, inv_quadr_factor);
> +	val1 =3D (int64_t)st->cal[2] * (int64_t)t_square;
> +	p_lut[2] =3D lut_upper + (int32_t)div_s64(val1, inv_quadr_factor);
> +	dev_dbg(&st->client->dev, "p_lut =3D [%d, %d, %d]\n",
> +		p_lut[0], p_lut[1], p_lut[2]);
> +
> +	/* compute a, b, c factors */
> +	val1 =3D (int64_t)p_lut[0] * (int64_t)p_lut[1] *
> +			(int64_t)(p_calib[0] - p_calib[1]) +
> +		(int64_t)p_lut[1] * (int64_t)p_lut[2] *
> +			(int64_t)(p_calib[1] - p_calib[2]) +
> +		(int64_t)p_lut[2] * (int64_t)p_lut[0] *
> +			(int64_t)(p_calib[2] - p_calib[0]);
> +	val2 =3D (int64_t)p_lut[2] * (int64_t)(p_calib[0] - p_calib[1]) +
> +		(int64_t)p_lut[0] * (int64_t)(p_calib[1] - p_calib[2]) +
> +		(int64_t)p_lut[1] * (int64_t)(p_calib[2] - p_calib[0]);
> +	c =3D div64_s64(val1, val2);
> +	dev_dbg(&st->client->dev, "val1 =3D %lld, val2 =3D %lld, c =3D %lld\n",
> +		val1, val2, c);
> +	val1 =3D (int64_t)p_calib[0] * (int64_t)p_lut[0] -
> +		(int64_t)p_calib[1] * (int64_t)p_lut[1] -
> +		(int64_t)(p_calib[1] - p_calib[0]) * c;
> +	val2 =3D (int64_t)p_lut[0] - (int64_t)p_lut[1];
> +	a =3D div64_s64(val1, val2);
> +	dev_dbg(&st->client->dev, "val1 =3D %lld, val2 =3D %lld, a =3D %lld\n",
> +		val1, val2, a);
> +	b =3D ((int64_t)p_calib[0] - a) * ((int64_t)p_lut[0] + c);
> +	dev_dbg(&st->client->dev, "b =3D %lld\n", b);
> +
> +	/*
> +	 * pressure_Pa =3D a + (b / (c + raw_pressure))
> +	 * pressure_mPa =3D 1000 * pressure_Pa
> +	 */
> +	pressure_mPa =3D 1000LL * a + div64_s64(1000LL * b, c + raw_pressure);
> +
> +	return pressure_mPa;
> +}
> +
> +static int icp10100_read_raw_measures(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      int *val, int *val2)
> +{
> +	struct icp10100_state *st =3D iio_priv(indio_dev);
> +	uint32_t raw_pressure;
> +	uint16_t raw_temp;
> +	uint32_t pressure_mPa;
> +	int ret;
> +
> +	ret =3D iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D icp10100_get_measures(st, &raw_pressure, &raw_temp);
> +	if (ret)
> +		goto error_release;
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		pressure_mPa =3D icp10100_get_pressure(st, raw_pressure,
> +						     raw_temp);
> +		/* mPa to kPa */
> +		*val =3D pressure_mPa / 1000000;
> +		*val2 =3D pressure_mPa % 1000000;
> +		ret =3D IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	case IIO_TEMP:
> +		*val =3D raw_temp;
> +		ret =3D IIO_VAL_INT;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	};
> +
> +error_release:
> +	iio_device_release_direct_mode(indio_dev);
> +	return ret;
> +}
> +
> +static int icp10100_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct icp10100_state *st =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_PROCESSED:
> +		return icp10100_read_raw_measures(indio_dev, chan, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			/* 1000 * 175=C2=B0C / 65536 in m=C2=B0C */
> +			*val =3D 2;
> +			*val2 =3D 670288;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			/* 1000 * -45=C2=B0C in m=C2=B0C */
> +			*val =3D -45000;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		mutex_lock(&st->lock);
> +		*val =3D 1 << st->mode;
> +		mutex_unlock(&st->lock);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int icp10100_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	static int oversamplings[] =3D {1, 2, 4, 8};
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals =3D oversamplings;
> +		*type =3D IIO_VAL_INT;
> +		*length =3D ARRAY_SIZE(oversamplings);
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int icp10100_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct icp10100_state *st =3D iio_priv(indio_dev);
> +	unsigned int mode;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		/* oversampling is always positive and a power of 2 */
> +		if (val <=3D 0 || !is_power_of_2(val))
> +			return -EINVAL;
> +		mode =3D ilog2(val);
> +		if (mode >=3D ICP10100_MODE_NB)
> +			return -EINVAL;
> +		ret =3D iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		mutex_lock(&st->lock);
> +		st->mode =3D mode;
> +		mutex_unlock(&st->lock);
> +		iio_device_release_direct_mode(indio_dev);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int icp10100_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info icp10100_info =3D {
> +	.read_raw =3D icp10100_read_raw,
> +	.read_avail =3D icp10100_read_avail,
> +	.write_raw =3D icp10100_write_raw,
> +	.write_raw_get_fmt =3D icp10100_write_raw_get_fmt,
> +};
> +
> +static const struct iio_chan_spec icp10100_channels[] =3D {
> +	{
> +		.type =3D IIO_PRESSURE,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_all =3D
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all_available =3D
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	}, {
> +		.type =3D IIO_TEMP,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_OFFSET),
> +		.info_mask_shared_by_all =3D
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all_available =3D
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +};
> +
> +static int icp10100_enable_regulator(struct icp10100_state *st)
> +{
> +	int ret;
> +
> +	ret =3D regulator_enable(st->vdd);
> +	if (ret)
> +		return ret;
> +	msleep(100);
> +
> +	return 0;
> +}
> +
> +static void icp10100_disable_regulator_action(void *data)
> +{
> +	struct icp10100_state *st =3D data;
> +	int ret;
> +
> +	ret =3D regulator_disable(st->vdd);
> +	if (ret)
> +		dev_err(&st->client->dev, "error %d disabling vdd\n", ret);
> +}
> +
> +static void icp10100_pm_disable(void *data)
> +{
> +	struct device *dev =3D data;
> +
> +	pm_runtime_put_sync_suspend(dev);
> +	pm_runtime_disable(dev);
> +}
> +
> +static int icp10100_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct icp10100_state *st;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev, "plain i2c transactions not supported\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	indio_dev->dev.parent =3D &client->dev;
> +	indio_dev->name =3D client->name;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D icp10100_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(icp10100_channels);
> +	indio_dev->info =3D &icp10100_info;
> +
> +	st =3D iio_priv(indio_dev);
> +	mutex_init(&st->lock);
> +	st->client =3D client;
> +	st->mode =3D ICP10100_MODE_N;
> +
> +	st->vdd =3D devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(st->vdd))
> +		return PTR_ERR(st->vdd);
> +
> +	ret =3D icp10100_enable_regulator(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(&client->dev,
> +				       icp10100_disable_regulator_action, st);
> +	if (ret)
> +		return ret;
> +
> +	/* has to be done before the first i2c communication */
> +	crc8_populate_msb(icp10100_crc8_table, ICP10100_CRC8_POLYNOMIAL);
> +
> +	ret =3D icp10100_init_chip(st);
> +	if (ret) {
> +		dev_err(&client->dev, "init chip error %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* enable runtime pm with autosuspend delay of 2s */
> +	pm_runtime_get_noresume(&client->dev);
> +	pm_runtime_set_active(&client->dev);
> +	pm_runtime_enable(&client->dev);
> +	pm_runtime_set_autosuspend_delay(&client->dev, 2000);
> +	pm_runtime_use_autosuspend(&client->dev);
> +	pm_runtime_put(&client->dev);
> +	ret =3D devm_add_action_or_reset(&client->dev, icp10100_pm_disable,
> +				       &client->dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static int __maybe_unused icp10100_suspend(struct device *dev)
> +{
> +	struct icp10100_state *st =3D iio_priv(dev_get_drvdata(dev));
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret =3D regulator_disable(st->vdd);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused icp10100_resume(struct device *dev)
> +{
> +	struct icp10100_state *st =3D iio_priv(dev_get_drvdata(dev));
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret =3D icp10100_enable_regulator(st);
> +	if (ret)
> +		goto out_unlock;
> +
> +	/* reset chip */
> +	ret =3D icp10100_send_cmd(st, &icp10100_cmd_soft_reset, NULL, 0);
> +
> +out_unlock:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static UNIVERSAL_DEV_PM_OPS(icp10100_pm, icp10100_suspend, icp10100_resu=
me,
> +			    NULL);
> +
> +static const struct of_device_id icp10100_of_match[] =3D {
> +	{
> +		.compatible =3D "invensense,icp10100",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, icp10100_of_match);
> +
> +static const struct i2c_device_id icp10100_id[] =3D {
> +	{ "icp10100", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, icp10100_id);
> +
> +static struct i2c_driver icp10100_driver =3D {
> +	.driver =3D {
> +		.name =3D "icp10100",
> +		.pm =3D &icp10100_pm,
> +		.of_match_table =3D of_match_ptr(icp10100_of_match),
> +	},
> +	.probe =3D icp10100_probe,
> +	.id_table =3D icp10100_id,
> +};
> +module_i2c_driver(icp10100_driver);
> +
> +MODULE_AUTHOR("InvenSense, Inc.");
> +MODULE_DESCRIPTION("InvenSense icp10100 driver");
> +MODULE_LICENSE("GPL");

