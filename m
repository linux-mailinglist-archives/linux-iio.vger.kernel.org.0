Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A527A6A225
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 08:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfGPGLw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jul 2019 02:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfGPGLw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Jul 2019 02:11:52 -0400
Received: from localhost.localdomain (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F9F2145D;
        Tue, 16 Jul 2019 06:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563257511;
        bh=mt3c0DiBDMTlOHMKGxKeg3+DIq0pOX98ZQW8XfQKqiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CiMsogjT3dX031TdT3rBNZgCmyINA1CgZ9Px2P5SmbjhaiP/LU7o59gbbU6YNapAC
         1FOXNCvJb+vPLlrzWIivLlypdPA7NGH0nmay6ZGCOTgC5su7k6b63ezsE4cXVkxMzp
         FUYTwSVMaPil7AX61KMbSqDXnvRgdGtXZ8LHBXAY=
Date:   Tue, 16 Jul 2019 08:11:47 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
Subject: Re: [PATCH v2 6/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190716061147.GD23126@localhost.localdomain>
References: <20190715081514.81129-1-sean@geanix.com>
 <20190715081514.81129-6-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline
In-Reply-To: <20190715081514.81129-6-sean@geanix.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Report iio motion events to iio subsystem
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>=20
> Changes since v1:
>  * none
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 52 ++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 0503abab6efc..acc653d5e00e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -39,6 +39,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/interrupt.h>
> @@ -76,6 +77,12 @@
>  #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
>  #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
> =20
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR		0x1B
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Z_WU_MASK	BIT(0)
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Y_WU_MASK	BIT(1)
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_X_WU_MASK	BIT(2)
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK	BIT(3)
> +
>  #define ST_LSM6DSX_REG_TAP_CFG_ADDR		0x58
>  #define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK	BIT(7)
> =20
> @@ -1212,6 +1219,39 @@ int st_lsm6dsx_event_setup(int id, struct st_lsm6d=
sx_hw *hw)
> =20
>  	return err;
>  }
> +int st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
> +{
> +	s64 timestamp =3D iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> +
> +	if (data & ST_LSM6DSX_REG_WAKE_UP_SRC_Z_WU_MASK)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Z,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	if (data & ST_LSM6DSX_REG_WAKE_UP_SRC_Y_WU_MASK)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Y,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	if (data & ST_LSM6DSX_REG_WAKE_UP_SRC_X_WU_MASK)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_X,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	return 0;
> +}
> =20
>  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>  {
> @@ -1222,7 +1262,19 @@ static irqreturn_t st_lsm6dsx_handler_thread(int i=
rq, void *private)
>  {
>  	struct st_lsm6dsx_hw *hw =3D private;
>  	int count =3D 0;
> +	int data, err;
> +
> +	if (hw->enable_event) {
> +		err =3D regmap_read(hw->regmap,
> +				  ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR, &data);

I think we can move the ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR read in
st_lsm6dsx_report_motion_event (and rename it) and avoid goto try_fifo

> +		if (err < 0)
> +			goto try_fifo;
> +
> +		if (data & ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK)
> +			st_lsm6dsx_report_motion_event(hw, data);
> +	}
> =20
> +try_fifo:
>  	if (hw->sip > 0) {
>  		mutex_lock(&hw->fifo_lock);
>  		count =3D st_lsm6dsx_read_fifo(hw);
> --=20
> 2.22.0
>=20

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXS1qoAAKCRA6cBh0uS2t
rAC1AQC6PuJBqZNdoOOSfggI0VCH3Z3zXMrjUQybX9/uzjcdVwEAy4fO/0zJRxCW
EKMXvcM9Vy3gRSKY/gAeQHM00+iAAAo=
=MVjH
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
