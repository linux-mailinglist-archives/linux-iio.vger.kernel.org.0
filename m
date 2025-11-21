Return-Path: <linux-iio+bounces-26347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C8C77C93
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 09:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3A8D34DF67
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 08:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C75227B94;
	Fri, 21 Nov 2025 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da7dybDa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4310217736;
	Fri, 21 Nov 2025 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763712107; cv=none; b=KC1EqotmaV6OuQ/QsqtNe85gN7qNdvaLFjUve2zhzZdFc/+62xbCkYUi599+jpN2DhcdjAcqkAL80/gYkXi2/+wVrG0A3BMZAzx/4VlZge+OA8jbSmwCuzdOVadfBsPHU/EWP6xCFQcyxSMhL00OwTHvbtWpfwiTLfle8hGMpG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763712107; c=relaxed/simple;
	bh=RHok1K+PLmfI5hBI5WLx6+a3L0XTjD7BJnzrHZhei+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImNaySTG9N8JIP2oHz/Ly27Tqe3dJxaxy09dlY2YZ7nlDRvW8abw75rLBenfujCxROMDhZe/QMNz95D625+xkUAplArO1iC8BleXWWbIw/rHwHJT4kGW6u1IrVxpYeeRdJrBN4rfyiFzsTQHxAn4s0xa1HbDtuzjezX6rupxjQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da7dybDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B1FC4CEF1;
	Fri, 21 Nov 2025 08:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763712107;
	bh=RHok1K+PLmfI5hBI5WLx6+a3L0XTjD7BJnzrHZhei+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=da7dybDaNqNQ+A9I20uY5QYVwQFIPdb/x9gjBplN7stHfvkvPqZ3hbrFxfsnd62F8
	 EOTV8pwwl4IvU/k/r9uz3inQliyWfLo+pGV5cBNfCm07g6zNxKpk6uKggAfaIXNUkE
	 AA2BRwX2jz2hwowtdYrT3Qs0Xeu8kX11qGNuhoDcWXLsC5mOwMl7reAPTUigz2l+zs
	 YoNn8e59j/41H3txvJv6Q3kts0lDd7IY0keZuH7lbfg11vRICX6SIjvFSIuhVQ0Fp8
	 G7cAKmzeXfGR7oEmGaU1C0EDOELOqshydNLwmhUsaUjhi9ozf62pp5dORyoJsrrXPD
	 Rhby5s6WSLC/g==
Date: Fri, 21 Nov 2025 09:01:45 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] iio: imu: st_lsm6dsx: move wakeup event enable
 mask to event_src
Message-ID: <aSAcaaU_UZobKvUy@lore-desk>
References: <20251120082615.3263892-1-flavra@baylibre.com>
 <20251120082615.3263892-4-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GM6Mq/xMYkVQrU2N"
Content-Disposition: inline
In-Reply-To: <20251120082615.3263892-4-flavra@baylibre.com>


--GM6Mq/xMYkVQrU2N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The mask value being assigned to the irq1_func and irq2_func fields of the
> irq_config struct is specific to a single event source (i.e. the wakeup
> event), and as such it should be separate from the definition of the
> interrupt function registers, which cover multiple event sources.
> In preparation for adding support for more event types, change the
> irq1_func and irq2_func type from an {address, mask} pair to an address,
> and move the mask value to a new field of struct st_lsm6dsx_event_src. No
> functional changes.

