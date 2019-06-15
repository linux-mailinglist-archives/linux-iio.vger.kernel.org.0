Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267FC46EFD
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2019 10:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfFOIbF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jun 2019 04:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfFOIbF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Jun 2019 04:31:05 -0400
Received: from localhost.localdomain (unknown [77.246.15.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C8B206B7;
        Sat, 15 Jun 2019 08:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560587464;
        bh=YPDAcqZR7S0Bvl89e76VtpzVkEwAlsosnm+TS4/hznU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OrrMjB+IZV6V7IhKxD8+jHmWbcNBXqisDxZ6wvv8HI5FsjsyiUUlgsmOdTkLFVIDS
         yEf4npUbncSyXjF3ymmAYEcjBIpirRuN/klTg2BTJOate4wXv/Il209uNBcKT+e3IW
         OjxE8NmPX/S8res1yoTh4pg1qQuec5JG20S6I5SM=
Date:   Sat, 15 Jun 2019 10:30:58 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        martin@geanix.com
Subject: Re: [RFC PATCH 1/3] iio: imu: st_lsm6dsx: add wake on accelerometer
 threshold
Message-ID: <20190615083022.GA4857@localhost.localdomain>
References: <20190614122604.52935-1-sean@geanix.com>
 <20190614122604.52935-2-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <20190614122604.52935-2-sean@geanix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Added wakeup-source option for waking on accelerometer events.
> If the wakeup-source is specified, we activate this on our
> way down to suspend. We start the accelerometer in
> low power mode and wait for it to report a wake event.
>=20

Hi Sean,

thx for working on this, some comments inline.

Regards,
Lorenzo

> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 70 ++++++++++++++++++++
>  2 files changed, 72 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index edcd838037cd..ef4327fd57d6 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -147,6 +147,7 @@ struct st_lsm6dsx_hw {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	int irq;
> +	bool irq_wake;
> =20
>  	struct mutex fifo_lock;
>  	struct mutex conf_lock;
> @@ -155,6 +156,7 @@ struct st_lsm6dsx_hw {
>  	u8 enable_mask;
>  	u8 ts_sip;
>  	u8 sip;
> +	u8 wake_threshold;
> =20
>  	u8 *buff;
> =20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index aebbe0ddd8d8..092c4d02bd4e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -36,6 +36,7 @@
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/bitfield.h>
> @@ -71,6 +72,17 @@
>  #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
>  #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
> =20
> +#define ST_LSM6DSX_REG_TAP_CFG_ADDR		0x58
> +#define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK	BIT(7)
> +#define ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK	GENMASK(6, 5)
> +
> +#define ST_LSM6DSX_DEFAULT_WAKE_THRESH		0
> +#define ST_LSM6DSX_REG_WAKE_UP_THS_ADDR		0x5B
> +#define ST_LSM6DSX_REG_WAKE_UP_THS_THRES_MASK	GENMASK(5, 0)
> +
> +#define ST_LSM6DSX_REG_MD1_CFG_ADDR		0x5E
> +#define ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK	BIT(5)
> +
>  #define ST_LSM6DSX_ACC_FS_2G_GAIN		IIO_G_TO_M_S_2(61)
>  #define ST_LSM6DSX_ACC_FS_4G_GAIN		IIO_G_TO_M_S_2(122)
>  #define ST_LSM6DSX_ACC_FS_8G_GAIN		IIO_G_TO_M_S_2(244)

have you verified these register maps is the same for all supported devices?

> @@ -428,6 +440,19 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sens=
or *sensor, u16 odr)
>  				  ST_LSM6DSX_SHIFT_VAL(val, reg->mask));
>  }
> =20
> +static int st_lsm6dsx_set_wake_threshold(struct st_lsm6dsx_hw *hw, u8 th=
reshold)
> +{
> +	int err =3D 0;
> +
> +	err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_WAKE_UP_THS_ADDR,
> +				 ST_LSM6DSX_REG_WAKE_UP_THS_THRES_MASK,
> +				 threshold);
> +	if (!err)
> +		hw->wake_threshold =3D threshold;
> +
> +	return err;
> +}

I guess you can move it in patch 3/3

> +
>  int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor)
>  {
>  	int err;
> @@ -754,6 +779,8 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_h=
w *hw)
>  	if (err < 0)
>  		return err;
> =20
> +	st_lsm6dsx_set_wake_threshold(hw, ST_LSM6DSX_DEFAULT_WAKE_THRESH);

we do not need this since default value is 0

> +
>  	return st_lsm6dsx_init_hw_timer(hw);
>  }
> =20
> @@ -853,6 +880,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, in=
t hw_id, const char *name,
>  			return err;
>  	}
> =20
> +	if (dev->of_node)
> +		if (of_property_read_bool(dev->of_node, "wakeup-source"))
> +			device_init_wakeup(dev, true);
> +

you probably need to add the equivalent for the pdata case. Maybe it is bet=
ter
a dedicated routine

>  	return 0;
>  }
>  EXPORT_SYMBOL(st_lsm6dsx_probe);
> @@ -879,6 +910,26 @@ static int __maybe_unused st_lsm6dsx_suspend(struct =
device *dev)
>  	if (hw->fifo_mode !=3D ST_LSM6DSX_FIFO_BYPASS)
>  		err =3D st_lsm6dsx_flush_fifo(hw);
> =20
> +	if (device_may_wakeup(dev)) {
> +		sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> +		err =3D st_lsm6dsx_sensor_enable(sensor);

better not not disable the acc in this case

> +
> +		/* Enable inactivity function - low power ACC, GYRO powered-down */
> +		err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_TAP_CFG_ADDR,
> +				ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK |
> +				ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK,
> +				ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK |
> +				ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK);
> +
> +		/* Enable wakeup interrupt */
> +		err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_MD1_CFG_ADDR,
> +				ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK,
> +				ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK);

I guess we can enable it by default

> +
> +		/* Enable wake from IRQ */
> +		hw->irq_wake =3D (enable_irq_wake(hw->irq) =3D=3D 0);

do we really need this? maybe it is enough to just disable
ST_LSM6DSX_REG_TAP_CFG_ADDR in st_lsm6dsx_resume and drop irq_wake

> +	}
> +
>  	return err;
>  }
> =20
> @@ -888,6 +939,25 @@ static int __maybe_unused st_lsm6dsx_resume(struct d=
evice *dev)
>  	struct st_lsm6dsx_sensor *sensor;
>  	int i, err =3D 0;
> =20
> +	if (device_may_wakeup(dev) && hw->irq_wake) {
> +		disable_irq_wake(hw->irq);
> +		hw->irq_wake =3D false;
> +
> +		sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> +		err =3D st_lsm6dsx_sensor_disable(sensor);

I guess this breaks the acc/sensor hub resume

> +
> +		/* Disable inactivity function */
> +		err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_TAP_CFG_ADDR,
> +				ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK |
> +				ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK,
> +				0);
> +
> +		/* Disable wakeup interrupt */
> +		err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_MD1_CFG_ADDR,
> +				ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK,
> +				0);
> +	}
> +
>  	for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
>  		sensor =3D iio_priv(hw->iio_devs[i]);
>  		if (!(hw->enable_mask & BIT(sensor->id)))
> --=20
> 2.22.0
>=20

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQSsvgAKCRA6cBh0uS2t
rAJ5AP4gpFYV+mUEfZzlkdmaMLQD0AGAoJGkRSW+LMkMeKyMzgD+KQCyAiCxTLrm
G/LGrADSAbWmVAcCe0XHAJmbLWYBFQ8=
=giOS
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
