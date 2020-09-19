Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B95F270E22
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 15:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgISNa0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 09:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISNa0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 09:30:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE6F2100A;
        Sat, 19 Sep 2020 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600522225;
        bh=umIqp8rQ5cHUnScAQ74bGLk7Bj2WKt5zdB9CN5qaKaU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rXVfGV6ffn32x3ws9NUJtU/t1DJX+dMVDm+o9yF1+GmA2NX0x76dfXa5hUGbffgeJ
         rTV5jEeFoB2CD/1HTDeWVB74md3S2XvDpKr/D1Bk+8lebo/BqduAb8FuPmcM81IEEM
         OsIZ+HaH0VXFd/NVMkeJCcfAIrUn/lGGxNwmtx8Y=
Date:   Sat, 19 Sep 2020 14:30:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mario Tesi <martepisa@gmail.com>
Cc:     lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.tesi@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Scaling factor type set to
 IIO_VAL_INT_PLUS_NANO
Message-ID: <20200919143020.53df1f3f@archlinux>
In-Reply-To: <1600361236-2285-1-git-send-email-martepisa@gmail.com>
References: <1600361236-2285-1-git-send-email-martepisa@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 17 Sep 2020 18:47:16 +0200
Mario Tesi <martepisa@gmail.com> wrote:

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
Is this v2?  If so where is the change log?
Thankfully wasn't too hard to spot the difference and you were fixing what
Lorenzo was pointing out in v1.

Also, should have picked up Lorenzo's tag from v1 as you have fixed
what he asked you to fix before applying it.

Anyhow, stuff to get right next time.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan


