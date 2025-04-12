Return-Path: <linux-iio+bounces-18033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42671A86F10
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 21:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF6B19E1547
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 19:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041C821A42F;
	Sat, 12 Apr 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG0WSRaP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC682907;
	Sat, 12 Apr 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744485020; cv=none; b=mgK8XYRYcFY48sbP9Xu/xM/VdZc+BZi6PbzmMXJ8hRaCEJcdJW0AoKgiJa75yc8qX6inhmmmSnhDUtqjdKsBLOk32F9JYHWgXlzAtrWQMS4ad4UQB+fTyS74QC7qjErv3TaEOtiuxODimxKDjJ59/CbUsx5sE0t6qvHX2TpWSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744485020; c=relaxed/simple;
	bh=SOijzQmw1+WvqPCWXWzCmpPbJnUPmP4eFeuwtpUxxDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5l2FtS+YIruhaSpEej4Wo5K7lsQgXBj/WCKtrB59THwBXBpdlAXiwIcOEj9pUlOmOw2RqVpDbBvUBWr32otfOC9F66bO6puesBVi0oIU6gMOntEr4FVuCFP+O7R6v4UnjKSeHs3LHAl3tnUGGLsZN2/j9A+8/Y/JEj7VPAbkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG0WSRaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F976C4CEE3;
	Sat, 12 Apr 2025 19:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744485019;
	bh=SOijzQmw1+WvqPCWXWzCmpPbJnUPmP4eFeuwtpUxxDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CG0WSRaP8oQenMwVv4IPMr2n20Gca8QWo0bz4CFSXN5Qsl14XcctQyeWAK5/qhZdh
	 MvJZpZwzb4WA1ogkMcVS3A5jUky94f6+7YbjFs0RzZiAQtFuzUfvPXED83iS7SLbEG
	 2hw4vI+gEPN0XSs4FMjnYh2/sfJjA05+OVs3z3p0miO6vBcgDDdTYlfu0+QqxmUaH0
	 YQ9z+nTnUok56lwFihoORlMZuMw0WAPu7ssuUeUfpB9o3XYeTvT56um0jyILw3urAi
	 ZdcRuYn1BrHJKTjRyC39u8e6gvAsrANte1yRwB1wnZYmMEH81yy6ZV58e66Y6GoMPf
	 2FBkuc8qfMwGA==
Date: Sat, 12 Apr 2025 20:10:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/8] iio: imu: inv_icm45600: add new inv_icm45600 driver
Message-ID: <20250412201013.107bea53@jic23-huawei>
In-Reply-To: <20250411-add_newport_driver-v1-1-15082160b019@tdk.com>
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
	<20250411-add_newport_driver-v1-1-15082160b019@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Apr 2025 13:28:33 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
>=20
> Core component of a new driver for InvenSense ICM-456xx devices.
> It includes:
> - registers definition, main probe/setup, and device
> utility functions.
> - IIO device for gyroscope sensor with data polling interface.
> Attributes: raw, scale, sampling_frequency, calibbias.
> - IIO device for gyroscope sensor with data polling interface.
> Attributes: raw, scale, sampling_frequency, calibbias.
> - Temperature is available as a processed
> channel
>=20
> ICM-456xx devices are latest generation of 6-axis IMU,
> gyroscope+accelerometer and temperature sensor. This device
> includes a 8K FIFO, supports I2C/I3C/SPI, and provides
> intelligent motion features like pedometer, tilt detection,
> and tap detection.
>=20
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
> ---
>  drivers/iio/imu/inv_icm45600/inv_icm45600.h       | 421 ++++++++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c | 902 ++++++++++++++++=
+++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_core.c  | 906 ++++++++++++++++=
+++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c  | 919 ++++++++++++++++=
++++++

Too big. Build this up in stages.  Rule of thumb is don't go over 1000 line=
s in a
single patch without very good reason.  Until you break it up review is lik=
ely
to be rather superficial (as this one is!)

1st patch should just have the core part but it should be complete and buil=
dable
2-4 patches introduce the other driver types.

Code is in pretty good shape from a first look. Various minor things inline.

Jonathan


>  drivers/iio/imu/inv_icm45600/inv_icm45600_temp.c  |  82 ++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_temp.h  |  31 +
>  6 files changed, 3261 insertions(+)
>=20
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/im=
u/inv_icm45600/inv_icm45600.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..6d10b3ffabbcbc054986d6cc0=
011891863b74e1a
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> @@ -0,0 +1,421 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025 Invensense, Inc.
> + */
> +
> +#ifndef INV_ICM45600_H_
> +#define INV_ICM45600_H_
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
This is a lot to find in the way of includes in a header.
Where possible use forward defines for any pointer types and push
as many of these includes as possible down into the c files where
I'm assuming they are mostly relevant.

> +
> +#include "inv_icm45600_buffer.h"
> +
> +#define INV_ICM45600_REG_GET_BANK(_r)	FIELD_GET(GENMASK(15, 8), (_r))
> +#define INV_ICM45600_REG_GET_ADDR(_r)	FIELD_GET(GENMASK(7, 0), (_r))
> +
> +enum inv_icm45600_chip {
> +	INV_CHIP_INVALID,
Why? =20
> +	INV_CHIP_ICM45605,
> +	INV_CHIP_ICM45686,
> +	INV_CHIP_ICM45688P,
> +	INV_CHIP_ICM45608,
> +	INV_CHIP_ICM45634,
> +	INV_CHIP_ICM45689,
> +	INV_CHIP_ICM45606,
> +	INV_CHIP_ICM45687,
> +	INV_CHIP_NB,
No comma on a terminating entry like this.  It always needs to be at the en=
d.
> +};

In general the presence of an enum for the supported chips often indicates
that the driver is doing things in code that should be data.  Basically move
all the device specific stuff into a chip specific config structure.  That
can use callbacks if necessary, but static const data preferred where possi=
ble.

That approach has many times proven to be more scalable and readable as it
brings all the subtleties of a given chip together in one place.

