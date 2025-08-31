Return-Path: <linux-iio+bounces-23551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7EBB3D4EC
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 21:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6037A189AE2A
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 19:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C015274B44;
	Sun, 31 Aug 2025 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="m3uQmUZe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DA19D89E;
	Sun, 31 Aug 2025 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756668335; cv=none; b=OHaeP7v12Ib+FTgNVRyeF0L3VOfEVNNnB+fY06Lz9UNqb/8RXgJ31eSHYFV/yW3aPPUCPfYGrqC0xdp8FJyGAtYyHn2vqGrTWPneWAqJMqcOeECGwefGT1u0b8X8tDv0dc/O0z2GAPGphReAJ/LucwvI2aZJflUP5rFznIvW0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756668335; c=relaxed/simple;
	bh=B2JtDD9+W3elSf7jZhzNofE+gGKxLSm637u1tjL/XZU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=Up0Jn5G/jrpAi7iK1JRY2Pl4emUxX4D9nLLuc99E5H+Kgn2nDktzaKcnLDRdoGby83DfYn3kVzk41e75tOnUmKFTe+MXc+TiYJGgXUqVEBu4RvDciJjD30QIBpylXemu/wfu/pPvp+HI/qtLhRHeB/RzXXbHy7vgDDRACh9fR0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=m3uQmUZe; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1756668296; x=1757968296;
	bh=sHYq8xTp1pV5jA5VdRd/Vfz56X4r7wwk3KzAnDzCpUQ=; h=From;
	b=m3uQmUZe3XiuykTePEyySPQXxyWApFdTgaH+P0I3YSP/p1dKb4uDmsjWx0hVGROXH
	 ZR1HZcGzuXUcqJJCGJeFvKUFmYtJHGHgQhzc8xYRlbcfhI+9yJQ7EEnF53UHFOryK0
	 rVP7XIAxs2TLqmxt+uCa8bbGOo6ruNglbQXqBObUQiZcDXNjLhM0zqOjiCB0XRXT4c
	 itDxTdjCBqYm3KD/HRddfGFiwbQKdFnr9vdCTJkoNoSdEHp1jHeMKMSgJhFaBmvU+0
	 NavwxP29+nlk2nwZre/+506Fi6tU7s/WgC0iCBtoTTGJJ5IziWDlMSJM230m9Ihtg3
	 CeMeNxrw2lLZw==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 57VJOsJc024360
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 21:24:56 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 Aug 2025 21:24:54 +0200
Message-Id: <DCGUXTSZ8B9G.2S2Q2JXYMBSRY@matfyz.cz>
Cc: "David Wronek" <david@mainlining.org>, <phone-devel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC
 ADC
To: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
        "Jonathan
 Cameron" <jic23@kernel.org>,
        "David Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy Shevchenko"
 <andy@kernel.org>, "Lee Jones" <lee@kernel.org>,
        "Rob Herring"
 <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
 <20250831-88pm886-gpadc-v2-2-759c1e14d95f@dujemihanovic.xyz>
In-Reply-To: <20250831-88pm886-gpadc-v2-2-759c1e14d95f@dujemihanovic.xyz>

Duje Mihanovi=C4=87, 2025-08-31T12:33:05+02:00:
> Marvell's 88PM886 PMIC has a so-called General Purpose ADC used for
> monitoring various system voltages and temperatures. Add the relevant
> register definitions to the MFD header and a driver for the ADC.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> ---
> v2:
> - default MFD_88PM886_PMIC
> - u8[2] -> __be16
> - Drop kernel.h include
> - Add pm886_gpadc struct
> - Reorder channel enum
> - Drop GPADC voltage channels
> - Drop unnecessary masking in gpadc_get_raw()
> - Extend gpadc_enable_bias() to allow disabling bias
> - usleep_range() -> fsleep()
> - PM wrapper for pm886_gpadc_read_raw()
> - Proper channel info: voltage is RAW | SCALE, temperature is RAW |
>   OFFSET | SCALE, resistance is PROCESSED
> - Explicitly define channels to en/disable in pm886_gpadc_setup()
> - Don't explicitly set iio->dev.parent
> - Miscellaneous style changes
> ---
>  MAINTAINERS                     |   5 +
>  drivers/iio/adc/88pm886-gpadc.c | 383 ++++++++++++++++++++++++++++++++++=
++++++
>  drivers/iio/adc/Kconfig         |  13 ++
>  drivers/iio/adc/Makefile        |   1 +
>  include/linux/mfd/88pm886.h     |  54 ++++++
>  5 files changed, 456 insertions(+)
>

