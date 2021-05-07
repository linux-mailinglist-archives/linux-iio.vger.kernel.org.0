Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174EA37642B
	for <lists+linux-iio@lfdr.de>; Fri,  7 May 2021 13:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhEGLB1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 May 2021 07:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhEGLB1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 May 2021 07:01:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39DCC613C9;
        Fri,  7 May 2021 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620385227;
        bh=PA+GYyzqnYNydB+YRKfx0dZBkeAj2+1s6Tyb356JRzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qoWDg1CBKWtlkKCPUkrYqo5IuvZlrOHVtj2cZ+gBK2TyljlfKOlCEywvNzNfZtSus
         1XepJmNCOzeMaZVlWo7I9dMy83BoTL6Gxm9RbdndNHe3XfuogHuYdpFvZkiu5P/OSV
         asbWMhvLsc7RG/H+4Qz6TlPqeng0EiIn16NtTCKVZr/Zze0eRtqTvZmh1RrRokpiHP
         Bte8JuE51q0bnwX//6ewByCWw5TseucglaZXguWcsmj3cwN4twENGrJLo4RlzQYuY+
         vPni/MsjHIwznE9mSQcmBLVj8mwTmb8NH6IOSW3dqqGnuKhGXcNXNByKvUsKbIPxdi
         s/7g1/vNqXTVw==
Date:   Fri, 7 May 2021 13:00:23 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: correct ODR in header
Message-ID: <YJUdx+UEOEFQkvU9@lore-desk>
References: <20210507103149.2193932-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vk/nqYSj1OFeqX13"
Content-Disposition: inline
In-Reply-To: <20210507103149.2193932-1-sean@geanix.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--vk/nqYSj1OFeqX13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fix wrongly stated 13 Hz ODR for accelerometers, the correct ODR is 12.5 =
Hz
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 2ab1ac5a2412..a3ab16615729 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -15,19 +15,19 @@
>   *
>   * Supported sensors:
>   * - LSM6DS3:
> - *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208,=
 416
> + *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 20=
8, 416
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-=
2000
>   *   - FIFO size: 8KB
>   *
>   * - LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC/LSM6DS3TR-C:
> - *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208,=
 416
> + *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 20=
8, 416
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-=
2000
>   *   - FIFO size: 4KB
>   *
>   * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX:
> - *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208,=
 416,
> + *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 20=
8, 416,
>   *     833
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-=
2000
> --=20
> 2.31.0
>=20

--vk/nqYSj1OFeqX13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYJUdxAAKCRA6cBh0uS2t
rNJqAP9NGfq/9JK/0nuV/biMsZ2ZyqzBcZzDIazDcsn4aJUpggEA8shAn32cPPNV
pUnVVDynfM6AsYYRPdEaZnJg4ciqpwM=
=YEN4
-----END PGP SIGNATURE-----

--vk/nqYSj1OFeqX13--