> +
> +enum inv_icm45600_sensor_mode {
> +	INV_ICM45600_SENSOR_MODE_OFF,
> +	INV_ICM45600_SENSOR_MODE_STANDBY,
> +	INV_ICM45600_SENSOR_MODE_LOW_POWER,
> +	INV_ICM45600_SENSOR_MODE_LOW_NOISE,
> +	INV_ICM45600_SENSOR_MODE_NB,

Similar to above. If you have a numbering entry, no trailing comma
as we want it to be the last element.

> +};
> +
> +/* gyroscope fullscale values */
> +enum inv_icm45600_gyro_fs {
Given you have a gyroscope specific file, can we not push this
down into that c file rather than the header?

Try to minimize what is in the shared header.

> +	INV_ICM45600_GYRO_FS_2000DPS,
> +	INV_ICM45600_GYRO_FS_1000DPS,
> +	INV_ICM45600_GYRO_FS_500DPS,
> +	INV_ICM45600_GYRO_FS_250DPS,
> +	INV_ICM45600_GYRO_FS_125DPS,
> +	INV_ICM45600_GYRO_FS_62_5DPS,
> +	INV_ICM45600_GYRO_FS_31_25DPS,
> +	INV_ICM45600_GYRO_FS_15_625DPS,
> +	INV_ICM45600_GYRO_FS_NB,
> +};

Blank line here and similar locations.


> +enum inv_icm45686_gyro_fs {
> +	INV_ICM45686_GYRO_FS_4000DPS,
> +	INV_ICM45686_GYRO_FS_2000DPS,
> +	INV_ICM45686_GYRO_FS_1000DPS,
> +	INV_ICM45686_GYRO_FS_500DPS,
> +	INV_ICM45686_GYRO_FS_250DPS,
> +	INV_ICM45686_GYRO_FS_125DPS,
> +	INV_ICM45686_GYRO_FS_62_5DPS,
> +	INV_ICM45686_GYRO_FS_31_25DPS,
> +	INV_ICM45686_GYRO_FS_15_625DPS,
> +	INV_ICM45686_GYRO_FS_NB,
> +};
> +
> +/* accelerometer fullscale values */
> +enum inv_icm45600_accel_fs {
> +	INV_ICM45600_ACCEL_FS_16G,
> +	INV_ICM45600_ACCEL_FS_8G,
> +	INV_ICM45600_ACCEL_FS_4G,
> +	INV_ICM45600_ACCEL_FS_2G,
> +	INV_ICM45600_ACCEL_FS_NB,
> +};
> +enum inv_icm45686_accel_fs {
> +	INV_ICM45686_ACCEL_FS_32G,
> +	INV_ICM45686_ACCEL_FS_16G,
> +	INV_ICM45686_ACCEL_FS_8G,
> +	INV_ICM45686_ACCEL_FS_4G,
> +	INV_ICM45686_ACCEL_FS_2G,
> +	INV_ICM45686_ACCEL_FS_NB,
> +};
> +
> +/* ODR suffixed by LN or LP are Low-Noise or Low-Power mode only */
> +enum inv_icm45600_odr {
> +	INV_ICM45600_ODR_6400HZ_LN =3D 0x03,
> +	INV_ICM45600_ODR_3200HZ_LN,
> +	INV_ICM45600_ODR_1600HZ_LN,
> +	INV_ICM45600_ODR_800HZ_LN,
> +	INV_ICM45600_ODR_400HZ,
> +	INV_ICM45600_ODR_200HZ,
> +	INV_ICM45600_ODR_100HZ,
> +	INV_ICM45600_ODR_50HZ,
> +	INV_ICM45600_ODR_25HZ,
> +	INV_ICM45600_ODR_12_5HZ,
> +	INV_ICM45600_ODR_6_25HZ_LP,
> +	INV_ICM45600_ODR_3_125HZ_LP,
> +	INV_ICM45600_ODR_1_5625HZ_LP,
> +	INV_ICM45600_ODR_NB,
> +};
> +
> +struct inv_icm45600_sensor_conf {
> +	int mode;
> +	int fs;
> +	int odr;
> +	int filter;
> +};
> +#define INV_ICM45600_SENSOR_CONF_INIT		{-1, -1, -1, -1}
> +
> +struct inv_icm45600_conf {
> +	struct inv_icm45600_sensor_conf gyro;
> +	struct inv_icm45600_sensor_conf accel;
> +};
> +
> +struct inv_icm45600_suspended {
> +	enum inv_icm45600_sensor_mode gyro;
> +	enum inv_icm45600_sensor_mode accel;
> +};
> +
> +/**
> + *  struct inv_icm45600_state - driver state variables
> + *  @lock:		lock for serializing multiple registers access.
> + *  @chip:		chip identifier.
> + *  @name:		chip name.

If this is the state (Rather than config data) why do you need a chip
name here?  iio_dev->name is perhaps enough?


> + *  @map:		regmap pointer.
> + *  @vdd_supply:	VDD voltage regulator for the chip.
Seems this is always on, so no need to store in this structure

> + *  @vddio_supply:	I/O voltage regulator for the chip.
This does need to be here though as you turn it off when suspended.

> + *  @orientation:	sensor chip orientation relative to main hardware.
> + *  @conf:		chip sensors configurations.
> + *  @suspended:		suspended sensors configuration.
> + *  @indio_gyro:	gyroscope IIO device.
> + *  @indio_accel:	accelerometer IIO device.
> + *  @timestamp:		interrupt timestamps.
> + *  @fifo:		FIFO management structure.
> + *  @buffer:		data transfer buffer aligned for DMA.
> + */
> +struct inv_icm45600_state {
> +	struct mutex lock;
> +	enum inv_icm45600_chip chip;
> +	const char *name;
> +	struct regmap *map;
> +	struct regulator *vdd_supply;
> +	struct regulator *vddio_supply;
> +	struct iio_mount_matrix orientation;
> +	struct inv_icm45600_conf conf;
> +	struct inv_icm45600_suspended suspended;
> +	struct iio_dev *indio_gyro;
> +	struct iio_dev *indio_accel;
> +	struct {
> +		int64_t gyro;
> +		int64_t accel;
> +	} timestamp;
> +	struct inv_icm45600_fifo fifo;
> +	uint8_t buffer[2] __aligned(IIO_DMA_MINALIGN);
> +};
> +

1 blank line enough

> +
> +/**
> + * struct inv_icm45600_sensor_state - sensor state variables
> + * @scales:		table of scales.
> + * @scales_len:		length (nb of items) of the scales table.
> + * @power_mode:		sensor requested power mode (for common frequencies)
> + * @ts:			timestamp module states.
> + */
> +struct inv_icm45600_sensor_state {
> +	const int *scales;
> +	size_t scales_len;
> +	enum inv_icm45600_sensor_mode power_mode;
> +	struct inv_sensors_timestamp ts;
> +};
> +
> +/* Virtual register addresses: @bank on MSB (16 bits), @address on LSB */
> +
> +/* Indirect register access */
> +#define INV_ICM45600_REG_IREG_ADDR			0x7C
> +#define INV_ICM45600_REG_IREG_DATA			0x7E
> +
> +/* Direct acces registers */
> +#define INV_ICM45600_REG_MISC2				0x007F
> +#define INV_ICM45600_MISC2_SOFT_RESET			BIT(1)
> +
> +#define INV_ICM45600_REG_DRIVE_CONFIG0			0x0032
> +#define INV_ICM45600_DRIVE_CONFIG0_I2C_MASK		GENMASK(6, 4)
> +#define INV_ICM45600_DRIVE_CONFIG0_I2C(_rate)		\
These 'function' like macros don't really add anything to redability over
just calling the FIELD_PREP inline.

