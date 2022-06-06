Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D70353E2A8
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jun 2022 10:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiFFIfy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jun 2022 04:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiFFIfy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jun 2022 04:35:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0504C14782C
        for <linux-iio@vger.kernel.org>; Mon,  6 Jun 2022 01:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 60C90CE0FD7
        for <linux-iio@vger.kernel.org>; Mon,  6 Jun 2022 08:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25870C385A9;
        Mon,  6 Jun 2022 08:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654504549;
        bh=Lwfl2GQggh0W+3ZGCY2FCaCAMsbiR6wGtDodrz0SZEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdVXbu7xuzGV/Xi6XRhNPhZGew3V5ojkD/z/dexMHynC0wx5Avi7U1Whp86c6KDSF
         aeQgcj5XV7y6kh2QgyjXlmZ+Hdrs3lmIme+iGRyeGPRLuNt7DEG7xn5Ue/oz1O8EaS
         xFYdxalAz3hBIayrgSFx5f08qmt0dJ+HVAWBU4gvt8/1I78NQsbAMxTETUXxEjJo+b
         J6rO2p5VpmzfKRgQ518MZzYJknLbYaYtVLe2DuArnZoeADyiC6sEBxm9KLG7UbYqYn
         ixgUP12Ps+jLxfLqEHyUh3AhqXsqpMrmNAAo21vy34Ja/fDW+TFpjxa6d97RWzVby1
         rzxZdfK+eYNvw==
Date:   Mon, 6 Jun 2022 10:35:45 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RESEND PATCH 5/5] iio: imu: lsm6dsx: Move exported symbols to
 the IIO_LSM6DSX namespace
Message-ID: <Yp28YfzYeWcLMm1E@lore-desk>
References: <20220604161223.461847-1-jic23@kernel.org>
 <20220604161223.461847-6-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lutB5cFvVVHVBktC"
Content-Disposition: inline
In-Reply-To: <20220604161223.461847-6-jic23@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--lutB5cFvVVHVBktC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Avoid unnecessary pollution of the global symbol namespace by
> moving library functions in to a specific namespace and import
> that into the drivers that make use of the functions.
>=20
> For more info: https://lwn.net/Articles/760045/
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Link: https://lore.kernel.org/r/20220220181522.541718-9-jic23@kernel.org

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  | 1 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c  | 1 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  | 1 +
>  4 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 9e4aa5c1c8d6..6b268f1c5fc3 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2289,7 +2289,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, i=
nt hw_id,
> =20
>  	return 0;
>  }
> -EXPORT_SYMBOL(st_lsm6dsx_probe);
> +EXPORT_SYMBOL_NS(st_lsm6dsx_probe, IIO_LSM6DSX);
> =20
>  static int st_lsm6dsx_suspend(struct device *dev)
>  {
> @@ -2366,8 +2366,8 @@ static int st_lsm6dsx_resume(struct device *dev)
>  	return err;
>  }
> =20
> -EXPORT_SIMPLE_DEV_PM_OPS(st_lsm6dsx_pm_ops, st_lsm6dsx_suspend,
> -			 st_lsm6dsx_resume);
> +EXPORT_NS_SIMPLE_DEV_PM_OPS(st_lsm6dsx_pm_ops, st_lsm6dsx_suspend,
> +			    st_lsm6dsx_resume, IIO_LSM6DSX);
> =20
>  MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 5bd565b93a8c..2ea34c0d3a8c 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -146,3 +146,4 @@ MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.=
com>");
>  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>  MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i2c driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_LSM6DSX);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_i3c.c
> index 4df186499802..3b0c8b19c448 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> @@ -54,3 +54,4 @@ module_i3c_driver(st_lsm6dsx_driver);
>  MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
>  MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i3c driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_LSM6DSX);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_spi.c
> index 3a206fd4d92c..6a8883f022a8 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -146,3 +146,4 @@ MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.=
com>");
>  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>  MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx spi driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_LSM6DSX);
> --=20
> 2.36.1
>=20

--lutB5cFvVVHVBktC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYp28YQAKCRA6cBh0uS2t
rAIRAP9i4CdWekcrINOksbGbzoSZGMMAIaArOp4pN45HMOiRggEA0Wq6yLmktJHy
frC05VNdTV8sv/CvihYlbzDJ3KOnWA8=
=jvAk
-----END PGP SIGNATURE-----

--lutB5cFvVVHVBktC--
