Return-Path: <linux-iio+bounces-21878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A4B0E143
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBF83ACCC9
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344B8273806;
	Tue, 22 Jul 2025 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="XeAFprVC"
X-Original-To: linux-iio@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DCD156677;
	Tue, 22 Jul 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200385; cv=pass; b=UzbqGL0pN+Z2JAR8D5TW8JH0JoWoZcVEP116yh6zGgoMaIYmVLN9rc99snin2+eN8v3pyHGeXf0EvJzxr+fwFxTewKB6eHUNAR0aXoSonEWXFjAKSS6JgEAGKdwnbQuoqisf851V3KuuByhCL9cJelS+DV60tjPmhDjZECc0meI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200385; c=relaxed/simple;
	bh=mjZxpkkOmgWTJS3HohqCC9KVMyRu+iHyV+aDastD1jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY73Aac82fPg9e82XNApWGwTKuFmWo2Xe9xzdZpHveMfx8P6OYreMbQF088F9OorybjcVoY7MaOnpRtr6JHDjWJdfOCN26/iEzAxll7eCH7mDdYLe2VfSMwJbhJbaVwZKst/6Q0sR8rT2amhcC8VVZZpueFyjb7Y28Lia7yQNS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=XeAFprVC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753200350; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bPfUu4/fDLcc/1OaW9ghu46V0cuCvANVAAy8c/2ci0ArlpFJhmScZGhjiZ4oy/M/vNrz9f+QVlgo5pZL5KxFsETzHqcpjjt3bKb32sz8FPZBNtSzDnbOJ3V8cXFeZFxtv8WEAQxfMNpsW2YT5sYtQyAxWwc520Ppnzf3Vn+/0+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753200350; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jnn+YY9xeFWDvZfuwBS1Gp+44txJHb0/kWa1etPLITY=; 
	b=le3C40bq+2h7spJ3FDA6E55/XL6I6gWcehPGNGpAJqs/BlTNLhECPKIDqsBRZ/as9ffqLR13R0sMzp5A/2KUCMQT6uoxq6xS+TNPNrBvcFeOi5JCtv1WDKlgb0AAYnC9nZwaiPNcoeI8+xvO26Wr1UCIIQGnJZx1ybaPYYFZy3I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753200350;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=jnn+YY9xeFWDvZfuwBS1Gp+44txJHb0/kWa1etPLITY=;
	b=XeAFprVCV6JdbvthKRm4fiCwvtM4sFjNx+kMu/6xN9j2bDkoWFC6DkZ78p5NyIoL
	v0gX4iG9uR/RlvPr0AHAlZKzTwdL80RajFjWhkfuBrYFawRuIDrwL5yAzflSlPKUNfe
	siXw2HLrdLRyM7oraCa6Jvz5V7Wtv3v5RxcRiWKQ=
Received: by mx.zohomail.com with SMTPS id 1753200345571386.83294962666776;
	Tue, 22 Jul 2025 09:05:45 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id E95E3180622; Tue, 22 Jul 2025 18:05:39 +0200 (CEST)
Date: Tue, 22 Jul 2025 18:05:39 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	krzysztof.kozlowski@linaro.org, u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org, 
	casey.connolly@linaro.org
Subject: Re: [PATCH v2 3/7] power: reset: qcom-pon: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <z4xuesfnqc7wmenbgvu7k3odphxb7p6pyqdihx6cchojtrprpu@ihxk7tdrtrgz>
References: <20250722101317.76729-1-angelogioacchino.delregno@collabora.com>
 <20250722101317.76729-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="toudz4436ogxw66g"
Content-Disposition: inline
In-Reply-To: <20250722101317.76729-4-angelogioacchino.delregno@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/253.177.86
X-ZohoMailClient: External


--toudz4436ogxw66g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/7] power: reset: qcom-pon: Migrate to
 devm_spmi_subdevice_alloc_and_add()
MIME-Version: 1.0