> +		FIELD_PREP(INV_ICM45600_DRIVE_CONFIG0_I2C_MASK, (_rate))
> +#define INV_ICM45600_I2C_SLEW_RATE_7NS				\
> +		INV_ICM45600_DRIVE_CONFIG0_I2C(2)
For these store the value that get written to the filed, not the result
of the FIELD_PREP.=20

> +#define INV_ICM45600_I2C_SLEW_RATE_20NS				\
> +		INV_ICM45600_DRIVE_CONFIG0_I2C(0)
> +#define INV_ICM45600_DRIVE_CONFIG0_SPI_MASK		GENMASK(3, 1)
> +#define INV_ICM45600_DRIVE_CONFIG0_SPI(_rate)		\
> +		FIELD_PREP(INV_ICM45600_DRIVE_CONFIG0_SPI_MASK, (_rate))

Similar to above.  Just have the masks and field values defined, not
the result of using FIELD_PREP() which you should just do inline in the cod=
e.

Same for all the other similar places.

> +#define INV_ICM45600_SPI_SLEW_RATE_0_5NS			\
> +		INV_ICM45600_DRIVE_CONFIG0_SPI(6)

> +
> +/* Sleep times required by the driver */
> +#define INV_ICM45600_POWER_UP_TIME_MS		100

If these are not used in lots of places, just use the value inline but
provide a reference there to the spec to say why the value is what it
is.

> +#define INV_ICM45600_RESET_TIME_MS		1
> +#define INV_ICM45600_ACCEL_STARTUP_TIME_MS	60
> +#define INV_ICM45600_GYRO_STARTUP_TIME_MS	60
> +#define INV_ICM45600_GYRO_STOP_TIME_MS		150
> +#define INV_ICM45600_SUSPEND_DELAY_MS		2000
> +#define INV_ICM45600_IREG_DELAY_US		4



> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c b/drivers/=
iio/imu/inv_icm45600/inv_icm45600_accel.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..3c046cad83474da43509295dd=
5542e40b7a0296a
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c
> @@ -0,0 +1,902 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Invensense, Inc.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include "inv_icm45600_buffer.h"
> +#include "inv_icm45600_temp.h"
> +#include "inv_icm45600.h"
> +
> +#define INV_ICM45600_ACCEL_CHAN(_modifier, _index, _ext_info)		\

I'd put these define nearer where it is used.  That is where we will want
to know how it is defined.

> +	{								\
> +		.type =3D IIO_ACCEL,					\
> +		.modified =3D 1,						\
> +		.channel2 =3D _modifier,					\
> +		.info_mask_separate =3D					\
> +			BIT(IIO_CHAN_INFO_RAW) |			\
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
> +		.info_mask_shared_by_type =3D				\
> +			BIT(IIO_CHAN_INFO_SCALE),			\
> +		.info_mask_shared_by_type_available =3D			\
> +			BIT(IIO_CHAN_INFO_SCALE) |			\
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
> +		.info_mask_shared_by_all =3D				\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +		.info_mask_shared_by_all_available =3D			\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +		.scan_index =3D _index,					\
> +		.scan_type =3D {						\
> +			.sign =3D 's',					\
> +			.realbits =3D 16,					\
> +			.storagebits =3D 16,				\
> +			.endianness =3D IIO_LE,				\
> +		},							\
> +		.ext_info =3D _ext_info,					\
> +	}


> +
> +static int inv_icm45600_accel_power_mode_set(struct iio_dev *indio_dev,
> +					     const struct iio_chan_spec *chan,
> +					     unsigned int idx)
> +{
> +	struct inv_icm45600_state *st =3D iio_device_get_drvdata(indio_dev);
> +	struct inv_icm45600_sensor_state *accel_st =3D iio_priv(indio_dev);
> +	unsigned int val =3D 0;
> +	int power_mode;
> +
> +	if (chan->type !=3D IIO_ACCEL)
> +		return -EINVAL;
> +
> +	if (idx >=3D ARRAY_SIZE(inv_icm45600_accel_power_mode_values))

Given you provided the enum, this probably doesn't need checking. This func=
tion
can't be called with a value that doesn't pass the check that I can see.

> +		return -EINVAL;
> +
> +	if (iio_buffer_enabled(indio_dev))
This is racey and why we have to use
	if (!iio_device_claim_direct(indio_deV))
		return -EBUSY;

and release it explicitly when we don't mind the state changing again.

> +		return -EBUSY;
> +
> +	power_mode =3D inv_icm45600_accel_power_mode_values[idx];
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* prevent change if power mode is not supported by the ODR */
> +	switch (power_mode) {
> +	case INV_ICM45600_SENSOR_MODE_LOW_NOISE:
> +		if (st->conf.accel.odr >=3D INV_ICM45600_ODR_6_25HZ_LP &&
> +		    st->conf.accel.odr <=3D INV_ICM45600_ODR_1_5625HZ_LP)
> +			return -EPERM;
> +		break;
> +	case INV_ICM45600_SENSOR_MODE_LOW_POWER:
> +	default:
The enum only takes two values. Use that as the type and the defualt here
should not be needed.

> +		if (st->conf.accel.odr <=3D INV_ICM45600_ODR_800HZ_LN)
> +			return -EPERM;
> +		break;
> +	}
> +
> +	accel_st->power_mode =3D power_mode;
> +
> +	if (accel_st->power_mode =3D=3D INV_ICM45600_SENSOR_MODE_LOW_POWER)
> +		val =3D INV_ICM45600_SMC_CONTROL_0_ACCEL_LP_CLK_SEL;
> +
> +	return regmap_update_bits(st->map, INV_ICM45600_REG_SMC_CONTROL_0,
> +				INV_ICM45600_SMC_CONTROL_0_ACCEL_LP_CLK_SEL, val);
> +}
> +
> +static int inv_icm45600_accel_power_mode_get(struct iio_dev *indio_dev,
> +					     const struct iio_chan_spec *chan)
> +{
> +	struct inv_icm45600_state *st =3D iio_device_get_drvdata(indio_dev);
> +	struct inv_icm45600_sensor_state *accel_st =3D iio_priv(indio_dev);
> +	unsigned int idx;
> +	int power_mode;
> +
> +	if (chan->type !=3D IIO_ACCEL)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* if sensor is on, returns actual power mode and not configured one */
> +	switch (st->conf.accel.mode) {
> +	case INV_ICM45600_SENSOR_MODE_LOW_POWER:
> +	case INV_ICM45600_SENSOR_MODE_LOW_NOISE:
> +		power_mode =3D st->conf.accel.mode;
> +		break;
> +	default:
> +		power_mode =3D accel_st->power_mode;
> +		break;
> +	}
> +
> +	for (idx =3D 0; idx < ARRAY_SIZE(inv_icm45600_accel_power_mode_values);=
 ++idx) {
> +		if (power_mode =3D=3D inv_icm45600_accel_power_mode_values[idx])
> +			break;
> +	}
> +	if (idx >=3D ARRAY_SIZE(inv_icm45600_accel_power_mode_values))

It's not going to >  Just check =3D=3D

> +		return -EINVAL;
> +
> +	return idx;
> +}
> +
> +static const struct iio_enum inv_icm45600_accel_power_mode_enum =3D {
> +	.items =3D inv_icm45600_accel_power_mode_items,
> +	.num_items =3D ARRAY_SIZE(inv_icm45600_accel_power_mode_items),
> +	.set =3D inv_icm45600_accel_power_mode_set,
> +	.get =3D inv_icm45600_accel_power_mode_get,
> +};
> +
> +static const struct iio_chan_spec_ext_info inv_icm45600_accel_ext_infos[=
] =3D {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm45600_get_mount_matrix),
> +	IIO_ENUM_AVAILABLE("power_mode", IIO_SHARED_BY_TYPE,
> +			   &inv_icm45600_accel_power_mode_enum),
> +	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE,
> +		 &inv_icm45600_accel_power_mode_enum),
> +	{},
	{ }

