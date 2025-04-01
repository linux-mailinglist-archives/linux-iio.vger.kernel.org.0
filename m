Return-Path: <linux-iio+bounces-17502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CB4A77493
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 08:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CE216029F
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC36E1E1C29;
	Tue,  1 Apr 2025 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvjueR9e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3DC1DF73B
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489216; cv=none; b=ltm10GIvY775aU2BjmqX3xoTeEwf39pVGF+HnUj0PgOgwdZxK75gZ+Y3m6pA/ft+djs1IZAdmxxdfbXGBeYB56sq/K5zlkDN+kKYebUziuRl2KV64UoHgFZjENTQm8cOSA1M5k6BBxsqcXuZPIsrwhpRdePEGOWE4ir5EEokid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489216; c=relaxed/simple;
	bh=otS5aG1EwYlHrYnlJMj7WL47cYVYW2k5bNd5qqu33Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHdFgT1FEgV6L3w9aUshqScdnj6gO+3TKLiyP282sxG7CZDtCohkmgSCFAk8gCQf8ZJCVnT14L15t8cJZT6fbk7gKmoFbSf/llePWo4tKOoEdiAnfoB1RWJUrao7OdB/MGoX5ahiuKMEPwmwoa37l0/LvE7kSAcd1OXBhSA2JLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvjueR9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7877DC4CEE8;
	Tue,  1 Apr 2025 06:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743489216;
	bh=otS5aG1EwYlHrYnlJMj7WL47cYVYW2k5bNd5qqu33Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvjueR9eT/B+EA29SFiM1CY96uFt/lIOcp6/VlUxNRwQPUPFgEMbxuXutnuMwRF+P
	 i2KUH6CWRBD+c66ONrai/5cAZF/jaIWpffEFVK/OEYyRhuEB04WZ70K1Ol7wnXZtAy
	 qt7HcgR5H9mpZS5r14qq/JHnhwQCCC02XWIjvi4woIZN/AdPOCA6VsnGEdYH3wWoff
	 S2rBh9/yfPCVWf2imo3jdHIZuMSZ0nsErbop70D5xJakrhrh9pr8eTSG5FY6ys9dqJ
	 sH37eh3xMWRn9OGV1fpnAybXUS2+ahzwTj00BKtHkNM1wrW0YkEYzEL8FNZeJ/xTxH
	 tRkxa429Edd9g==
Date: Tue, 1 Apr 2025 08:33:33 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 13/37] iio: humidity: hts211: Factor out everything under
 direct mode claim into helper functions.
Message-ID: <Z-uIvYx-wvyUbkiO@lore-desk>
References: <20250331121317.1694135-1-jic23@kernel.org>
 <20250331121317.1694135-14-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4a9lkLkmWWsXro2o"
Content-Disposition: inline
In-Reply-To: <20250331121317.1694135-14-jic23@kernel.org>


