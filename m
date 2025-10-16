Return-Path: <linux-iio+bounces-25162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063D0BE55DF
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 22:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBF81AA07FE
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 20:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B612DCF41;
	Thu, 16 Oct 2025 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgJO9zfZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417D221FA8;
	Thu, 16 Oct 2025 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646164; cv=none; b=EdhgQnM54IUlZyL57HWZfaVZU9gJMSjGRjIxBVtSP94812ETsukSNreT1F9wcUnGp/igqYLBDeFk7wdugTPsKtMJ8Hk1UJrVxQ2K9jPUSszHi+NNf+EfdSbn/8RmfkohY0ly+cH8JvIbDbhgi/cmj3sBw6PfQBnB5dARisQmKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646164; c=relaxed/simple;
	bh=LybdVQpflkl8XVoGBODqi2kdekMgnuY4p4/TJMv50nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzUdDvT4aLj4/pW7ugomIInHCOPUIxHXWWfXNC+73wadfluA17N4jCTJKbD16wLtXOot2DgBB1RrPospx1M0SOS3H4OcIf6LVmrr/6as2GPzipvvNYPwT0QHZj4whw0q0bjh0nmmMR0eVUuS8+bI0Lia+3cc+y/cgeFrZ9yTNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgJO9zfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F3AC4CEF1;
	Thu, 16 Oct 2025 20:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760646161;
	bh=LybdVQpflkl8XVoGBODqi2kdekMgnuY4p4/TJMv50nE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgJO9zfZ1AHE1PR7PsXD/Em1Wkm9OyUdX6grwp01F0I/YHNjBptkftWqRfeiMokqc
	 Ut3hEGBO7Mb1cgQiq7lKgQg0f8CsN/vgNMH/Mfmm7/iTbJDOQv42Ja3hblPAcWiQXz
	 N5V+Lx6Uv5zuaM99bpT+PfMul6YnfOPz6aOtCwA2Ey3JLIUMaKFoWbLavmYrD5714B
	 xhPTR1ykabdtOvE/ks/SCYWWJtmVuZI1Cixiq650uMuR5QCK+tLYZwMCOq42qm59MX
	 AxDI9cPEIRMtKaYdHcwG1TkUtETITj2XkNlfvIQzhXAIigfnB7lcYfql+hCySfYOXZ
	 aiC4Tw28xVf3g==
Date: Thu, 16 Oct 2025 22:22:38 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
Message-ID: <aPFUDr59szl_-Ckq@lore-desk>
References: <20251016172122.1220332-1-flavra@baylibre.com>
 <20251016172122.1220332-3-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rnInvlsCw4CKCj18"
Content-Disposition: inline
In-Reply-To: <20251016172122.1220332-3-flavra@baylibre.com>


--rnInvlsCw4CKCj18
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
> sample values from the hardware FIFO at a lower data rate (e.g. to
> minimize the amount of I2C or SPI traffic and the rate of periodic
> interrupts).
> To support the above use case, add a sampling_frequency sysfs
> attribute to the buffer directory of st_lsm6dsx IIO devices, which
> controls the BDR for a given sensor independently from the "main"
> sampling_frequency attribute (which controls the ODR); introduce a
> new `hwfifo_odr_mHz` field in struct st_lsm6dsx_sensor to keep
> track of the current BDR value, and use this field instead of the
> `odr` field in the code that deals with the FIFO data rate. In the
> sensor hub driver, make the hwfifo_odr_mHz value always mirror the
> odr value, since there is no separate configuration setting to
> control the BDR for data produced by the sensor hub functionality.
> For backwards compatibility, set the buffer frequency equal to the
> main frequency whenever the latter is updated via sysfs; if
> userspace wants a different buffer frequency, it has to write to
> the relevant sysfs attribute after any writes to the main frequency
> attribute.
>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>

Hi Francesco,

