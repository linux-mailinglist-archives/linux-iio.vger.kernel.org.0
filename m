Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229DB53E2C2
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jun 2022 10:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiFFIiO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jun 2022 04:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiFFIiL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jun 2022 04:38:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E54E31517
        for <linux-iio@vger.kernel.org>; Mon,  6 Jun 2022 01:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDB2C6120D
        for <linux-iio@vger.kernel.org>; Mon,  6 Jun 2022 08:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A8EC385A9;
        Mon,  6 Jun 2022 08:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654504685;
        bh=0T9BGkSZ6S8yrMrs14/TGB8esZoSQw5iijhMRfSW6fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HoKDzVVED+5eU/9kcMVPQ6dF4Mnq8EX1s/WfW3/tNSYWBrB+kJxyjSdj5JrJftxOM
         UmzHJTCAKUfZdRkz4cPUaokqWpAy7AbV87xpwqxwaytE7HaTjyqTRyBEHoX1C5EhoV
         vkkKkUl2JX0eEqNRhKiP2hsFS4Y5J6O1y0c5UA5ji6n8PZ/l6ERAo0lK7ssTyPO/ET
         evhf6WevP9Y98tLrcLyVjt+c/7+vV8QHvow1iQjZ/WSzolh0iH567p1G4xrp8qIYHQ
         Pi2KlWIZwBC/qeF8mtJdIzZhEGnwCa7ZvcYrLT5xH/cTyF+Y6YW26ROqtFtakyl5I9
         +K0ogUletvePg==
Date:   Mon, 6 Jun 2022 10:38:02 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RESEND PATCH 2/5] iio: humidity: hts221: Use
 EXPORT_SIMPLE_DEV_PM_OPS() to allow compiler to remove dead code.
Message-ID: <Yp286mfsRToBD6te@lore-desk>
References: <20220604161223.461847-1-jic23@kernel.org>
 <20220604161223.461847-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sRi/gLoUWY2jW4Mf"
Content-Disposition: inline
In-Reply-To: <20220604161223.461847-3-jic23@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--sRi/gLoUWY2jW4Mf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> If CONFIG_PM_SLEEP is not defined using EXPORT_SIMPLE_DEV_PM_OPS()
> in conjunction with pm_sleep_ptr() allows the compiler to remove
> the unused code and data. This removes the need for __maybe_unused
> markings etc.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Link: https://lore.kernel.org/r/20220220181522.541718-6-jic23@kernel.org

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/humidity/hts221_core.c | 9 +++------
>  drivers/iio/humidity/hts221_i2c.c  | 2 +-
>  drivers/iio/humidity/hts221_spi.c  | 2 +-
>  3 files changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/ht=
s221_core.c
> index 6a39615b6961..da9c08432ef2 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -670,7 +670,7 @@ int hts221_probe(struct device *dev, int irq, const c=
har *name,
>  }
>  EXPORT_SYMBOL(hts221_probe);
> =20
> -static int __maybe_unused hts221_suspend(struct device *dev)
> +static int hts221_suspend(struct device *dev)
>  {
>  	struct iio_dev *iio_dev =3D dev_get_drvdata(dev);
>  	struct hts221_hw *hw =3D iio_priv(iio_dev);
> @@ -680,7 +680,7 @@ static int __maybe_unused hts221_suspend(struct devic=
e *dev)
>  				  FIELD_PREP(HTS221_ENABLE_MASK, false));
>  }
> =20
> -static int __maybe_unused hts221_resume(struct device *dev)
> +static int hts221_resume(struct device *dev)
>  {
>  	struct iio_dev *iio_dev =3D dev_get_drvdata(dev);
>  	struct hts221_hw *hw =3D iio_priv(iio_dev);
> @@ -694,10 +694,7 @@ static int __maybe_unused hts221_resume(struct devic=
e *dev)
>  	return err;
>  }
> =20
> -const struct dev_pm_ops hts221_pm_ops =3D {
> -	SET_SYSTEM_SLEEP_PM_OPS(hts221_suspend, hts221_resume)
> -};
> -EXPORT_SYMBOL(hts221_pm_ops);
> +EXPORT_SIMPLE_DEV_PM_OPS(hts221_pm_ops, hts221_suspend, hts221_resume);
> =20
>  MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>  MODULE_DESCRIPTION("STMicroelectronics hts221 sensor driver");
> diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts=
221_i2c.c
> index cab39c4756f8..933b05e4d972 100644
> --- a/drivers/iio/humidity/hts221_i2c.c
> +++ b/drivers/iio/humidity/hts221_i2c.c
> @@ -62,7 +62,7 @@ MODULE_DEVICE_TABLE(i2c, hts221_i2c_id_table);
>  static struct i2c_driver hts221_driver =3D {
>  	.driver =3D {
>  		.name =3D "hts221_i2c",
> -		.pm =3D &hts221_pm_ops,
> +		.pm =3D pm_sleep_ptr(&hts221_pm_ops),
>  		.of_match_table =3D hts221_i2c_of_match,
>  		.acpi_match_table =3D ACPI_PTR(hts221_acpi_match),
>  	},
> diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts=
221_spi.c
> index 729e86e433b1..888c5eab944c 100644
> --- a/drivers/iio/humidity/hts221_spi.c
> +++ b/drivers/iio/humidity/hts221_spi.c
> @@ -55,7 +55,7 @@ MODULE_DEVICE_TABLE(spi, hts221_spi_id_table);
>  static struct spi_driver hts221_driver =3D {
>  	.driver =3D {
>  		.name =3D "hts221_spi",
> -		.pm =3D &hts221_pm_ops,
> +		.pm =3D pm_sleep_ptr(&hts221_pm_ops),
>  		.of_match_table =3D hts221_spi_of_match,
>  	},
>  	.probe =3D hts221_spi_probe,
> --=20
> 2.36.1
>=20

--sRi/gLoUWY2jW4Mf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYp286QAKCRA6cBh0uS2t
rHB7AP0SuTOXtB5ZpynaYEoelapfHxKYbn+Ut+AXW9rOqdPR+QD+MkZvCCCiNGuW
yXW9P5boJhQUT05xRIwou0nqka4vrAA=
=mHFi
-----END PGP SIGNATURE-----

--sRi/gLoUWY2jW4Mf--
