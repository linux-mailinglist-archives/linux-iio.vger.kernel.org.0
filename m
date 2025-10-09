Return-Path: <linux-iio+bounces-24889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71338BCB17C
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 00:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DF9C4E5999
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 22:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2B285061;
	Thu,  9 Oct 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUbmYNhK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355663CB;
	Thu,  9 Oct 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049016; cv=none; b=l2UpZElhSlT6zMNM0ORnjA53D4l63bHSplW9CDm6f+Grm0YzlcDEq9t1UQfnHwgrmWO2x+PBncHGIagbTwg0gtp+c9d2Tiwdrr37EZZIa2zF3st3RK2ijdvaeUqelKKisFnrfg+HNcpHAc7oXjUCVOw+amQ2V0ajTXn/ck7GKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049016; c=relaxed/simple;
	bh=immcT5NCY31PjUseNWXytM+DbAd3mPnEzy59RGO2S3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkqKnuEsQetRMahBBJrWVn2Mz4HKxpZ+aIcE79xmnuMfp9YPnGaTaAXgONFlCnYrYPdwBDVgXtRgofsHEq6jj2L9r/HiT7X1dL7ST58yyGBFdpfI8i0PUDyassST3iHLuY0m8+1rPiwzuDhZUjo0DQLwTawX3u4NLNA48sMOI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUbmYNhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2252DC4CEE7;
	Thu,  9 Oct 2025 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760049016;
	bh=immcT5NCY31PjUseNWXytM+DbAd3mPnEzy59RGO2S3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUbmYNhKMUfYFn4/E1ECl9v6f5QcBuuSDo1YXOhm1j19IH2L/zBkGdKhvLvftbEe6
	 JSHOGL2RlNtvAlmgstirQd2pLnFa7Wov+kz/oHXj9R+zZZSamE9uQd3osghBZ9Wn8l
	 5L9X4IDa9pt0wRSLYtqx1YOyE/Sl4Ta9q7aq/mu8tORM01nP1HSr0VFnNR/Ar87ngT
	 Z5RxqLUL8lCRUCsKGS/kT9wVmP56BF9U1zcjW/S4AIAm1mGLu0qYn6hbQg7NgUQ89E
	 A0MR0mzmGcQK2FOtJtssHFR7Mof29ZmuRkiN2j9uTc2c2JQoVhA83kdPgfuqy5gb1T
	 /f7L9cevbLzhg==
Date: Fri, 10 Oct 2025 00:30:14 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
Message-ID: <aOg3dg21aWNTF47x@lore-desk>
References: <20251009173609.992452-1-flavra@baylibre.com>
 <20251009173609.992452-3-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PZTB0aTF+sLXKEc+"
Content-Disposition: inline
In-Reply-To: <20251009173609.992452-3-flavra@baylibre.com>


--PZTB0aTF+sLXKEc+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The rate at which accelerometer or gyroscope sensor samples are fed
> to the hardware FIFO (batch data rate, or BDR) does not have to
> coincide with the sensor sampling frequency (output data rate, or
> ODR); the only requirement is for the BDR to not be greater than
> the ODR. Having a BDR lower than the ODR is useful in cases where
> an application requires a high sampling rate for accurate detection
> of motion events (e.g. wakeup events), but wants to read sensor
> sample values from the device buffer at a lower data rate.

can you please provide more details here? Are you using the hw fifo to read
data? If we configure the hw fifo according to the BDR (even assuming the
watermark is set 1) the hw will generate interrupts according to the BDR
(bdr < odr).

