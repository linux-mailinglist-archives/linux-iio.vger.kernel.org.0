Return-Path: <linux-iio+bounces-25689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC056C21460
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 17:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB7224E8919
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E412DF3D1;
	Thu, 30 Oct 2025 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8obaozL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7F277C96;
	Thu, 30 Oct 2025 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842548; cv=none; b=aXXFlhTPGbZkxIRBtEXrTErKrWV9B40vQaqFsVd8L3QUcycE+/o74cGm3SOXeNwFrlblno+mr57UVkrtC0p0ot1x+qKNy2MjyqREUBWhV4iVcWL8Qq4JYbSs4QjuVJgL6dqAtw3nd2yeMzF7628LxE5H6ljf0D0LMb4/4jmnxJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842548; c=relaxed/simple;
	bh=0IQFFDlxl9LPu85l9AkvRne4bRDfULuqaqsDAoZsvSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut7OE0C6bpu3eKFOwCe7ooKeJZXRaRk65vBCQ11EDuDP8dFTuwEEeuKg7lLM52U45GELcQw42WVr5BdaCc10V5cytSxZlIJvKPw40cDzvjFUuf+wmHc79163t9u1joctPeK8WPsKZUykqc8DQAnDeUaGWPAiJGAHHlkIz1fuL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8obaozL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B026BC4CEF1;
	Thu, 30 Oct 2025 16:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761842548;
	bh=0IQFFDlxl9LPu85l9AkvRne4bRDfULuqaqsDAoZsvSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8obaozLTXOAHjCzu04/OJ8Z0vq6UdAFuFuWx/UxW0NCx9lOifaR8uc9qmpbfE4ht
	 xvYYvZw990Je5AKKt7zdEAjtIxJiCPNGxSdixXGDyrbrQx5vBTHJMIFqZnP4uiP02T
	 ch8uYBWCixK6L8v1jg4kigXwL94LgShZYKaDNFA3TXo8f2mpp6tmOnUqiFMB0xPakE
	 u0xPzoGABZHUZFM7MZyUDzDcRH9Pykd7HmCxp/wKQX++JbHn3p0Z/MDT6LGZr8wlz0
	 ZNlv4Tqy+9G4ag0CO2g0BXQj9HP+YPQ8DSsX6sZnu8ILTgV/xgFKFIG3fBkqZZTx9C
	 P2sV3DM+M9AQQ==
Date: Thu, 30 Oct 2025 17:42:24 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize
 iio_chan_spec data
Message-ID: <aQOVcCinTd-ZJJX3@lore-desk>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-2-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YQQtpU9Ze4ampjl4"
Content-Disposition: inline
In-Reply-To: <20251030072752.349633-2-flavra@baylibre.com>


--YQQtpU9Ze4ampjl4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Using the ST_LSM6DSX_CHANNEL_ACC() macro as a static initializer
> for the iio_chan_spec struct arrays makes all sensors advertise
> channel event capabilities regardless of whether they actually
> support event generation. And if userspace tries to configure
> accelerometer wakeup events on a sensor device that does not
> support them (e.g. LSM6DS0), st_lsm6dsx_write_event() dereferences
> a NULL pointer when trying to write to the wakeup register.
> Replace usage of the ST_LSM6DSX_CHANNEL_ACC() and
> ST_LSM6DSX_CHANNEL() macros with dynamic allocation and
> initialization of struct iio_chan_spec arrays, where the
> st_lsm6dsx_event structure is only used for sensors that support
> wakeup events; besides fixing the above bug, this serves as a
> preliminary step for adding support for more event types.

I agree we are missing the Fixes tag here.

