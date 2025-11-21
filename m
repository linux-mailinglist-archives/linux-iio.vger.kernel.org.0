Return-Path: <linux-iio+bounces-26346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08089C77C3A
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 08:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E957F4E76A8
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 07:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B18F1F2380;
	Fri, 21 Nov 2025 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvITUqNy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9431770F;
	Fri, 21 Nov 2025 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763711648; cv=none; b=bwfu+UYOURb+7VJynluPsSiE+dNR2TJWvd2NEFiNO+qnu21ZbvmXed0StkcC6Fc5j+eQTRrZAIPhchhph0X4w6hDkqzUWcU8RkhMd3PjoFpW0x87obwRQGpgW/zDIc5mVfDNQNnOX7PaotTvcmzuhTUwlmVOUYiEQ0S3xrOJ5qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763711648; c=relaxed/simple;
	bh=TA4DPk6xrdHHH+ZC5ot2RDZMZHwtgpngvEpYszRxTrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvLFVXyw7m3XTn3RXKdVUp43Ryo3HNJswGdzPxwtVjuW4cTlx4X4qTW1Qb8aR9+v57tU1Lvco0cPtKRWW9C6gFLkqtVNw+7/99qohlgfUe8in+rA0o9RQOtmkX7MVc+S5IUR/TgAJovkFmhRj1VZMD3n3gYm1slwfAUsTr7DiN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvITUqNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10ECC16AAE;
	Fri, 21 Nov 2025 07:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763711648;
	bh=TA4DPk6xrdHHH+ZC5ot2RDZMZHwtgpngvEpYszRxTrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvITUqNyMnzArAwHIreD3Lgs2OImLYqUG1Bn1dpPQH1Cq7iGYZJHfMmtR6qjt+RGb
	 fof8GzE/SR0kvC/4mRdxWqIifEL7nwqmN3trURZqb7nr8y/IV3/3cWkOXS+3TFE3SE
	 XndCFK/NAmNgAE3AkP5Csv089ZTjTNlot6RYe6OC+JS0RQHro//noSehkAeiFJS8+z
	 FeeH3vWJmdn81f+EdH0vdm5VjXOuX4rDTjn2e5XgbKPf+U8wBmX1UK4S6GY5iDBVtE
	 +AG289tTpC2CuzKYySBiyjH6k0wChD2RTxTpXG+fWQxUyqSrqGmbC9K1KS3YDBBlPx
	 Wop3GCygVXltg==
Date: Fri, 21 Nov 2025 08:54:05 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] iio: imu: st_lsm6dsx: make event_settings more
 generic
Message-ID: <aSAanUJMvYVJXtSq@lore-desk>
References: <20251120082615.3263892-1-flavra@baylibre.com>
 <20251120082615.3263892-3-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2AvTIsJr2IV9u0So"
Content-Disposition: inline
In-Reply-To: <20251120082615.3263892-3-flavra@baylibre.com>


--2AvTIsJr2IV9u0So
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The st_lsm6dsx_event_settings structure contains fields specific for one
> event type (wakeup). In preparation for adding support for more event
> types, introduce an event id enum and a generic event source structure, a=
nd
> replace wakeup-specific data in struct st_lsm6dsx_event_settings with an
> array of event source structures.

Hi Francesco,

just one nit inline, other than that:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Regards,
Lorenzo

>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  21 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 134 +++++++++++--------
>  2 files changed, 95 insertions(+), 60 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index a4f558899767..4c3ff1cc0097 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -242,14 +242,23 @@ struct st_lsm6dsx_shub_settings {
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

I think you can use st_lsm6dsx_reg struct here:

	struct st_lsm6dsx_reg status;

> +	u8 status_x_mask;
> +	u8 status_y_mask;
> +	u8 status_z_mask;
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
> index a09df9d772dd..a71174e75f44 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -388,15 +388,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
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
> @@ -554,15 +558,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
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
> @@ -791,15 +799,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
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
> @@ -1028,15 +1040,19 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
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
> @@ -1209,15 +1225,19 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
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
> @@ -1415,15 +1435,19 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
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
> @@ -1935,7 +1959,7 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
>  	if (val < 0 || val > 31)
>  		return -EINVAL;
> =20
> -	reg =3D &hw->settings->event_settings.wakeup_reg;
> +	reg =3D &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].=
value;
>  	data =3D ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
>  	err =3D st_lsm6dsx_update_bits_locked(hw, reg->addr,
>  					    reg->mask, data);
> @@ -2420,6 +2444,7 @@ static bool
>  st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
>  {
>  	const struct st_lsm6dsx_event_settings *event_settings;
> +	const struct st_lsm6dsx_event_src *src;
>  	int err, data;
>  	s64 timestamp;
> =20
> @@ -2427,13 +2452,14 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_=
hw *hw)
>  		return false;
> =20
>  	event_settings =3D &hw->settings->event_settings;
> -	err =3D st_lsm6dsx_read_locked(hw, event_settings->wakeup_src_reg,
> +	src =3D &event_settings->sources[ST_LSM6DSX_EVENT_WAKEUP];
> +	err =3D st_lsm6dsx_read_locked(hw, src->status_reg,
>  				     &data, sizeof(data));
>  	if (err < 0)
>  		return false;
> =20
>  	timestamp =3D iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> -	if ((data & hw->settings->event_settings.wakeup_src_z_mask) &&
> +	if ((data & src->status_z_mask) &&
>  	    (hw->enable_event & BIT(IIO_MOD_Z)))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> @@ -2443,7 +2469,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw=
 *hw)
>  						  IIO_EV_DIR_EITHER),
>  						  timestamp);
> =20
> -	if ((data & hw->settings->event_settings.wakeup_src_y_mask) &&
> +	if ((data & src->status_y_mask) &&
>  	    (hw->enable_event & BIT(IIO_MOD_Y)))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> @@ -2453,7 +2479,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw=
 *hw)
>  						  IIO_EV_DIR_EITHER),
>  						  timestamp);
> =20
> -	if ((data & hw->settings->event_settings.wakeup_src_x_mask) &&
> +	if ((data & src->status_x_mask) &&
>  	    (hw->enable_event & BIT(IIO_MOD_X)))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> @@ -2463,7 +2489,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw=
 *hw)
>  						  IIO_EV_DIR_EITHER),
>  						  timestamp);
> =20
> -	return data & event_settings->wakeup_src_status_mask;
> +	return data & src->status_mask;
>  }
> =20
>  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> --=20
> 2.39.5
>=20

--2AvTIsJr2IV9u0So
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaSAanQAKCRA6cBh0uS2t
rMXDAP9/mo93wAAp3kAUNaDejUp35qiafFW3y5xFcFagiGv7rwD/W47YqtxNNKnE
gT+kxfaFE0lac+JN2xrw0evnOEaS2gQ=
=PVGW
-----END PGP SIGNATURE-----

--2AvTIsJr2IV9u0So--