--4a9lkLkmWWsXro2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 31, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Pulling out the functionality of read_raw() and write_raw() callbacks
> so that only the mode claim is done in the initial call allows for
> direct returns and simpler error handling in the new __hts211_write_raw()
> / __hts211_read_raw() functions.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/humidity/hts221_core.c | 89 +++++++++++++++---------------
>  1 file changed, 45 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/ht=
s221_core.c
> index 0be11470730c..ca4746f2ecba 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -418,31 +418,22 @@ static int hts221_read_oneshot(struct hts221_hw *hw=
, u8 addr, int *val)
>  	return IIO_VAL_INT;
>  }
> =20
> -static int hts221_read_raw(struct iio_dev *iio_dev,
> -			   struct iio_chan_spec const *ch,
> -			   int *val, int *val2, long mask)
> +static int __hts221_read_raw(struct iio_dev *iio_dev,
> +			     struct iio_chan_spec const *ch,
> +			     int *val, int *val2, long mask)
>  {
>  	struct hts221_hw *hw =3D iio_priv(iio_dev);
> -	int ret;
> -
> -	ret =3D iio_device_claim_direct_mode(iio_dev);
> -	if (ret)
> -		return ret;
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret =3D hts221_read_oneshot(hw, ch->address, val);
> -		break;
> +		return hts221_read_oneshot(hw, ch->address, val);
>  	case IIO_CHAN_INFO_SCALE:
> -		ret =3D hts221_get_sensor_scale(hw, ch->type, val, val2);
> -		break;
> +		return hts221_get_sensor_scale(hw, ch->type, val, val2);
>  	case IIO_CHAN_INFO_OFFSET:
> -		ret =3D hts221_get_sensor_offset(hw, ch->type, val, val2);
> -		break;
> +		return hts221_get_sensor_offset(hw, ch->type, val, val2);
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*val =3D hw->odr;
> -		ret =3D IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
>  		u8 idx;
>  		const struct hts221_avg *avg;
> @@ -452,62 +443,72 @@ static int hts221_read_raw(struct iio_dev *iio_dev,
>  			avg =3D &hts221_avg_list[HTS221_SENSOR_H];
>  			idx =3D hw->sensors[HTS221_SENSOR_H].cur_avg_idx;
>  			*val =3D avg->avg_avl[idx];
> -			ret =3D IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		case IIO_TEMP:
>  			avg =3D &hts221_avg_list[HTS221_SENSOR_T];
>  			idx =3D hw->sensors[HTS221_SENSOR_T].cur_avg_idx;
>  			*val =3D avg->avg_avl[idx];
> -			ret =3D IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		default:
> -			ret =3D -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}
> -		break;
>  	}
>  	default:
> -		ret =3D -EINVAL;
> -		break;
> +		return -EINVAL;
>  	}
> -
> -	iio_device_release_direct_mode(iio_dev);
> -
> -	return ret;
>  }
> =20
> -static int hts221_write_raw(struct iio_dev *iio_dev,
> -			    struct iio_chan_spec const *chan,
> -			    int val, int val2, long mask)
> +static int hts221_read_raw(struct iio_dev *iio_dev,
> +			   struct iio_chan_spec const *ch,
> +			   int *val, int *val2, long mask)
>  {
> -	struct hts221_hw *hw =3D iio_priv(iio_dev);
>  	int ret;
> =20
>  	ret =3D iio_device_claim_direct_mode(iio_dev);
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D __hts221_read_raw(iio_dev, ch, val, val2, mask);
> +
> +	iio_device_release_direct_mode(iio_dev);
> +
> +	return ret;
> +}
> +
> +static int __hts221_write_raw(struct iio_dev *iio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, long mask)
> +{
> +	struct hts221_hw *hw =3D iio_priv(iio_dev);
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		ret =3D hts221_update_odr(hw, val);
> -		break;
> +		return hts221_update_odr(hw, val);
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> -			ret =3D hts221_update_avg(hw, HTS221_SENSOR_H, val);
> -			break;
> +			return hts221_update_avg(hw, HTS221_SENSOR_H, val);
>  		case IIO_TEMP:
> -			ret =3D hts221_update_avg(hw, HTS221_SENSOR_T, val);
> -			break;
> +			return hts221_update_avg(hw, HTS221_SENSOR_T, val);
>  		default:
> -			ret =3D -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}
> -		break;
>  	default:
> -		ret =3D -EINVAL;
> -		break;
> +		return -EINVAL;
>  	}
> +}
> +
> +static int hts221_write_raw(struct iio_dev *iio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	int ret;
> +
> +	ret =3D iio_device_claim_direct_mode(iio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __hts221_write_raw(iio_dev, chan, val, mask);
> =20
>  	iio_device_release_direct_mode(iio_dev);
> =20
> --=20
> 2.48.1
>=20

--4a9lkLkmWWsXro2o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ+uIvQAKCRA6cBh0uS2t
rMtOAQDHBga1A7O/vxZOXMwoQEOjqJVknWPE66hZHyB1nfmehwEAthWaf0pbbP/K
jKSFC9e1FSJMVCEvVaN8lsQDGKOaXAI=
=Ri7C
-----END PGP SIGNATURE-----

--4a9lkLkmWWsXro2o--