>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  26 +--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 164 ++++++++-----------
>  2 files changed, 71 insertions(+), 119 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index a4f558899767..db863bd1898d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -80,27 +80,6 @@ enum st_lsm6dsx_hw_id {
>  					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
>  #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
> =20
> -#define ST_LSM6DSX_CHANNEL_ACC(chan_type, addr, mod, scan_idx)		\
> -{									\
> -	.type =3D chan_type,						\
> -	.address =3D addr,						\
> -	.modified =3D 1,							\
> -	.channel2 =3D mod,						\
> -	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> -	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),		\
> -	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> -	.scan_index =3D scan_idx,						\
> -	.scan_type =3D {							\
> -		.sign =3D 's',						\
> -		.realbits =3D 16,						\
> -		.storagebits =3D 16,					\
> -		.endianness =3D IIO_LE,					\
> -	},								\
> -	.event_spec =3D &st_lsm6dsx_event,				\
> -	.ext_info =3D st_lsm6dsx_ext_info,				\
> -	.num_event_specs =3D 1,						\
> -}
> -
>  #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
>  {									\
>  	.type =3D chan_type,						\
> @@ -328,10 +307,7 @@ struct st_lsm6dsx_settings {
>  		const char *name;
>  		u8 wai;
>  	} id[ST_LSM6DSX_MAX_ID];
> -	struct {
> -		const struct iio_chan_spec *chan;
> -		int len;
> -	} channels[2];
> +	u8 chan_addr_base[2];

nit: chan_addr[2]

>  	struct {
>  		struct st_lsm6dsx_reg irq1;
>  		struct st_lsm6dsx_reg irq2;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 216160549b5a..17b46e15cce5 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -96,26 +96,7 @@
> =20
>  #define ST_LSM6DSX_TS_SENSITIVITY		25000UL /* 25us */
> =20
> -static const struct iio_chan_spec st_lsm6dsx_acc_channels[] =3D {
> -	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
> -	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
> -	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
> -	IIO_CHAN_SOFT_TIMESTAMP(3),
> -};
> -
> -static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] =3D {
> -	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x22, IIO_MOD_X, 0),
> -	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x24, IIO_MOD_Y, 1),
> -	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x26, IIO_MOD_Z, 2),
> -	IIO_CHAN_SOFT_TIMESTAMP(3),
> -};
> -
> -static const struct iio_chan_spec st_lsm6ds0_gyro_channels[] =3D {
> -	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x18, IIO_MOD_X, 0),
> -	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x1a, IIO_MOD_Y, 1),
> -	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x1c, IIO_MOD_Z, 2),
> -	IIO_CHAN_SOFT_TIMESTAMP(3),
> -};
> +#define ST_LSM6DSX_CHAN_COUNT		4
> =20
>  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] =3D=
 {
>  	{
> @@ -142,15 +123,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.wai =3D 0x68,
>  			},
>  		},
> -		.channels =3D {
> -			[ST_LSM6DSX_ID_ACC] =3D {
> -				.chan =3D st_lsm6dsx_acc_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_acc_channels),
> -			},
> -			[ST_LSM6DSX_ID_GYRO] =3D {
> -				.chan =3D st_lsm6ds0_gyro_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6ds0_gyro_channels),
> -			},
> +		.chan_addr_base =3D {
> +			[ST_LSM6DSX_ID_ACC] =3D 0x28,
> +			[ST_LSM6DSX_ID_GYRO] =3D 0x18,
>  		},
>  		.odr_table =3D {
>  			[ST_LSM6DSX_ID_ACC] =3D {
> @@ -246,15 +221,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.wai =3D 0x69,
>  			},
>  		},
> -		.channels =3D {
> -			[ST_LSM6DSX_ID_ACC] =3D {
> -				.chan =3D st_lsm6dsx_acc_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_acc_channels),
> -			},
> -			[ST_LSM6DSX_ID_GYRO] =3D {
> -				.chan =3D st_lsm6dsx_gyro_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_gyro_channels),
> -			},
> +		.chan_addr_base =3D {
> +			[ST_LSM6DSX_ID_ACC] =3D 0x28,
> +			[ST_LSM6DSX_ID_GYRO] =3D 0x22,
>  		},
>  		.odr_table =3D {
>  			[ST_LSM6DSX_ID_ACC] =3D {
> @@ -412,15 +381,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.wai =3D 0x69,
>  			},
>  		},
> -		.channels =3D {
> -			[ST_LSM6DSX_ID_ACC] =3D {
> -				.chan =3D st_lsm6dsx_acc_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_acc_channels),
> -			},
> -			[ST_LSM6DSX_ID_GYRO] =3D {
> -				.chan =3D st_lsm6dsx_gyro_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_gyro_channels),
> -			},
> +		.chan_addr_base =3D {
> +			[ST_LSM6DSX_ID_ACC] =3D 0x28,
> +			[ST_LSM6DSX_ID_GYRO] =3D 0x22,
>  		},
>  		.odr_table =3D {
>  			[ST_LSM6DSX_ID_ACC] =3D {
> @@ -590,15 +553,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.wai =3D 0x6a,
>  			},
>  		},
> -		.channels =3D {
> -			[ST_LSM6DSX_ID_ACC] =3D {
> -				.chan =3D st_lsm6dsx_acc_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_acc_channels),
> -			},
> -			[ST_LSM6DSX_ID_GYRO] =3D {
> -				.chan =3D st_lsm6dsx_gyro_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_gyro_channels),
> -			},
> +		.chan_addr_base =3D {
> +			[ST_LSM6DSX_ID_ACC] =3D 0x28,
> +			[ST_LSM6DSX_ID_GYRO] =3D 0x22,
>  		},
>  		.odr_table =3D {
>  			[ST_LSM6DSX_ID_ACC] =3D {
> @@ -847,15 +804,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.wai =3D 0x6d,
>  			},
>  		},
> -		.channels =3D {
> -			[ST_LSM6DSX_ID_ACC] =3D {
> -				.chan =3D st_lsm6dsx_acc_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_acc_channels),
> -			},
> -			[ST_LSM6DSX_ID_GYRO] =3D {
> -				.chan =3D st_lsm6dsx_gyro_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_gyro_channels),
> -			},
> +		.chan_addr_base =3D {
> +			[ST_LSM6DSX_ID_ACC] =3D 0x28,
> +			[ST_LSM6DSX_ID_GYRO] =3D 0x22,
>  		},
>  		.drdy_mask =3D {
>  			.addr =3D 0x13,
> @@ -1060,15 +1011,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
>  				.wai =3D 0x6b,
>  			},
>  		},
> -		.channels =3D {
> -			[ST_LSM6DSX_ID_ACC] =3D {
> -				.chan =3D st_lsm6dsx_acc_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_acc_channels),
> -			},
> -			[ST_LSM6DSX_ID_GYRO] =3D {
> -				.chan =3D st_lsm6dsx_gyro_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_gyro_channels),
> -			},
> +		.chan_addr_base =3D {
> +			[ST_LSM6DSX_ID_ACC] =3D 0x28,
> +			[ST_LSM6DSX_ID_GYRO] =3D 0x22,
>  		},
>  		.drdy_mask =3D {
>  			.addr =3D 0x13,
> @@ -1237,15 +1182,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
>  				.wai =3D 0x70,
>  			},
>  		},
> -		.channels =3D {
> -			[ST_LSM6DSX_ID_ACC] =3D {
> -				.chan =3D st_lsm6dsx_acc_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_acc_channels),
> -			},
> -			[ST_LSM6DSX_ID_GYRO] =3D {
> -				.chan =3D st_lsm6dsx_gyro_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_gyro_channels),
> -			},
> +		.chan_addr_base =3D {
> +			[ST_LSM6DSX_ID_ACC] =3D 0x28,
> +			[ST_LSM6DSX_ID_GYRO] =3D 0x22,
>  		},
>  		.drdy_mask =3D {
>  			.addr =3D 0x13,
> @@ -1443,15 +1382,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
>  				.wai =3D 0x22,
>  			}
>  		},
> -		.channels =3D {
> -			[ST_LSM6DSX_ID_ACC] =3D {
> -				.chan =3D st_lsm6dsx_acc_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_acc_channels),
> -			},
> -			[ST_LSM6DSX_ID_GYRO] =3D {
> -				.chan =3D st_lsm6dsx_gyro_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_gyro_channels),
> -			},
> +		.chan_addr_base =3D {
> +			[ST_LSM6DSX_ID_ACC] =3D 0x28,
> +			[ST_LSM6DSX_ID_GYRO] =3D 0x22,
>  		},
>  		.odr_table =3D {
>  			[ST_LSM6DSX_ID_ACC] =3D {
> @@ -2366,21 +2299,64 @@ static int st_lsm6dsx_init_device(struct st_lsm6d=
sx_hw *hw)
>  	return st_lsm6dsx_init_hw_timer(hw);
>  }
> =20

> +static int st_lsm6dsx_chan_init(struct iio_chan_spec *channels, struct s=
t_lsm6dsx_hw *hw,
> +				enum st_lsm6dsx_sensor_id id, int index)

please try to respect the 79 column limit (I still like it :))

