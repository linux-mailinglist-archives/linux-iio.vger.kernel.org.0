Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981E053E2BB
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jun 2022 10:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiFFIhL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jun 2022 04:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiFFIhK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jun 2022 04:37:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1681DC
        for <linux-iio@vger.kernel.org>; Mon,  6 Jun 2022 01:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C10DB81235
        for <linux-iio@vger.kernel.org>; Mon,  6 Jun 2022 08:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661B0C385A9;
        Mon,  6 Jun 2022 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654504624;
        bh=WJBuHW4UxW5LboW3+gu/7UNcvX6OU0V1SDqShk3kQEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nui/d2YvACC4O/IUfYNBDYq5gaWWunDjWs8PvZpgpUiQiblFSZ9GSl4i/2ygauLXk
         aI95TKoqH/s/wbeESuo7v2EYpOYBes7HCXNIbEnhJjw9PVRs0UwPxcDa8J/mxfdE0S
         3phAqU7biEB5Ic5ACxtW5lHxIBUi1S3LLKXNkqnlgM0sTfzKvdPQeQpnAKfzUaRqoc
         Q97tne+sbco8HIqzog2wJxQDmiM21RUt9aaPOWwvCqdsOVIIIwG+tx8/kbdXZGRSGi
         Og+VY4HshoYNwqb3AxscoPEjRNlrGnavdVCKuilNKNJkxCotTFQV7Yo+2lszCNBpb7
         nj7Z/BdzzjrmQ==
Date:   Mon, 6 Jun 2022 10:37:00 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RESEND PATCH 4/5] iio: imu: lsm6dsx: Use new pm_sleep_ptr() and
 EXPORT_SIMPLE_DEV_PM_OPS()
Message-ID: <Yp28rLIxHgcihx70@lore-desk>
References: <20220604161223.461847-1-jic23@kernel.org>
 <20220604161223.461847-5-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="//4N/U3azP23z4ZN"
Content-Disposition: inline
In-Reply-To: <20220604161223.461847-5-jic23@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--//4N/U3azP23z4ZN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> These new functions move the burden of removing unused code when
> CONFIG_PM_SLEEP is not defined onto the compiler rather than requiring
> the use of CONFIG_PM guards and similar.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Link: https://lore.kernel.org/r/20220220181522.541718-8-jic23@kernel.org
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 10 ++++------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c  |  2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  2 +-
>  4 files changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 910397716833..9e4aa5c1c8d6 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2291,7 +2291,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, i=
nt hw_id,
>  }
>  EXPORT_SYMBOL(st_lsm6dsx_probe);
> =20
> -static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
> +static int st_lsm6dsx_suspend(struct device *dev)
>  {
>  	struct st_lsm6dsx_hw *hw =3D dev_get_drvdata(dev);
>  	struct st_lsm6dsx_sensor *sensor;
> @@ -2330,7 +2330,7 @@ static int __maybe_unused st_lsm6dsx_suspend(struct=
 device *dev)
>  	return err;
>  }
> =20
> -static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
> +static int st_lsm6dsx_resume(struct device *dev)
>  {
>  	struct st_lsm6dsx_hw *hw =3D dev_get_drvdata(dev);
>  	struct st_lsm6dsx_sensor *sensor;
> @@ -2366,10 +2366,8 @@ static int __maybe_unused st_lsm6dsx_resume(struct=
 device *dev)
>  	return err;
>  }
> =20
> -const struct dev_pm_ops st_lsm6dsx_pm_ops =3D {
> -	SET_SYSTEM_SLEEP_PM_OPS(st_lsm6dsx_suspend, st_lsm6dsx_resume)
> -};
> -EXPORT_SYMBOL(st_lsm6dsx_pm_ops);
> +EXPORT_SIMPLE_DEV_PM_OPS(st_lsm6dsx_pm_ops, st_lsm6dsx_suspend,
> +			 st_lsm6dsx_resume);
> =20
>  MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 715fbdc8190e..5bd565b93a8c 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -134,7 +134,7 @@ MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
>  static struct i2c_driver st_lsm6dsx_driver =3D {
>  	.driver =3D {
>  		.name =3D "st_lsm6dsx_i2c",
> -		.pm =3D &st_lsm6dsx_pm_ops,
> +		.pm =3D pm_sleep_ptr(&st_lsm6dsx_pm_ops),
>  		.of_match_table =3D st_lsm6dsx_i2c_of_match,
>  	},
>  	.probe =3D st_lsm6dsx_i2c_probe,
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_i3c.c
> index 35556cd04284..4df186499802 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> @@ -44,7 +44,7 @@ static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cd=
ev)
>  static struct i3c_driver st_lsm6dsx_driver =3D {
>  	.driver =3D {
>  		.name =3D "st_lsm6dsx_i3c",
> -		.pm =3D &st_lsm6dsx_pm_ops,
> +		.pm =3D pm_sleep_ptr(&st_lsm6dsx_pm_ops),
>  	},
>  	.probe =3D st_lsm6dsx_i3c_probe,
>  	.id_table =3D st_lsm6dsx_i3c_ids,
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_spi.c
> index f5767cf76c1d..3a206fd4d92c 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -134,7 +134,7 @@ MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
>  static struct spi_driver st_lsm6dsx_driver =3D {
>  	.driver =3D {
>  		.name =3D "st_lsm6dsx_spi",
> -		.pm =3D &st_lsm6dsx_pm_ops,
> +		.pm =3D pm_sleep_ptr(&st_lsm6dsx_pm_ops),
>  		.of_match_table =3D st_lsm6dsx_spi_of_match,
>  	},
>  	.probe =3D st_lsm6dsx_spi_probe,
> --=20
> 2.36.1
>=20

--//4N/U3azP23z4ZN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYp28rAAKCRA6cBh0uS2t
rD9JAQCrLYFQWZK4Y7b38vtPKbAnNY1CNhjfzFBA69uYybkR8AEAhcZqtfkipJ9m
eqWAap1UnHh8VCWWfvTnUAY4loOxdQs=
=iqR5
-----END PGP SIGNATURE-----

--//4N/U3azP23z4ZN--
