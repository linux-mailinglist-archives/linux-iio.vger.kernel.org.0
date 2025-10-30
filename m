Return-Path: <linux-iio+bounces-25690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E54AC21454
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 17:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A85188DC94
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 16:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A7D2ECD39;
	Thu, 30 Oct 2025 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAyUDIN1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA782DA779;
	Thu, 30 Oct 2025 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842669; cv=none; b=D8G4JhUJ9L0E+OO2AnIm6OtqCGGB6C8Rt8Ys5gTKtYxVdjq7A4eNUh8e6DLgb08jbsbsadE5EIgNIH9hNCQFtBCqJZ18Plpwjm8yd6yd0oLijvMELDoB45vtRbSDpKKepWaPPfbQVM948808e0E3CfMwkIKqTjwN3gGT4Ori+dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842669; c=relaxed/simple;
	bh=2q3VK84HTMmK/EPJXsQXOjq+6VRGYwssKFcSTHLn+g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7TQupJZdT2CrPMlp5ScRXh9cbVKaHqQzwyy2ecmTPkRsttYu3DJ2leyPTRY9UPa3q955djCfUlOQS17qGDNpUxH8Yd5x/oF+3OcCoMr3hd8Y28i5pU88paa/WhFEV0OZ7ZkVJpMgcajzwgd8DL38pmYl6OwCr8+ujc+Qk0RVQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAyUDIN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A339C4CEF8;
	Thu, 30 Oct 2025 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761842668;
	bh=2q3VK84HTMmK/EPJXsQXOjq+6VRGYwssKFcSTHLn+g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nAyUDIN1H29YuqgK+S2PG6ySl5YmS0Fi9K/KQJOT1KAo0TJP6jVtZsgDhDkdQWkNX
	 iJ+D/XwxIOwoWZ8Bucm90RBFS/x+ytyNpgBKe6tBeIhDg9xgTpny0FP3B3cvpW2r6+
	 5vB7yxMFoRsxYZ4zKgYKivoUYZaVSs0sWDnpAmtabdpQPDAnZ2FSSZq5gUicJrPGMi
	 hS7oQf7iKjlCdCoMFqGQI4W5dYIxfqDDbzVcoImJqY8PBiPu+xjd6K49/EDGqOR04N
	 NJj6v0zwxoaZCZMMXcWNd7lz49QZJ6B3+jSCQb7hBSRM+zgS25XTPWx6QzNi7ev7GL
	 Uo7jY0/HlxCBw==
Date: Thu, 30 Oct 2025 17:44:25 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] iio: imu: st_lsm6dsx: make event_settings more
 generic
Message-ID: <aQOV6cDVTJ-5uyCz@lore-desk>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-3-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3h315IgLwdcm9LEV"
Content-Disposition: inline
In-Reply-To: <20251030072752.349633-3-flavra@baylibre.com>


