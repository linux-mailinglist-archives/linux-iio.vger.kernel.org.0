Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B292A426567
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 09:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhJHHv2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 03:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhJHHv2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 03:51:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A119B61029;
        Fri,  8 Oct 2021 07:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633679373;
        bh=eeDr6DTkqJjWuETY90fIfcG38HYMME3dxX9Mdb6IJ+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iu/DUi1ijMBiuCVomGBoOQ2fZJkbz+pbMRgVO+53sOToLc6PWOhC0EHIut/7n2x01
         BwwIBLEQqlKjA4JGCmSWNCmLgd/pYDerjo8cUaVKYww7kWiC2LJVNjdQ+XSu/97bxk
         YVRtgfOIh2xW3ajB5C9j5+AvY33QhWncqHKUdeEfZV1uASiw4Lh8q1qUzuExmVyhnz
         a7Z5ZCnJDF7CbkNj4LfQ4A9cX8nMBN6i4hQgAIKePUd0awDzWbhIpZiSKQoYjm5Rdh
         OttQsZlNSihV5UI+qbc6q+rG0oOGLRdB6jnENdi3YkG+soJHIPPw9zWaCgejQELNCo
         MC27RJ+sOcF1Q==
Date:   Fri, 8 Oct 2021 09:49:27 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] io: imu: st_lsm6dsx: check if dev is null pointer
Message-ID: <YV/4B3mSn5ejJcgr@localhost.localdomain>
References: <1633663260-71997-1-git-send-email-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qaR85glXt6Juf0yi"
Content-Disposition: inline
In-Reply-To: <1633663260-71997-1-git-send-email-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--qaR85glXt6Juf0yi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The parameter 'dev' of st_lsm6dsx_probe() isn't been
> checked before used, including when st_lsm6dsx_probe() is called.
> Therefore, it might be better to check, just in case.
>=20
> Fixes: 290a6ce ("iio: imu: add support to lsm6dsx driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 7cedaab..7b4754d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2199,6 +2199,8 @@ int st_lsm6dsx_probe(struct device *dev, int irq, i=
nt hw_id,
>  	const char *name =3D NULL;
>  	int i, err;
> =20
> +	if (!dev)
> +		return -ENOMEM;

can this really happen? dev is a structure (not a pointer) in i2c_client or
spi_device.

Regards,
Lorenzo

>  	hw =3D devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
>  	if (!hw)
>  		return -ENOMEM;
> --=20
> 2.7.4
>=20

--qaR85glXt6Juf0yi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYV/4BAAKCRA6cBh0uS2t
rNt7AQCjx/gkPYW3iox+XpwsS9h88Yyh9+4UKpZ1AflB6koVCQEA5FXMQLwXMEJx
3fByb/kLYnuVF3ymjGo46uGHQ2HzpAM=
=LMgN
-----END PGP SIGNATURE-----

--qaR85glXt6Juf0yi--
