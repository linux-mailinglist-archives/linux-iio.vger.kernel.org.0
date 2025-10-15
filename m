Return-Path: <linux-iio+bounces-25102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6234FBDF525
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 17:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E170B19C6FC0
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 15:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F62FB97F;
	Wed, 15 Oct 2025 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc0+yVwG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BF52FB098
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541642; cv=none; b=H2/OUJhLm4RFigbMAiVQO1yB+70F7Q4fAoZYMdQyahjw7/Mvg7jmQMlBFPFA6Ue147l5aP5FDoJv/qS1nsGyKT1SolY8NvqOYexQZaxOiCbjbu9R8VipY2PdO3QyLvOq1ypy+bRj4BxyWjAgW/YwnczcBFr1m2zbEHpTUXDrZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541642; c=relaxed/simple;
	bh=HXudYhwB7Kchqn7VL0fSsZv3EQ9xKQiinovj7oP45mY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HiAe8nyrVgKtKydHABBKGqJZs5dmmK4WRUhDZ6Bw7HqhMRQLE89U919pksc+l2kLt1ClNXbD48Ut7YZDp8pEHPhzj/cV4ii3vcQhI5S2IHPxytKh4Tje0fxzTqyTvgGxc4VlHbxhWS0UbkurJmQEPd27D68HhkFj0DyRFIcFeTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc0+yVwG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4710683a644so6206855e9.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760541637; x=1761146437; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d8h0yoyt0f4ynabpsMipxvZQncX7yds0bex6WGCO/og=;
        b=Xc0+yVwG4IFKnMsiOAOgbyp5obCAn6OkY4g7qV+TRklnJINxO5X1t4DqrvBv+p/m+e
         sWLrxeKCX6pkkscVr/mqaDE3WGuUd/lTCFDNzkCnXTTBzGRJ6StDsoZht0Bf4z0NzF5+
         5Zbr+PGSWH118q1xkXbBexn5gGmHc8rdZnw23K1jB4MbLxZg0aRx3vm3vvyQfu1nsjyB
         ymSDoOXK/zSQcI9vEwkLAKJWiqYGRNknVKL3O0B6dkwNuNsiBUWMA9RdvmOIfJiUHtI4
         GqVD19eq+15Lb2nWHz2WBE04Wuc0WupRQuQ+fCDBxRi82ZmBCoc8tx8GFR7kiy7ysPPm
         a14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760541637; x=1761146437;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8h0yoyt0f4ynabpsMipxvZQncX7yds0bex6WGCO/og=;
        b=Q0HBB6JmE4CO1fiUXOOues19oQULyFZQA/JRPdNTE8WHFM16YqsDsLPpXuITQuegSm
         AuftLLqBCUPN+uwxWS8ezrNyJ8s4JVqdI/EUqGktH/1oAxkoSeOwlqMJVlnqqa7FTx4l
         nELK5Ic0fJgaxer5o4TdWq49ZNo2qbU8s/JFAKdJPzYAFRcJZkEersK9hk9mccRkSaqa
         HfM0+U5jvL/q5QVUs30HRphSm3+DYQyWKSnr5NvrT+YrnKb7wWUMhVl6CUP7LYVlKUA3
         hGjHVQetPrcJyPT7YOnZPPBF9aA8PqJsmhlMkzatN1mIEN8RJY+xppXEUclfgibb2rt1
         fE9w==
X-Gm-Message-State: AOJu0YwUdsZXhXm+OzO/mNpFa40jSCmerCBVRYOsp2yX8XM3o+ilUm1i
	9i5QgOhOv5ZcOyR/t5lmzW+KvrqdUndWyMMbZxrogK1HpRN6oTHatBX+
X-Gm-Gg: ASbGncvP3y5i12H/NZb0v7GM1fdlMuLehMhdj8ZwM9F11CGG6AzjVR5yo7YeMx2gdhY
	c1N1aMqvGvmj1PpCOn+FrPXfyK8zkKW/BGWE/p3MhEsfRehDRE3CgUe8C+NjfpzCpGJZKOszNCR
	j5PpeqBtmh76wn8BJnVu4y+MiNTC1cPBiNrOs60ESnuQPU5sjhevAoKjXSQnAHY1ghlcsQcAZZS
	9LU9DlEmFECbfHgwhhUdf63GFIgwrqPGoeWi2gQKEQ5F3xs2z47+MzOl3gud3so4N1vIhuEyeW6
	HmRgH4IuZCjYj3PMiYMm4n23MjY5tS3qwp5LWGIQuWwAuNxkmkCwhxeDZUoZX7//KVDSCAX+jus
	YCseR1UozMubp+exSODltBsq6IIrhui0xfUy9WtroVILJJA+2wBgjERDNqTa5
