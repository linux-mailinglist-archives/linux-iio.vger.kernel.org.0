Return-Path: <linux-iio+bounces-11507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C06A9B383A
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 18:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E016B282EAC
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753C21DF27A;
	Mon, 28 Oct 2024 17:51:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D321106;
	Mon, 28 Oct 2024 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137861; cv=none; b=RcnVXuxJ/Ut0RaJ3eox/XpfTrUDfF/dn/JlC6e5afbusO4UEjSJPFgzO26yYbiNSdp9k77p9Uu7E8d9qYqBVF9QliaQCK3zDWUhBJ+0oon7igkXSkXCnobvogN1+uV7eoBv/OzDiHP68pFsxtHjl+6P9cQKG3OMChiBlYSx4JKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137861; c=relaxed/simple;
	bh=pnaYUAyyqzsFkM5GSvjQ+oTB/Llkt6s9pMEsQHeN7+0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WS/2koKST2X2Ye/A4OyXPNgVmOkhkxOL4DgTmuRY0Hfg6EBok98ZJgGyutS97IhOmWNHE9kOevNtbWnfKZwJgFS/LsDpUl5rLv08FO+xN/SmokbE/uoyzot9U3WxAnzNsnyUzosLd7n7w8kSLoZDLF2r48n0uX54yR4JkWd6Atc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XcgmF02QLz6LDZY;
	Tue, 29 Oct 2024 01:46:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 783EB1404FC;
	Tue, 29 Oct 2024 01:50:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Oct
 2024 18:50:52 +0100
Date: Mon, 28 Oct 2024 17:50:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Budai <robert.budai@analog.com>
CC: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu
	<ramona.gradinariu@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, "Michael Hennerich"
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jagath Jog J
	<jagathjog1996@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <robi_budai@yahoo.com>
Subject: Re: [PATCH 4/5] iio: imu: adis16550: add adis16550 support
Message-ID: <20241028175050.00005fac@Huawei.com>
In-Reply-To: <20241028123550.9128-3-robert.budai@analog.com>
References: <20241028123550.9128-1-robert.budai@analog.com>
	<20241028123550.9128-3-robert.budai@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Oct 2024 14:35:44 +0200
Robert Budai <robert.budai@analog.com> wrote:

> From: Nuno S=E1 <nuno.sa@analog.com>
>=20
> The ADIS16550 is a complete inertial system that includes a triaxis
> gyroscope and a triaxis accelerometer. Each inertial sensor in
> the ADIS16550 combines industry leading MEMS only technology
> with signal conditioning that optimizes dynamic performance. The
> factory calibration characterizes each sensor for sensitivity, bias,
> and alignment. As a result, each sensor has its own dynamic com-
> pensation formulas that provide accurate sensor measurements
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Co-developed-by: Robert Budai <robert.budai@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>

Various minor things inline.

Robert, as sender your SoB should come last. (just move down your two
lines and it is fine).

> diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
> new file mode 100644
> index 000000000000..204d72c9f442
> --- /dev/null
> +++ b/drivers/iio/imu/adis16550.c
> @@ -0,0 +1,1228 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADIS16550 IMU driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/crc32.h>
> +#include <linux/debugfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/imu/adis.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/lcm.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/swab.h>
> +
> +#include <asm/unaligned.h>
Moved. Now linux/unaligned.h (rc2 onwards)