for all such terminators in IIO.  There is a patch on list from David
fixing all of the existing ones so we finally make this consistent.

> +};
> +
> +static const struct iio_chan_spec inv_icm45600_accel_channels[] =3D {
> +	INV_ICM45600_ACCEL_CHAN(IIO_MOD_X, INV_ICM45600_ACCEL_SCAN_X,
> +				inv_icm45600_accel_ext_infos),
> +	INV_ICM45600_ACCEL_CHAN(IIO_MOD_Y, INV_ICM45600_ACCEL_SCAN_Y,
> +				inv_icm45600_accel_ext_infos),
> +	INV_ICM45600_ACCEL_CHAN(IIO_MOD_Z, INV_ICM45600_ACCEL_SCAN_Z,
> +				inv_icm45600_accel_ext_infos),
> +	INV_ICM45600_TEMP_CHAN(INV_ICM45600_ACCEL_SCAN_TEMP),
> +	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM45600_ACCEL_SCAN_TIMESTAMP),
> +};
> +
> +/*
> + * IIO buffer data: size must be a power of 2 and timestamp aligned
> + * 16 bytes: 6 bytes acceleration, 2 bytes temperature, 8 bytes timestamp
> + */
> +struct inv_icm45600_accel_buffer {
> +	struct inv_icm45600_fifo_sensor_data accel;
> +	int16_t temp;
> +	aligned_s64 timestamp;
> +};
> +
> +#define INV_ICM45600_SCAN_MASK_ACCEL_3AXIS				\
> +	(BIT(INV_ICM45600_ACCEL_SCAN_X) |				\
> +	BIT(INV_ICM45600_ACCEL_SCAN_Y) |				\
> +	BIT(INV_ICM45600_ACCEL_SCAN_Z))
This doesn't add anything over just using all these BIT() in the one
entry in *_scan_masks[]

Always look at a define and check whether it actually improves readability =
enough
to bother.


> +
> +#define INV_ICM45600_SCAN_MASK_TEMP	BIT(INV_ICM45600_ACCEL_SCAN_TEMP)
> +
> +static const unsigned long inv_icm45600_accel_scan_masks[] =3D {
> +	/* 3-axis accel + temperature */
> +	INV_ICM45600_SCAN_MASK_ACCEL_3AXIS | INV_ICM45600_SCAN_MASK_TEMP,
> +	0,
> +};
> +

