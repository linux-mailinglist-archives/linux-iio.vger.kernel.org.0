Return-Path: <linux-iio+bounces-26351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DD3C78005
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 09:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F406F4E834D
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295B62BD001;
	Fri, 21 Nov 2025 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1S9Qe1m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776713777E;
	Fri, 21 Nov 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715192; cv=none; b=GB8qc+d90mSt/kvZLK4GGcnerq1NifniBO+G5LXDxajFlf/n/Bcatsor2jXySbUuoUUbq1Kr/4O0EKaQlMUX4McRrEmpAEEFoFDrT2kPgjDC6mJMzOMtdiFsba8T1g4+A62gIH7kSWO/YTLLtQI1EUm75Q1YyDFdPVKwui+cwKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715192; c=relaxed/simple;
	bh=0EGQUvFaaPO+K5NSQwTtmSbj3iZDfTfRBMueMbzncGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glKY7whvFedIaIW7yGxrYNRw4H7noV2FpIB5/Sozo/lmE7Y9CYUPSLE6nDCgdK+HfADCOItEV65D8vm5ZGTtv9hO3iDC+4s/S4XOsUSFaT60b8wEOX/B553OkFKC5AedJETatXTbjnBS9MzriCEM1N6YbzWf67emV7gQJjd7oTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1S9Qe1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBA4C4CEF1;
	Fri, 21 Nov 2025 08:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763715192;
	bh=0EGQUvFaaPO+K5NSQwTtmSbj3iZDfTfRBMueMbzncGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1S9Qe1mGDF0MyhpYbtpQtfjNUeSjMz+jsTLHb89wMK0kEULgfOg0QWjeTrV6Tuwk
	 zkmM7QD5KeuRAeqdyYnUlpDBjW9AcYeLsIS3WhNrGNfl5KSBARvzrtPGHC0cw12kuL
	 AkNDUoU3xyED+9qM/hTz2aLQB41QvKJ7SkXMCBI4DNQPxyi869BOlGNgVszNkgJgd7
	 ysYZM7MkMNVfydcwhLv33ktj0YamTtT/M9alv4AnsLsWKhropW6GtXrPzzHZWBHCAf
	 OOJYAyWbuyr18z4/czoBFZs9a2GT6HDxqqoodH524+AaQpKDhBeZUdhd/bvB8gNPLU
	 qwF9wvVL0Dh6g==
Date: Fri, 21 Nov 2025 09:53:10 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] iio: imu: st_lsm6dsx: make event management
 functions generic
Message-ID: <aSAodnHzW6fvm9yb@lore-desk>
References: <20251120082615.3263892-1-flavra@baylibre.com>
 <20251120082615.3263892-7-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W+u8RGf0S8Ui6rb4"
Content-Disposition: inline
In-Reply-To: <20251120082615.3263892-7-flavra@baylibre.com>


--W+u8RGf0S8Ui6rb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In preparation for adding support for more event types, use an array
> indexed by event ID instead of a scalar value to store enabled events, and
> refactor the functions to configure and report events so that their
> implementation is not specific for wakeup events. Move the logic to update
> the global event interrupt enable flag from st_lsm6dsx_event_setup() to i=
ts
> calling function, so that it can take into account also event sources
> different from the source being configured. While changing the signature =
of
> the st_lsm6dsx_event_setup() function, opportunistically add the currently
> unused `axis` parameter, which will be used when adding support for
> enabling and disabling events on a per axis basis.