> +{
> +	struct iio_chan_spec *chan =3D &channels[index];
> +
> +	chan->type =3D (id =3D=3D ST_LSM6DSX_ID_ACC) ? IIO_ACCEL : IIO_ANGL_VEL;

I think you should return an error here if id is not ST_LSM6DSX_ID_ACC or
ST_LSM6DSX_ID_GYRO.

> +	chan->address =3D hw->settings->chan_addr_base[id] + index * ST_LSM6DSX=
_CHAN_SIZE;
> +	chan->modified =3D 1;
> +	chan->channel2 =3D IIO_MOD_X + index;
> +	chan->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW);
> +	chan->info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE);
> +	chan->info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +	chan->scan_index =3D index;
> +	chan->scan_type.sign =3D 's';
> +	chan->scan_type.realbits =3D 16;
> +	chan->scan_type.storagebits =3D 16;
> +	chan->scan_type.endianness =3D IIO_LE;

what about reducing the scope of ST_LSM6DSX_CHANNEL_ACC/ST_LSM6DSX_CHANNEL =
here
to improve the iio_chan_spec struct initialization since most of the fields=
 are
always the same between different sensors.

> +	chan->ext_info =3D st_lsm6dsx_ext_info;
> +	if (id =3D=3D ST_LSM6DSX_ID_ACC) {
> +		if (hw->settings->event_settings.wakeup_reg.addr) {

	if (id =3D=3D ST_LSM6DSX_ID_ACC &&
	    hw->settings->event_settings.wakeup_reg.addr) {
	    ...
	}

> +			chan->event_spec =3D &st_lsm6dsx_event;
> +			chan->num_event_specs =3D 1;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  					       enum st_lsm6dsx_sensor_id id,
>  					       const char *name)
>  {
>  	struct st_lsm6dsx_sensor *sensor;
>  	struct iio_dev *iio_dev;
> +	struct iio_chan_spec *channels;

nit: chan to be consistent

> +	int i;
> =20
>  	iio_dev =3D devm_iio_device_alloc(hw->dev, sizeof(*sensor));
>  	if (!iio_dev)
>  		return NULL;
> =20
> +	channels =3D devm_kzalloc(hw->dev, sizeof(*channels) * ST_LSM6DSX_CHAN_=
COUNT, GFP_KERNEL);

79 column limit here. I guess you can use even devm_kcalloc() here.

> +	if (!channels)
> +		return NULL;
> +
> +	for (i =3D 0; i < 3; i++) {
> +		if (st_lsm6dsx_chan_init(channels, hw, id, i) < 0)
> +			return NULL;
> +	}

new line here.

> +	channels[3].type =3D IIO_TIMESTAMP;
> +	channels[3].channel =3D -1;
> +	channels[3].scan_index =3D 3;
> +	channels[3].scan_type.sign =3D 's';
> +	channels[3].scan_type.realbits =3D 64;
> +	channels[3].scan_type.storagebits =3D 64;
>  	iio_dev->modes =3D INDIO_DIRECT_MODE;
>  	iio_dev->available_scan_masks =3D st_lsm6dsx_available_scan_masks;
> -	iio_dev->channels =3D hw->settings->channels[id].chan;
> -	iio_dev->num_channels =3D hw->settings->channels[id].len;
> +	iio_dev->channels =3D channels;
> +	iio_dev->num_channels =3D ST_LSM6DSX_CHAN_COUNT;
> =20
>  	sensor =3D iio_priv(iio_dev);
>  	sensor->id =3D id;
> --=20
> 2.39.5
>=20

--YQQtpU9Ze4ampjl4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQOVcAAKCRA6cBh0uS2t
rOqrAPwMXIiL2zjrmU0LLk8q1ipomNxc8bR+jyN7rLgk/o63xQEAkZdgtzjazdUj
Jqs2M22PTQKOVo4f2khITKY6a5DaxAw=
=/gfG
-----END PGP SIGNATURE-----

--YQQtpU9Ze4ampjl4--

