Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D695453E272
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jun 2022 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiFFIhw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jun 2022 04:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiFFIht (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jun 2022 04:37:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBEE20BC5
        for <linux-iio@vger.kernel.org>; Mon,  6 Jun 2022 01:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 980B5CE1685
        for <linux-iio@vger.kernel.org>; Mon,  6 Jun 2022 08:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81C1C34119;
        Mon,  6 Jun 2022 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654504657;
        bh=9+IXd6jGMtH+L05nxGQCdxAMG+ZxVbt263kMmdFKYKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oz0Qj1oquMpSyXrHACqmx52lvLR7hJETb9SotuIrDVZ/NyHltqusFMCBPDkdikOfN
         z1WmZK4WiRPw3RiUTuC8Ba3SmzDrwkdZxndcQjdDg+gr/9muXMBr0JU0ZIFeKyLHVp
         c/FIfTHko+okwwcQ3G7zqFgLMa4l4YIEavNbaVze2osnIcVIugwMYDSkP8ZTaoE4gG
         G+0PQl8FeUu3r6YWUgqsb03ZI0z/YIYszhqBdn8Zlxf0D6poaQHp9CNyyvbu81GPC3
         sHobJo8fQ3Ujdp+vIk8RR/lxgiThv7+YbyTlyQ9zseR2e+Ro1sEJfd/cauzQToTgds
         uuF41/xjrcqbA==
Date:   Mon, 6 Jun 2022 10:37:33 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RESEND PATCH 3/5] iio: humidity: hts221: Move symbol exports
 into IIO_HTS221 namespace
Message-ID: <Yp28zXP50rmhCdAz@lore-desk>
References: <20220604161223.461847-1-jic23@kernel.org>
 <20220604161223.461847-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pn2KASQmQUZ2b2t9"
Content-Disposition: inline
In-Reply-To: <20220604161223.461847-4-jic23@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--pn2KASQmQUZ2b2t9
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

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Link: https://lore.kernel.org/r/20220220181522.541718-7-jic23@kernel.org
> ---
>  drivers/iio/humidity/hts221_core.c | 5 +++--
>  drivers/iio/humidity/hts221_i2c.c  | 1 +
>  drivers/iio/humidity/hts221_spi.c  | 1 +
>  3 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/ht=
s221_core.c
> index da9c08432ef2..517158307d8c 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -668,7 +668,7 @@ int hts221_probe(struct device *dev, int irq, const c=
har *name,
> =20
>  	return devm_iio_device_register(hw->dev, iio_dev);
>  }
> -EXPORT_SYMBOL(hts221_probe);
> +EXPORT_SYMBOL_NS(hts221_probe, IIO_HTS221);
> =20
>  static int hts221_suspend(struct device *dev)
>  {
> @@ -694,7 +694,8 @@ static int hts221_resume(struct device *dev)
>  	return err;
>  }
> =20
> -EXPORT_SIMPLE_DEV_PM_OPS(hts221_pm_ops, hts221_suspend, hts221_resume);
> +EXPORT_NS_SIMPLE_DEV_PM_OPS(hts221_pm_ops, hts221_suspend, hts221_resume,
> +			    IIO_HTS221);
> =20
>  MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>  MODULE_DESCRIPTION("STMicroelectronics hts221 sensor driver");
> diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts=
221_i2c.c
> index 933b05e4d972..afbc611f7712 100644
> --- a/drivers/iio/humidity/hts221_i2c.c
> +++ b/drivers/iio/humidity/hts221_i2c.c
> @@ -74,3 +74,4 @@ module_i2c_driver(hts221_driver);
>  MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>  MODULE_DESCRIPTION("STMicroelectronics hts221 i2c driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_HTS221);
> diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts=
221_spi.c
> index 888c5eab944c..fc4adb68faf6 100644
> --- a/drivers/iio/humidity/hts221_spi.c
> +++ b/drivers/iio/humidity/hts221_spi.c
> @@ -66,3 +66,4 @@ module_spi_driver(hts221_driver);
>  MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>  MODULE_DESCRIPTION("STMicroelectronics hts221 spi driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_HTS221);
> --=20
> 2.36.1
>=20

--pn2KASQmQUZ2b2t9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYp28zQAKCRA6cBh0uS2t
rN1RAQDDdzSEesI02dXwT3zxoTvOtDsQSogDp5XpY2eTSp200QD7BUNjuQcnpluT
FVBSobQ5L9fN0wSoWBSRoqfGuWMd5gE=
=IsXq
-----END PGP SIGNATURE-----

--pn2KASQmQUZ2b2t9--
