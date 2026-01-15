Return-Path: <linux-iio+bounces-27831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FBFD24BDB
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 14:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF0FF3015BC5
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DADE3A1A4E;
	Thu, 15 Jan 2026 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBCFbetT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F383A0EB8;
	Thu, 15 Jan 2026 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483934; cv=none; b=UIvtXMfryoskvTxyp/CTG+bhxvSeX4wbiXC3PGMWraSEwWdnrj3WZd8WunjFkv1HcsyPe8PeNAUhhY40WjZw9ez/QYDE66ceqBxcdQpIbHrpae3s0+ADLrQZ1H961lJy6I0S/2HN2L6ZTylsm7KBJXwrbKgDcOhdmDlGl0MrVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483934; c=relaxed/simple;
	bh=ylhEsUw0v05yvkFyZpcE+AW2Pk2PF7K37WhGFPJOwjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISi5xuGmm+JpV7rUP4oXkZFwzHVqMQ5gCs8P01lALqqEWilSvpKluxgVfE70BBfX5RarIl22mriQoLT4wgVh63CwYlJsUTjNBtyHt2+nH2qvQWNBTUVZex8C7AWEHtVgcehExeh4ITOYQ1QKEKsInVQe9ReAvl30ipbVRYFwhqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBCFbetT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7830EC16AAE;
	Thu, 15 Jan 2026 13:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768483933;
	bh=ylhEsUw0v05yvkFyZpcE+AW2Pk2PF7K37WhGFPJOwjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBCFbetTzuo5GRO9T+iE2ht5wNkDKpbns2Q1y75rts+pPyzohn0fEwGaPWBZ4ZocF
	 UGkQ8uAeHWoHXYxUjVH/3mzxXybE3f1LX0ZlUCRK0KRU4y3FllI7LzrM8P4jgJ+gRX
	 z/kqdwcHBjllNoWGG48sA67MiG4ke9xSqEaeM5nc9wjvBrGMgQa+UXRU9CQDIlUl24
	 OZUcoTHeVZrK5vQysISw2d7TYY3X6KERypXp1MwbamMXg+fZ+mZ7kKHWiJE8XU43Wp
	 nvAtK1tHuZGEg1HV9ANTowDqxtuGcwcjd9HKW+N+OOaU/bomycMJYCm2gIxTstQ8KG
	 5Kr8stl/8+98A==
Date: Thu, 15 Jan 2026 14:32:11 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <aWjsWzo3PXHKsdJX@lore-desk>
References: <20260115122431.1014630-1-flavra@baylibre.com>
 <20260115122431.1014630-4-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2dBuyfBb7xoK70FG"
Content-Disposition: inline
In-Reply-To: <20260115122431.1014630-4-flavra@baylibre.com>


--2dBuyfBb7xoK70FG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Some IMU chips in the LSM6DSX family have sensor fusion features that
> combine data from the accelerometer and gyroscope. One of these features
> generates rotation vector data and makes it available in the hardware
> FIFO as a quaternion (more specifically, the X, Y and Z components of the
> quaternion vector, expressed as 16-bit half-precision floating-point
> numbers).
>=20
> Add support for a new sensor instance that allows receiving sensor fusion
> data, by defining a new struct st_lsm6dsx_sf_settings (which contains
> chip-specific details for the sensor fusion functionality), and adding th=
is
> struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
> populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
> logic to initialize an additional IIO device if this struct is populated
> for the hardware type being probed.
> Note: a new IIO device is being defined (as opposed to adding channels to
> an existing device) because the rate at which sensor fusion data is
> generated may not match the data rate from any of the existing devices.
>=20
> Tested on LSMDSV16X.