Hi,

On Tue, Jul 22, 2025 at 12:13:13PM +0200, AngeloGioacchino Del Regno wrote:
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
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/power/reset/qcom-pon.c | 37 ++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-po=
n.c
> index 7e108982a582..3558494aea36 100644
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
> @@ -46,27 +46,47 @@ static int qcom_pon_reboot_mode_write(struct reboot_m=
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
> +	sparent =3D to_spmi_device(dev->parent);
> +	if (!sparent)
>  		return -ENODEV;

This cannot happen, since to_spmi_device() is using container_of(),
which is effectively just a cast.

> -	}
> =20
> -	error =3D of_property_read_u32(pdev->dev.of_node, "reg",
> -				     &pon->baseaddr);
> +	sub_sdev =3D devm_spmi_subdevice_alloc_and_add(dev, sparent);
> +	if (IS_ERR(sub_sdev))
> +		return PTR_ERR(sub_sdev);
> +
> +	error =3D of_property_read_u32(dev->of_node, "reg",
> +				     &qcom_pon_regmap_config.reg_base);
>  	if (error)
>  		return error;
> =20
> +	pon->regmap =3D devm_regmap_init_spmi_ext(&sub_sdev->sdev, &qcom_pon_re=
gmap_config);
> +	if (!pon->regmap) {
> +		dev_err(&pdev->dev, "failed to locate regmap\n");
> +		return -ENODEV;
> +	}

The error message no longer fits and the function returns error
pointers instead of NULL, so:

if (IS_ERR(pon->regmap))
    return PTR_ERR(pon->regmap);

Greetings,

-- Sebastian

>  	reason_shift =3D (long)of_device_get_match_data(&pdev->dev);
> =20
>  	if (reason_shift !=3D NO_REASON_SHIFT) {
> @@ -106,3 +126,4 @@ module_platform_driver(qcom_pon_driver);
> =20
>  MODULE_DESCRIPTION("Qualcomm Power On driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS("SPMI");
> --=20
> 2.50.1
>=20

--toudz4436ogxw66g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmh/tssACgkQ2O7X88g7
+pq8BBAAgC0Oselg4hI9UDRVATsC4PCz1BomMGMvK+DEypfi4oxEIWbXFxJYjpgv
mGdy+12po5zO9lBMaF0x7OhnSP2A+DjC/qS/oISgQ3B1Axs3rSkOnsJDjcXJ7dBm
LJjDI5QbCiy0T4woOk4+yJAP/bZN/qvXjQXa0F0plT2QuquO2FxqO/2FHouHjHnf
lle+cPGBPg16wyc22qhKjWtU8ZpPgkMacrm6pA53ZLD7XQ5lcEH3Uxz37dU74Onh
Q9cZIqHHW3uXiiAmIIVIBnr6dC/yDB7tEMla9EFr9yWrmmDvl4lbDMYgs4+2+pSo
03S/3o9xHC0ntfQsc0PViPrYu/X8W0Pz3lQ+5B0snzlTHd7qqQiNSk1KfPq/97b6
YGh2DGY0KmjHp6dVwCwsyC+4vJO512Bc6RVOTeh14iyGw0GTXPiYW88aaW9FPbfD
q2cXsRF8+YQLwWHavxAjjoBayyctYV2MG/oBlN5rxDIxJsBwxyuMPEyJl7SxfWEo
TOd7rShL/b1aLlhWcVyyn6C1FZWwn0On3m/wPEE34IL2Rr/2zCDwZe3CrwkDrKX6
VjgXBAcUrfuU95Oh6mHBONMmCUR1Hs4zKN5iXpwZLp9kXTh9pqhot3bEpS1EGKQT
2D6IZMlCua2f/UX45sjBRVFLDRNwKBaoN6pa7iZ3LWXQidkZFRU=
=GH1u
-----END PGP SIGNATURE-----

--toudz4436ogxw66g--