> +
> +#define ADIS16550_REG_BURST_GYRO_ACCEL		0x0a
> +#define ADIS16550_REG_BURST_DELTA_ANG_VEL	0x0b
> +#define ADIS16550_BURST_DATA_GYRO_ACCEL_MASK	GENMASK(5, 0)
> +#define ADIS16550_BURST_DATA_DELTA_ANG_VEL_MASK	GENMASK(12, 7)
> +
> +#define ADIS16550_REG_STATUS		0x0e
> +#define ADIS16550_REG_TEMP		0x10
> +#define ADIS16550_REG_X_GYRO		0x12
> +#define ADIS16550_REG_Y_GYRO		0x14
> +#define ADIS16550_REG_Z_GYRO		0x16
> +#define ADIS16550_REG_X_ACCEL		0x18
> +#define ADIS16550_REG_Y_ACCEL		0x1a
> +#define ADIS16550_REG_Z_ACCEL		0x1c
> +#define ADIS16550_REG_X_DELTANG_L	0x1E
> +#define ADIS16550_REG_Y_DELTANG_L	0x20
> +#define ADIS16550_REG_Z_DELTANG_L	0x22
> +#define ADIS16550_REG_X_DELTVEL_L	0x24
> +#define ADIS16550_REG_Y_DELTVEL_L	0x26
> +#define ADIS16550_REG_Z_DELTVEL_L	0x28
> +#define ADIS16550_REG_X_GYRO_SCALE	0x30
> +#define ADIS16550_REG_Y_GYRO_SCALE	0x32
> +#define ADIS16550_REG_Z_GYRO_SCALE	0x34
> +#define ADIS16550_REG_X_ACCEL_SCALE	0x36
> +#define ADIS16550_REG_Y_ACCEL_SCALE	0x38
> +#define ADIS16550_REG_Z_ACCEL_SCALE	0x3a
> +#define ADIS16550_REG_X_GYRO_BIAS	0x40
> +#define ADIS16550_REG_Y_GYRO_BIAS	0x42
> +#define ADIS16550_REG_Z_GYRO_BIAS	0x44
> +#define ADIS16550_REG_X_ACCEL_BIAS	0x46
> +#define ADIS16550_REG_Y_ACCEL_BIAS	0x48
> +#define ADIS16550_REG_Z_ACCEL_BIAS	0x4a
> +#define ADIS16550_REG_COMMAND		0x50
> +#define ADIS16550_REG_CONFIG		0x52
> +#define ADIS16550_GYRO_FIR_EN_MASK	BIT(3)
> +#define ADIS16550_ACCL_FIR_EN_MASK	BIT(2)
> +#define ADIS16550_SYNC_MASK	\
> +			(ADIS16550_SYNC_EN_MASK | ADIS16550_SYNC_MODE_MASK)
> +#define ADIS16550_SYNC_MODE_MASK	BIT(1)
> +#define ADIS16550_SYNC_EN_MASK		BIT(0)
> +/* max of 4000 SPS in scale sync */
> +#define ADIS16550_SYNC_SCALE_MAX_RATE	(4000 * 1000)
> +#define ADIS16550_REG_DEC_RATE		0x54
> +#define ADIS16550_REG_SYNC_SCALE	0x56
> +#define ADIS16550_REG_SERIAL_NUM	0x76
> +#define ADIS16550_REG_FW_REV		0x7A
> +#define ADIS16550_REG_FW_DATE		0x7C
> +#define ADIS16550_REG_PROD_ID		0x7E
> +#define ADIS16550_REG_FLASH_CNT		0x72
> +/* spi protocol*/
> +#define ADIS16550_SPI_DATA_MASK		GENMASK(31, 16)
> +#define ADIS16550_SPI_REG_MASK		GENMASK(14, 8)
> +#define ADIS16550_SPI_R_W_MASK		BIT(7)
> +#define ADIS16550_SPI_CRC_MASK		GENMASK(3, 0)
> +#define ADIS16550_SPI_SV_MASK		GENMASK(7, 6)
> +/* burst read */
> +#define ADIS16550_BURST_N_ELEM		12
> +#define ADIS16550_BURST_DATA_LEN	(ADIS16550_BURST_N_ELEM * 4)
> +#define ADIS16550_MAX_SCAN_DATA		12

> +static int adis16550_set_freq(struct adis16550 *st, u32 freq)
name freq to indicate the units.

