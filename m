Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E4F4A5E1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfFRPv3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 11:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbfFRPv3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 11:51:29 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B43020673;
        Tue, 18 Jun 2019 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560873088;
        bh=hdPh/wUZH2dv3law7xTgMkU1eCcqD41M4ktnR6UJMyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUFnTxvLGHrZwACDoU6KdSfeQVIf7UJtQXFInVxUQ8PcgsFP0t9eqQoc84sOaTsqR
         FjwpPe8+xhJfoNkl/J5K2enZ/jdNUjw3C/B8uGSPv1fDub2auFS04VXPUhseOfvVhg
         Qxe/ybCgZuf07GzeODyxHqrIf0MYE0LUo3mnm9JQ=
Date:   Tue, 18 Jun 2019 17:51:23 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
Subject: Re: [PATCH 3/5] iio: imu: st_lsm6dsx: add wakeup-source option
Message-ID: <20190618155122.GC20044@localhost.localdomain>
References: <20190618125939.105903-1-sean@geanix.com>
 <20190618125939.105903-4-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <20190618125939.105903-4-sean@geanix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> this add ways for the SoC to wake from accelerometer wake events.
>=20
> In the suspend function we skip disabling the sensor if wakeup-source
> and events are activated.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 351c46f01662..59a34894e495 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1076,6 +1076,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, =
int hw_id, const char *name,
>  			return err;
>  	}
> =20
> +	if (dev->of_node)
> +		if (of_property_read_bool(dev->of_node, "wakeup-source"))
> +			device_init_wakeup(dev, true);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(st_lsm6dsx_probe);
> @@ -1088,6 +1092,12 @@ static int __maybe_unused st_lsm6dsx_suspend(struc=
t device *dev)
>  	int i, err =3D 0;
> =20
>  	for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
> +		if (device_may_wakeup(dev) && (i =3D=3D ST_LSM6DSX_ID_ACC)) {
> +			/* Enable wake from IRQ */
> +			enable_irq_wake(hw->irq);
> +			continue;

This is breaking buffering mode

> +		}
> +
>  		sensor =3D iio_priv(hw->iio_devs[i]);
>  		if (!(hw->enable_mask & BIT(sensor->id)))
>  			continue;
> @@ -1112,6 +1122,11 @@ static int __maybe_unused st_lsm6dsx_resume(struct=
 device *dev)
>  	int i, err =3D 0;
> =20
>  	for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
> +		if (device_may_wakeup(dev) && (i =3D=3D ST_LSM6DSX_ID_ACC)) {
> +			disable_irq_wake(hw->irq);

same here

> +			continue;
> +		}
> +
>  		sensor =3D iio_priv(hw->iio_devs[i]);
>  		if (!(hw->enable_mask & BIT(sensor->id)))
>  			continue;
> --=20
> 2.22.0
>=20

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQkIeAAKCRA6cBh0uS2t
rDZ5AQDajKp8c5Mulc3cYB9kzGIMFL2s2nsy5Vu/vgjjQZlcpgEAhIlJrWksQOGv
vBZOzr2S1rbodbenWZ39vvcCzQl28A0=
=Mu84
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