Just a nit inline. Fixing it:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  7 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 81 +++++++-------------
>  2 files changed, 31 insertions(+), 57 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 4c3ff1cc0097..bbb967b2754b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -249,6 +249,7 @@ enum st_lsm6dsx_event_id {
> =20
>  struct st_lsm6dsx_event_src {
>  	struct st_lsm6dsx_reg value;
> +	u8 enable_mask;
>  	u8 status_reg;
>  	u8 status_mask;
>  	u8 status_x_mask;
> @@ -344,8 +345,8 @@ struct st_lsm6dsx_settings {
>  	struct {
>  		struct st_lsm6dsx_reg irq1;
>  		struct st_lsm6dsx_reg irq2;
> -		struct st_lsm6dsx_reg irq1_func;
> -		struct st_lsm6dsx_reg irq2_func;
> +		u8 irq1_func;
> +		u8 irq2_func;
>  		struct st_lsm6dsx_reg lir;
>  		struct st_lsm6dsx_reg clear_on_read;
>  		struct st_lsm6dsx_reg hla;
> @@ -444,7 +445,7 @@ struct st_lsm6dsx_hw {
>  	u8 ts_sip;
>  	u8 sip;
> =20
> -	const struct st_lsm6dsx_reg *irq_routing;
> +	u8 irq_routing;
>  	u8 event_threshold;
>  	u8 enable_event;
> =20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index a71174e75f44..ce5f9213d476 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -328,14 +328,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.addr =3D 0x58,
>  				.mask =3D BIT(0),
>  			},
> -			.irq1_func =3D {
> -				.addr =3D 0x5e,
> -				.mask =3D BIT(5),
> -			},
> -			.irq2_func =3D {
> -				.addr =3D 0x5f,
> -				.mask =3D BIT(5),
> -			},
> +			.irq1_func =3D 0x5e,
> +			.irq2_func =3D 0x5f,
>  			.hla =3D {
>  				.addr =3D 0x12,
>  				.mask =3D BIT(5),
> @@ -394,6 +388,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  						.addr =3D 0x5b,
>  						.mask =3D GENMASK(5, 0),
>  					},
> +					.enable_mask =3D BIT(5),
>  					.status_reg =3D 0x1b,
>  					.status_mask =3D BIT(3),
>  					.status_z_mask =3D BIT(0),
> @@ -498,14 +493,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.addr =3D 0x58,
>  				.mask =3D BIT(0),
>  			},
> -			.irq1_func =3D {
> -				.addr =3D 0x5e,
> -				.mask =3D BIT(5),
> -			},
> -			.irq2_func =3D {
> -				.addr =3D 0x5f,
> -				.mask =3D BIT(5),
> -			},
> +			.irq1_func =3D 0x5e,
> +			.irq2_func =3D 0x5f,
>  			.hla =3D {
>  				.addr =3D 0x12,
>  				.mask =3D BIT(5),
> @@ -564,6 +553,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  						.addr =3D 0x5b,
>  						.mask =3D GENMASK(5, 0),
>  					},
> +					.enable_mask =3D BIT(5),
>  					.status_reg =3D 0x1b,
>  					.status_mask =3D BIT(3),
>  					.status_z_mask =3D BIT(0),
> @@ -698,14 +688,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.addr =3D 0x58,
>  				.mask =3D BIT(0),
>  			},
> -			.irq1_func =3D {
> -				.addr =3D 0x5e,
> -				.mask =3D BIT(5),
> -			},
> -			.irq2_func =3D {
> -				.addr =3D 0x5f,
> -				.mask =3D BIT(5),
> -			},
> +			.irq1_func =3D 0x5e,
> +			.irq2_func =3D 0x5f,
>  			.hla =3D {
>  				.addr =3D 0x12,
>  				.mask =3D BIT(5),
> @@ -805,6 +789,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  						.addr =3D 0x5b,
>  						.mask =3D GENMASK(5, 0),
>  					},
> +					.enable_mask =3D BIT(5),
>  					.status_reg =3D 0x1b,
>  					.status_mask =3D BIT(3),
>  					.status_z_mask =3D BIT(0),
> @@ -951,14 +936,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.addr =3D 0x56,
>  				.mask =3D BIT(6),
>  			},
> -			.irq1_func =3D {
> -				.addr =3D 0x5e,
> -				.mask =3D BIT(5),
> -			},
> -			.irq2_func =3D {
> -				.addr =3D 0x5f,
> -				.mask =3D BIT(5),
> -			},
> +			.irq1_func =3D 0x5e,
> +			.irq2_func =3D 0x5f,
>  			.hla =3D {
>  				.addr =3D 0x12,
>  				.mask =3D BIT(5),
> @@ -1046,6 +1025,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  						.addr =3D 0x5b,
>  						.mask =3D GENMASK(5, 0),
>  					},
> +					.enable_mask =3D BIT(5),
>  					.status_reg =3D 0x1b,
>  					.status_mask =3D BIT(3),
>  					.status_z_mask =3D BIT(0),
> @@ -1168,14 +1148,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
>  				.addr =3D 0x56,
>  				.mask =3D BIT(6),
>  			},
> -			.irq1_func =3D {
> -				.addr =3D 0x5e,
> -				.mask =3D BIT(5),
> -			},
> -			.irq2_func =3D {
> -				.addr =3D 0x5f,
> -				.mask =3D BIT(5),
> -			},
> +			.irq1_func =3D 0x5e,
> +			.irq2_func =3D 0x5f,
>  			.hla =3D {
>  				.addr =3D 0x12,
>  				.mask =3D BIT(5),
> @@ -1231,6 +1205,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  						.addr =3D 0x5b,
>  						.mask =3D GENMASK(5, 0),
>  					},
> +					.enable_mask =3D BIT(5),
>  					.status_reg =3D 0x1b,
>  					.status_mask =3D BIT(3),
>  					.status_z_mask =3D BIT(0),
> @@ -1347,14 +1322,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
>  				.addr =3D 0x56,
>  				.mask =3D BIT(0),
>  			},
> -			.irq1_func =3D {
> -				.addr =3D 0x5e,
> -				.mask =3D BIT(5),
> -			},
> -			.irq2_func =3D {
> -				.addr =3D 0x5f,
> -				.mask =3D BIT(5),
> -			},
> +			.irq1_func =3D 0x5e,
> +			.irq2_func =3D 0x5f,
>  			.hla =3D {
>  				.addr =3D 0x03,
>  				.mask =3D BIT(4),
> @@ -1441,6 +1410,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  						.addr =3D 0x5b,
>  						.mask =3D GENMASK(5, 0),
>  					},
> +					.enable_mask =3D BIT(5),
>  					.status_reg =3D 0x45,
>  					.status_mask =3D BIT(3),
>  					.status_z_mask =3D BIT(0),
> @@ -1899,10 +1869,12 @@ static int st_lsm6dsx_write_raw(struct iio_dev *i=
io_dev,
>  static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
>  {
>  	const struct st_lsm6dsx_reg *reg;
> +	const struct st_lsm6dsx_event_src *src;
> +	u8 enable_mask;
>  	unsigned int data;
>  	int err;
> =20
> -	if (!hw->settings->irq_config.irq1_func.addr)
> +	if (!hw->irq_routing)
>  		return -ENOTSUPP;
> =20
>  	reg =3D &hw->settings->event_settings.enable_reg;
> @@ -1915,9 +1887,10 @@ static int st_lsm6dsx_event_setup(struct st_lsm6ds=
x_hw *hw, bool state)
>  	}
> =20
>  	/* Enable wakeup interrupt */
> -	data =3D ST_LSM6DSX_SHIFT_VAL(state, hw->irq_routing->mask);
> -	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing->addr,
> -					     hw->irq_routing->mask, data);
> +	src =3D &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP];
> +	enable_mask =3D src->enable_mask;