X-Google-Smtp-Source: AGHT+IGJ0ezl39N8NXlH/1sWWPosXzwUuY9Yct7CtS9Wami7Ctv6kENUpgVOrnD0fuCjQXtniwj/VQ==
X-Received: by 2002:a05:600c:a4f:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-47109a2cf5cmr4578755e9.8.1760541637224;
        Wed, 15 Oct 2025 08:20:37 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe69sm30667786f8f.32.2025.10.15.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:20:36 -0700 (PDT)
Message-ID: <1e8d7c96cdfaa93bcc0f581103dc0e13dfee17b7.camel@gmail.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>,  Wolfram
 Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner	 <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  Andy Shevchenko	
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven	 <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Liam Girdwood	 <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pascal Eberhard	
 <pascal.eberhard@se.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Date: Wed, 15 Oct 2025 16:21:09 +0100
In-Reply-To: <20251015142816.1274605-3-herve.codina@bootlin.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
	 <20251015142816.1274605-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 16:28 +0200, Herve Codina (Schneider Electric) wrote:
> The Renesas RZ/N1 ADC controller is the ADC controller available in the
> Renesas RZ/N1 SoCs family. It can use up to two internal ACD cores (ADC1
> and ADC2) those internal cores are not directly accessed but are handled
> through ADC controller virtual channels.
>=20
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.co=
m>
> ---
> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
> =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/rzn1-adc.c | 626 ++++++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 637 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/rzn1-adc.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 58a14e6833f6..113f6a5c9745 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1403,6 +1403,16 @@ config RZG2L_ADC
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the
> =C2=A0	=C2=A0 module will be called rzg2l_adc.
> =C2=A0
> +config RZN1_ADC
> +	tristate "Renesas RZ/N1 ADC driver"
> +	depends on ARCH_RZN1 || COMPILE_TEST
> +	help
> +	=C2=A0 Say yes here to build support for the ADC found in Renesas
> +	=C2=A0 RZ/N1 family.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the
> +	=C2=A0 module will be called rzn1-adc.
> +
> =C2=A0config SC27XX_ADC
> =C2=A0	tristate "Spreadtrum SC27xx series PMICs ADC"
> =C2=A0	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d008f78dc010..ba7a8a63d070 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -123,6 +123,7 @@ obj-$(CONFIG_ROHM_BD79112) +=3D rohm-bd79112.o
> =C2=A0obj-$(CONFIG_ROHM_BD79124) +=3D rohm-bd79124.o
> =C2=A0obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> =C2=A0obj-$(CONFIG_RZG2L_ADC) +=3D rzg2l_adc.o
> +obj-$(CONFIG_RZN1_ADC) +=3D rzn1-adc.o
> =C2=A0obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
> =C2=A0obj-$(CONFIG_SD_ADC_MODULATOR) +=3D sd_adc_modulator.o
> =C2=A0obj-$(CONFIG_SOPHGO_CV1800B_ADC) +=3D sophgo-cv1800b-adc.o
> diff --git a/drivers/iio/adc/rzn1-adc.c b/drivers/iio/adc/rzn1-adc.c
> new file mode 100644
> index 000000000000..f5e16b9cdf17
> --- /dev/null
> +++ b/drivers/iio/adc/rzn1-adc.c
> @@ -0,0 +1,626 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/N1 ADC driver
> + *
> + * Copyright (C) 2025 Schneider-Electric
> + *
> + * Author: Herve Codina <herve.codina@bootlin.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/completion.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/driver.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/bits.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/pm_runtime.h>
> +
> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADC1 ADC2
> + * RZ/N1D, BGA 400=C2=A0=C2=A0 y=C2=A0=C2=A0=C2=A0 y
> + * RZ/N1D, BGA 324=C2=A0=C2=A0 y=C2=A0=C2=A0=C2=A0 n
> + * RZ/N1S, BGA 324=C2=A0=C2=A0 y=C2=A0=C2=A0=C2=A0 n
> + * RZ/N1S, BGA 196=C2=A0=C2=A0 y=C2=A0=C2=A0=C2=A0 n
> + * RZ/N1L, BGA 196=C2=A0=C2=A0 y=C2=A0=C2=A0=C2=A0 n
> + */
> +
> +#define RZN1_ADC_CONTROL_REG	0x2c
> +#define RZN1_ADC_CONTROL_ADC_BUSY	BIT(6)
> +#define RZN1_ADC_FORCE_REG		0x30
> +#define RZN1_ADC_SET_FORCE_REG		0x34
> +#define RZN1_ADC_CLEAR_FORCE_REG	0x38
> +#define RZN1_ADC_FORCE_VC(_n)		BIT(_n)
> +
> +#define RZN1_ADC_CONFIG_REG	0x40
> +#define RZN1_ADC_CONFIG_ADC_POWER_DOWN	BIT(3)
> +
>=20