> +
> +static int inv_icm45600_accel_read_sensor(struct iio_dev *indio_dev,
> +					  struct iio_chan_spec const *chan,
> +					  int16_t *val)
> +{
> +	struct inv_icm45600_state *st =3D iio_device_get_drvdata(indio_dev);
> +	struct inv_icm45600_sensor_state *accel_st =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(st->map);
> +	struct inv_icm45600_sensor_conf conf =3D INV_ICM45600_SENSOR_CONF_INIT;
> +	unsigned int reg;
> +	__le16 *data;
> +	int ret;
> +
> +	if (chan->type !=3D IIO_ACCEL)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg =3D INV_ICM45600_REG_ACCEL_DATA_X;
> +		break;
> +	case IIO_MOD_Y:
> +		reg =3D INV_ICM45600_REG_ACCEL_DATA_Y;
> +		break;
> +	case IIO_MOD_Z:
> +		reg =3D INV_ICM45600_REG_ACCEL_DATA_Z;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	pm_runtime_get_sync(dev);
> +	scoped_guard(mutex, &st->lock) {
> +		/* enable accel sensor */
> +		conf.mode =3D accel_st->power_mode;
> +		ret =3D inv_icm45600_set_accel_conf(st, &conf, NULL);
> +		if (ret)
> +			break;
> +
> +		/* read accel register data */
> +		data =3D (__le16 *)&st->buffer[0];

Consider a union so you can use st->buffer16 when you need the __le16 intep=
retation
of that buffer.

> +		ret =3D regmap_bulk_read(st->map, reg, data, sizeof(*data));
> +		if (ret)
> +			break;
> +
> +		*val =3D (int16_t)le16_to_cpup(data);

Slight preference for sign_extend32() instead of casting to 16 bit int.
Same affect but kind of more obvious what is going on.

> +		if (*val =3D=3D INV_ICM45600_DATA_INVALID)
> +			ret =3D -EINVAL;
> +	}
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +	return ret;
> +}
> +
> +/* IIO format int + nano */
> +static const int inv_icm45600_accel_scale[] =3D {

Often we handle these as a 2D array and cast to a 1D one at the
point of use.  Simplifies the indices.

> +	/* +/- 16G =3D> 0.004788403 m/s-2 */
> +	[2 * INV_ICM45600_ACCEL_FS_16G] =3D 0,
> +	[2 * INV_ICM45600_ACCEL_FS_16G + 1] =3D 4788403,
> +	/* +/- 8G =3D> 0.002394202 m/s-2 */
> +	[2 * INV_ICM45600_ACCEL_FS_8G] =3D 0,
> +	[2 * INV_ICM45600_ACCEL_FS_8G + 1] =3D 2394202,
> +	/* +/- 4G =3D> 0.001197101 m/s-2 */
> +	[2 * INV_ICM45600_ACCEL_FS_4G] =3D 0,
> +	[2 * INV_ICM45600_ACCEL_FS_4G + 1] =3D 1197101,
> +	/* +/- 2G =3D> 0.000598550 m/s-2 */
> +	[2 * INV_ICM45600_ACCEL_FS_2G] =3D 0,
> +	[2 * INV_ICM45600_ACCEL_FS_2G + 1] =3D 598550,
> +};
> +static const int inv_icm45686_accel_scale[] =3D {
> +	/* +/- 32G =3D> 0.009576806 m/s-2 */
> +	[2 * INV_ICM45686_ACCEL_FS_32G] =3D 0,
> +	[2 * INV_ICM45686_ACCEL_FS_32G + 1] =3D 9576806,
> +	/* +/- 16G =3D> 0.004788403 m/s-2 */
> +	[2 * INV_ICM45686_ACCEL_FS_16G] =3D 0,
> +	[2 * INV_ICM45686_ACCEL_FS_16G + 1] =3D 4788403,
> +	/* +/- 8G =3D> 0.002394202 m/s-2 */
> +	[2 * INV_ICM45686_ACCEL_FS_8G] =3D 0,
> +	[2 * INV_ICM45686_ACCEL_FS_8G + 1] =3D 2394202,
> +	/* +/- 4G =3D> 0.001197101 m/s-2 */
> +	[2 * INV_ICM45686_ACCEL_FS_4G] =3D 0,
> +	[2 * INV_ICM45686_ACCEL_FS_4G + 1] =3D 1197101,
> +	/* +/- 2G =3D> 0.000598550 m/s-2 */
> +	[2 * INV_ICM45686_ACCEL_FS_2G] =3D 0,
> +	[2 * INV_ICM45686_ACCEL_FS_2G + 1] =3D 598550,
> +};

