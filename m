Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84AD130230
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2020 12:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgADLdh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jan 2020 06:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgADLdg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jan 2020 06:33:36 -0500
Received: from new-host-3 (net-2-42-61-77.cust.vodafonedsl.it [2.42.61.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4054C217F4;
        Sat,  4 Jan 2020 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578137616;
        bh=e1BRoC8LZzvKri6N8j3P0+16d+i9uQHr6qcIBKSIkzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KGr7fRnDVsU11eXKFLAAETNbXL13E39aPRS4tMNvc3XpIL9KRoLDKTyqnigBNu8wg
         xgX6NUWmVMhCYkZ0WenMBPZ1QN3N4gkFasRQEXE1RBy1OZ1iipWLpXfpuFnkob8/2h
         euOmFcz6dAQwCn4ZrxLa8T5nwt8kgF36M6J0txsY=
Date:   Sat, 4 Jan 2020 12:33:27 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: add mount matrix support
Message-ID: <20200104113327.GA3725@new-host-3>
References: <20200103102630.17109-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20200103102630.17109-1-martin.kepplinger@puri.sm>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Allow to read the mount-matrix device tree property and provide the
> mount_matrix file for userspace to read.
>=20
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>=20
> tested using the lsm9ds1 on the librem5-devkit (and userspace tools like
> iio-sensor-proxy) where this will be needed.
>=20
> thanks,
>=20
>                                martin
>=20
>=20
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 18 ++++++++++++++++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |  4 ++++
>  2 files changed, 22 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index a763ff46f596..8483f770b233 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -76,6 +76,7 @@ enum st_lsm6dsx_hw_id {
>  		.endianness =3D IIO_LE,					\
>  	},								\
>  	.event_spec =3D &st_lsm6dsx_event,				\
> +	.ext_info =3D st_lsm6dsx_accel_ext_info,				\
>  	.num_event_specs =3D 1,						\
>  }
> =20
> @@ -406,6 +407,8 @@ struct st_lsm6dsx_hw {
>  	struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
> =20
>  	const struct st_lsm6dsx_settings *settings;
> +
> +	struct iio_mount_matrix orientation;

Could you please add doc for orientation struct as we did for all other mem=
ber
of st_lsm6dsx_hw?

>  };
> =20
>  static __maybe_unused const struct iio_event_spec st_lsm6dsx_event =3D {
> @@ -479,4 +482,19 @@ st_lsm6dsx_write_locked(struct st_lsm6dsx_hw *hw, un=
signed int addr,
>  	return err;
>  }
> =20
> +static const struct iio_mount_matrix *
> +st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev,
> +			    const struct iio_chan_spec *chan)

static const inline struct iio_mount_matrix *
st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev

> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +
> +	return &hw->orientation;
> +}
> +
> +static const struct iio_chan_spec_ext_info st_lsm6dsx_accel_ext_info[] =
=3D {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_lsm6dsx_get_mount_matrix),
> +	{ }
> +};
> +
>  #endif /* ST_LSM6DSX_H */
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 0c64e35c7599..587e02bb9be9 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2325,6 +2325,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, =
int hw_id,
>  	    (pdata && pdata->wakeup_source))
>  		device_init_wakeup(dev, true);
> =20
> +	err =3D iio_read_mount_matrix(hw->dev, "mount-matrix", &hw->orientation=
);
> +	if (err)
> +		return err;
> +
>  	return 0;

	return iio_read_mount_matrix(hw->dev, "mount-matrix",
				     &hw->orientation);=20

>  }
>  EXPORT_SYMBOL(st_lsm6dsx_probe);
> --=20
> 2.20.1
>=20

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXhB4BQAKCRA6cBh0uS2t
rAsfAP9tq6mTNNnaX2MxhUnln49limq1MKIYY7AJZ3a/jXUeMgEAxUutJdDZ8A3h
JGyea3INWmEf5o0eTKQFy165QPh6mAg=
=8TmB
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
