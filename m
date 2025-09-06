Return-Path: <linux-iio+bounces-23829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C26BB47734
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 22:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F86216DBF2
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 20:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F917288524;
	Sat,  6 Sep 2025 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="PJDWq/A/"
X-Original-To: linux-iio@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2E1C84B8;
	Sat,  6 Sep 2025 20:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757192274; cv=pass; b=gEpOIluvnfaCPQPpzP41vA/nMMOncyCImCnT/tIvpcp/MjVOHdhkmvyr4sG3jsytszz6BB27SBmJawUk4YiS+Yt+0xpVK+AV0hBhdh1fZTO2ZQd143mNki30EbWrC+F4u+O09KttpndgRdkJIB1z5bJ71rAwJvLygvT4BroOv0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757192274; c=relaxed/simple;
	bh=l32AwYLK/TYFU66BBY9yknnBv5/XApTIzj2TmvlKtT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvHkYrLRtYasyqldf5FYn7V1g6lq8RCPwAq+A4RNjA/PBkEUmyj9dZQob8bIamqtIPNlEUM3NhrD3qiiSOACdZ8mf8bFL6/Kvw11s9o03VDJ+AuHG0cypI9WVL6ndFKGGRqwMsKvz4AiVnRU6rXuL4eWL0w5RmYPA9SAHlEL0RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=PJDWq/A/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757192244; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d7WqGtU8AB2aFF1H3hAlffH64U/3g0v0EhoVrsB1ufJhAL4NN2RgXtj6kiviuEYbMhLiTxe9fO0bM3iYIsjGwyg9Uodxr6z4iiCLDjb0J9pxg7AfKv+62yrvcZzxkNUR+Z5pxvKjb7wFL+6ufg3CDXsc2wofbn4scmRod33fVAI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757192244; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7PhY5ZGj8flLaH400r6U3+guFxADQWYwlTB4W8pYYuU=; 
	b=LbdCuUfHI0dqciRzrjJylyiD9RA4eUF2e0zCs/Yx1GfIsPwbOmoJDheQnNVvPLau3odx92wqUQY1sE4dynj2wgMpAXNUGNW0NUPJWSbbtIBglBatizcBkt58bDaGryfa05qDQNye+66q26lXNhckI5fVnCB0ei1AWrAlCp9i55M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757192244;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=7PhY5ZGj8flLaH400r6U3+guFxADQWYwlTB4W8pYYuU=;
	b=PJDWq/A/OPRZ12T4icOQoZJWK9bnpynRzPsE1Wfao+0OOm8diG+2H040H7JLlTpt
	MUYZlfPcdWTTlXsDPLwxFPPp1fxRaOz1tU+pD/kEFGnKOx2TPJJ+V/uHlhVfqY9UBdi
	w+SES3KHsg1LwZVV0/N5PGN6deGnM9gOb4M560G8=
Received: by mx.zohomail.com with SMTPS id 1757192241714683.1408118822674;
	Sat, 6 Sep 2025 13:57:21 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 4A343180B18; Sat, 06 Sep 2025 22:57:15 +0200 (CEST)
Date: Sat, 6 Sep 2025 22:57:15 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	krzysztof.kozlowski@linaro.org, u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org, 
	casey.connolly@linaro.org
Subject: Re: [PATCH v3 3/7] power: reset: qcom-pon: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <j3hsfjkdfta5cheavnem5heaszuytm2zfhzm3y3udat3pjxnc5@vzymqkcdau7k>
References: <20250730112645.542179-1-angelogioacchino.delregno@collabora.com>
 <20250730112645.542179-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tehjknaqql6re6on"
Content-Disposition: inline
In-Reply-To: <20250730112645.542179-4-angelogioacchino.delregno@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/257.176.7
X-ZohoMailClient: External


--tehjknaqql6re6on
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/7] power: reset: qcom-pon: Migrate to
 devm_spmi_subdevice_alloc_and_add()
MIME-Version: 1.0

Hi,

On Wed, Jul 30, 2025 at 01:26:41PM +0200, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrates a Power On device supporting pwrkey
> and resin along with the Android reboot reason action identifier.
>=20
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device for PON
> and initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
>=20
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.
>=20
> Link: https://lore.kernel.org/r/20250722101317.76729-4-angelogioacchino.d=
elregno@collabora.com
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