> +{
> +	u16 dec;
> +	int ret;
> +	u32 sample_rate =3D st->clk_freq;
> +	/*
> +	 * The optimal sample rate for the supported IMUs is between
> +	 * int_clk - 1000 and int_clk + 500.
> +	 */
> +	u32 max_sample_rate =3D  st->info->int_clk * 1000 + 500000;
> +	u32 min_sample_rate =3D  st->info->int_clk * 1000 - 1000000;
> +
> +	if (!freq)
> +		return -EINVAL;
> +
> +	adis_dev_lock(&st->adis);
adis_dev_auto_lock() here and in similar places
then you can directly return from error paths.


> +
> +	if (st->sync_mode =3D=3D ADIS16550_SYNC_MODE_SCALED) {
> +		unsigned long scaled_rate =3D lcm(st->clk_freq, freq);
> +		int sync_scale;
> +
> +		if (scaled_rate > max_sample_rate)
> +			scaled_rate =3D max_sample_rate / st->clk_freq * st->clk_freq;
> +		else
> +			scaled_rate =3D max_sample_rate / scaled_rate * scaled_rate;
> +
> +		if (scaled_rate < min_sample_rate)
> +			scaled_rate =3D roundup(min_sample_rate, st->clk_freq);
> +
> +		sync_scale =3D scaled_rate / st->clk_freq;
> +		ret =3D __adis_write_reg_16(&st->adis, ADIS16550_REG_SYNC_SCALE,
> +					  sync_scale);
> +		if (ret)
> +			goto error;
> +
> +		sample_rate =3D scaled_rate;
> +	}
> +
> +	dec =3D DIV_ROUND_CLOSEST(sample_rate, freq);
> +
> +	if (dec)
> +		dec--;
> +
> +	if (dec > st->info->max_dec)
> +		dec =3D st->info->max_dec;

dec =3D min(dec, st->info->max_dec)

> +
> +	ret =3D __adis_write_reg_16(&st->adis, ADIS16550_REG_DEC_RATE, dec);
> +	if (ret)
> +		goto error;
> +
> +	adis_dev_unlock(&st->adis);
> +
> +	return 0;
> +
> +error:
> +	adis_dev_unlock(&st->adis);
> +	return ret;
> +}