[...]

> diff --git a/drivers/iio/adc/88pm886-gpadc.c b/drivers/iio/adc/88pm886-gp=
adc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4622d2525e0edeed89c6e6d43=
336b177590aa885
> --- /dev/null
> +++ b/drivers/iio/adc/88pm886-gpadc.c

[...]

> +static int pm886_gpadc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct pm886_chip *chip =3D dev_get_drvdata(dev->parent);
> +	struct i2c_client *client =3D chip->client;
> +	struct pm886_gpadc *gpadc;
> +	struct i2c_client *page;
> +	struct iio_dev *iio;
> +	int ret;
> +
> +	iio =3D devm_iio_device_alloc(dev, sizeof(*gpadc));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	gpadc =3D iio_priv(iio);
> +	dev_set_drvdata(dev, iio);
> +
> +	page =3D devm_i2c_new_dummy_device(dev, client->adapter,
> +					 client->addr + PM886_PAGE_OFFSET_GPADC);
> +	if (IS_ERR(page))
> +		return dev_err_probe(dev, PTR_ERR(page), "Failed to initialize GPADC p=
age\n");
> +
> +	gpadc->map =3D devm_regmap_init_i2c(page, &pm886_gpadc_regmap_config);
> +	if (IS_ERR(gpadc->map))
> +		return dev_err_probe(dev, PTR_ERR(gpadc->map),
> +				     "Failed to initialize GPADC regmap\n");
> +
> +	iio->name =3D "88pm886-gpadc";
> +	iio->dev.of_node =3D dev->parent->of_node;

Didn't you mean to drop this since Jonathan pointed out that it's done
by the core?

> +	iio->modes =3D INDIO_DIRECT_MODE;
> +	iio->info =3D &pm886_gpadc_iio_info;
> +	iio->channels =3D pm886_gpadc_channels;
> +	iio->num_channels =3D ARRAY_SIZE(pm886_gpadc_channels);
> +
> +	pm_runtime_set_autosuspend_delay(dev, 50);
> +	pm_runtime_use_autosuspend(dev);
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +
> +	ret =3D devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register ADC\n");
> +
> +	return 0;
> +}

[...]

