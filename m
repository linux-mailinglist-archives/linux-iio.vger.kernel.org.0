Return-Path: <linux-iio+bounces-13022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E57A29E1E49
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 14:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5194B30BF1
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 12:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67531EC009;
	Tue,  3 Dec 2024 12:53:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF79C1EBA04;
	Tue,  3 Dec 2024 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230415; cv=none; b=BsD2QP0/2AlFwEagnryw+8lU0j/50V4C6t48vCiMO4TZFK86+RXPBsYJmzVLI0gLYconcjUG1yTsWWk5HL1wSUAmoFcgefUrT3mgY/SF1tLJLZeYke6ILfEV/EN9ZP7ZYT8Bj9JkUKk3Agw9ia4cpYJfQaNPTpx/WTUA1/tx9o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230415; c=relaxed/simple;
	bh=cNmkxzapUO7QczoDwL+xVGi9yBG+fPmNhU/lvd+cUvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9nj/H4gCHfSqw8wYg/iWEDP7MtcQx1xpehxTDZYP9+KTybSZJ6rm07exHRbMQH4Qoj1rPmhkfgrYHnmXHR7IrJkLtwiB1WIgL03XFEC8RKUP8Vg2RUIX0vT64p2pMi8hN3fFJQ2C2UfxgIUwfqJNZwp5Budk0wNV4lkEQtEMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: NZ2Q9QJrS8etHAiLa1x1gg==
X-CSE-MsgGUID: JtmiqDwnS4m1caDtvBSMNA==
X-IronPort-AV: E=Sophos;i="6.12,205,1728918000"; 
   d="asc'?scan'208";a="226786275"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Dec 2024 21:53:30 +0900
Received: from [10.226.93.8] (unknown [10.226.93.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 161DC4002623;
	Tue,  3 Dec 2024 21:53:24 +0900 (JST)
Message-ID: <9fbf057c-164b-4451-85a8-cf4d5807b4c1@bp.renesas.com>
Date: Tue, 3 Dec 2024 12:53:23 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] iio: adc: rzg2l_adc: Simplify the runtime PM code
Content-Language: en-GB
To: Claudiu <claudiu.beznea@tuxon.dev>,
 prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
 <20241203111314.2420473-4-claudiu.beznea.uj@bp.renesas.com>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20241203111314.2420473-4-claudiu.beznea.uj@bp.renesas.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ejkQ6uLn0GaiFSlClZC0XSqf"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ejkQ6uLn0GaiFSlClZC0XSqf
Content-Type: multipart/mixed; boundary="------------dmg0AGwwVL6W8RXA0ox4qbMm";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Claudiu <claudiu.beznea@tuxon.dev>,
 prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Message-ID: <9fbf057c-164b-4451-85a8-cf4d5807b4c1@bp.renesas.com>
Subject: Re: [PATCH 03/14] iio: adc: rzg2l_adc: Simplify the runtime PM code
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
 <20241203111314.2420473-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241203111314.2420473-4-claudiu.beznea.uj@bp.renesas.com>

--------------dmg0AGwwVL6W8RXA0ox4qbMm
Content-Type: multipart/mixed; boundary="------------u8Ideiazs4hCjoXAckzRyQhI"

--------------u8Ideiazs4hCjoXAckzRyQhI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On 03/12/2024 11:13, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> All Renesas SoCs using the rzg2l_adc driver manage ADC clocks through P=
M
> domains. Calling pm_runtime_{resume_and_get, put_sync}() implicitly set=
s
> the state of the clocks. As a result, the code in the rzg2l_adc driver =
that
> explicitly manages ADC clocks can be removed, leading to simpler and
> cleaner implementation.
>=20
> Additionally, replace the use of rzg2l_adc_set_power() with direct PM
> runtime API calls to further simplify and clean up the code.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/iio/adc/rzg2l_adc.c | 100 ++++++++----------------------------=

>  1 file changed, 20 insertions(+), 80 deletions(-)
>=20
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 7039949a7554..a17690ecbdc3 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -8,7 +8,6 @@
>   */
> =20
>  #include <linux/bitfield.h>
> -#include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
> @@ -69,8 +68,6 @@ struct rzg2l_adc_data {
> =20
>  struct rzg2l_adc {
>  	void __iomem *base;
> -	struct clk *pclk;
> -	struct clk *adclk;
>  	struct reset_control *presetn;
>  	struct reset_control *adrstn;
>  	struct completion completion;
> @@ -188,29 +185,18 @@ static int rzg2l_adc_conversion_setup(struct rzg2=
l_adc *adc, u8 ch)
>  	return 0;
>  }
> =20
> -static int rzg2l_adc_set_power(struct iio_dev *indio_dev, bool on)
> -{
> -	struct device *dev =3D indio_dev->dev.parent;
> -
> -	if (on)
> -		return pm_runtime_resume_and_get(dev);
> -
> -	return pm_runtime_put_sync(dev);
> -}
> -
>  static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2=
l_adc *adc, u8 ch)
>  {
> +	struct device *dev =3D indio_dev->dev.parent;
>  	int ret;
> =20
> -	ret =3D rzg2l_adc_set_power(indio_dev, true);
> +	ret =3D pm_runtime_resume_and_get(dev);
>  	if (ret)
>  		return ret;

Should we check (ret < 0) here instead of just (ret)? According to the
docs [1], pm_runtime_resume_and_get() can return 1 if the device is
already active.

[1]: https://docs.kernel.org/power/runtime_pm.html#runtime-pm-device-help=
er-functions

Thanks,

--=20
Paul Barker
--------------u8Ideiazs4hCjoXAckzRyQhI
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------u8Ideiazs4hCjoXAckzRyQhI--

--------------dmg0AGwwVL6W8RXA0ox4qbMm--

--------------ejkQ6uLn0GaiFSlClZC0XSqf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ07/QwUDAAAAAAAKCRDbaV4Vf/JGvVOM
AQCiRexXepiHi421Gc03OVPh445YisuIwwomitYof6QldgEAujvSzuyZroUMHy7zZTCeAHqe4H/E
Z+DS14dFXJTVyQU=
=hrD+
-----END PGP SIGNATURE-----

--------------ejkQ6uLn0GaiFSlClZC0XSqf--