> +
> +static int inv_icm45600_accel_write_scale(struct iio_dev *indio_dev,
> +					  int val, int val2)
> +{
> +	struct inv_icm45600_state *st =3D iio_device_get_drvdata(indio_dev);
> +	struct inv_icm45600_sensor_state *accel_st =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(st->map);
> +	unsigned int idx;
> +	struct inv_icm45600_sensor_conf conf =3D INV_ICM45600_SENSOR_CONF_INIT;
> +	int ret;
> +
> +	for (idx =3D 0; idx < accel_st->scales_len; idx +=3D 2) {
> +		if (val =3D=3D accel_st->scales[idx] &&
> +		    val2 =3D=3D accel_st->scales[idx + 1])
> +			break;
> +	}
> +	if (idx >=3D accel_st->scales_len)

As in earlier case. Don't imply it can be > when it can only match.

> +		return -EINVAL;
> +
> +	conf.fs =3D idx / 2;
> +
> +	/* Full scale register starts at 1 for not High FSR parts */
> +	if (accel_st->scales =3D=3D inv_icm45600_accel_scale)
> +		conf.fs++;
> +
> +	pm_runtime_get_sync(dev);
> +	scoped_guard(mutex, &st->lock) {
> +		ret =3D inv_icm45600_set_accel_conf(st, &conf, NULL);
> +	}
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +/* IIO format int + micro */
> +static const int inv_icm45600_accel_odr[] =3D {

Similar to above, consider casting form 2D array so we can have
it easy to read here. Lots of drivers do that for their available attribute=
s.

> +	/* 1.5625Hz */
> +	1, 562500,
> +	/* 3.125Hz */
> +	3, 125000,
> +	/* 6.25Hz */
> +	6, 250000,
> +	/* 12.5Hz */
> +	12, 500000,
> +	/* 25Hz */
> +	25, 0,
> +	/* 50Hz */
> +	50, 0,
> +	/* 100Hz */
> +	100, 0,
> +	/* 200Hz */
> +	200, 0,
> +	/* 400Hz */
> +	400, 0,
> +	/* 800Hz */
> +	800, 0,
> +	/* 1.6kHz */
> +	1600, 0,
> +	/* 3.2kHz */
> +	3200, 0,
> +	/* 6.4kHz */
> +	6400, 0,
> +};
> +
> +static const int inv_icm45600_accel_odr_conv[] =3D {
> +	INV_ICM45600_ODR_1_5625HZ_LP,
> +	INV_ICM45600_ODR_3_125HZ_LP,
> +	INV_ICM45600_ODR_6_25HZ_LP,
> +	INV_ICM45600_ODR_12_5HZ,
> +	INV_ICM45600_ODR_25HZ,
> +	INV_ICM45600_ODR_50HZ,
> +	INV_ICM45600_ODR_100HZ,
> +	INV_ICM45600_ODR_200HZ,
> +	INV_ICM45600_ODR_400HZ,
> +	INV_ICM45600_ODR_800HZ_LN,
> +	INV_ICM45600_ODR_1600HZ_LN,
> +	INV_ICM45600_ODR_3200HZ_LN,
> +	INV_ICM45600_ODR_6400HZ_LN,
> +};


> +struct iio_dev *inv_icm45600_accel_init(struct inv_icm45600_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->map);
> +	const char *name;
> +	struct inv_icm45600_sensor_state *accel_st;
> +	struct inv_sensors_timestamp_chip ts_chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	name =3D devm_kasprintf(dev, GFP_KERNEL, "%s-accel", st->name);
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*accel_st));
> +	if (!indio_dev)
> +		return ERR_PTR(-ENOMEM);
> +	accel_st =3D iio_priv(indio_dev);
> +
> +	switch (st->chip) {

This stuff should be data in a chip specific structure not code here.

	accel_st->scales =3D st->chip_info->scales;
etc.


> +	case INV_CHIP_ICM45686:
> +	case INV_CHIP_ICM45688P:
> +	case INV_CHIP_ICM45689:
> +	case INV_CHIP_ICM45687:
> +		accel_st->scales =3D inv_icm45686_accel_scale;
> +		accel_st->scales_len =3D ARRAY_SIZE(inv_icm45686_accel_scale);
> +		break;
> +	default:
> +		accel_st->scales =3D inv_icm45600_accel_scale;
> +		accel_st->scales_len =3D ARRAY_SIZE(inv_icm45600_accel_scale);
> +		/* Set Accel default FSR */
> +		ret =3D regmap_update_bits(st->map, INV_ICM45600_REG_ACCEL_CONFIG0,
> +					INV_ICM45600_ACCEL_CONFIG0_FS_MASK,
> +					INV_ICM45600_ACCEL_CONFIG0_FS_16G);
> +		if (ret)
> +			return ERR_PTR(ret);
> +		break;
> +	}
> +	/* low-power (LP) mode by default at init, no ULP mode */
> +	accel_st->power_mode =3D INV_ICM45600_SENSOR_MODE_LOW_POWER;
> +	ret =3D regmap_set_bits(st->map, INV_ICM45600_REG_SMC_CONTROL_0,
> +			      INV_ICM45600_SMC_CONTROL_0_ACCEL_LP_CLK_SEL);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	/*
> +	 * clock period is 32kHz (31250ns)
> +	 * jitter is +/- 2% (20 per mille)
> +	 */
> +	ts_chip.clock_period =3D 31250;
> +	ts_chip.jitter =3D 20;
> +	ts_chip.init_period =3D inv_icm45600_odr_to_period(st->conf.accel.odr);
> +	inv_sensors_timestamp_init(&accel_st->ts, &ts_chip);
> +
> +	iio_device_set_drvdata(indio_dev, st);
> +	indio_dev->name =3D name;
> +	indio_dev->info =3D &inv_icm45600_accel_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D inv_icm45600_accel_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(inv_icm45600_accel_channels);
> +	indio_dev->available_scan_masks =3D inv_icm45600_accel_scan_masks;
> +
> +	ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev,
> +					  &inv_icm45600_buffer_ops);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return indio_dev;
> +}
> +
> +int inv_icm45600_accel_parse_fifo(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm45600_state *st =3D iio_device_get_drvdata(indio_dev);
> +	struct inv_icm45600_sensor_state *accel_st =3D iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts =3D &accel_st->ts;
> +	ssize_t i, size;
> +	unsigned int no;
> +	const void *accel, *gyro, *timestamp;

Can't we type these? Using void * is far from ideal from a readability
point of view.

> +	const int8_t *temp;
> +	unsigned int odr;
> +	int64_t ts_val;
> +	struct inv_icm45600_accel_buffer buffer;
> +
> +	/* parse all fifo packets */
> +	for (i =3D 0, no =3D 0; i < st->fifo.count; i +=3D size, ++no) {
> +		size =3D inv_icm45600_fifo_decode_packet(&st->fifo.data[i],
> +				&accel, &gyro, &temp, &timestamp, &odr);
> +		/* quit if error or FIFO is empty */
> +		if (size <=3D 0)
> +			return size;
> +
> +		/* skip packet if no accel data or data is invalid */
> +		if (accel =3D=3D NULL || !inv_icm45600_fifo_is_data_valid(accel))
> +			continue;
> +
> +		/* update odr */
> +		if (odr & INV_ICM45600_SENSOR_ACCEL)
> +			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
> +							 st->fifo.nb.total, no);
> +
> +		/* buffer is copied to userspace, zeroing it to avoid any data leak */
> +		memset(&buffer, 0, sizeof(buffer));
> +		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
> +		/* convert 8 bits FIFO temperature in high resolution format */
> +		buffer.temp =3D temp ? (*temp * 64) : 0;
> +		ts_val =3D inv_sensors_timestamp_pop(ts);
> +		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/i=
io/imu/inv_icm45600/inv_icm45600_core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..66e9826005a9fecf5b154c0a1=
308a4c4f40c4edd
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> @@ -0,0 +1,906 @@

> +
> +static int inv_icm45600_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	uint8_t *d =3D (uint8_t *)data;
> +	unsigned int reg =3D (unsigned int) be16_to_cpup(data);
> +	struct regmap *map =3D context;
> +
> +	if (INV_ICM45600_REG_GET_BANK(reg) =3D=3D 0)
> +		return regmap_bulk_write(map, INV_ICM45600_REG_GET_ADDR(reg),
> +					d+2, count-2);
> +
> +	return inv_icm45600_ireg_write(map, reg, d+2, count-2);
> +}
single blank line.
> +
> +
> +static const struct regmap_bus inv_icm45600_regmap_bus =3D {
> +	.read =3D inv_icm45600_read,

> +
> +static const struct inv_icm45600_hw inv_icm45600_hw[INV_CHIP_NB] =3D {

These arrays have tended to prove a design mistake in other drivers.
Instead just have extern in the header so the individual bus drivers
can reference each structure instance in their match tables.

> +	[INV_CHIP_ICM45605] =3D {
> +		.whoami =3D INV_ICM45600_WHOAMI_ICM45605,
> +		.name =3D "icm45605",
> +		.conf =3D &inv_icm45600_default_conf,
> +	},
> +	[INV_CHIP_ICM45686] =3D {
> +		.whoami =3D INV_ICM45600_WHOAMI_ICM45686,
> +		.name =3D "icm45686",
> +		.conf =3D &inv_icm45686_default_conf,
> +	},
> +	[INV_CHIP_ICM45688P] =3D {
> +		.whoami =3D INV_ICM45600_WHOAMI_ICM45688P,
> +		.name =3D "icm45688p",
> +		.conf =3D &inv_icm45686_default_conf,
> +	},
> +	[INV_CHIP_ICM45608] =3D {
> +		.whoami =3D INV_ICM45600_WHOAMI_ICM45608,
> +		.name =3D "icm45608",
> +		.conf =3D &inv_icm45600_default_conf,
> +	},
> +	[INV_CHIP_ICM45634] =3D {
> +		.whoami =3D INV_ICM45600_WHOAMI_ICM45634,
> +		.name =3D "icm45634",
> +		.conf =3D &inv_icm45600_default_conf,
> +	},
> +	[INV_CHIP_ICM45689] =3D {
> +		.whoami =3D INV_ICM45600_WHOAMI_ICM45689,
> +		.name =3D "icm45689",
> +		.conf =3D &inv_icm45686_default_conf,
> +	},
> +	[INV_CHIP_ICM45606] =3D {
> +		.whoami =3D INV_ICM45600_WHOAMI_ICM45606,
> +		.name =3D "icm45606",
> +		.conf =3D &inv_icm45600_default_conf,
> +	},
> +	[INV_CHIP_ICM45687] =3D {
> +		.whoami =3D INV_ICM45600_WHOAMI_ICM45687,
> +		.name =3D "icm45687",
> +		.conf =3D &inv_icm45686_default_conf,
> +	},
> +};
> +
>
> +
> +int inv_icm45600_set_gyro_conf(struct inv_icm45600_state *st,
> +			       struct inv_icm45600_sensor_conf *conf,
> +			       unsigned int *sleep_ms)
> +{
> +	struct inv_icm45600_sensor_conf *oldconf =3D &st->conf.gyro;
> +	unsigned int val;
> +	int ret;
> +
> +	/* sanitize missing values with current values */
> +	if (conf->mode < 0)
> +		conf->mode =3D oldconf->mode;
> +	if (conf->fs < 0)
> +		conf->fs =3D oldconf->fs;
> +	if (conf->odr < 0)
> +		conf->odr =3D oldconf->odr;
> +	if (conf->filter < 0)
> +		conf->filter =3D oldconf->filter;
> +
> +	/* force power mode against ODR when sensor is on */
> +	switch (conf->mode) {
> +	case INV_ICM45600_SENSOR_MODE_LOW_POWER:
> +		if (conf->odr !=3D INV_ICM45600_ODR_400HZ)
> +			conf->filter =3D INV_ICM45600_GYRO_LP_AVG_SEL_8X;
> +		else
> +			conf->filter =3D INV_ICM45600_GYRO_LP_AVG_SEL_2X;
> +		if (conf->odr <=3D INV_ICM45600_ODR_800HZ_LN)
> +			conf->mode =3D INV_ICM45600_SENSOR_MODE_LOW_NOISE;
> +		break;
> +	case INV_ICM45600_SENSOR_MODE_LOW_NOISE:
> +		if (conf->odr >=3D INV_ICM45600_ODR_6_25HZ_LP &&
> +			   conf->odr <=3D INV_ICM45600_ODR_1_5625HZ_LP) {
> +			conf->mode =3D INV_ICM45600_SENSOR_MODE_LOW_POWER;
> +			conf->filter =3D INV_ICM45600_GYRO_LP_AVG_SEL_8X;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/* set GYRO_CONFIG0 register (gyro fullscale & odr) */
> +	if (conf->fs !=3D oldconf->fs || conf->odr !=3D oldconf->odr) {
> +		val =3D INV_ICM45600_GYRO_CONFIG0_FS(conf->fs) |
> +		      INV_ICM45600_GYRO_CONFIG0_ODR(conf->odr);
> +		ret =3D regmap_write(st->map, INV_ICM45600_REG_GYRO_CONFIG0, val);
> +		if (ret)
> +			return ret;
> +		oldconf->fs =3D conf->fs;
> +		oldconf->odr =3D conf->odr;
> +	}
> +
> +	/* set GYRO_LP_AVG_SEL register (gyro low-power average filter) */
> +	if (conf->filter !=3D oldconf->filter) {
> +		ret =3D regmap_update_bits(st->map, INV_ICM45600_IPREG_SYS1_REG_170,
> +			INV_ICM45600_IPREG_SYS1_REG_170_MASK, conf->filter);
> +		if (ret)
> +			return ret;
> +		oldconf->filter =3D conf->filter;
> +	}
> +
> +	/* set PWR_MGMT0 register (gyro sensor mode) */
> +	return inv_icm45600_set_pwr_mgmt0(st, conf->mode, st->conf.accel.mode,
> +					  sleep_ms);
> +
> +	return 0;
can't get here.

> +}

> +
> +static void inv_icm45600_disable_pm(void *_data)
> +{
> +	struct device *dev =3D _data;
> +
> +	pm_runtime_put_sync(dev);
This put makes me wonder what it is balancing.=20
> +	pm_runtime_disable(dev);
This one should be handled by devm_pm_runtime_enable()
though that has some issues we are working out with some power domains.

> +}
> +
> +int inv_icm45600_core_probe(struct regmap *regmap, int chip, bool reset,
> +			    inv_icm45600_bus_setup bus_setup)
> +{
> +	struct device *dev =3D regmap_get_device(regmap);
> +	struct fwnode_handle *fwnode;
> +	struct inv_icm45600_state *st;
> +	struct regmap *regmap_custom;
> +	int irq, irq_type;
> +	bool open_drain;
> +	int ret;
> +
> +	if (chip <=3D INV_CHIP_INVALID || chip >=3D INV_CHIP_NB) {
We should never all this function if we can't guarantee those.
I don't like the enum as stated above but this check is down
to the use of int chip rather than enum in the parameters.
(+ the invalid thing that we don't need anyway that I can see).

> +		dev_err(dev, "invalid chip =3D %d\n", chip);
For all probe related error prints please use
		return dev_err_probe(dev, -ENODEV, "...")
It uses fewer lines and where deferral can happen deals with it cleanly
plus sets up some debug stuff.

> +		return -ENODEV;
> +	}
> +
> +	/* get INT1 only supported interrupt */
> +	fwnode =3D dev_fwnode(dev);
> +	if (!fwnode)
> +		return -ENODEV;
> +	irq =3D fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq < 0) {
> +		if (irq !=3D -EPROBE_DEFER)
> +			dev_err(dev, "error missing INT1 interrupt\n");
> +		return irq;
> +	}
> +
> +	irq_type =3D irq_get_trigger_type(irq);
> +	if (!irq_type)
> +		irq_type =3D IRQF_TRIGGER_FALLING;

This should never happen unless we have a bug in the firmware so
shouldn't need the fallback.

> +
> +	open_drain =3D device_property_read_bool(dev, "drive-open-drain");
> +
> +	regmap_custom =3D devm_regmap_init(dev, &inv_icm45600_regmap_bus,
> +					 regmap, &inv_icm45600_regmap_config);
> +	if (IS_ERR(regmap_custom)) {
> +		dev_err(dev, "Failed to register icm45600 regmap %ld\n", PTR_ERR(regma=
p_custom));
> +		return PTR_ERR(regmap_custom);
> +	}
> +
> +	st =3D devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, st);
> +	mutex_init(&st->lock);
	ret =3D devm_mutex_init();=20
	if (ret)
		return ret;

We are doing this for new code as it provides small debug advantages and wi=
th
devm doesn't add much complexity.
=20
> +	st->chip =3D chip;
> +	st->map =3D regmap_custom;
> +
> +	ret =3D iio_read_mount_matrix(dev, &st->orientation);
> +	if (ret) {
> +		dev_err(dev, "failed to retrieve mounting matrix %d\n", ret);
> +		return ret;
> +	}
> +
> +	st->vdd_supply =3D devm_regulator_get(dev, "vdd");

devm_regulator_get_enabled() and no need to store in the state
structure or use a custom devm callback.

> +	if (IS_ERR(st->vdd_supply))
> +		return PTR_ERR(st->vdd_supply);
> +
> +	st->vddio_supply =3D devm_regulator_get(dev, "vddio");
> +	if (IS_ERR(st->vddio_supply))
> +		return PTR_ERR(st->vddio_supply);
> +
> +	ret =3D regulator_enable(st->vdd_supply);
> +	if (ret)
> +		return ret;
> +	msleep(INV_ICM45600_POWER_UP_TIME_MS);
> +
> +	ret =3D devm_add_action_or_reset(dev, inv_icm45600_disable_vdd_reg, st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D inv_icm45600_enable_regulator_vddio(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev, inv_icm45600_disable_vddio_reg, s=
t);
> +	if (ret)
> +		return ret;
> +
> +	/* setup chip registers */
> +	ret =3D inv_icm45600_setup(st, reset, bus_setup);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D inv_icm45600_timestamp_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D inv_icm45600_buffer_init(st);
> +	if (ret)
> +		return ret;
> +
> +	st->indio_gyro =3D inv_icm45600_gyro_init(st);
> +	if (IS_ERR(st->indio_gyro))
> +		return PTR_ERR(st->indio_gyro);
> +
> +	st->indio_accel =3D inv_icm45600_accel_init(st);
> +	if (IS_ERR(st->indio_accel))
> +		return PTR_ERR(st->indio_accel);
> +
> +	ret =3D inv_icm45600_irq_init(st, irq, irq_type, open_drain);
> +	if (ret)
> +		return ret;
> +
> +	/* setup runtime power management */
> +	ret =3D pm_runtime_set_active(dev);
> +	if (ret)
> +		return ret;
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_enable(dev);

devm_pm_runtime_enable() which will correctly turn off autosuspend (unlike =
this
code).

> +	pm_runtime_set_autosuspend_delay(dev, INV_ICM45600_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_put(dev);
> +
> +	return devm_add_action_or_reset(dev, inv_icm45600_disable_pm, dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(inv_icm45600_core_probe, "IIO_ICM45600");


> +/* Sensors are enabled by iio devices, no need to turn them back on here=
. */
> +static int inv_icm45600_runtime_resume(struct device *dev)
> +{
> +	struct inv_icm45600_state *st =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret =3D inv_icm45600_enable_regulator_vddio(st);
return inv_icm...

> +
> +	return ret;
> +}

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c b/drivers/i=
io/imu/inv_icm45600/inv_icm45600_gyro.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4ada93f990c1ffdc1e0a00ae7=
c78e03c09d1c682
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c

I assumed this was similar to accelerometer and for this version won't read=
 it.



> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_temp.c b/drivers/i=
io/imu/inv_icm45600/inv_icm45600_temp.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b2b5697da407de0a0338841eb=
858b4322996923c
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_temp.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Invensense, Inc.
> + */
Push this into the core file.  It doesn't need it's own place to live
given how simple it is.

> +
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include "inv_icm45600_temp.h"
> +#include "inv_icm45600.h"
> +
> +static int inv_icm45600_temp_read(struct inv_icm45600_state *st, int16_t=
 *temp)
> +{
> +	struct device *dev =3D regmap_get_device(st->map);
> +	__le16 *raw;
> +	int ret;
> +
> +	pm_runtime_get_sync(dev);
> +	scoped_guard(mutex, &st->lock) {
> +		raw =3D (__le16 *)&st->buffer[0];
> +		ret =3D regmap_bulk_read(st->map, INV_ICM45600_REG_TEMP_DATA, raw, siz=
eof(*raw));
> +		if (ret)
> +			break;
> +
> +		*temp =3D (int16_t)le16_to_cpup(raw);
> +		if (*temp =3D=3D INV_ICM45600_DATA_INVALID)
> +			ret =3D -EINVAL;
> +	}
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +int inv_icm45600_temp_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int *val, int *val2, long mask)
> +{
> +	struct inv_icm45600_state *st =3D iio_device_get_drvdata(indio_dev);
> +	int16_t temp;
> +	int ret;
> +
> +	if (chan->type !=3D IIO_TEMP)
> +		return -EINVAL;
> +
> +	/* temperature sensor work only with accel and/or gyro */
> +	if (st->conf.accel.mode <=3D INV_ICM45600_SENSOR_MODE_STANDBY &&
> +		st->conf.gyro.mode  <=3D INV_ICM45600_SENSOR_MODE_STANDBY) {
> +		return -ENODATA;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D inv_icm45600_temp_read(st, &temp);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +		*val =3D temp;
> +		return IIO_VAL_INT;
> +	/*
> +	 * T=C2=B0C =3D (temp / 128) + 25
> +	 * Tm=C2=B0C =3D 1000 * ((temp * 100 / 12800) + 25)
> +	 * scale: 100000 / 13248 =3D 7.8125
> +	 * offset: 25000
> +	 */
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 7;
> +		*val2 =3D 812500;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D 25000;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_temp.h b/drivers/i=
io/imu/inv_icm45600/inv_icm45600_temp.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..1b93e1417e2ec1292e44f05b9=
8c6393354c5297c
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_temp.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025 Invensense, Inc.
> + */
> +
> +#ifndef INV_ICM45600_TEMP_H_
> +#define INV_ICM45600_TEMP_H_
> +
> +#include <linux/iio/iio.h>
> +
Put this in the core header.

> +#define INV_ICM45600_TEMP_CHAN(_index)					\
> +	{								\
> +		.type =3D IIO_TEMP,					\
> +		.info_mask_separate =3D					\
> +			BIT(IIO_CHAN_INFO_RAW) |			\
> +			BIT(IIO_CHAN_INFO_OFFSET) |			\
> +			BIT(IIO_CHAN_INFO_SCALE),			\
> +		.scan_index =3D _index,					\
> +		.scan_type =3D {						\
> +			.sign =3D 's',					\
> +			.realbits =3D 16,					\
> +			.storagebits =3D 16,				\
> +			.endianness =3D IIO_LE,				\
> +		},							\
> +	}
> +
> +int inv_icm45600_temp_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int *val, int *val2, long mask);
> +
> +#endif
>=20


