Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D2A8DB2
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2019 21:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbfIDR1U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Sep 2019 13:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731852AbfIDR1U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Sep 2019 13:27:20 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20F8D2087E;
        Wed,  4 Sep 2019 17:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567618039;
        bh=KIVqEBkBTfgw6EKX55HcQbWNyPMQMJ9i7u2qbbfivXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1aXgyTV8tQa3DonBNr1c/gEYftkYRpl3nO4SCC2srIPIFdEztFDpZGohL/7tObkQ2
         TVZGMGMLnB7ng3+URokR6vhStiZXyLKuKL+g15ZKAz4NcthmV5F634RbKlRkwCK62J
         rOUh5Zx1rsokjiPncnkM8mAsSNLocYSPWjyqmRYQ=
Date:   Wed, 4 Sep 2019 19:27:13 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v3 3/6] iio: imu: st_lsm6dsx: add wakeup-source option
Message-ID: <20190904172713.GD2058@localhost.localdomain>
References: <20190904091732.112281-1-sean@geanix.com>
 <20190904091732.112281-3-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <20190904091732.112281-3-sean@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 04, Sean Nyekjaer wrote:
> This add ways for the SoC to wake from accelerometer wake events.
>=20
> In the suspend function we skip disabling the sensor if wakeup-source
> and events are activated.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>  * none, as the call to st_lsm6dsx_flush_fifo will put the fifo in
>    bypass mode.
>=20
> Changes since v2:
>  * Removed unnecessary brackets
>  * Move enable_irq to after the enable mask
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index d4d6ba934b6d..bb72800bf99b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1754,6 +1754,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, =
int hw_id,
>  			return err;
>  	}
> =20
> +	if (dev->of_node)
> +		if (of_property_read_bool(dev->of_node, "wakeup-source"))
> +			device_init_wakeup(dev, true);

if (dev->of_node &&
    of_property_read_bool(dev->of_node, "wakeup-source"))
	device_init_wakeup(dev, true);

I guess it is more readable in this way, isn't it?

> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(st_lsm6dsx_probe);
> @@ -1772,6 +1776,12 @@ static int __maybe_unused st_lsm6dsx_suspend(struc=
t device *dev)
>  		if (!(hw->enable_mask & BIT(sensor->id)))
>  			continue;
> =20
> +		if (device_may_wakeup(dev) && i =3D=3D ST_LSM6DSX_ID_ACC) {
> +			/* Enable wake from IRQ */
> +			enable_irq_wake(hw->irq);
> +			continue;
> +		}
> +
>  		if (sensor->id =3D=3D ST_LSM6DSX_ID_EXT0 ||
>  		    sensor->id =3D=3D ST_LSM6DSX_ID_EXT1 ||
>  		    sensor->id =3D=3D ST_LSM6DSX_ID_EXT2)
> @@ -1804,6 +1814,11 @@ static int __maybe_unused st_lsm6dsx_resume(struct=
 device *dev)
>  		if (!(hw->suspend_mask & BIT(sensor->id)))
>  			continue;
> =20
> +		if (device_may_wakeup(dev) && i =3D=3D ST_LSM6DSX_ID_ACC) {
> +			disable_irq_wake(hw->irq);
> +			continue;
> +		}
> +
>  		if (sensor->id =3D=3D ST_LSM6DSX_ID_EXT0 ||
>  		    sensor->id =3D=3D ST_LSM6DSX_ID_EXT1 ||
>  		    sensor->id =3D=3D ST_LSM6DSX_ID_EXT2)
> --=20
> 2.23.0
>=20

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXW/z7gAKCRA6cBh0uS2t
rO5xAQC0HfAFRlbsQrzTdslw36bUbOdas0gtmx7UR/oSv667xAEAhyviBlLJ7kAu
QW4+sHlqMv4T7Zv6vwKzJ7D/3VlWGgc=
=wqnw
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--