> To support the above use case, add a sampling_frequency sysfs
> attribute to the buffer directory of st_lsm6dsx IIO devices, which
> controls the BDR for a given sensor independently from the "main"
> sampling_frequency attribute (which controls the ODR); introduce a
> new `bdr` field in struct st_lsm6dsx_sensor to keep track of the
> current BDR value, and use this field instead of the `odr` field in
> the code that deals with the FIFO data rate. In the sensor hub
> driver, make the bdr value always mirror the odr value, since there
> is no separate configuration setting to control the BDR for data
> produced by the sensor hub functionality.
>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 +
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 64 ++++++++++++++++---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  9 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  4 +-
>  4 files changed, 66 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index bd366c6e282a..dc4aeea3a3b8 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -366,6 +366,7 @@ enum st_lsm6dsx_fifo_mode {
>   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
>   * @gain: Configured sensor sensitivity.
>   * @odr: Output data rate of the sensor [mHz].
> + * @bdr: Batch data rate [mHz]
>   * @samples_to_discard: Number of samples to discard for filters settlin=
g time.
>   * @watermark: Sensor watermark level.
>   * @decimator: Sensor decimation factor.
> @@ -380,6 +381,7 @@ struct st_lsm6dsx_sensor {
> =20
>  	u32 gain;
>  	u32 odr;
> +	u32 bdr;
> =20
>  	u16 samples_to_discard;
>  	u16 watermark;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 8a9d2593576a..5912ea76d493 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -56,6 +56,7 @@
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/sysfs.h>
>  #include <linux/regmap.h>
>  #include <linux/bitfield.h>
> =20
> @@ -105,7 +106,7 @@ static int
>  st_lsm6dsx_get_decimator_val(struct st_lsm6dsx_sensor *sensor, u32 max_o=
dr)
>  {
>  	const int max_size =3D ARRAY_SIZE(st_lsm6dsx_decimator_table);
> -	u32 decimator =3D  max_odr / sensor->odr;
> +	u32 decimator =3D  max_odr / sensor->bdr;
>  	int i;
> =20
>  	if (decimator > 1)
> @@ -136,14 +137,14 @@ static void st_lsm6dsx_get_max_min_odr(struct st_ls=
m6dsx_hw *hw,
>  		if (!(hw->enable_mask & BIT(sensor->id)))
>  			continue;
> =20
> -		*max_odr =3D max_t(u32, *max_odr, sensor->odr);
> -		*min_odr =3D min_t(u32, *min_odr, sensor->odr);
> +		*max_odr =3D max_t(u32, *max_odr, sensor->bdr);
> +		*min_odr =3D min_t(u32, *min_odr, sensor->bdr);
>  	}
>  }
> =20
>  static u8 st_lsm6dsx_get_sip(struct st_lsm6dsx_sensor *sensor, u32 min_o=
dr)
>  {
> -	u8 sip =3D sensor->odr / min_odr;
> +	u8 sip =3D sensor->bdr / min_odr;
> =20
>  	return sip > 1 ? round_down(sip, 2) : sip;
>  }
> @@ -231,7 +232,7 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_=
sensor *sensor,
>  		if (enable) {
>  			int err;
> =20
> -			err =3D st_lsm6dsx_check_odr(sensor, sensor->odr,
> +			err =3D st_lsm6dsx_check_odr(sensor, sensor->bdr,
>  						   &data);
>  			if (err < 0)
>  				return err;
> @@ -713,7 +714,7 @@ st_lsm6dsx_update_samples_to_discard(struct st_lsm6ds=
x_sensor *sensor)
> =20
>  	data =3D &hw->settings->samples_to_discard[sensor->id];
>  	for (i =3D 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++) {
> -		if (data->val[i].milli_hz =3D=3D sensor->odr) {
> +		if (data->val[i].milli_hz =3D=3D sensor->bdr) {
>  			sensor->samples_to_discard =3D data->val[i].samples;
>  			return;
>  		}
> @@ -799,6 +800,52 @@ static const struct iio_buffer_setup_ops st_lsm6dsx_=
buffer_ops =3D {
>  	.postdisable =3D st_lsm6dsx_buffer_postdisable,
>  };
> =20
> +static ssize_t st_lsm6dsx_bdr_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(dev_to_iio_dev(dev));
> +	u32 bdr =3D sensor->bdr;
> +
> +	return sysfs_emit(buf, "%d.%03d\n", bdr / 1000, bdr % 1000);
> +}
> +
> +static ssize_t st_lsm6dsx_bdr_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct iio_dev *iio_dev =3D dev_to_iio_dev(dev);
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> +	int integer, fract;
> +	int ret;
> +	u32 bdr;
> +	u8 data;
> +
> +	ret =3D iio_str_to_fixpoint(buf, 100, &integer, &fract);
> +	if (ret)
> +		return ret;
nit: new line here.

> +	bdr =3D integer * 1000 + fract;
> +	ret =3D st_lsm6dsx_check_odr(sensor, bdr, &data);
> +	if (ret < 0)
> +		return ret;

nit: new line here.

> +	bdr =3D ret;
> +	if (!iio_device_claim_direct(iio_dev))
> +		return -EBUSY;

I guess you can check it at the beginning of the routine.

> +	/* the batch data rate must not exceed the sensor output data rate */
> +	if (bdr <=3D sensor->odr)
> +		sensor->bdr =3D bdr;
> +	else
> +		ret =3D -EINVAL;

nit: new line here.

> +	iio_device_release_direct(iio_dev);

nit: new line here.

> +	return (ret < 0) ? ret : len;

nit: we do not need brackets here.

> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(0664, st_lsm6dsx_bdr_show, st_lsm6dsx_bdr_=
store);
> +
> +static const struct iio_dev_attr *st_lsm6dsx_buffer_attrs[] =3D {
> +	&iio_dev_attr_sampling_frequency,
> +	NULL
> +};
> +
>  int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
>  {
>  	int i, ret;
> @@ -807,8 +854,9 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
>  		if (!hw->iio_devs[i])
>  			continue;
> =20
> -		ret =3D devm_iio_kfifo_buffer_setup(hw->dev, hw->iio_devs[i],
> -						  &st_lsm6dsx_buffer_ops);
> +		ret =3D devm_iio_kfifo_buffer_setup_ext(hw->dev, hw->iio_devs[i],
> +						      &st_lsm6dsx_buffer_ops,
> +						      st_lsm6dsx_buffer_attrs);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index c65ad49829e7..e4922578329e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1847,10 +1847,13 @@ static int st_lsm6dsx_write_raw(struct iio_dev *i=
io_dev,
> =20
>  		val =3D val * 1000 + val2 / 1000;
>  		val =3D st_lsm6dsx_check_odr(sensor, val, &data);
> -		if (val < 0)
> +		if (val < 0) {
>  			err =3D val;
> -		else
> +		} else {
>  			sensor->odr =3D val;
> +			/* the batch data rate must not exceed the sensor ODR */
> +			sensor->bdr =3D min_t(u32, sensor->bdr, sensor->odr);
> +		}
>  		break;
>  	}
>  	default:
> @@ -2383,7 +2386,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(stru=
ct st_lsm6dsx_hw *hw,
>  	sensor =3D iio_priv(iio_dev);
>  	sensor->id =3D id;
>  	sensor->hw =3D hw;
> -	sensor->odr =3D hw->settings->odr_table[id].odr_avl[0].milli_hz;
> +	sensor->odr =3D sensor->bdr =3D hw->settings->odr_table[id].odr_avl[0].=
milli_hz;

please add a new line to set sensor->bdr here.

>  	sensor->gain =3D hw->settings->fs_table[id].fs_avl[0].gain;
>  	sensor->watermark =3D 1;
> =20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 3c5e65dc0f97..01d73002e888 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -639,7 +639,7 @@ __st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
>  			return odr;
> =20
>  		sensor->ext_info.slv_odr =3D val;
> -		sensor->odr =3D odr;
> +		sensor->odr =3D sensor->bdr =3D odr;
>  		return 0;
>  	}
>  	case IIO_CHAN_INFO_SCALE:
> @@ -745,7 +745,7 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  	sensor =3D iio_priv(iio_dev);
>  	sensor->id =3D id;
>  	sensor->hw =3D hw;
> -	sensor->odr =3D hw->settings->odr_table[ref_id].odr_avl[0].milli_hz;
> +	sensor->odr =3D sensor->bdr =3D hw->settings->odr_table[ref_id].odr_avl=
[0].milli_hz;

please add a new line to set sensor->bdr here.

>  	sensor->ext_info.slv_odr =3D info->odr_table.odr_avl[0].milli_hz;
>  	sensor->gain =3D info->fs_table.fs_avl[0].gain;
>  	sensor->ext_info.settings =3D info;
> --=20
> 2.39.5
>=20

--PZTB0aTF+sLXKEc+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaOg3dQAKCRA6cBh0uS2t
rGGLAP0Qeyu28ZGU5aO8JUksXcrWeoIwL5c1BmPWw8Jmufk7xwEA5iWbjGgmKhSK
giI13aHeE8LEl1tiUpawGoQ3Cs8B2A4=
=G2P/
-----END PGP SIGNATURE-----

--PZTB0aTF+sLXKEc+--

