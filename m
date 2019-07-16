Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869816A389
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 10:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfGPIE7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jul 2019 04:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfGPIE7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Jul 2019 04:04:59 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EDB9206C2;
        Tue, 16 Jul 2019 08:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563264298;
        bh=/sVDjuinD4+ipoCYceCKqlp5M99j4+ZjF194clbqp/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WzsqdMvVM85Lv756SChHK/L8ey5/P4JHWhw9TIh60F1LOpSQdeP/6wLRnX5jWN3+m
         e3e65ssTt8PcQBVJIOIMmUGJ7REvGQwCBetLpfTzTbQkcfvyiUdY/6OrjLc9RaiTlx
         iSO8tg1Jcu90SWjb9uxPuN6CH3VW/nJcwObqFDik=
Date:   Tue, 16 Jul 2019 10:04:53 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
Subject: Re: [PATCH v2 4/6] iio: imu: st_lsm6dsx: add wakeup-source option
Message-ID: <20190716080453.GA13440@localhost.localdomain>
References: <20190715081514.81129-1-sean@geanix.com>
 <20190715081514.81129-4-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20190715081514.81129-4-sean@geanix.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This add ways for the SoC to wake from accelerometer wake events.
>=20
> In the suspend function we skip disabling the sensor if wakeup-source
> and events are activated.
>=20

[...]

>  EXPORT_SYMBOL(st_lsm6dsx_probe);
> @@ -1372,6 +1376,12 @@ static int __maybe_unused st_lsm6dsx_suspend(struc=
t device *dev)
>  		if (!hw->iio_devs[i])
>  			continue;
> =20
> +		if (device_may_wakeup(dev) && (i =3D=3D ST_LSM6DSX_ID_ACC)) {

unnecessary brackets

> +			/* Enable wake from IRQ */
> +			enable_irq_wake(hw->irq);
> +			continue;
> +		}

I think we need to move this after enable_mask check, dont' we?

> +
>  		sensor =3D iio_priv(hw->iio_devs[i]);
>  		if (!(hw->enable_mask & BIT(sensor->id)))
>  			continue;
> @@ -1404,6 +1414,11 @@ static int __maybe_unused st_lsm6dsx_resume(struct=
 device *dev)
>  		if (!hw->iio_devs[i])
>  			continue;
> =20
> +		if (device_may_wakeup(dev) && (i =3D=3D ST_LSM6DSX_ID_ACC)) {

unnecessary brackets

> +			disable_irq_wake(hw->irq);
> +			continue;
> +		}
> +
>  		sensor =3D iio_priv(hw->iio_devs[i]);
>  		if (!(hw->suspend_mask & BIT(sensor->id)))
>  			continue;
> --=20
> 2.22.0
>=20

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXS2FIgAKCRA6cBh0uS2t
rBcRAPsGF2mtl8Ynn9RaZ0bu1QWe+FlhunxfRHjOZgwf0ho9lQEApd28y0SpcnZw
RLY0SuPee88IcNwTbA9ObLWwOzwXoQU=
=mZ5w
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
