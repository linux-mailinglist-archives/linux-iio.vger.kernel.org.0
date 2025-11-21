Return-Path: <linux-iio+bounces-26348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEA0C77D2E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 09:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B03235E88E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 08:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856AE33858B;
	Fri, 21 Nov 2025 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0Pi4tBV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF1339B3B;
	Fri, 21 Nov 2025 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763712850; cv=none; b=UwMGPFlhZTadhGfoLuYBuTYSHcxbsblYHXq8K6Rs1nEOJWajH/P0nZ9+KTCIVAFyqyaIUp/nYJmy9FcpMO7SRNmXXLmpUtvF0MxVcJb8eaVFZj3YToCxBa81CxSEyDOHPv8dZpNe7nE9EHuQb41fNZ60Jbp1SU5290v8r6mSi5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763712850; c=relaxed/simple;
	bh=h2HrkxZ3elnxTHFS4QYGzwV7ivZUvxmXhZvYJcVzxZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZqZzVjoLk1oVay5BzchpKBwwWWC/cgExMNbwz4AI1o0m21KAC8GZMEj1WdZPLrdKHqXOH/o0R75r0MfJT67PF6YYkZ8F9jFPf1zhtrsSb1bHW0pFUl+br3bGYQkUMVvDdiAkCwUfLEU7mbPsITp93vMsMUHHib4E58hV/JyEgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0Pi4tBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EE3C19422;
	Fri, 21 Nov 2025 08:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763712849;
	bh=h2HrkxZ3elnxTHFS4QYGzwV7ivZUvxmXhZvYJcVzxZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0Pi4tBVj7DIc1smVjMrdWhtJ9SxaR7W4T7DbNvDDwEUKrCsBc3wuOI3svyIS8dVL
	 eNdtvXH8Em4zqU4GwpbUJnAWxc+ixp0A4IdXf0eq7LS5lBqycOT72HmuyNlD8maFYa
	 8KyczWU/aF40mW+WIzbWAwdwb5LEjpBSEnR6GdqJR9tpuunNada1/Rl+gdLsO0uSOM
	 c8tMjv+igA9iM33s2gAXBh9YedmRL+gPeqGiyU7hnaYqwqQmut9warjiYTLs7lkND9
	 AOK3cYUaM5LX0W0EmYBuWmjlboIOey1fv+TFmyl8/GR1BI9n4HLFxbaQNehJkToVrT
	 JxvMo4Ceg24mg==
Date: Fri, 21 Nov 2025 09:14:07 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] iio: imu: st_lsm6dsx: remove event_threshold
 field from hw struct
Message-ID: <aSAfT3OZRnaTtjXn@lore-desk>
References: <20251120082615.3263892-1-flavra@baylibre.com>
 <20251120082615.3263892-6-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zoUUxKmni0obvg8+"
Content-Disposition: inline
In-Reply-To: <20251120082615.3263892-6-flavra@baylibre.com>


--zoUUxKmni0obvg8+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This field is used to store the wakeup event detection threshold value.
> When adding support for more event types, some of which may have different
> threshold values for different axes, storing all threshold values for all
> event sources would be cumbersome. Thus, remove this field altogether, and
> read the currently configured value from the sensor when requested by
> userspace.
>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>

Just a nit inline, fixing it:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  3 +--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 12 +++++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index bbb967b2754b..e727a87413e5 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -79,6 +79,7 @@ enum st_lsm6dsx_hw_id {
>  #define ST_LSM6DSX_MAX_TAGGED_WORD_LEN	((32 / ST_LSM6DSX_TAGGED_SAMPLE_S=
IZE) \
>  					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
>  #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
> +#define st_lsm6dsx_field_get(mask, reg)	((reg & mask) >> __ffs(mask))

To be aligned with the rest of the code, I guess we could use capital lette=
rs
here:

	#define ST_LSM6DSX_FIELD_GET(mask, reg)=E2=96=B8     ((reg & mask) >> __ff=
s(mask))

> =20
>  #define ST_LSM6DSX_CHANNEL_ACC(chan_type, addr, mod, scan_idx)		\
>  {									\
> @@ -422,7 +423,6 @@ struct st_lsm6dsx_sensor {
>   * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
>   * @buff: Device read buffer.
>   * @irq_routing: pointer to interrupt routing configuration.
> - * @event_threshold: wakeup event threshold.
>   * @enable_event: enabled event bitmask.
>   * @iio_devs: Pointers to acc/gyro iio_dev instances.
>   * @settings: Pointer to the specific sensor settings in use.
> @@ -446,7 +446,6 @@ struct st_lsm6dsx_hw {
>  	u8 sip;
> =20
>  	u8 irq_routing;
> -	u8 event_threshold;
>  	u8 enable_event;
> =20
>  	u8 *buff;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 287a85d4bd58..117ecb080d8e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1900,12 +1900,20 @@ static int st_lsm6dsx_read_event(struct iio_dev *=
iio_dev,
>  {
>  	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +	const struct st_lsm6dsx_reg *reg;
> +	u8 data;
> +	int err;
> =20
>  	if (type !=3D IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
> =20
> +	reg =3D &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].=
value;
> +	err =3D st_lsm6dsx_read_locked(hw, reg->addr, &data, sizeof(data));
> +	if (err < 0)
> +		return err;
> +
>  	*val2 =3D 0;
> -	*val =3D hw->event_threshold;
> +	*val =3D st_lsm6dsx_field_get(reg->mask, data);
> =20
>  	return IIO_VAL_INT;
>  }
> @@ -1937,8 +1945,6 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
>  	if (err < 0)
>  		return -EINVAL;
> =20
> -	hw->event_threshold =3D val;
> -
>  	return 0;
>  }
> =20
> --=20
> 2.39.5
>=20

--zoUUxKmni0obvg8+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaSAfTwAKCRA6cBh0uS2t
rEXbAP9eOlQbrofAbLADaTOaqbwuxUYdS0FxQGozZGpeFXkp9QD8DJenMTiurb0y
DW8iRyaTpywTm8VTeYLcMcmmVKx8YQA=
=JSbb
-----END PGP SIGNATURE-----

--zoUUxKmni0obvg8+--