--3h315IgLwdcm9LEV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 30, Francesco Lavra wrote:
> The st_lsm6dsx_event_settings structure contains fields specific
> for one event type (wakeup). In preparation for adding support for
> more event types, introduce an event id enum and a generic event
> source structure, and replace wakeup-specific data in struct
> st_lsm6dsx_event_settings with an array of event source structures.
>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  21 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 136 +++++++++++--------
>  2 files changed, 96 insertions(+), 61 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index db863bd1898d..05689887f7ec 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -221,14 +221,23 @@ struct st_lsm6dsx_shub_settings {
>  	u8 pause;
>  };
> =20
> +enum st_lsm6dsx_event_id {
> +	ST_LSM6DSX_EVENT_WAKEUP,
> +	ST_LSM6DSX_EVENT_MAX
> +};
> +
> +struct st_lsm6dsx_event_src {
> +	struct st_lsm6dsx_reg value;
> +	u8 status_reg;
> +	u8 status_mask;
> +	u8 status_x_mask;
> +	u8 status_y_mask;
> +	u8 status_z_mask;

you can use st_lsm6dsx_reg here.

> +};
> +
>  struct st_lsm6dsx_event_settings {
>  	struct st_lsm6dsx_reg enable_reg;
> -	struct st_lsm6dsx_reg wakeup_reg;
> -	u8 wakeup_src_reg;
> -	u8 wakeup_src_status_mask;
> -	u8 wakeup_src_z_mask;
> -	u8 wakeup_src_y_mask;
> -	u8 wakeup_src_x_mask;
> +	struct st_lsm6dsx_event_src sources[ST_LSM6DSX_EVENT_MAX];
>  };
> =20
>  enum st_lsm6dsx_ext_sensor_id {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 17b46e15cce5..bb4c4c531128 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -350,15 +350,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  			},
>  		},
>  		.event_settings =3D {
> -			.wakeup_reg =3D {
> -				.addr =3D 0x5B,
> -				.mask =3D GENMASK(5, 0),
> +			.sources =3D {
> +				[ST_LSM6DSX_EVENT_WAKEUP] =3D {
> +					.value =3D {
> +						.addr =3D 0x5b,
> +						.mask =3D GENMASK(5, 0),
> +					},
> +					.status_reg =3D 0x1b,
> +					.status_mask =3D BIT(3),
> +					.status_z_mask =3D BIT(0),
> +					.status_y_mask =3D BIT(1),
> +					.status_x_mask =3D BIT(2),
> +				},
>  			},
> -			.wakeup_src_reg =3D 0x1b,
> -			.wakeup_src_status_mask =3D BIT(3),
> -			.wakeup_src_z_mask =3D BIT(0),
> -			.wakeup_src_y_mask =3D BIT(1),
> -			.wakeup_src_x_mask =3D BIT(2),
>  		},
>  	},
>  	{
> @@ -510,15 +514,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  			},
>  		},
>  		.event_settings =3D {
> -			.wakeup_reg =3D {
> -				.addr =3D 0x5B,
> -				.mask =3D GENMASK(5, 0),
> +			.sources =3D {
> +				[ST_LSM6DSX_EVENT_WAKEUP] =3D {
> +					.value =3D {
> +						.addr =3D 0x5b,
> +						.mask =3D GENMASK(5, 0),
> +					},
> +					.status_reg =3D 0x1b,
> +					.status_mask =3D BIT(3),
> +					.status_z_mask =3D BIT(0),
> +					.status_y_mask =3D BIT(1),
> +					.status_x_mask =3D BIT(2),
> +				},
>  			},
> -			.wakeup_src_reg =3D 0x1b,
> -			.wakeup_src_status_mask =3D BIT(3),
> -			.wakeup_src_z_mask =3D BIT(0),
> -			.wakeup_src_y_mask =3D BIT(1),
> -			.wakeup_src_x_mask =3D BIT(2),
>  		},
>  	},
>  	{
> @@ -741,15 +749,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  				.addr =3D 0x58,
>  				.mask =3D BIT(7),
>  			},
> -			.wakeup_reg =3D {
> -				.addr =3D 0x5B,
> -				.mask =3D GENMASK(5, 0),
> +			.sources =3D {
> +				[ST_LSM6DSX_EVENT_WAKEUP] =3D {
> +					.value =3D {
> +						.addr =3D 0x5b,
> +						.mask =3D GENMASK(5, 0),
> +					},
> +					.status_reg =3D 0x1b,
> +					.status_mask =3D BIT(3),
> +					.status_z_mask =3D BIT(0),
> +					.status_y_mask =3D BIT(1),
> +					.status_x_mask =3D BIT(2),
> +				},
>  			},
> -			.wakeup_src_reg =3D 0x1b,
> -			.wakeup_src_status_mask =3D BIT(3),
> -			.wakeup_src_z_mask =3D BIT(0),
> -			.wakeup_src_y_mask =3D BIT(1),
> -			.wakeup_src_x_mask =3D BIT(2),
>  		},
>  	},
>  	{
> @@ -972,15 +984,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  				.addr =3D 0x58,
>  				.mask =3D BIT(7),
>  			},
> -			.wakeup_reg =3D {
> -				.addr =3D 0x5b,
> -				.mask =3D GENMASK(5, 0),
> +			.sources =3D {
> +				[ST_LSM6DSX_EVENT_WAKEUP] =3D {
> +					.value =3D {
> +						.addr =3D 0x5b,
> +						.mask =3D GENMASK(5, 0),
> +					},
> +					.status_reg =3D 0x1b,
> +					.status_mask =3D BIT(3),
> +					.status_z_mask =3D BIT(0),
> +					.status_y_mask =3D BIT(1),
> +					.status_x_mask =3D BIT(2),
> +				},
>  			},
> -			.wakeup_src_reg =3D 0x1b,
> -			.wakeup_src_status_mask =3D BIT(3),
> -			.wakeup_src_z_mask =3D BIT(0),
> -			.wakeup_src_y_mask =3D BIT(1),
> -			.wakeup_src_x_mask =3D BIT(2),
>  		},
>  	},
>  	{
> @@ -1147,15 +1163,19 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
>  				.addr =3D 0x58,
>  				.mask =3D BIT(7),
>  			},
> -			.wakeup_reg =3D {
> -				.addr =3D 0x5B,
> -				.mask =3D GENMASK(5, 0),
> +			.sources =3D {
> +				[ST_LSM6DSX_EVENT_WAKEUP] =3D {
> +					.value =3D {
> +						.addr =3D 0x5b,
> +						.mask =3D GENMASK(5, 0),
> +					},
> +					.status_reg =3D 0x1b,
> +					.status_mask =3D BIT(3),
> +					.status_z_mask =3D BIT(0),
> +					.status_y_mask =3D BIT(1),
> +					.status_x_mask =3D BIT(2),
> +				},
>  			},
> -			.wakeup_src_reg =3D 0x1b,
> -			.wakeup_src_status_mask =3D BIT(3),
> -			.wakeup_src_z_mask =3D BIT(0),
> -			.wakeup_src_y_mask =3D BIT(1),
> -			.wakeup_src_x_mask =3D BIT(2),
>  		},
>  	},
>  	{
> @@ -1347,15 +1367,19 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
>  				.addr =3D 0x50,
>  				.mask =3D BIT(7),
>  			},
> -			.wakeup_reg =3D {
> -				.addr =3D 0x5b,
> -				.mask =3D GENMASK(5, 0),
> +			.sources =3D {
> +				[ST_LSM6DSX_EVENT_WAKEUP] =3D {
> +					.value =3D {
> +						.addr =3D 0x5b,
> +						.mask =3D GENMASK(5, 0),
> +					},
> +					.status_reg =3D 0x45,
> +					.status_mask =3D BIT(3),
> +					.status_z_mask =3D BIT(0),
> +					.status_y_mask =3D BIT(1),
> +					.status_x_mask =3D BIT(2),
> +				},
>  			},
> -			.wakeup_src_reg =3D 0x45,
> -			.wakeup_src_status_mask =3D BIT(3),
> -			.wakeup_src_z_mask =3D BIT(0),
> -			.wakeup_src_y_mask =3D BIT(1),
> -			.wakeup_src_x_mask =3D BIT(2),
>  		},
>  	},
>  	{
> @@ -1861,7 +1885,7 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
>  	if (val < 0 || val > 31)
>  		return -EINVAL;
> =20
> -	reg =3D &hw->settings->event_settings.wakeup_reg;
> +	reg =3D &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].=
value;
>  	data =3D ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
>  	err =3D st_lsm6dsx_update_bits_locked(hw, reg->addr,
>  					    reg->mask, data);
> @@ -2318,7 +2342,7 @@ static int st_lsm6dsx_chan_init(struct iio_chan_spe=
c *channels, struct st_lsm6ds
>  	chan->scan_type.endianness =3D IIO_LE;
>  	chan->ext_info =3D st_lsm6dsx_ext_info;
>  	if (id =3D=3D ST_LSM6DSX_ID_ACC) {
> -		if (hw->settings->event_settings.wakeup_reg.addr) {
> +		if (hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].valu=
e.addr) {
>  			chan->event_spec =3D &st_lsm6dsx_event;
>  			chan->num_event_specs =3D 1;
>  		}
> @@ -2389,6 +2413,7 @@ static bool
>  st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
>  {
>  	const struct st_lsm6dsx_event_settings *event_settings;
> +	const struct st_lsm6dsx_event_src *event_src;
>  	int err, data;
>  	s64 timestamp;
> =20
> @@ -2396,13 +2421,14 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_=
hw *hw)
>  		return false;
> =20
>  	event_settings =3D &hw->settings->event_settings;
> -	err =3D st_lsm6dsx_read_locked(hw, event_settings->wakeup_src_reg,
> +	event_src =3D &event_settings->sources[ST_LSM6DSX_EVENT_WAKEUP];
> +	err =3D st_lsm6dsx_read_locked(hw, event_src->status_reg,
>  				     &data, sizeof(data));
>  	if (err < 0)
>  		return false;
> =20
>  	timestamp =3D iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> -	if ((data & hw->settings->event_settings.wakeup_src_z_mask) &&
> +	if ((data & event_src->status_z_mask) &&
>  	    (hw->enable_event & BIT(IIO_MOD_Z)))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> @@ -2412,7 +2438,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw=
 *hw)
>  						  IIO_EV_DIR_EITHER),
>  						  timestamp);
> =20
> -	if ((data & hw->settings->event_settings.wakeup_src_y_mask) &&
> +	if ((data & event_src->status_y_mask) &&
>  	    (hw->enable_event & BIT(IIO_MOD_Y)))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> @@ -2422,7 +2448,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw=
 *hw)
>  						  IIO_EV_DIR_EITHER),
>  						  timestamp);
> =20
> -	if ((data & hw->settings->event_settings.wakeup_src_x_mask) &&
> +	if ((data & event_src->status_x_mask) &&
>  	    (hw->enable_event & BIT(IIO_MOD_X)))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> @@ -2432,7 +2458,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw=
 *hw)
>  						  IIO_EV_DIR_EITHER),
>  						  timestamp);
> =20
> -	return data & event_settings->wakeup_src_status_mask;
> +	return data & event_src->status_mask;
>  }
> =20
>  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> --=20
> 2.39.5
>=20

--3h315IgLwdcm9LEV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQOV6QAKCRA6cBh0uS2t
rAhiAP9TlU6cp59Xh8zx30ktx+FtXc0wWXDpW8nonseALreFNAEAhp9Joxv/RVJm
8jZq8sEW6ZBwBkg/PXsrr2kx8o3M5wA=
=gEi9
-----END PGP SIGNATURE-----

--3h315IgLwdcm9LEV--

