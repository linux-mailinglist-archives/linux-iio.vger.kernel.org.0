Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 327A0B304E
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 15:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfIONmo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 09:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfIONmo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 09:42:44 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.2.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B35BB214C6;
        Sun, 15 Sep 2019 13:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568554962;
        bh=CSrLwMsBohipC6vBCT84GTYOgUzyu79IrYF0aTvuueQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LtqA5MG/TSG/L05GaiKvA3zgztZENPxbg+BxsYZV/7qEJkdC67gWcU9Xp4Zr0gJJP
         blKsMuM/866yiPog/x/3Mx80hnewX/bXPkTHv6KZVIbHDNVLykRnPJiW1An6z9pq5Y
         1vpMC+Dz1E1TruZg51zLot/sxWvRVyzyf9yP/C/Q=
Date:   Sun, 15 Sep 2019 15:42:37 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v8 3/5] iio: imu: st_lsm6dsx: add wakeup-source option
Message-ID: <20190915134237.GE15634@lore-desk-wlan.lan>
References: <20190913090708.1442057-1-sean@geanix.com>
 <20190913090708.1442057-4-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline
In-Reply-To: <20190913090708.1442057-4-sean@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This add ways for the SoC to wake from accelerometer wake events.
>=20
> In the suspend function we skip disabling the sensor if wakeup-source
> and events are activated.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v4:
>  * More devices supports wakeup
>=20
> Changes since v5:
>  * None
>=20
> Changes since v6:
>  * None
>=20
> Changes since v7:
>  * Add check for hw->enable_event
>  * Moved disable_irq_wake section so it's called
>  * Removed not neeeded continue from disable_irq_wake section
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 4198ba263d03..810807c52d5f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1858,6 +1858,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, i=
nt hw_id,
>  			return err;
>  	}
> =20
> +	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"=
))
> +		device_init_wakeup(dev, true);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(st_lsm6dsx_probe);
> @@ -1876,6 +1879,13 @@ static int __maybe_unused st_lsm6dsx_suspend(struc=
t device *dev)
>  		if (!(hw->enable_mask & BIT(sensor->id)))
>  			continue;
> =20
> +		if (device_may_wakeup(dev) && i =3D=3D ST_LSM6DSX_ID_ACC &&

since you have to send v9...better to use sensor->id instead of i here


> +		    hw->enable_event) {
> +			/* Enable wake from IRQ */
> +			enable_irq_wake(hw->irq);
> +			continue;
> +		}
> +
>  		if (sensor->id =3D=3D ST_LSM6DSX_ID_EXT0 ||
>  		    sensor->id =3D=3D ST_LSM6DSX_ID_EXT1 ||
>  		    sensor->id =3D=3D ST_LSM6DSX_ID_EXT2)
> @@ -1904,6 +1914,10 @@ static int __maybe_unused st_lsm6dsx_resume(struct=
 device *dev)
>  		if (!hw->iio_devs[i])
>  			continue;
> =20
> +		if (device_may_wakeup(dev) && i =3D=3D ST_LSM6DSX_ID_ACC &&
> +		    hw->enable_event)
> +			disable_irq_wake(hw->irq);
> +
>  		sensor =3D iio_priv(hw->iio_devs[i]);
>  		if (!(hw->suspend_mask & BIT(sensor->id)))
>  			continue;
> --=20
> 2.23.0
>=20

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXX4/ygAKCRA6cBh0uS2t
rJAXAQC5rf6DxqvylhEji3AS3bwphlPLtTzbhzxXTYqdpV7PfgEAldNaJ5rOf08H
W2c5tB7AmvTFYn2rRUeoqa9jzCkytw0=
=3Jfc
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--