=09

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 134 +++++++++++++++------=
------
>  1 file changed, 77 insertions(+), 57 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 346c242..42f4856 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -157,10 +157,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  					.addr =3D 0x20,
>  					.mask =3D GENMASK(4, 3),
>  				},
> -				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61), 0x0 },
> -				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
> -				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
> -				.fs_avl[3] =3D { IIO_G_TO_M_S_2(732), 0x1 },
> +				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61000), 0x0 },
> +				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122000), 0x2 },
> +				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244000), 0x3 },
> +				.fs_avl[3] =3D { IIO_G_TO_M_S_2(732000), 0x1 },
>  				.fs_len =3D 4,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] =3D {
> @@ -169,9 +169,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  					.mask =3D GENMASK(4, 3),
>  				},
> =20
> -				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750), 0x0 },
> -				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
> -				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
> +				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
> +				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500000), 0x1 },
> +				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(70000000), 0x3 },
>  				.fs_len =3D 3,
>  			},
>  		},
> @@ -259,10 +259,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  					.addr =3D 0x10,
>  					.mask =3D GENMASK(3, 2),
>  				},
> -				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61), 0x0 },
> -				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
> -				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
> -				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488), 0x1 },
> +				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61000), 0x0 },
> +				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122000), 0x2 },
> +				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244000), 0x3 },
> +				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488000), 0x1 },
>  				.fs_len =3D 4,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] =3D {
> @@ -270,10 +270,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  					.addr =3D 0x11,
>  					.mask =3D GENMASK(3, 2),
>  				},
> -				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750), 0x0 },
> -				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
> -				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000), 0x2 },
> -				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
> +				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
> +				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500000), 0x1 },
> +				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000000), 0x2 },
> +				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000000), 0x3 },
>  				.fs_len =3D 4,
>  			},
>  		},
> @@ -425,10 +425,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  					.addr =3D 0x10,
>  					.mask =3D GENMASK(3, 2),
>  				},
> -				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61), 0x0 },
> -				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
> -				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
> -				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488), 0x1 },
> +				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61000), 0x0 },
> +				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122000), 0x2 },
> +				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244000), 0x3 },
> +				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488000), 0x1 },
>  				.fs_len =3D 4,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] =3D {
> @@ -436,10 +436,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  					.addr =3D 0x11,
>  					.mask =3D GENMASK(3, 2),
>  				},
> -				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750), 0x0 },
> -				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
> -				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000), 0x2 },
> -				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
> +				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
> +				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500000), 0x1 },
> +				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000000), 0x2 },
> +				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000000), 0x3 },
>  				.fs_len =3D 4,
>  			},
>  		},
> @@ -600,10 +600,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  					.addr =3D 0x10,
>  					.mask =3D GENMASK(3, 2),
>  				},
> -				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61), 0x0 },
> -				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
> -				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
> -				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488), 0x1 },
> +				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61000), 0x0 },
> +				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122000), 0x2 },
> +				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244000), 0x3 },
> +				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488000), 0x1 },
>  				.fs_len =3D 4,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] =3D {
> @@ -611,10 +611,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  					.addr =3D 0x11,
>  					.mask =3D GENMASK(3, 2),
>  				},
> -				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750), 0x0 },
> -				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
> -				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000), 0x2 },
> -				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
> +				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
> +				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500000), 0x1 },
> +				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000000), 0x2 },
> +				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000000), 0x3 },
>  				.fs_len =3D 4,
>  			},
>  		},
> @@ -816,10 +816,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  					.addr =3D 0x10,
>  					.mask =3D GENMASK(3, 2),
>  				},
> -				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61), 0x0 },
> -				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
> -				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
> -				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488), 0x1 },
> +				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61000), 0x0 },
> +				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122000), 0x2 },
> +				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244000), 0x3 },
> +				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488000), 0x1 },
>  				.fs_len =3D 4,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] =3D {
> @@ -827,10 +827,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  					.addr =3D 0x11,
>  					.mask =3D GENMASK(3, 2),
>  				},
> -				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750), 0x0 },
> -				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
> -				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000), 0x2 },
> -				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
> +				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
> +				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500000), 0x1 },
> +				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000000), 0x2 },
> +				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000000), 0x3 },
>  				.fs_len =3D 4,
>  			},
>  		},
> @@ -1021,10 +1021,10 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
>  					.addr =3D 0x10,
>  					.mask =3D GENMASK(3, 2),
>  				},
> -				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61), 0x0 },
> -				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
> -				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
> -				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488), 0x1 },
> +				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61000), 0x0 },
> +				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122000), 0x2 },
> +				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244000), 0x3 },
> +				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488000), 0x1 },
>  				.fs_len =3D 4,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] =3D {
> @@ -1032,10 +1032,10 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
>  					.addr =3D 0x11,
>  					.mask =3D GENMASK(3, 2),
>  				},
> -				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750), 0x0 },
> -				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
> -				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000), 0x2 },
> -				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
> +				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
> +				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500000), 0x1 },
> +				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000000), 0x2 },
> +				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000000), 0x3 },
>  				.fs_len =3D 4,
>  			},
>  		},
> @@ -1200,10 +1200,10 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
>  					.addr =3D 0x10,
>  					.mask =3D GENMASK(3, 2),
>  				},
> -				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61), 0x0 },
> -				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
> -				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
> -				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488), 0x1 },
> +				.fs_avl[0] =3D {  IIO_G_TO_M_S_2(61000), 0x0 },
> +				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122000), 0x2 },
> +				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244000), 0x3 },
> +				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488000), 0x1 },
>  				.fs_len =3D 4,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] =3D {
> @@ -1211,10 +1211,10 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
>  					.addr =3D 0x11,
>  					.mask =3D GENMASK(3, 2),
>  				},
> -				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750), 0x0 },
> -				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
> -				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000), 0x2 },
> -				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
> +				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
> +				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500000), 0x1 },
> +				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000000), 0x2 },
> +				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000000), 0x3 },
>  				.fs_len =3D 4,
>  			},
>  		},
> @@ -1598,7 +1598,7 @@ static int st_lsm6dsx_read_raw(struct iio_dev *iio_=
dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		*val =3D 0;
>  		*val2 =3D sensor->gain;
> -		ret =3D IIO_VAL_INT_PLUS_MICRO;
> +		ret =3D IIO_VAL_INT_PLUS_NANO;
>  		break;
>  	default:
>  		ret =3D -EINVAL;
> @@ -1836,13 +1836,31 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struc=
t device *dev,
> =20
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
> +}
> +
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sysfs_sampling_frequency_=
avail);
>  static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
>  		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
> @@ -1868,6 +1886,7 @@ static const struct iio_info st_lsm6dsx_acc_info =
=3D {
>  	.read_event_config =3D st_lsm6dsx_read_event_config,
>  	.write_event_config =3D st_lsm6dsx_write_event_config,
>  	.hwfifo_set_watermark =3D st_lsm6dsx_set_watermark,
> +	.write_raw_get_fmt =3D st_lsm6dsx_write_raw_get_fmt,
>  };
> =20
>  static struct attribute *st_lsm6dsx_gyro_attributes[] =3D {
> @@ -1885,6 +1904,7 @@ static const struct iio_info st_lsm6dsx_gyro_info =
=3D {
>  	.read_raw =3D st_lsm6dsx_read_raw,
>  	.write_raw =3D st_lsm6dsx_write_raw,
>  	.hwfifo_set_watermark =3D st_lsm6dsx_set_watermark,
> +	.write_raw_get_fmt =3D st_lsm6dsx_write_raw_get_fmt,
>  };
> =20
>  static int st_lsm6dsx_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_p=
in)