...

> +static int rzn1_adc_enable(struct rzn1_adc *rzn1_adc)
> +{
> +	int ret;
> +
> +	ret =3D rzn1_adc_core_power_on(&rzn1_adc->adc_core[0]);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D rzn1_adc_core_power_on(&rzn1_adc->adc_core[1]);
> +	if (ret)
> +		goto poweroff_adc_core0;
> +
> +	ret =3D clk_prepare_enable(rzn1_adc->pclk);
> +	if (ret)
> +		goto poweroff_adc_core1;
> +
> +	ret =3D clk_prepare_enable(rzn1_adc->adc_clk);
> +	if (ret)
> +		goto disable_pclk;
> +
> +	ret =3D rzn1_adc_power(rzn1_adc, true);
> +	if (ret)
> +		goto disable_adc_clk;

Can we use devm_actions() on the above to avoid the complex error path plus=
 the
.remove() callback?

> +
> +	return 0;
> +
> +disable_adc_clk:
> +	clk_disable_unprepare(rzn1_adc->adc_clk);
> +disable_pclk:
> +	clk_disable_unprepare(rzn1_adc->pclk);
> +poweroff_adc_core1:
> +	rzn1_adc_core_power_off(&rzn1_adc->adc_core[1]);
> +poweroff_adc_core0:
> +	rzn1_adc_core_power_off(&rzn1_adc->adc_core[0]);
> +	return ret;
> +}
> +
> +static void rzn1_adc_disable(struct rzn1_adc *rzn1_adc)
> +{
> +	rzn1_adc_power(rzn1_adc, false);
> +
> +	clk_disable_unprepare(rzn1_adc->adc_clk);
> +	clk_disable_unprepare(rzn1_adc->pclk);
> +
> +	rzn1_adc_core_power_off(&rzn1_adc->adc_core[1]);
> +	rzn1_adc_core_power_off(&rzn1_adc->adc_core[0]);
> +}
> +
> +static int rzn1_adc_set_iio_dev_channels(struct rzn1_adc *rzn1_adc,
> +					 struct iio_dev *indio_dev)
> +{
> +	int adc_used;
> +
> +	adc_used =3D rzn1_adc->adc_core[0].is_used ? 0x01 : 0x00;
> +	adc_used |=3D rzn1_adc->adc_core[1].is_used ? 0x02 : 0x00;
> +
> +	switch (adc_used) {
> +	case 0x01:
> +		indio_dev->channels =3D rzn1_adc1_channels;
> +		indio_dev->num_channels =3D ARRAY_SIZE(rzn1_adc1_channels);
> +		return 0;
> +	case 0x02:
> +		indio_dev->channels =3D rzn1_adc2_channels;
> +		indio_dev->num_channels =3D ARRAY_SIZE(rzn1_adc2_channels);
> +		return 0;
> +	case 0x03:
> +		indio_dev->channels =3D rzn1_adc1_adc2_channels;
> +		indio_dev->num_channels =3D
> ARRAY_SIZE(rzn1_adc1_adc2_channels);
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	dev_err(rzn1_adc->dev, "Failed to set IIO channels, no ADC core
> used\n");
> +	return -ENODEV;

dev_err_probe()?

> +}
> +
> +static int rzn1_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct rzn1_adc *rzn1_adc;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*rzn1_adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	rzn1_adc =3D iio_priv(indio_dev);
> +	rzn1_adc->dev =3D dev;
> +	mutex_init(&rzn1_adc->lock);

devm_mutex_init()

> +
> +	rzn1_adc->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rzn1_adc->regs))
> +		return PTR_ERR(rzn1_adc->regs);
> +
> +	rzn1_adc->pclk =3D devm_clk_get(dev, "pclk");
> +	if (IS_ERR(rzn1_adc->pclk))
> +		return dev_err_probe(dev, PTR_ERR(rzn1_adc->pclk), "Failed to
> get pclk\n");
> +
> +	rzn1_adc->adc_clk =3D devm_clk_get(dev, "adc-clk");
> +	if (IS_ERR(rzn1_adc->pclk))
> +		return dev_err_probe(dev, PTR_ERR(rzn1_adc->pclk), "Failed to
> get adc-clk\n");
> +
> +	ret =3D rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc->adc_core[0],
> +					=C2=A0=C2=A0 "adc1-avdd", "adc1-vref");
> +	if (ret)
> +		return ret;
> +
> +	ret =3D rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc->adc_core[1],
> +					=C2=A0=C2=A0 "adc2-avdd", "adc2-vref");
> +	if (ret)
> +		return ret;

