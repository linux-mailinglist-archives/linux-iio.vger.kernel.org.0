Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0604726D5B1
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 10:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIQIHk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 04:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgIQIHB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Sep 2020 04:07:01 -0400
Received: from localhost (unknown [151.66.80.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB2021D7F;
        Thu, 17 Sep 2020 08:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600330021;
        bh=PYy18IYLPyly6lpSvONF4fmQOHk7Au32VIWvOL+8b8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tc7PsFLcqRhs565sfekGU8p420yu3Xn+raDRVhtpuC755sX5IOUIVMm3fMVnfQtf0
         9U74O20nM03yTS4a2oIMm4P0o+xgVi5bw/4hSqXx2PInCNaG0y114SUolO91wy6K76
         A8Mv+ABQPj9zy9krNynPkdb8/yf+KNoAqUQLqqkA=
Date:   Thu, 17 Sep 2020 10:06:56 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Mario Tesi <martepisa@gmail.com>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.tesi@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Scaling factor type set to
 IIO_VAL_INT_PLUS_NANO
Message-ID: <20200917080656.GA22982@lore-desk>
References: <1600274660-29143-1-git-send-email-martepisa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <1600274660-29143-1-git-send-email-martepisa@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Mario Tesi <mario.tesi@st.com>
>=20
> Scaling factor values for Acc lead to an unacceptable rounding of the
> full scale (FS) calculated by some SensorHAL on Android devices. For exam=
ples
> setting FS to 4g the in_accel_x_scale, in_accel_y_scale and in_accel_z_sc=
ale
> are 0.001196 on 6 decimal digits and the FS is
> 0.001196 =C3=97 ((2^15) =E2=88=92 1) ~=3D 39.1893 m/s^2.
>=20
> Android CTS R10 SensorParameterRangeTest test expects a value greater than
> 39.20 m/s^2 so this test fails (ACCELEROMETER_MAX_RANGE =3D 4 * 9.80).
>=20
> Using 9 decimal digits the new scale factor is 0.001196411 and the FS now
> is 0.001196411 =C3=97 ((2^15)=E2=88=921) ~=3D 39.2028 m/s^2.
>=20
> This patch extends to IIO_VAL_INT_PLUS_NANO type the scaling factor to all
> IMU devices where SensorParameterRangeTest CTS test fails.
>=20
> Signed-off-by: Mario Tesi <mario.tesi@st.com>

Hi Mario,

just a minor comment inline. Fixing it:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 136 ++++++++++++++++-----=
------
>  1 file changed, 79 insertions(+), 57 deletions(-)
>=20

[...]

>  	fs_table =3D &hw->settings->fs_table[sensor->id];
>  	for (i =3D 0; i < fs_table->fs_len; i++)
> -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
> +		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
>  				 fs_table->fs_avl[i].gain);
>  	buf[len - 1] =3D '\n';
> =20
>  	return len;
>  }
> =20
> +static int st_lsm6dsx_write_raw_get_fmt(struct iio_dev *indio_dev,
> +					struct iio_chan_spec const *chan,
> +					long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +		case IIO_ACCEL:
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	return -EINVAL;

you can remove this

> +}
> +
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sysfs_sampling_frequency_=
avail);
>  static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
>  		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
> @@ -1868,6 +1888,7 @@ static const struct iio_info st_lsm6dsx_acc_info =
=3D {
>  	.read_event_config =3D st_lsm6dsx_read_event_config,
>  	.write_event_config =3D st_lsm6dsx_write_event_config,
>  	.hwfifo_set_watermark =3D st_lsm6dsx_set_watermark,
> +	.write_raw_get_fmt =3D st_lsm6dsx_write_raw_get_fmt,
>  };
> =20
>  static struct attribute *st_lsm6dsx_gyro_attributes[] =3D {
> @@ -1885,6 +1906,7 @@ static const struct iio_info st_lsm6dsx_gyro_info =
=3D {
>  	.read_raw =3D st_lsm6dsx_read_raw,
>  	.write_raw =3D st_lsm6dsx_write_raw,
>  	.hwfifo_set_watermark =3D st_lsm6dsx_set_watermark,
> +	.write_raw_get_fmt =3D st_lsm6dsx_write_raw_get_fmt,
>  };
> =20
>  static int st_lsm6dsx_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_p=
in)
> --=20
> 2.7.4
>=20

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX2MZHQAKCRA6cBh0uS2t
rHL/AP96R7XytMxa6K9VjyJF4K2K8BSdYyIad7PfYCNCKsj+dAEA2GQN9/EDTUz+
Aoo53Jh582buw4rBvjezJiIXzFoZ9g4=
=L8iq
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