Nice feature, thx for working on this. I think the patch is fine,
just a couple of Nits inline.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  26 ++-
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  16 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 212 ++++++++++++++++++
>  5 files changed, 307 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_lsm=
6dsx/Makefile
> index 57cbcd67d64f..19a488254de3 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Makefile
> +++ b/drivers/iio/imu/st_lsm6dsx/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  st_lsm6dsx-y :=3D st_lsm6dsx_core.o st_lsm6dsx_buffer.o \
> -		st_lsm6dsx_shub.o
> +		st_lsm6dsx_shub.o st_lsm6dsx_fusion.o
> =20
>  obj-$(CONFIG_IIO_ST_LSM6DSX) +=3D st_lsm6dsx.o
>  obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) +=3D st_lsm6dsx_i2c.o
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 07b1773c87bd..4173f670f7af 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -294,6 +294,7 @@ enum st_lsm6dsx_sensor_id {
>  	ST_LSM6DSX_ID_EXT0,
>  	ST_LSM6DSX_ID_EXT1,
>  	ST_LSM6DSX_ID_EXT2,
> +	ST_LSM6DSX_ID_SF,
>  	ST_LSM6DSX_ID_MAX
>  };
> =20
> @@ -301,6 +302,15 @@ enum st_lsm6dsx_ext_sensor_id {
>  	ST_LSM6DSX_ID_MAGN,
>  };
> =20
> +struct st_lsm6dsx_sf_settings {
> +	const struct iio_chan_spec *chan;
> +	int chan_len;
> +	struct st_lsm6dsx_odr_table_entry odr_table;
> +	struct st_lsm6dsx_reg fifo_enable;
> +	struct st_lsm6dsx_reg page_mux;
> +	struct st_lsm6dsx_reg enable;
> +};
> +
>  /**
>   * struct st_lsm6dsx_ext_dev_settings - i2c controller slave settings
>   * @i2c_addr: I2c slave address list.
> @@ -388,6 +398,7 @@ struct st_lsm6dsx_settings {
>  	struct st_lsm6dsx_hw_ts_settings ts_settings;
>  	struct st_lsm6dsx_shub_settings shub_settings;
>  	struct st_lsm6dsx_event_settings event_settings;
> +	struct st_lsm6dsx_sf_settings sf_settings;
>  };
> =20
>  enum st_lsm6dsx_fifo_mode {
> @@ -510,6 +521,9 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *se=
nsor, u32 odr, u8 *val);
>  int st_lsm6dsx_shub_probe(struct st_lsm6dsx_hw *hw, const char *name);
>  int st_lsm6dsx_shub_set_enable(struct st_lsm6dsx_sensor *sensor, bool en=
able);
>  int st_lsm6dsx_shub_read_output(struct st_lsm6dsx_hw *hw, u8 *data, int =
len);
> +int st_lsm6dsx_sf_probe(struct st_lsm6dsx_hw *hw, const char *name);
> +int st_lsm6dsx_sf_set_enable(struct st_lsm6dsx_sensor *sensor, bool enab=
le);
> +int st_lsm6dsx_sf_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable);
>  int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable);
> =20
>  static inline int
> @@ -564,12 +578,14 @@ st_lsm6dsx_get_mount_matrix(const struct iio_dev *i=
io_dev,
>  static inline int
>  st_lsm6dsx_device_set_enable(struct st_lsm6dsx_sensor *sensor, bool enab=
le)
>  {
> -	if (sensor->id =3D=3D ST_LSM6DSX_ID_EXT0 ||
> -	    sensor->id =3D=3D ST_LSM6DSX_ID_EXT1 ||
> -	    sensor->id =3D=3D ST_LSM6DSX_ID_EXT2)
> +	switch (sensor->id) {
> +	case ST_LSM6DSX_ID_EXT0 ... ST_LSM6DSX_ID_EXT2:
>  		return st_lsm6dsx_shub_set_enable(sensor, enable);
> -
> -	return st_lsm6dsx_sensor_set_enable(sensor, enable);
> +	case ST_LSM6DSX_ID_SF:
> +		return st_lsm6dsx_sf_set_enable(sensor, enable);
> +	default:
> +		return st_lsm6dsx_sensor_set_enable(sensor, enable);
> +	}
>  }
> =20
>  static const
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index cde29b2e6f34..1846b9f84c29 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -88,6 +88,7 @@ enum st_lsm6dsx_fifo_tag {
>  	ST_LSM6DSX_EXT0_TAG =3D 0x0f,
>  	ST_LSM6DSX_EXT1_TAG =3D 0x10,
>  	ST_LSM6DSX_EXT2_TAG =3D 0x11,
> +	ST_LSM6DSX_ROT_TAG =3D 0x13,
>  };
> =20
>  static const
> @@ -226,8 +227,11 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx=
_sensor *sensor,
>  	u8 data;
> =20
>  	/* Only internal sensors have a FIFO ODR configuration register. */
> -	if (sensor->id >=3D ARRAY_SIZE(hw->settings->batch))
> +	if (sensor->id >=3D ARRAY_SIZE(hw->settings->batch)) {
> +		if (sensor->id =3D=3D ST_LSM6DSX_ID_SF)
> +			return st_lsm6dsx_sf_set_odr(sensor, enable);

Nit: please align this to the comment in patch 1/3

>  		return 0;
> +	}
> =20
>  	batch_reg =3D &hw->settings->batch[sensor->id];
>  	if (batch_reg->addr) {
> @@ -580,6 +584,16 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw=
, u8 tag,
>  	case ST_LSM6DSX_EXT2_TAG:
>  		iio_dev =3D hw->iio_devs[ST_LSM6DSX_ID_EXT2];
>  		break;
> +	case ST_LSM6DSX_ROT_TAG:
> +		/*
> +		 * The sensor reports only the {X, Y, Z} elements of the
> +		 * quaternion vector; set the W value to 0 (it can be derived
> +		 * from the {X, Y, Z} values due to the property that the vector
> +		 * is normalized).
> +		 */
> +		*(u16 *)(data + ST_LSM6DSX_SAMPLE_SIZE) =3D 0;
> +		iio_dev =3D hw->iio_devs[ST_LSM6DSX_ID_SF];
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index dc0ae0e488ce..c21163a06a71 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -94,6 +94,24 @@
> =20
>  #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
> =20
> +/* Raw values from the IMU are 16-bit half-precision floating-point numb=
ers. */
> +#define ST_LSM6DSX_CHANNEL_ROT						\
> +{									\
> +	.type =3D IIO_ROT,						\
> +	.modified =3D 1,							\
> +	.channel2 =3D IIO_MOD_QUATERNION,					\
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index =3D 0,						\
> +	.scan_type =3D {							\
> +		.sign =3D 'u',						\
> +		.realbits =3D 16,						\
> +		.storagebits =3D 16,					\
> +		.endianness =3D IIO_LE,					\
> +		.repeat =3D 4,						\
> +	},								\
> +	.ext_info =3D st_lsm6dsx_ext_info,				\
> +}
> +
>  static const struct iio_event_spec st_lsm6dsx_ev_motion[] =3D {
>  	{
>  		.type =3D IIO_EV_TYPE_THRESH,
> @@ -153,6 +171,11 @@ static const struct iio_chan_spec st_lsm6ds0_gyro_ch=
annels[] =3D {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
> =20
> +static const struct iio_chan_spec st_lsm6dsx_sf_channels[] =3D {
> +	ST_LSM6DSX_CHANNEL_ROT,
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
>  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] =3D=
 {
>  	{
>  		.reset =3D {
> @@ -1492,6 +1515,35 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
>  				},
>  			},
>  		},
> +		.sf_settings =3D {
> +			.chan =3D st_lsm6dsx_sf_channels,
> +			.chan_len =3D ARRAY_SIZE(st_lsm6dsx_sf_channels),
> +			.odr_table =3D {
> +				.reg =3D {
> +					.addr =3D 0x5e,
> +					.mask =3D GENMASK(5, 3),
> +				},
> +				.odr_avl[0] =3D {  15000, 0x00 },
> +				.odr_avl[1] =3D {  30000, 0x01 },
> +				.odr_avl[2] =3D {  60000, 0x02 },
> +				.odr_avl[3] =3D { 120000, 0x03 },
> +				.odr_avl[4] =3D { 240000, 0x04 },
> +				.odr_avl[5] =3D { 480000, 0x05 },
> +				.odr_len =3D 6,
> +			},
> +			.fifo_enable =3D {
> +				.addr =3D 0x44,
> +				.mask =3D BIT(1),
> +			},
> +			.page_mux =3D {
> +				.addr =3D 0x01,
> +				.mask =3D BIT(7),
> +			},
> +			.enable =3D {
> +				.addr =3D 0x04,
> +				.mask =3D BIT(1),
> +			},
> +		},
>  	},
>  	{
>  		.reset =3D {
> @@ -2899,6 +2951,12 @@ int st_lsm6dsx_probe(struct device *dev, int irq, =
int hw_id,
>  			return err;
>  	}
> =20
> +	if (hw->settings->sf_settings.chan) {
> +		err =3D st_lsm6dsx_sf_probe(hw, name);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (hw->irq > 0) {
>  		err =3D st_lsm6dsx_irq_setup(hw);
>  		if (err < 0)
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> new file mode 100644
> index 000000000000..3594d97a98ff
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * STMicroelectronics st_lsm6dsx IMU sensor fusion
> + */
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/sprintf.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include "st_lsm6dsx.h"
> +
> +static int
> +st_lsm6dsx_sf_get_odr_val(const struct st_lsm6dsx_sf_settings *settings,
> +			  u32 odr, u8 *val)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < settings->odr_table.odr_len; i++) {
> +		if (settings->odr_table.odr_avl[i].milli_hz =3D=3D odr)
> +			break;
> +	}
> +	if (i =3D=3D settings->odr_table.odr_len)
> +		return -EINVAL;
> +
> +	*val =3D settings->odr_table.odr_avl[i].val;
> +	return 0;
> +}
> +
> +/**
> + * st_lsm6dsx_sf_set_page - Enable or disable access to sensor fusion
> + * configuration registers.
> + * @hw: Sensor hardware instance.
> + * @enable: True to enable access, false to disable access.
> + *
> + * Return: 0 on success, negative value on error.
> + */
> +static int st_lsm6dsx_sf_set_page(struct st_lsm6dsx_hw *hw, bool enable)
> +{
> +	const struct st_lsm6dsx_reg *mux =3D &hw->settings->sf_settings.page_mu=
x;
> +
> +	return regmap_assign_bits(hw->regmap, mux->addr, mux->mask, enable);
> +}
> +
> +int st_lsm6dsx_sf_set_enable(struct st_lsm6dsx_sensor *sensor, bool enab=
le)
> +{
> +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +	const struct st_lsm6dsx_reg *en_reg;
> +	int err;
> +
> +	guard(mutex)(&hw->page_lock);
> +
> +	en_reg =3D &hw->settings->sf_settings.enable;
> +	err =3D st_lsm6dsx_sf_set_page(hw, true);
> +	if (err < 0)
> +		return err;
> +
> +	err =3D regmap_assign_bits(hw->regmap, en_reg->addr, en_reg->mask, enab=
le);
> +	st_lsm6dsx_sf_set_page(hw, false);
> +
> +	return err;
> +}
> +
> +int st_lsm6dsx_sf_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable)
> +{
> +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +	const struct st_lsm6dsx_sf_settings *settings;
> +	u8 data;
> +	int err;
> +
> +	guard(mutex)(&hw->page_lock);
> +
> +	err =3D st_lsm6dsx_sf_set_page(hw, true);
> +	if (err < 0)
> +		return err;
> +
> +	settings =3D &hw->settings->sf_settings;
> +	if (enable) {
> +		u8 odr_val;
> +		const struct st_lsm6dsx_reg *reg =3D &settings->odr_table.reg;
> +
> +		st_lsm6dsx_sf_get_odr_val(settings, sensor->hwfifo_odr_mHz,
> +					  &odr_val);
> +		data =3D ST_LSM6DSX_SHIFT_VAL(odr_val, reg->mask);
> +		err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +					 data);
> +		if (err < 0)
> +			goto out;
> +	}

Nit: new-line here.

> +	err =3D regmap_assign_bits(hw->regmap, settings->fifo_enable.addr,
> +				 settings->fifo_enable.mask, enable);
> +
> +out:
> +	st_lsm6dsx_sf_set_page(hw, false);
> +
> +	return err;
> +}
> +
> +static int st_lsm6dsx_sf_read_raw(struct iio_dev *iio_dev,
> +				  struct iio_chan_spec const *ch,
> +				  int *val, int *val2, long mask)
> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D sensor->hwfifo_odr_mHz / MILLI;
> +		*val2 =3D (sensor->hwfifo_odr_mHz % MILLI) * (MICRO / MILLI);
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int st_lsm6dsx_sf_write_raw(struct iio_dev *iio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   int val, int val2, long mask)
> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> +	const struct st_lsm6dsx_sf_settings *settings;
> +	int err;

I guess err =3D -EINVAL;

> +
> +	settings =3D &sensor->hw->settings->sf_settings;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		u32 odr_mHz;
> +		u8 odr_val;
> +
> +		odr_mHz =3D val * MILLI + val2 * MILLI / MICRO;
> +		err =3D st_lsm6dsx_sf_get_odr_val(settings, odr_mHz, &odr_val);
> +		if (err)
> +			return err;
> +
> +		sensor->hwfifo_odr_mHz =3D odr_mHz;
> +		return 0;

break;

> +	}
> +	default:
> +		return -EINVAL;

break;

> +	}

return err;

> +}
> +
> +static ssize_t st_lsm6dsx_sf_sampling_freq_avail(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(dev_to_iio_dev(dev));
> +	const struct st_lsm6dsx_sf_settings *settings;
> +	int len =3D 0;
> +
> +	settings =3D &sensor->hw->settings->sf_settings;
> +	for (unsigned int i =3D 0; i < settings->odr_table.odr_len; i++) {
> +		u32 val =3D settings->odr_table.odr_avl[i].milli_hz;
> +
> +		len +=3D sysfs_emit_at(buf, len, "%lu.%03lu ", val / MILLI,
> +				     val % MILLI);
> +	}
> +	buf[len - 1] =3D '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sf_sampling_freq_avail);
> +static struct attribute *st_lsm6dsx_sf_attributes[] =3D {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group st_lsm6dsx_sf_attribute_group =3D {
> +	.attrs =3D st_lsm6dsx_sf_attributes,
> +};
> +
> +static const struct iio_info st_lsm6dsx_sf_info =3D {
> +	.attrs =3D &st_lsm6dsx_sf_attribute_group,
> +	.read_raw =3D st_lsm6dsx_sf_read_raw,
> +	.write_raw =3D st_lsm6dsx_sf_write_raw,
> +	.hwfifo_set_watermark =3D st_lsm6dsx_set_watermark,
> +};
> +
> +int st_lsm6dsx_sf_probe(struct st_lsm6dsx_hw *hw, const char *name)
> +{
> +	const struct st_lsm6dsx_sf_settings *settings;
> +	struct st_lsm6dsx_sensor *sensor;
> +	struct iio_dev *iio_dev;
> +
> +	iio_dev =3D devm_iio_device_alloc(hw->dev, sizeof(*sensor));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	settings =3D &hw->settings->sf_settings;
> +	sensor =3D iio_priv(iio_dev);
> +	sensor->id =3D ST_LSM6DSX_ID_SF;
> +	sensor->hw =3D hw;
> +	sensor->hwfifo_odr_mHz =3D settings->odr_table.odr_avl[0].milli_hz;
> +	sensor->watermark =3D 1;
> +	iio_dev->modes =3D INDIO_DIRECT_MODE;
> +	iio_dev->info =3D &st_lsm6dsx_sf_info;
> +	iio_dev->channels =3D settings->chan;
> +	iio_dev->num_channels =3D settings->chan_len;
> +	snprintf(sensor->name, sizeof(sensor->name), "%s_sf", name);
> +	iio_dev->name =3D sensor->name;
> +
> +	/*
> +	 *  Put the IIO device pointer in the iio_devs array so that the caller
> +	 *  can set up a buffer and register this IIO device.
> +	 */
> +	hw->iio_devs[ST_LSM6DSX_ID_SF] =3D iio_dev;
> +
> +	return 0;
> +}
> --=20
> 2.39.5
>=20

--2dBuyfBb7xoK70FG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWjsWwAKCRA6cBh0uS2t
rFFrAP9wzFo39EpP7iUGXI+Rq3hHZw8n/czIQKMjO9nc2ap8igEA2wNTl18WCdi1
6GH0rTmwdNJgMs3pu5O4ekyT9Pizjgs=
=K7lO
-----END PGP SIGNATURE-----

--2dBuyfBb7xoK70FG--