Hmm, is avdd really an optional regulator? I mean can the ADC power up at a=
ll
without a supply in AVDD? Even vref seems to be mandatory as we can't prope=
rly
scale the sample without it.

Also, can't we have getting and enabling the regulator together? Then, we c=
ould
use some of the modern helpers to simplify the code (ok I see you use them =
in
the PM callbacks).

> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	indio_dev->name =3D dev_name(dev);

dev_name() should not be used for the above. It's typically the part name s=
o I
guess in here "rzn1-adc" would be the appropriate one.

> +	indio_dev->info =3D &rzn1_adc_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	ret =3D rzn1_adc_set_iio_dev_channels(rzn1_adc, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D rzn1_adc_enable(rzn1_adc);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, 500);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);

There's a devm_pm_runtime_enable() API now.

> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		goto disable;
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +
> +disable:
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_dont_use_autosuspend(dev);
> +
> +	rzn1_adc_disable(rzn1_adc);
> +	return ret;
> +}
> +
> +static void rzn1_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> +	struct rzn1_adc *rzn1_adc =3D iio_priv(indio_dev);
> +
> +	pm_runtime_disable(rzn1_adc->dev);
> +	pm_runtime_set_suspended(rzn1_adc->dev);
> +	pm_runtime_dont_use_autosuspend(rzn1_adc->dev);
> +
> +	rzn1_adc_disable(rzn1_adc);
> +}

I'm fairly confident we can sanely go without .remove().
=20
> +
> +static int rzn1_adc_pm_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct rzn1_adc *rzn1_adc =3D iio_priv(indio_dev);
> +
> +	rzn1_adc_disable(rzn1_adc);
> +
> +	return 0;
> +}
> +
> +static int rzn1_adc_pm_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct rzn1_adc *rzn1_adc =3D iio_priv(indio_dev);
> +
> +	return rzn1_adc_enable(rzn1_adc);
> +}
> +
> +static const struct dev_pm_ops rzn1_adc_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(rzn1_adc_pm_runtime_suspend,
> rzn1_adc_pm_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id rzn1_adc_of_match[] =3D {
> +	{ .compatible =3D "renesas,rzn1-adc" },
> +	{ /* sentinel */ },
> +};

We typically don't add the sentinel comment in IIO.

> +
> +MODULE_DEVICE_TABLE(of, rzn1_adc_of_match);
> +
> +static struct platform_driver rzn1_adc_driver =3D {
> +	.probe =3D rzn1_adc_probe,
> +	.remove =3D rzn1_adc_remove,
> +	.driver =3D {
> +		.name =3D "rzn1-adc",
> +		.of_match_table =3D of_match_ptr(rzn1_adc_of_match),

Drop of_match_ptr().

- Nuno S=C3=A1