Just some nits inline. Fixing them:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 149 ++++++++++++++-----
>  2 files changed, 109 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index e727a87413e5..037b3b817e83 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -446,7 +446,7 @@ struct st_lsm6dsx_hw {
>  	u8 sip;
> =20
>  	u8 irq_routing;
> -	u8 enable_event;
> +	u8 enable_event[ST_LSM6DSX_EVENT_MAX];
> =20
>  	u8 *buff;
> =20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 117ecb080d8e..18a09ed6907c 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1747,11 +1747,16 @@ static int
>  st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor)
>  {
>  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +	int event;
> =20
>  	if (sensor->id !=3D ST_LSM6DSX_ID_ACC)
>  		return 0;
> =20
> -	return hw->enable_event;
> +	for (event =3D 0; event < ST_LSM6DSX_EVENT_MAX; event++) {
> +		if (hw->enable_event[event])
> +			return true;
> +	}
> +	return false;
>  }
> =20
>  int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> @@ -1864,9 +1869,10 @@ static int st_lsm6dsx_write_raw(struct iio_dev *ii=
o_dev,
>  	return err;
>  }
> =20
> -static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
> +static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw,
> +				  enum st_lsm6dsx_event_id event, int axis,
> +				  bool state)
>  {
> -	const struct st_lsm6dsx_reg *reg;
>  	const struct st_lsm6dsx_event_src *src;
>  	u8 enable_mask;
>  	unsigned int data;
> @@ -1875,22 +1881,24 @@ static int st_lsm6dsx_event_setup(struct st_lsm6d=
sx_hw *hw, bool state)
>  	if (!hw->irq_routing)
>  		return -ENOTSUPP;
> =20
> -	reg =3D &hw->settings->event_settings.enable_reg;
> -	if (reg->addr) {
> -		data =3D ST_LSM6DSX_SHIFT_VAL(state, reg->mask);
> -		err =3D st_lsm6dsx_update_bits_locked(hw, reg->addr,
> -						    reg->mask, data);
> -		if (err < 0)
> -			return err;
> -	}
> -
> -	/* Enable wakeup interrupt */
> -	src =3D &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP];
> +	/* Enable/disable event interrupt */
> +	src =3D &hw->settings->event_settings.sources[event];
>  	enable_mask =3D src->enable_mask;
>  	data =3D ST_LSM6DSX_SHIFT_VAL(state, enable_mask);
>  	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing, enable_mask, =
data);
>  }
> =20
> +static enum st_lsm6dsx_event_id
> +st_lsm6dsx_get_event_id(enum iio_event_type type)
> +{
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		return ST_LSM6DSX_EVENT_WAKEUP;
> +	default:
> +		return ST_LSM6DSX_EVENT_MAX;
> +	}
> +}
> +
>  static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
>  				 const struct iio_chan_spec *chan,
>  				 enum iio_event_type type,
> @@ -1898,16 +1906,17 @@ static int st_lsm6dsx_read_event(struct iio_dev *=
iio_dev,
>  				 enum iio_event_info info,
>  				 int *val, int *val2)
>  {
> +	enum st_lsm6dsx_event_id event =3D st_lsm6dsx_get_event_id(type);
>  	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
>  	const struct st_lsm6dsx_reg *reg;
>  	u8 data;
>  	int err;
> =20
> -	if (type !=3D IIO_EV_TYPE_THRESH)
> +	if (event =3D=3D ST_LSM6DSX_EVENT_MAX)
>  		return -EINVAL;
> =20
> -	reg =3D &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].=
value;
> +	reg =3D &hw->settings->event_settings.sources[event].value;
>  	err =3D st_lsm6dsx_read_locked(hw, reg->addr, &data, sizeof(data));
>  	if (err < 0)
>  		return err;
> @@ -1926,19 +1935,20 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
>  		       enum iio_event_info info,
>  		       int val, int val2)
>  {
> +	enum st_lsm6dsx_event_id event =3D st_lsm6dsx_get_event_id(type);
>  	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
>  	const struct st_lsm6dsx_reg *reg;
>  	unsigned int data;
>  	int err;
> =20
> -	if (type !=3D IIO_EV_TYPE_THRESH)
> +	if (event =3D=3D ST_LSM6DSX_EVENT_MAX)
>  		return -EINVAL;
> =20
>  	if (val < 0 || val > 31)
>  		return -EINVAL;
> =20
> -	reg =3D &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].=
value;
> +	reg =3D &hw->settings->event_settings.sources[event].value;
>  	data =3D ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
>  	err =3D st_lsm6dsx_update_bits_locked(hw, reg->addr,
>  					    reg->mask, data);
> @@ -1954,13 +1964,53 @@ st_lsm6dsx_read_event_config(struct iio_dev *iio_=
dev,
>  			     enum iio_event_type type,
>  			     enum iio_event_direction dir)
>  {
> +	enum st_lsm6dsx_event_id event =3D st_lsm6dsx_get_event_id(type);
>  	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> =20
> -	if (type !=3D IIO_EV_TYPE_THRESH)
> +	if (event =3D=3D ST_LSM6DSX_EVENT_MAX)
>  		return -EINVAL;
> =20
> -	return !!(hw->enable_event & BIT(chan->channel2));
> +	return !!(hw->enable_event[event] & BIT(chan->channel2));
> +}
> +
> +/**
> + * st_lsm6dsx_check_other_events - Check for enabled sensor events.
> + * @hw: Sensor hardware instance.
> + * @curr: Current event type.
> + *
> + * Return: whether any events other than @curr are enabled.
> + */
> +static bool st_lsm6dsx_check_other_events(struct st_lsm6dsx_hw *hw,
> +					  enum st_lsm6dsx_event_id curr)
> +{
> +	enum st_lsm6dsx_event_id other;
> +
> +	for (other =3D 0; other < ST_LSM6DSX_EVENT_MAX; other++) {
> +		if (other !=3D curr && hw->enable_event[other])
> +			return true;
> +	}

new line here

> +	return false;
> +}
> +
> +static int st_lsm6dsx_events_enable(struct st_lsm6dsx_sensor *sensor,
> +				    bool state)
> +{
> +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +	const struct st_lsm6dsx_reg *reg;
> +
> +	reg =3D &hw->settings->event_settings.enable_reg;
> +	if (reg->addr) {
> +		int err;
> +
> +		err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +					 ST_LSM6DSX_SHIFT_VAL(state, reg->mask));
> +		if (err)
> +			return err;
> +	}