> +static int adis16550_read_raw(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      int *val, int *val2, long info)
> +{
> +	struct adis16550 *st =3D iio_priv(indio_dev);
> +	int ret;
> +	const int idx =3D chan->scan_index;
> +	u32 tmp;
> +	u16 scale;
reverse xmas tree.

> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		return adis_single_conversion(indio_dev, chan, 0, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			*val =3D st->info->gyro_max_val;
> +			*val2 =3D st->info->gyro_max_scale;
This level of flexibility only makes sense if you are very soon
going to send additional support for devices where these change.
If you are, state that in the patch description.

> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_ACCEL:
> +			*val =3D st->info->accel_max_val;
> +			*val2 =3D st->info->accel_max_scale;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_TEMP:
> +			*val =3D st->info->temp_scale;
> +			return IIO_VAL_INT;
> +		case IIO_DELTA_ANGL:
> +			*val =3D st->info->deltang_max_val;
> +			*val2 =3D 31;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case IIO_DELTA_VELOCITY:
> +			*val =3D st->info->deltvel_max_val;
> +			*val2 =3D 31;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		/* temperature centered at 25=B0C */
> +		*val =3D DIV_ROUND_CLOSEST(25000, st->info->temp_scale);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret =3D adis_read_reg_32(&st->adis,
> +				       adis16550_calib_bias[idx], val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		ret =3D adis_read_reg_16(&st->adis,
> +				       adis16550_calib_scale[idx], &scale);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D scale;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret =3D adis16550_get_freq(st, &tmp);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D tmp / 1000;
> +		*val2 =3D (tmp % 1000) * 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			ret =3D adis16550_get_accl_filter_freq(st, val);
> +			if (ret)
> +				return ret;
> +			return IIO_VAL_INT;
> +		case IIO_ACCEL:
> +			ret =3D adis16550_get_gyro_filter_freq(st, val);
> +			if (ret)
> +				return ret;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adis16550_write_raw(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       int val, int val2, long info)
> +{
> +	struct adis16550 *st =3D iio_priv(indio_dev);
> +	u32 tmp;
> +	const int idx =3D chan->scan_index;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		tmp =3D val * 1000 + val2 / 1000;
> +		return adis16550_set_freq(st, tmp);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return adis_write_reg_32(&st->adis, adis16550_calib_bias[idx],
> +					 val);
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return adis_write_reg_16(&st->adis, adis16550_calib_scale[idx],
> +					 val);
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			return adis16550_set_accl_filter_freq(st, val);
> +		case IIO_ACCEL:
> +			return adis16550_set_gyro_filter_freq(st, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define ADIS16550_MOD_CHAN(_type, _mod, _address, _si, _r_bits, _s_bits)=
 \
> +	{ \
> +		.type =3D (_type), \
> +		.modified =3D 1, \
> +		.channel2 =3D (_mod), \
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> +			BIT(IIO_CHAN_INFO_CALIBBIAS) | \
> +			BIT(IIO_CHAN_INFO_CALIBSCALE), \
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) | \
> +					    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +		.address =3D (_address), \
> +		.scan_index =3D (_si), \
> +		.scan_type =3D { \
> +			.sign =3D 's', \
> +			.realbits =3D (_r_bits), \
> +			.storagebits =3D (_s_bits), \
As below. These are always 32 , so just fix that for now.

> +			.endianness =3D IIO_BE, \
> +		}, \
> +	}
> +
> +#define ADIS16550_GYRO_CHANNEL(_mod) \
> +	ADIS16550_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_ ## _mod, \
> +	ADIS16550_REG_ ## _mod ## _GYRO, ADIS16550_SCAN_GYRO_ ## _mod, 32, \
> +	32)
> +
> +#define ADIS16550_ACCEL_CHANNEL(_mod) \
> +	ADIS16550_MOD_CHAN(IIO_ACCEL, IIO_MOD_ ## _mod, \
> +	ADIS16550_REG_ ## _mod ## _ACCEL, ADIS16550_SCAN_ACCEL_ ## _mod, 32, \
> +	32)
> +
> +#define ADIS16550_TEMP_CHANNEL() { \
> +		.type =3D IIO_TEMP, \
> +		.indexed =3D 1, \
> +		.channel =3D 0, \
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET), \
> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +		.address =3D ADIS16550_REG_TEMP, \
> +		.scan_index =3D ADIS16550_SCAN_TEMP, \
> +		.scan_type =3D { \
> +			.sign =3D 's', \
> +			.realbits =3D 16, \
Add a comment here on why you aren't storing it in a be16
(I assume because it requires special casing and no one is ever going to
run this device as just a thermometer!

> +			.storagebits =3D 32, \
> +			.endianness =3D IIO_BE, \
> +		}, \
> +	}
> +
> +#define ADIS16550_MOD_CHAN_DELTA(_type, _mod, _address, _si, _r_bits, _s=
_bits) { \
> +		.type =3D (_type), \
> +		.modified =3D 1, \
> +		.channel2 =3D (_mod), \
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +		.address =3D (_address), \
> +		.scan_index =3D _si, \
> +		.scan_type =3D { \
> +			.sign =3D 's', \
> +			.realbits =3D (_r_bits), \
> +			.storagebits =3D (_s_bits), \
If they are always 32, encode them as that and we can revisit when you add
more parts that aren't.=20

> +			.endianness =3D IIO_BE, \
> +		}, \
> +	}
> +
> +#define ADIS16550_DELTANG_CHAN(_mod) \
> +	ADIS16550_MOD_CHAN_DELTA(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
> +			   ADIS16550_REG_ ## _mod ## _DELTANG_L, ADIS16550_SCAN_DELTANG_ ## _=
mod, 32, 32)
> +
> +#define ADIS16550_DELTVEL_CHAN(_mod) \
> +	ADIS16550_MOD_CHAN_DELTA(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
> +			   ADIS16550_REG_ ## _mod ## _DELTVEL_L, ADIS16550_SCAN_DELTVEL_ ## _=
mod, 32, 32)
> +
> +#define ADIS16550_DELTANG_CHAN_NO_SCAN(_mod) \
> +	ADIS16550_MOD_CHAN_DELTA(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
> +			   ADIS16550_REG_ ## _mod ## _DELTANG_L, -1, 32, 32)
> +
> +#define ADIS16550_DELTVEL_CHAN_NO_SCAN(_mod) \
> +	ADIS16550_MOD_CHAN_DELTA(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
> +			   ADIS16550_REG_ ## _mod ## _DELTVEL_L, -1, 32, 32)

> +
> +#define ADIS16550_CHIP_INFO(_name) \
> +	{ \
> +		.num_channels =3D ARRAY_SIZE(adis16550_channels), \
> +		.channels =3D adis16550_channels, \
> +		.name =3D # _name, \

If only the name differs, then use a fallback compatible in DT.
Also do we care about the normal vs w variant?


> +		.gyro_max_val =3D 1, \
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(80 << 16), \
> +		.accel_max_val =3D 1, \
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(102400000), \
> +		.temp_scale =3D 4, \
> +		.deltang_max_val =3D IIO_DEGREE_TO_RAD(720), \
> +		.deltvel_max_val =3D 125, \
> +		.int_clk =3D 4000, \
> +		.max_dec =3D 4095, \
> +		.sync_mode =3D adis16550_sync_modes, \
> +		.num_sync =3D ARRAY_SIZE(adis16550_sync_modes), \
> +	}
> +
> +static const struct adis16550_chip_info adis16550_chip_info[] =3D {
> +	[ADIS16550] =3D
> +		ADIS16550_CHIP_INFO(adis16550),
> +	[ADIS16550W] =3D
> +		ADIS16550_CHIP_INFO(adis16550w),
> +};

We've generally stopped using arrays of chip info structures because
it's easier to read
&adis16550_chip_info, &adis16550w_chip_info

So split this.  Note lots of older drivers do what you have here
so this is more of a 'new' best practice thing than anything
thing else.


> +
> +static u32 adis16550_validate_crc(const u32 *buf, const u8 n_elem,
> +				  const u32 crc)
> +{
> +	u32 crc_calc;
> +	u32 crc_buf[ADIS16550_BURST_N_ELEM - 2];
> +	int j;
> +	/*
> +	 * The crc calculation of the data is done in little endian. Hence, we
> +	 * always swap the 32bit elements making sure that the data LSB is
> +	 * always on address 0...
> +	 */
> +	for (j =3D 0; j < n_elem; j++)
> +		crc_buf[j] =3D swab32(buf[j]);
> +
> +	crc_calc =3D crc32(~0, crc_buf, n_elem * 4);
> +	crc_calc ^=3D ~0;
> +
> +	return (crc_calc =3D=3D crc);
Drop the ()

> +}
> +
> +static irqreturn_t adis16550_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct adis *adis =3D iio_device_get_drvdata(indio_dev);
> +	struct adis16550 *st =3D iio_priv(indio_dev);
> +	__be32 *buffer =3D adis->buffer, data[ADIS16550_MAX_SCAN_DATA];

Separate lines for those two. This is very hard to read.

> +	u32 crc;
> +	u16 dummy;
> +	int ret, bit, i =3D 0;
> +	u8 data_offset =3D 4;
> +	u8 buff_offset =3D 0;
> +	bool valid;
> +
> +	ret =3D spi_sync(adis->spi, &adis->msg);
> +	if (ret)
> +		goto done;
> +	/*
> +	 * Validate the header. The header is a normal spi reply with state
> +	 * vector and crc4.
> +	 */
> +	ret =3D adis16550_spi_validate(&st->adis, buffer[0], &dummy);
> +	if (ret)
> +		goto done;
> +
> +	crc =3D be32_to_cpu(buffer[ADIS16550_BURST_N_ELEM - 1]);
> +	/* the header is not included in the crc */
> +	valid =3D adis16550_validate_crc((u32 *)&buffer[1],
> +				       ADIS16550_BURST_N_ELEM - 2, crc);
> +	if (!valid) {
> +		dev_err(&adis->spi->dev, "Burst Invalid crc!\n");
> +		goto done;
> +	}
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		switch (bit) {
> +		case ADIS16550_SCAN_TEMP:
> +			data[i++] =3D buffer[data_offset - 1];
> +			break;
> +		case ADIS16550_SCAN_DELTANG_X ... ADIS16550_SCAN_DELTVEL_Z:
> +			buff_offset =3D ADIS16550_SCAN_DELTANG_X;

I assume these are contiguous and give available masks you will have
them all if any are set. Use memcpy()
This probably wants to be a bunch of if statements given you should just
check for an indicative element then copy in blocks.


> +			fallthrough;

Just repeat the assignment. The fallthrough makes this harder to read.

> +		case ADIS16550_SCAN_GYRO_X ... ADIS16550_SCAN_ACCEL_Z:
> +			data[i++] =3D buffer[bit + data_offset - buff_offset];
> +			break;
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static const unsigned long adis16550_channel_masks[] =3D {
> +	ADIS16550_BURST_DATA_GYRO_ACCEL_MASK | BIT(ADIS16550_SCAN_TEMP) | BIT(1=
3),
> +	ADIS16550_BURST_DATA_DELTA_ANG_VEL_MASK | BIT(ADIS16550_SCAN_TEMP) | BI=
T(13),

IIRC timestamp is handled separately so shouldn't need to be in here.
I think this is going to end up allocating larger storage than you need
because the timestamp will get counted twice when computing that buffer.

> +	0,
> +};
> +
> +static int adis16550_update_scan_mode(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
> +{
> +	struct adis *adis =3D iio_device_get_drvdata(indio_dev);
> +	u8 *tx;

If no other reason for ordering, pick something like reverse xmas
tree and make the code consistent.

> +	u16 burst_length =3D ADIS16550_BURST_DATA_LEN;
> +	u8 burst_cmd;
> +
> +	if (*scan_mask & ADIS16550_BURST_DATA_GYRO_ACCEL_MASK)
> +		burst_cmd =3D ADIS16550_REG_BURST_GYRO_ACCEL;
> +	else
> +		burst_cmd =3D ADIS16550_REG_BURST_DELTA_ANG_VEL;
> +
> +	kfree(adis->xfer);
> +	kfree(adis->buffer);
> +
> +	adis->xfer =3D kcalloc(2, sizeof(*adis->xfer), GFP_KERNEL);
> +	if (!adis->xfer)
> +		return -ENOMEM;

Always the same size?  Why reallocate it in here - just do it once
at probe, or possibly embed it in the iio_priv() with appropriate
handling to make it dma safe.


> +
> +	adis->buffer =3D kzalloc(burst_length + sizeof(u32), GFP_KERNEL);
Use a local variable to set this up + __free() to clean it up and
finally no_free_ptr() to 'steal' the ownership after all opportunities
for error have passed.

> +	if (!adis->buffer) {
> +		kfree(adis->xfer);
> +		adis->xfer =3D NULL;
> +		return -ENOMEM;
> +	}
> +
> +	tx =3D adis->buffer + burst_length;
> +	tx[0] =3D 0x00;
> +	tx[1] =3D 0x00;
> +	tx[2] =3D burst_cmd;
> +	/* crc4 is 0 on burst command */
> +	tx[3] =3D spi_crc4(get_unaligned_le32(tx));
> +
> +	adis->xfer[0].tx_buf =3D tx;
> +	adis->xfer[0].len =3D 4;
> +	adis->xfer[0].cs_change =3D 1;
> +	adis->xfer[0].delay.value =3D 8;
> +	adis->xfer[0].delay.unit =3D SPI_DELAY_UNIT_USECS;
> +	adis->xfer[1].rx_buf =3D adis->buffer;
> +	adis->xfer[1].len =3D burst_length;
> +
> +	spi_message_init_with_transfers(&adis->msg, adis->xfer, 2);
> +
> +	return 0;
> +}

> +static int adis16550_config_sync(struct adis16550 *st)
> +{
> +	int ret;
> +	const struct adis16550_sync *sync;
> +	struct device *dev =3D &st->adis.spi->dev;
> +	u32 sync_mode;
> +	struct clk *clk;
> +	u16 mode;

I left a comment on the DT binding on this. I'm not sure why we need to exp=
licitly
add a binding for it as opposed to picking right choice based on input clock
frequency and presence or not of the clock.

Maybe you can always pick based just on the clock frequency.
I've not checked the ranges.

> +
> +	if (!device_property_present(dev, "adi,sync-mode")) {
> +		st->clk_freq =3D st->info->int_clk * 1000;
> +		return 0;
> +	}
> +
> +	if (!device_property_match_string(dev, "adi,sync-mode", "direct_sync"))
> +		sync_mode =3D 0;
> +	else if (!device_property_match_string(dev, "adi,sync-mode", "scaled_sy=
nc"))
> +		sync_mode =3D 1;
> +	else
> +		return -EINVAL;
> +
> +	sync =3D &st->info->sync_mode[sync_mode];
> +	st->sync_mode =3D sync->sync_mode;
> +
> +	clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	st->clk_freq =3D clk_get_rate(clk);
> +	if (st->clk_freq > sync->max_rate || st->clk_freq < sync->min_rate)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Clk rate: %lu not in a valid range:[%u %u]\n",
> +				     st->clk_freq, sync->min_rate, sync->max_rate);
> +
> +	if (sync->sync_mode =3D=3D ADIS16550_SYNC_MODE_SCALED) {
> +		u16 sync_scale;
> +		u32 scaled_freq =3D 0;
> +		/*
> +		 * In pps scaled sync we must scale the input clock to a range
> +		 * of [3000 45000].
> +		 */
> +		ret =3D device_property_read_u32(dev, "adi,scaled-output-hz",
> +					       &scaled_freq);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "adi,scaled-output-hz property not found");
> +

Not in the binding Docs that I can see..

> +		if (scaled_freq < 3000 || scaled_freq > 4500)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid value:%u for adi,scaled-output-hz",
> +					     scaled_freq);
> +
> +		sync_scale =3D DIV_ROUND_CLOSEST(scaled_freq, st->clk_freq);
> +
> +		ret =3D adis_write_reg_16(&st->adis, ADIS16550_REG_SYNC_SCALE,
> +					sync_scale);
> +		if (ret)
> +			return ret;
> +
> +		st->clk_freq =3D scaled_freq;
> +	}
> +
> +	st->clk_freq *=3D 1000;
change clk_freq to include a unit.
clk_freq_hz or similar then it should be obvious why the multiplier is need=
ed.


> +
> +	/* set sync mode */

Obvious from the field name. I'd drop the comment as it doesn't add
much.

> +	mode =3D FIELD_PREP(ADIS16550_SYNC_MODE_MASK, sync->sync_mode);
> +	mode |=3D FIELD_PREP(ADIS16550_SYNC_EN_MASK, true);
	mode =3D FIELD_PREP() |
	       FIELD_PREP();

cleaner if it's only two lines like this.

> +
> +	return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
> +				  ADIS16550_SYNC_MASK, mode);
> +}

> +static int adis16550_probe(struct spi_device *spi)
> +{
struct device *dev =3D &spi->dev;
will shorten just enough paths to be worth adding I think.
> +	struct iio_dev *indio_dev;
> +	struct adis16550 *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	st->info =3D  device_get_match_data(&spi->dev);

Extra space before device

> +	if (!st->info)
> +		return -EINVAL;
> +
> +	indio_dev->name =3D st->info->name;
> +	indio_dev->channels =3D st->info->channels;
> +	indio_dev->num_channels =3D st->info->num_channels;
> +	indio_dev->available_scan_masks =3D adis16550_channel_masks;
> +	indio_dev->info =3D &adis16550_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	st->adis.ops =3D &adis16550_ops;
> +
> +	ret =3D devm_regulator_get_enable(&spi->dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to get vdd regulator\n");
> +
> +	ret =3D adis_init(&st->adis, indio_dev, spi, &adis16550_data);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __adis_initial_startup(&st->adis);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D adis16550_config_sync(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> +						 adis16550_trigger_handler);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	adis16550_debugfs_init(indio_dev);
> +
> +	return 0;
> +}