I think the patch is fine, just few nits inline. Addressing them:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 +
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 71 ++++++++++++++++---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  3 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  3 +-
>  4 files changed, 69 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index bd366c6e282a..3cd520bdec46 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -366,6 +366,7 @@ enum st_lsm6dsx_fifo_mode {
>   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
>   * @gain: Configured sensor sensitivity.
>   * @odr: Output data rate of the sensor [mHz].
> + * hwfifo_odr_mHz: Batch data rate for hardware FIFO [mHz]
>   * @samples_to_discard: Number of samples to discard for filters settlin=
g time.
>   * @watermark: Sensor watermark level.
>   * @decimator: Sensor decimation factor.
> @@ -380,6 +381,7 @@ struct st_lsm6dsx_sensor {
> =20
>  	u32 gain;
>  	u32 odr;
> +	u32 hwfifo_odr_mHz;
> =20
>  	u16 samples_to_discard;
>  	u16 watermark;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 8a9d2593576a..7a66f06522c4 100644
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
> +	u32 decimator =3D max_odr / sensor->hwfifo_odr_mHz;
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
> +		*max_odr =3D max(*max_odr, sensor->hwfifo_odr_mHz);
> +		*min_odr =3D min(*min_odr, sensor->hwfifo_odr_mHz);
>  	}
>  }
> =20
>  static u8 st_lsm6dsx_get_sip(struct st_lsm6dsx_sensor *sensor, u32 min_o=
dr)
>  {
> -	u8 sip =3D sensor->odr / min_odr;
> +	u8 sip =3D sensor->hwfifo_odr_mHz / min_odr;
> =20
>  	return sip > 1 ? round_down(sip, 2) : sip;
>  }
> @@ -231,7 +232,7 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_=
sensor *sensor,
>  		if (enable) {
>  			int err;
> =20
> -			err =3D st_lsm6dsx_check_odr(sensor, sensor->odr,
> +			err =3D st_lsm6dsx_check_odr(sensor, sensor->hwfifo_odr_mHz,
>  						   &data);
>  			if (err < 0)
>  				return err;
> @@ -713,7 +714,7 @@ st_lsm6dsx_update_samples_to_discard(struct st_lsm6ds=
x_sensor *sensor)
> =20
>  	data =3D &hw->settings->samples_to_discard[sensor->id];
>  	for (i =3D 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++) {
> -		if (data->val[i].milli_hz =3D=3D sensor->odr) {
> +		if (data->val[i].milli_hz =3D=3D sensor->hwfifo_odr_mHz) {
>  			sensor->samples_to_discard =3D data->val[i].samples;
>  			return;
>  		}
> @@ -799,6 +800,59 @@ static const struct iio_buffer_setup_ops st_lsm6dsx_=
buffer_ops =3D {
>  	.postdisable =3D st_lsm6dsx_buffer_postdisable,
>  };
> =20
> +static ssize_t st_lsm6dsx_hwfifo_odr_show(struct device *dev,
> +					  struct device_attribute *attr, char *buf)
> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(dev_to_iio_dev(dev));
> +	u32 hwfifo_odr =3D sensor->hwfifo_odr_mHz;

nit: you can rid of this hwfifo_odr variable here and use
sensor->hwfifo_odr_mHz directly.

> +
> +	return sysfs_emit(buf, "%d.%03d\n", hwfifo_odr / 1000, hwfifo_odr % 100=
0);
> +}
> +
> +static ssize_t st_lsm6dsx_hwfifo_odr_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t len)
> +{
> +	struct iio_dev *iio_dev =3D dev_to_iio_dev(dev);
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> +	int integer, milli;
> +	int ret;
> +	u32 hwfifo_odr;
> +	u8 data;
> +
> +	if (!iio_device_claim_direct(iio_dev))
> +		return -EBUSY;
> +
> +	ret =3D iio_str_to_fixpoint(buf, 100, &integer, &milli);
> +	if (ret)
> +		goto out;
> +
> +	hwfifo_odr =3D integer * 1000 + milli;
> +	ret =3D st_lsm6dsx_check_odr(sensor, hwfifo_odr, &data);
> +	if (ret < 0)
> +		goto out;
> +
> +	hwfifo_odr =3D ret;
> +
> +	/* the batch data rate must not exceed the sensor output data rate */
> +	if (hwfifo_odr <=3D sensor->odr)
> +		sensor->hwfifo_odr_mHz =3D hwfifo_odr;
> +	else
> +		ret =3D -EINVAL;
> +
> +out:
> +	iio_device_release_direct(iio_dev);
> +
> +	return ret < 0 ? ret : len;
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(0664, st_lsm6dsx_hwfifo_odr_show, st_lsm6d=
sx_hwfifo_odr_store);
> +
> +static const struct iio_dev_attr *st_lsm6dsx_buffer_attrs[] =3D {
> +	&iio_dev_attr_sampling_frequency,
> +	NULL
> +};
> +
>  int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
>  {
>  	int i, ret;
> @@ -807,8 +861,9 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
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
> index c65ad49829e7..055424303a4f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1850,7 +1850,7 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio=
_dev,
>  		if (val < 0)
>  			err =3D val;
>  		else
> -			sensor->odr =3D val;
> +			sensor->odr =3D sensor->hwfifo_odr_mHz =3D val;

please avoid multi-assignment here.

>  		break;
>  	}
>  	default:
> @@ -2384,6 +2384,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(stru=
ct st_lsm6dsx_hw *hw,
>  	sensor->id =3D id;
>  	sensor->hw =3D hw;
>  	sensor->odr =3D hw->settings->odr_table[id].odr_avl[0].milli_hz;
> +	sensor->hwfifo_odr_mHz =3D sensor->odr;
>  	sensor->gain =3D hw->settings->fs_table[id].fs_avl[0].gain;
>  	sensor->watermark =3D 1;
> =20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 3c5e65dc0f97..039f588ef806 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -639,7 +639,7 @@ __st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
>  			return odr;
> =20
>  		sensor->ext_info.slv_odr =3D val;
> -		sensor->odr =3D odr;
> +		sensor->odr =3D sensor->hwfifo_odr_mHz =3D odr;

same here, one assignment per line.

>  		return 0;
>  	}
>  	case IIO_CHAN_INFO_SCALE:
> @@ -746,6 +746,7 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  	sensor->id =3D id;
>  	sensor->hw =3D hw;
>  	sensor->odr =3D hw->settings->odr_table[ref_id].odr_avl[0].milli_hz;
> +	sensor->hwfifo_odr_mHz =3D sensor->odr;
>  	sensor->ext_info.slv_odr =3D info->odr_table.odr_avl[0].milli_hz;
>  	sensor->gain =3D info->fs_table.fs_avl[0].gain;
>  	sensor->ext_info.settings =3D info;
> --=20
> 2.39.5
>=20

--rnInvlsCw4CKCj18
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaPFUDgAKCRA6cBh0uS2t
rDjnAQDsugt6n+QUQcBuwHDkiGL0RT1uOuMnl70Cu8MOdRmlxwD/VHdvQl0yUoOm
wDq3nKNArjVO3vk3MSZXoczpepgfhAg=
=leUB
-----END PGP SIGNATURE-----

--rnInvlsCw4CKCj18--