new line here

> +	if (state || !(hw->fifo_mask & BIT(sensor->id)))
> +		return __st_lsm6dsx_sensor_set_enable(sensor, state);

new line here

> +	return 0;
>  }
> =20
>  static int
> @@ -1969,22 +2019,24 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio=
_dev,
>  			      enum iio_event_type type,
>  			      enum iio_event_direction dir, bool state)
>  {
> +	enum st_lsm6dsx_event_id event =3D st_lsm6dsx_get_event_id(type);
>  	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +	int axis =3D chan->channel2;

I think you can drop axis here and just use chan->channel2 directly.

>  	u8 enable_event;
>  	int err;
> =20
> -	if (type !=3D IIO_EV_TYPE_THRESH)
> +	if (event =3D=3D ST_LSM6DSX_EVENT_MAX)
>  		return -EINVAL;
> =20
>  	if (state) {
> -		enable_event =3D hw->enable_event | BIT(chan->channel2);
> +		enable_event =3D hw->enable_event[event] | BIT(axis);
> =20
>  		/* do not enable events if they are already enabled */
> -		if (hw->enable_event)
> +		if (hw->enable_event[event])
>  			goto out;
>  	} else {
> -		enable_event =3D hw->enable_event & ~BIT(chan->channel2);
> +		enable_event =3D hw->enable_event[event] & ~BIT(axis);
> =20
>  		/* only turn off sensor if no events is enabled */
>  		if (enable_event)
> @@ -1992,22 +2044,24 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio=
_dev,
>  	}
> =20
>  	/* stop here if no changes have been made */
> -	if (hw->enable_event =3D=3D enable_event)
> +	if (hw->enable_event[event] =3D=3D enable_event)
>  		return 0;
> =20
> -	err =3D st_lsm6dsx_event_setup(hw, state);
> +	err =3D st_lsm6dsx_event_setup(hw, event, axis, state);
>  	if (err < 0)
>  		return err;
> =20
>  	mutex_lock(&hw->conf_lock);
> -	if (enable_event || !(hw->fifo_mask & BIT(sensor->id)))
> -		err =3D __st_lsm6dsx_sensor_set_enable(sensor, state);
> +	if (enable_event)
> +		err =3D st_lsm6dsx_events_enable(sensor, true);
> +	else if (!st_lsm6dsx_check_other_events(hw, event))
> +		err =3D st_lsm6dsx_events_enable(sensor, false);
>  	mutex_unlock(&hw->conf_lock);
>  	if (err < 0)
>  		return err;
> =20
>  out:
> -	hw->enable_event =3D enable_event;
> +	hw->enable_event[event] =3D enable_event;
> =20
>  	return 0;
>  }
> @@ -2418,18 +2472,20 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(st=
ruct st_lsm6dsx_hw *hw,
>  }
> =20
>  static bool
> -st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
> +st_lsm6dsx_report_events(struct st_lsm6dsx_hw *hw, enum st_lsm6dsx_event=
_id id,
> +			 enum iio_event_type type, enum iio_event_direction dir)
>  {
> +	u8 enable_event =3D hw->enable_event[id];

same here, can you just use hw->enable_event[id] directly?

>  	const struct st_lsm6dsx_event_settings *event_settings;
>  	const struct st_lsm6dsx_event_src *src;
>  	int err, data;
>  	s64 timestamp;
> =20
> -	if (!hw->enable_event)
> +	if (!enable_event)
>  		return false;
> =20
>  	event_settings =3D &hw->settings->event_settings;
> -	src =3D &event_settings->sources[ST_LSM6DSX_EVENT_WAKEUP];
> +	src =3D &event_settings->sources[id];
>  	err =3D st_lsm6dsx_read_locked(hw, src->status_reg,
>  				     &data, sizeof(data));
>  	if (err < 0)
> @@ -2437,38 +2493,49 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_=
hw *hw)
> =20
>  	timestamp =3D iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
>  	if ((data & src->status_z_mask) &&
> -	    (hw->enable_event & BIT(IIO_MOD_Z)))
> +	    (enable_event & BIT(IIO_MOD_Z)))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
>  						  IIO_MOD_Z,
> -						  IIO_EV_TYPE_THRESH,
> -						  IIO_EV_DIR_EITHER),
> +						  type,
> +						  dir),
>  						  timestamp);
> =20
>  	if ((data & src->status_y_mask) &&
> -	    (hw->enable_event & BIT(IIO_MOD_Y)))
> +	    (enable_event & BIT(IIO_MOD_Y)))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
>  						  IIO_MOD_Y,
> -						  IIO_EV_TYPE_THRESH,
> -						  IIO_EV_DIR_EITHER),
> +						  type,
> +						  dir),
>  						  timestamp);
> =20
>  	if ((data & src->status_x_mask) &&
> -	    (hw->enable_event & BIT(IIO_MOD_X)))
> +	    (enable_event & BIT(IIO_MOD_X)))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
>  						  IIO_MOD_X,
> -						  IIO_EV_TYPE_THRESH,
> -						  IIO_EV_DIR_EITHER),
> +						  type,
> +						  dir),
>  						  timestamp);
> =20
>  	return data & src->status_mask;
>  }
> =20
> +static bool st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
> +{
> +	bool events_found;
> +
> +	events_found =3D st_lsm6dsx_report_events(hw, ST_LSM6DSX_EVENT_WAKEUP,
> +						IIO_EV_TYPE_THRESH,
> +						IIO_EV_DIR_EITHER);
> +
> +	return events_found;
> +}
> +
>  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  {
>  	struct st_lsm6dsx_hw *hw =3D private;
> --=20
> 2.39.5
>=20

--W+u8RGf0S8Ui6rb4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaSAodgAKCRA6cBh0uS2t
rPeDAP98dmHwWhrr07o0WB++YE+53oP0IQ6keJnBSd4Sonv72wD+Nm1YlZEiuRZQ
1Y6z1cHKs34VbpY34mkxRlsPl5F6YA8=
=fyGA
-----END PGP SIGNATURE-----

--W+u8RGf0S8Ui6rb4--