> diff --git a/include/linux/mfd/88pm886.h b/include/linux/mfd/88pm886.h
> index 85eca44f39ab58ba4cb9ec4216118ee9604d021f..85c3c16fb10b7ee6aafdd6e68=
fd9135d8009eef8 100644
> --- a/include/linux/mfd/88pm886.h
> +++ b/include/linux/mfd/88pm886.h
> @@ -10,6 +10,7 @@
>  #define PM886_IRQ_ONKEY			0
> =20
>  #define PM886_PAGE_OFFSET_REGULATORS	1
> +#define PM886_PAGE_OFFSET_GPADC		2
> =20
>  #define PM886_REG_ID			0x00
> =20
> @@ -67,6 +68,59 @@
>  #define PM886_REG_BUCK4_VOUT		0xcf
>  #define PM886_REG_BUCK5_VOUT		0xdd
> =20
> +/* GPADC enable/disable registers */
> +#define PM886_REG_GPADC_CONFIG(n)	(n)
> +
> +/* GPADC channel registers */
> +#define PM886_REG_GPADC_VSC		0x40
> +#define PM886_REG_GPADC_VCHG_PWR	0x4c
> +#define PM886_REG_GPADC_VCF_OUT		0x4e
> +#define PM886_REG_GPADC_TINT		0x50
> +#define PM886_REG_GPADC_GPADC0		0x54
> +#define PM886_REG_GPADC_GPADC1		0x56
> +#define PM886_REG_GPADC_GPADC2		0x58
> +#define PM886_REG_GPADC_VBAT		0xa0
> +#define PM886_REG_GPADC_GND_DET1	0xa4
> +#define PM886_REG_GPADC_GND_DET2	0xa6
> +#define PM886_REG_GPADC_VBUS		0xa8
> +#define PM886_REG_GPADC_GPADC3		0xaa
> +#define PM886_REG_GPADC_MIC_DET		0xac
> +#define PM886_REG_GPADC_VBAT_SLP	0xb0
> +
> +/* GPADC channel enable bits */
> +#define PM886_GPADC_VSC_EN	BIT(0)
> +#define PM886_GPADC_VBAT_EN	BIT(1)
> +#define PM886_GPADC_GNDDET1_EN	BIT(3)
> +#define PM886_GPADC_VBUS_EN	BIT(4)
> +#define PM886_GPADC_VCHG_PWR_EN	BIT(5)
> +#define PM886_GPADC_VCF_OUT_EN	BIT(6)
> +#define PM886_GPADC_CONFIG1_EN_ALL (PM886_GPADC_VSC_EN | \
> +				    PM886_GPADC_VBAT_EN | \
> +				    PM886_GPADC_GNDDET1_EN | \
> +				    PM886_GPADC_VBUS_EN | \
> +				    PM886_GPADC_VCHG_PWR_EN | \
> +				    PM886_GPADC_VCF_OUT_EN)
> +
> +#define PM886_GPADC_TINT_EN	BIT(0)
> +#define PM886_GPADC_PMODE_EN	BIT(1)
> +#define PM886_GPADC_GPADC0_EN	BIT(2)
> +#define PM886_GPADC_GPADC1_EN	BIT(3)
> +#define PM886_GPADC_GPADC2_EN	BIT(4)
> +#define PM886_GPADC_GPADC3_EN	BIT(5)
> +#define PM886_GPADC_MIC_DET_EN	BIT(6)
> +#define PM886_GPADC_CONFIG2_EN_ALL (PM886_GPADC_TINT_EN | \
> +				    PM886_GPADC_GPADC0_EN | \
> +				    PM886_GPADC_GPADC1_EN | \
> +				    PM886_GPADC_GPADC2_EN | \
> +				    PM886_GPADC_GPADC3_EN | \
> +				    PM886_GPADC_MIC_DET_EN)
> +
> +/* No CONFIG3_EN_ALL because this is the only bit there */
> +#define PM886_GPADC_GND_DET2_EN	BIT(0)

I have previously ordered the definitions here to always have the
individual bits follow the register definition (see above REG_STATUS1
for instance). I don't know if this is a common practice, but it seemed
useful to me to make it clear which register the bits are found in
without having to look at their usage (even though in your case it is
clear from the _EN_ALL definition following them) and without making
them long by stuffing the register name in their names. So if you wanted
to follow this logic, the preceding three paragraphs should be moved
after the GPADC_CONFIG macro (since you used that to condense the
individual register definitions).

Also a nit, the above comment is I believe a full sentence, so it should
have a period at the end (I wouldn't mention it, but I seem to recall
that Lee was keen on this :-).

> +
> +#define PM886_GPADC_BIAS_LEVELS		16
> +#define PM886_GPADC_INDEX_TO_BIAS_UA(i)	(1 + (i) * 5)
> +
>  #define PM886_LDO_VSEL_MASK		0x0f
>  #define PM886_BUCK_VSEL_MASK		0x7f

It would also seem logical to me to keep these last two grouped with the
other regulators-related definitions.