The patch looks good to me, but we need to check how to get it
merged. Probably the best way is an immutable branch. As it looks
like the series needs another respin:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/power/reset/qcom-pon.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-po=
n.c
> index 7e108982a582..0e075a2e5e48 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -11,6 +11,7 @@
>  #include <linux/reboot.h>
>  #include <linux/reboot-mode.h>
>  #include <linux/regmap.h>
> +#include <linux/spmi.h>
> =20
>  #define PON_SOFT_RB_SPARE		0x8f
> =20
> @@ -22,7 +23,6 @@
>  struct qcom_pon {
>  	struct device *dev;
>  	struct regmap *regmap;
> -	u32 baseaddr;
>  	struct reboot_mode_driver reboot_mode;
>  	long reason_shift;
>  };
> @@ -35,7 +35,7 @@ static int qcom_pon_reboot_mode_write(struct reboot_mod=
e_driver *reboot,
>  	int ret;
> =20
>  	ret =3D regmap_update_bits(pon->regmap,
> -				 pon->baseaddr + PON_SOFT_RB_SPARE,
> +				 PON_SOFT_RB_SPARE,
>  				 GENMASK(7, pon->reason_shift),
>  				 magic << pon->reason_shift);
>  	if (ret < 0)
> @@ -46,27 +46,42 @@ static int qcom_pon_reboot_mode_write(struct reboot_m=
ode_driver *reboot,
> =20
>  static int qcom_pon_probe(struct platform_device *pdev)
>  {
> +	struct regmap_config qcom_pon_regmap_config =3D {
> +		.reg_bits =3D 16,
> +		.val_bits =3D 8,
> +		.max_register =3D 0x100,
> +		.fast_io =3D true,
> +	};
> +	struct device *dev =3D &pdev->dev;
> +	struct spmi_subdevice *sub_sdev;
> +	struct spmi_device *sparent;
>  	struct qcom_pon *pon;
>  	long reason_shift;
>  	int error;
> =20
> +	if (!dev->parent)
> +		return -ENODEV;
> +
>  	pon =3D devm_kzalloc(&pdev->dev, sizeof(*pon), GFP_KERNEL);
>  	if (!pon)
>  		return -ENOMEM;
> =20
>  	pon->dev =3D &pdev->dev;
> =20
> -	pon->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> -	if (!pon->regmap) {
> -		dev_err(&pdev->dev, "failed to locate regmap\n");
> -		return -ENODEV;
> -	}
> +	sparent =3D to_spmi_device(dev->parent);
> +	sub_sdev =3D devm_spmi_subdevice_alloc_and_add(dev, sparent);
> +	if (IS_ERR(sub_sdev))
> +		return PTR_ERR(sub_sdev);
> =20
> -	error =3D of_property_read_u32(pdev->dev.of_node, "reg",
> -				     &pon->baseaddr);
> +	error =3D of_property_read_u32(dev->of_node, "reg",
> +				     &qcom_pon_regmap_config.reg_base);
>  	if (error)
>  		return error;
> =20
> +	pon->regmap =3D devm_regmap_init_spmi_ext(&sub_sdev->sdev, &qcom_pon_re=
gmap_config);
> +	if (IS_ERR(pon->regmap))
> +		return PTR_ERR(pon->regmap);
> +
>  	reason_shift =3D (long)of_device_get_match_data(&pdev->dev);
> =20
>  	if (reason_shift !=3D NO_REASON_SHIFT) {
> @@ -106,3 +121,4 @@ module_platform_driver(qcom_pon_driver);
> =20
>  MODULE_DESCRIPTION("Qualcomm Power On driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS("SPMI");
> --=20
> 2.50.1
>=20

--tehjknaqql6re6on
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmi8oCQACgkQ2O7X88g7
+poX8g/8DFCdbsBCTzACdw4Hq7WasS27ARUDajPOcVExRwI6WTOyM7/9+zSXA99h
MX25nKNB2amDOdtdiroWCrzJ5V4PoDAQzt+G3RWyDiQ84wqTozB6jTSPvXiojCNr
zuYs5eU8fbXD30TvDYig/1KzxT2cOd3/bb2DOow9NHIYF6HzxjV4ddFwO6gxntpL
Mtaqd8YY/2Bjj2MHSQroqSnAJKizeazMfJTc5zscorxgYri4vrCl0MghCX6rSIUE
//2QFh3Ert3rBHYfs4OgNRTT4/0v3qBRnj7xyRKgQMC38Wy7a//ciHnaJ7q56Bd/
6FX/qhw3nXnDUIsvu7cac1CJdNYg1QfaD9rGlIY7TNkMPuLJjjx5CntyoJx2UbC1
spqRlRY9ND7ROSPRnNUYQlmMFqH+JDkiGWu2qyO3WZw2dNwUIkBME8GIwK9uOGuk
LIFSlYccD0pAdR3O1hBSMACRuTs5jKK+YyiTH4XVaVFmf+zXqDqbg7o7IAZ/TFr6
eDI2y/zfilbojn5apHPn7bZVOki8rXMdpXTBual+WwjBV71XUM9jus9fbHq7xYDA
+dWJoc5D3/yvsNV8Zsi7HHGyH8zCg/fuJq2wxpZ0qDNTLqysTkvVkNCrrTgOBKDo
tYRqdDaQi/RkGmPLSl/PiM4vpgJvPeyeN+yXST6uDHJo3Ag1DY8=
=XxRm
-----END PGP SIGNATURE-----

--tehjknaqql6re6on--

