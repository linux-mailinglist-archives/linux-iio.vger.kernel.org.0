Return-Path: <linux-iio+bounces-25842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F0AC2B6F5
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 12:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0173BBB30
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 11:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA130214D;
	Mon,  3 Nov 2025 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm1zZ+o+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E26A2FBDF4
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169643; cv=none; b=XZFZUidONTopVtBOswScBmn9I8yC5mzZ3I+fGWgF3w8cn/okQ3pDC9BIuos4Yp98X73RWl4oy6X7L65KZpA3wFyLnma+1XphHXKjvQvyih9K8HGQ99TmJOOKGBg8AxpkbTI0CsUJYPOtqhR9i/GOvOKUI+uhoU4uhKsR86F+XlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169643; c=relaxed/simple;
	bh=cuQUH77MkBh0VUBEfQGuQkOtLJDnbqOfJIHSvLF3Blg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h6qshO+lvPPxr30vKnX1CRMUNnjq6PAgbk0VW1fCJqheFkpCQtUxndUPeNnLFfB1g+4T7jCKi0FV0O//XGCQqZUHYGqXPvS6OuITajsmP4Y1PDfQuPeG3M5V/x1v32waG5Wte501HAKFKqLsyzHBC3uuasrM2w8BMYN2V6ifR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qm1zZ+o+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso1751030f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 03:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762169640; x=1762774440; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vOloNiz/LIv+fxFQ4H8D3qzw660SR91t+vlAvFfeGIo=;
        b=Qm1zZ+o+uZFKnjRV9heoNFHkbIeApl9qHzONenf88RFQO61+ioJpy0ZW1TqyRCeAM9
         akUU/2guK4zn97emgosIuPDn/lWcZrfCtxOtaY1mSJU1egvWOtd9l5Wc04AG1j0x+PmW
         oYe6fSFvbOAFMRqPVy6qTanEnLmNAG/Wm/FCP2pa6qDAhMKT6rcgOhVObVx4H/DIFGzT
         CX5y0VUC0tMBc/zHbeDeuDWOw/cMO+eUxHspQifuUZX9W287zvRkYAhJgU9yV6DKGF8O
         MjBHBKe3hemuMv6zaxeB1ZHkgjVwaUA/RoXO1JnbrKHRG7o09fQ60lL2fT9l4u801LGe
         emTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169640; x=1762774440;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOloNiz/LIv+fxFQ4H8D3qzw660SR91t+vlAvFfeGIo=;
        b=atV+XK4lLSDBNtOE6vhUJMWBUpy/FiMBG0SjIVM1n/d7m2U2KH9zvFaLCSTJQ5P50s
         zFzis3t25PAUwuDWgjQ9D0MMTmKxTnqihPVXFOs9me1oh24J7ejEhrhjbH7L3hWNzzIz
         ya6eWsvJN5mNFkmSnfH5S3Tslec5qpIOUQzsALFN6GdA4okBb/SREiAPLeYtLCcMaSgh
         ua0XJ4JML3CBdjQqCdO9hPSVcj5JA1ydqr5pfZVLJJt7VCWbE/lIaZbCfaKurWMHYJ9V
         obo+TMn7pj487h/yfNv8CR0FUKSzmXsalAb8os9pgli0XW/gGQxiuQbUvuoeuO5QeOU8
         DCfA==
X-Gm-Message-State: AOJu0Yx85HNpHuVBP3g9pWR0rfN64s1hZAyYvlygE570quECtMm1Vz5f
	OOomF34shET9p6uT/nx/1lrr5LRPkVZgOG7uMrnSHSzyOPB0cinsvrn2
X-Gm-Gg: ASbGncvH/jZra/tokicpkAnkCIdzibbXhYKVMYq0I1MPEmy3YvjosOLPV0yJuYUMt6N
	znz6hLqekKPwYwgwloGCUxVBwaThPP+ZdsyVCKz5ZING0xXQ+xXuit4RFF3MGXsLCsokIM6SYXK
	mMV9D5koSbclZXu6X20WjLhhh05Wwkl2IBwgT2W5Rx9DiceAaHLIbZemrCelIK9uwXOOZDMJzOf
	vdnTG8JEn781BfH+3KXfccgkFbJvXhsfaF8TlTdlHgF3XGsgRKzC0oqeA2VPtsrPFf3ncJjRFuc
	7yeZG3lRMBmTWSi/ou6CXp3vuaDdXbDN9RiWaYFk4cAmrpgGrjha0aENqfJCRxjjy05HJEWlaUo
	ktkHg6hNLphTLA6FReK+YLAS5K9n1SKG3eMIheXExZFYR34Ys/3T0+SBH5RMC3PxZl62Z+gaiLf
	xLmi4jK8bk
X-Google-Smtp-Source: AGHT+IHEgZpMAanIx/WNbbiJiPaCSI2QOctFxePvc+vMhoOiDgHLLdOJk4neydoG/A7CpeJvkw4SLA==
X-Received: by 2002:a05:6000:24c7:b0:3ec:de3c:c56 with SMTP id ffacd0b85a97d-429bd68cf3fmr10670694f8f.16.1762169640205;
        Mon, 03 Nov 2025 03:34:00 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1d47sm20034750f8f.23.2025.11.03.03.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:33:59 -0800 (PST)
Message-ID: <20e485b69419ffd518c7aeb16881df429b0a4873.camel@gmail.com>
Subject: Re: [PATCH v2 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
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
Date: Mon, 03 Nov 2025 11:34:35 +0000
In-Reply-To: <20251029144644.667561-3-herve.codina@bootlin.com>
References: <20251029144644.667561-1-herve.codina@bootlin.com>
	 <20251029144644.667561-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 15:46 +0100, Herve Codina (Schneider Electric) wrote:
> The Renesas RZ/N1 ADC controller is the ADC controller available in the
> Renesas RZ/N1 SoCs family. It can use up to two internal ADC cores (ADC1
> and ADC2) those internal cores are not directly accessed but are handled
> through ADC controller virtual channels.
>=20
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.co=
m>
> ---

Not much to add to Andy's review. Looks in good shape... Just one small rem=
ark
from me. With it and Andy's stuff addressed:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
> =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/rzn1-adc.c | 493 ++++++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 504 insertions(+)
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
> index 000000000000..52ec13adddef
> --- /dev/null
> +++ b/drivers/iio/adc/rzn1-adc.c
> @@ -0,0 +1,493 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/N1 ADC driver
> + *
> + * Copyright (C) 2025 Schneider-Electric
> + *
> + * Author: Herve Codina <herve.codina@bootlin.com>
> + *
> + * The RZ/N1 ADC controller can handle channels from its internal ADC1 a=
nd/or
> + * ADC2 cores. The driver use ADC1 and/or ADC2 cores depending on the pr=
esence
> + * of the related power supplies (AVDD and VREF) description in the devi=
ce-tree.
> + */

...

>=20
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +

If I'm not missing nothing, there's no real need to pass in indio_dev. So, =
why not
passing rzn1_adc directly and avoid the pointer arithmetic's in the pm call=
backs?

- Nuno S=C3=A1