I think you can drop enable_mask here and just use src->enable_mask directly
here.

> +	data =3D ST_LSM6DSX_SHIFT_VAL(state, enable_mask);
> +	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing, enable_mask, =
data);
>  }
> =20
>  static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> @@ -2171,11 +2144,11 @@ st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
> =20
>  	switch (drdy_pin) {
>  	case 1:
> -		hw->irq_routing =3D &hw->settings->irq_config.irq1_func;
> +		hw->irq_routing =3D hw->settings->irq_config.irq1_func;
>  		*drdy_reg =3D &hw->settings->irq_config.irq1;
>  		break;
>  	case 2:
> -		hw->irq_routing =3D &hw->settings->irq_config.irq2_func;
> +		hw->irq_routing =3D hw->settings->irq_config.irq2_func;
>  		*drdy_reg =3D &hw->settings->irq_config.irq2;
>  		break;
>  	default:
> --=20
> 2.39.5
>=20

--GM6Mq/xMYkVQrU2N
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaSAcaAAKCRA6cBh0uS2t
rClpAPdzFAsfxz+9H5PokyWP7hq5xqgn2hU4onO+Q9fT4acmAP444rbgDCDAPdeU
M7xEExi7FMoBmhRSs4sLAB36Za5uCQ==
=ii0w
-----END PGP SIGNATURE-----

--GM6Mq/xMYkVQrU2N--

