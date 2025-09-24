Return-Path: <linux-iio+bounces-24417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F153B9A435
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8443AEBA8
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C4A307AC2;
	Wed, 24 Sep 2025 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhtjSPTV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532B1ACEDE
	for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724462; cv=none; b=PHFnZrP41gSkpS/12u5EeVp7Gg5e+6MHOa/jL4bqBMR4g7l5Wzh/gQivf6T+f6yOZ+6ERgnJnZHMTaZdIGfueHV+Don4m7g+/KdowJJgLu2rBVeQbyd8TezqPo39CJsXkKyCihU7wVQS7LfxraF35gHBG3PF0t5tsK2x8acqBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724462; c=relaxed/simple;
	bh=A9PimX6bUbgQ7SeUVDOv0qB4SMDat/5djDZWcI5N8yI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ARn9X68rJzbKOKyZt1ryYop0SMgjda4DByiijKXCEaH6c+4Nh/asTuSaOgzRFKzQrwCw6VbR6Gui3DTe4C8+cn9sJHsQKG5bOSaxVdaMukVJREIq5Ezr8WOXg+wLR49QBCbTgFufEv2xGL6Y4DKNU7W4Dxu1YSR3W+Z40Vjq2xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhtjSPTV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so5280521f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724459; x=1759329259; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FGuldXcjqf8OihVldC7MI7YO4JLmIiQzrU/Ak4hlUT8=;
        b=NhtjSPTVz6CE3h3aDhfNIovy3mbAnnxgziyM+bPBfvo9A2UwJeIfhBwFJDtXGaTWEe
         uGonJrwJx/3c98ZVLPIW45eSjanFE/fd4KVxLDrNEd0DrewnmE28toJjmOFOZ7IWHpNk
         553OmJb34FcS/+n4iF09QPaWghFXF2n3jSsgPLKhzZZf4tjajXVIAd+0ltstLtXmADTt
         BjI/tHjmVZLVV2KQU4b1RMoKl+lrMQFVZDKN9T4u37KDxO0yfK5sDWEBVlpts4ozz0vN
         GXwdYqERFvmHBcpzu0SbLi7h7bHhfF8JP1WFPxN4mQ/F/eRHa+Dy2VBNKgsQCtBhhda1
         ztoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724459; x=1759329259;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGuldXcjqf8OihVldC7MI7YO4JLmIiQzrU/Ak4hlUT8=;
        b=Mv7r9zj+L/q95vBBkMXJydhQdMh3D9Vnx8X/lnUyvqILmbBzPGlfnsUW0e7Wpsz1jD
         y30hm2Pq+uDbROlMHaSfCixe0XxM0ebzCKttExsHnGNDluLaR5SylWo+Q0CJy6jK0tNK
         tvROEv84zB4Z+7ZH1yfK0QQ+HUBMaxfifU4w6l9fDsLwUw4HQoqh28p6eLOe/nROh23F
         8urAP+ZgNWLXMoxclA/QCOA+31ELCBjNUZsU3gRAAW/twT3+F80GvbPRAGrZHwMqfuN+
         8OEPEYsPcrYgjO39BfJj+uXaP15nMai544TTLkGdJ91FQaahDffBx2QWTYLK8afjTWm6
         NB+A==
X-Forwarded-Encrypted: i=1; AJvYcCUIIzbYIh53bSB5onccpiyNQvJLLSxENxmwNbFnk85Yw4okN/mw3YSjNl5tH8XQlhfVKnDnwEDvQk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV5sDCaRErbGe5oKAcP3DMR3MEp65PeXdXvH4tBNIpyqVJSani
	oultIyOg0ARcdiD3iaxQ5SF7W/9TYwVQORFRVXLQj0sg+xWTCdazMb9o
X-Gm-Gg: ASbGncvL4zCISkc7OUsFHkd1yFyl1mR7VoYrEAnOt+PaU7GfXVwiIXnuaT3ZL+OPk8A
	Bvh4KpAqqcZPUhQG0Mnk13WOCgxl+7Qhh9s/EvDPwKjE+KXNRe/jnevgzFYzZ+ESTCMn5F7baif
	AAfrLXWziCgTa74DLHchkv8Oplh5gL7z/PAr01VnH56gihW6ug2l1Vt6MMh/a8V7bOJKjen9DDd
	SssSlLnzvpBD0uRt70k4Yjf5kLvlCxg1p422mLF0dzWHeefSOuOcrFW+K4HGzKsMXGse+Niiw9Z
	jgDVEIaaq7zBQ5b3hQXcuxAZ5N4bDWyFYmkeD1Zu0lpIDw/9EmsuMtZi45DCXgWg0V/z0KPhEWf
	kXvHcr66ZyewX1iF2I8uYag==
X-Google-Smtp-Source: AGHT+IGLJblPflhmFCHt94DviBP9O/s0y5YTbBNNacFFsu0nA3nuXpOv6LIYJxuAR0FgwMMN3hA1gg==
X-Received: by 2002:a05:6000:220f:b0:3ec:3cac:7dfd with SMTP id ffacd0b85a97d-40e44c3da28mr207611f8f.26.1758724458762;
        Wed, 24 Sep 2025 07:34:18 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbffaeasm28405985f8f.62.2025.09.24.07.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:34:18 -0700 (PDT)
Message-ID: <404c05f20becd0fc8e3256425843187b40a3b625.camel@gmail.com>
Subject: Re: [PATCH 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd	 <sboyd@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, 	linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-clk@vger.kernel.org
Date: Wed, 24 Sep 2025 15:34:45 +0100
In-Reply-To: <20250923160524.1096720-4-cosmin-gabriel.tanislav.xa@renesas.com>
References: 
	<20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
	 <20250923160524.1096720-4-cosmin-gabriel.tanislav.xa@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Cosmin,

Some comments/questions from me...
=20
On Tue, 2025-09-23 at 19:05 +0300, Cosmin Tanislav wrote:
> Add support for the A/D 12-Bit successive approximation converters found
> in the Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>=20
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>=20
> Conversions can be performed in single or continuous mode. Result of the
> conversion is stored in a 16-bit data register corresponding to each
> channel.
>=20
> The conversions can be started by a software trigger, a synchronous
> trigger (from MTU or from ELC) or an asynchronous external trigger (from
> ADTRGn# pin).
>=20
> Only single mode with software trigger is supported for now.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 ++
> =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/rzt2h_adc.c | 328 +++++++++++++++++++++++++++++++++=
+++
> =C2=A04 files changed, 340 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/rzt2h_adc.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 07e0d37cf468..d550399dc390 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21828,6 +21828,7 @@ L:	linux-iio@vger.kernel.org
> =C2=A0L:	linux-renesas-soc@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.=
yaml
> +F:	drivers/iio/adc/rzt2h_adc.c
> =C2=A0
> =C2=A0RENESAS RTCA-3 RTC DRIVER
> =C2=A0M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 58a14e6833f6..cab5eeba48fe 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1403,6 +1403,16 @@ config RZG2L_ADC
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the
> =C2=A0	=C2=A0 module will be called rzg2l_adc.
> =C2=A0
> +config RZT2H_ADC
> +	tristate "Renesas RZ/T2H / RZ/N2H ADC driver"
> +	select IIO_ADC_HELPER
> +	help
> +	=C2=A0 Say yes here to build support for the ADC found in Renesas
> +	=C2=A0 RZ/T2H / RZ/N2H SoCs.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the
> +	=C2=A0 module will be called rzt2h_adc.
> +
> =C2=A0config SC27XX_ADC
> =C2=A0	tristate "Spreadtrum SC27xx series PMICs ADC"
> =C2=A0	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d008f78dc010..ed647a734c51 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -123,6 +123,7 @@ obj-$(CONFIG_ROHM_BD79112) +=3D rohm-bd79112.o
> =C2=A0obj-$(CONFIG_ROHM_BD79124) +=3D rohm-bd79124.o
> =C2=A0obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> =C2=A0obj-$(CONFIG_RZG2L_ADC) +=3D rzg2l_adc.o
> +obj-$(CONFIG_RZT2H_ADC) +=3D rzt2h_adc.o
> =C2=A0obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
> =C2=A0obj-$(CONFIG_SD_ADC_MODULATOR) +=3D sd_adc_modulator.o
> =C2=A0obj-$(CONFIG_SOPHGO_CV1800B_ADC) +=3D sophgo-cv1800b-adc.o
> diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> new file mode 100644
> index 000000000000..d855a79b3d96
> --- /dev/null
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/iio/adc-helpers.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +
> +#define RZT2H_NAME			"rzt2h-adc"
> +
> +#define RZT2H_ADCSR_REG			0x00
> +#define RZT2H_ADCSR_ADIE_MASK		BIT(12)
> +#define RZT2H_ADCSR_ADCS_MASK		GENMASK(14, 13)
> +#define RZT2H_ADCSR_ADCS_SINGLE		0b00
> +#define RZT2H_ADCSR_ADST_MASK		BIT(15)
> +
> +#define RZT2H_ADANSA0_REG		0x04
> +#define RZT2H_ADANSA0_CH_MASK(x)	BIT(x)
> +
> +#define RZT2H_ADDR_REG(x)		(0x20 + 0x2 * (x))
> +
> +#define RZT2H_ADCALCTL_REG		0x1f0
> +#define RZT2H_ADCALCTL_CAL_MASK		BIT(0)
> +#define RZT2H_ADCALCTL_CAL_RDY_MASK	BIT(1)
> +#define RZT2H_ADCALCTL_CAL_ERR_MASK	BIT(2)
> +
> +#define RZT2H_ADC_MAX_CHANNELS		16
> +#define RZT2H_ADC_VREF_MV		1800
> +#define RZT2H_ADC_RESOLUTION		12
> +
> +struct rzt2h_adc {
> +	void __iomem *base;
> +	struct device *dev;
> +
> +	struct completion completion;
> +	/* lock to protect against multiple access to the device */
> +	struct mutex lock;
> +
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +
> +	u16 data[RZT2H_ADC_MAX_CHANNELS];
> +};
> +
> +static void rzt2h_adc_start_stop(struct rzt2h_adc *adc, bool start,
> +				 unsigned int conversion_type)
> +{
> +	u16 mask;
> +	u16 reg;
> +
> +	reg =3D readw(adc->base + RZT2H_ADCSR_REG);
> +
> +	if (start) {
> +		/* Set conversion type */
> +		reg &=3D ~RZT2H_ADCSR_ADCS_MASK;
> +		reg |=3D FIELD_PREP(RZT2H_ADCSR_ADCS_MASK, conversion_type);
> +	}
> +
> +	/* Toggle end of conversion interrupt and start bit. */
> +	mask =3D RZT2H_ADCSR_ADIE_MASK | RZT2H_ADCSR_ADST_MASK;
> +	if (start)
> +		reg |=3D mask;
> +	else
> +		reg &=3D ~mask;
> +
> +	writew(reg, adc->base + RZT2H_ADCSR_REG);
> +}
> +
> +static void rzt2h_adc_start(struct rzt2h_adc *adc, unsigned int
> conversion_type)
> +{
> +	rzt2h_adc_start_stop(adc, true, conversion_type);
> +}
> +
> +static void rzt2h_adc_stop(struct rzt2h_adc *adc)
> +{
> +	rzt2h_adc_start_stop(adc, false, 0);
> +}
> +

I'm not 100% convince the above two helpers add much value given the usage =
they
have. I do understand that they make things a bit more readable but still..=
.

rzt2h_adc_start_stop(adc, false/true, ...) is already fairly clear about it=
's
happening. Dont't feel strong about it anyways so up to you.

> +static int rzt2h_adc_read_single(struct rzt2h_adc *adc, unsigned int ch,=
 int
> *val)
> +{
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(adc->dev);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&adc->lock);
> +
> +	reinit_completion(&adc->completion);
> +
> +	/* Enable a single channel */
> +	writew(RZT2H_ADANSA0_CH_MASK(ch), adc->base + RZT2H_ADANSA0_REG);
> +
> +	rzt2h_adc_start(adc, RZT2H_ADCSR_ADCS_SINGLE);

This is the only place where this is called. So we could just pass
RZT2H_ADCSR_ADCS_SINGLE inside the function. Unless this will be extended i=
n the
near future?

> +
> +	/*
> +	 * Datasheet Page 2770, Table 41.1:
> +	 * 0.32us per channel when sample-and-hold circuits are not in use.
> +	 */
> +	ret =3D wait_for_completion_timeout(&adc->completion,
> usecs_to_jiffies(1));
> +	if (!ret) {
> +		ret =3D -ETIMEDOUT;
> +		goto disable;
> +	}
> +
> +	*val =3D adc->data[ch];
> +	ret =3D IIO_VAL_INT;
> +
> +disable:
> +	rzt2h_adc_stop(adc);
> +
> +	pm_runtime_put_autosuspend(adc->dev);
> +
> +	return ret;
> +}
> +
> +static void rzt2h_adc_set_cal(struct rzt2h_adc *adc, bool cal)
> +{
> +	u16 val;
> +
> +	val =3D readw(adc->base + RZT2H_ADCALCTL_REG);
> +	if (cal)
> +		val |=3D RZT2H_ADCALCTL_CAL_MASK;
> +	else
> +		val &=3D ~RZT2H_ADCALCTL_CAL_MASK;
> +
> +	writew(val, adc->base + RZT2H_ADCALCTL_REG);
> +}
> +
> +static int rzt2h_adc_calibrate(struct rzt2h_adc *adc)
> +{
> +	u16 val;
> +	int ret;
> +
> +	rzt2h_adc_set_cal(adc, true);
> +
> +	ret =3D read_poll_timeout(readw, val, val &
> RZT2H_ADCALCTL_CAL_RDY_MASK,
> +				200, 1000, true, adc->base +
> RZT2H_ADCALCTL_REG);
> +	if (ret) {
> +		dev_err(adc->dev, "Calibration timed out: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (val & RZT2H_ADCALCTL_CAL_ERR_MASK) {
> +		dev_err(adc->dev, "Calibration failed\n");
> +		return -EINVAL;
> +	}
> +
> +	rzt2h_adc_set_cal(adc, false);

Should we disable calibrations in the error path (or right after
read_poll_timeout()) or it does not really matter?

> +
> +	return 0;
> +}
> +
> +static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask)
> +{
> +	struct rzt2h_adc *adc =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return rzt2h_adc_read_single(adc, chan->channel, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D RZT2H_ADC_VREF_MV;
> +		*val2 =3D RZT2H_ADC_RESOLUTION;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info rzt2h_adc_iio_info =3D {
> +	.read_raw =3D rzt2h_adc_read_raw,
> +};
> +
> +static irqreturn_t rzt2h_adc_isr(int irq, void *private)
> +{
> +	struct rzt2h_adc *adc =3D private;
> +	unsigned long enabled_channels;
> +	unsigned int ch;
> +
> +	enabled_channels =3D readw(adc->base + RZT2H_ADANSA0_REG);
> +	if (!enabled_channels)
> +		return IRQ_NONE;

Is the above possible at all? In rzt2h_adc_read_single() we do write the sa=
me
register...

> +
> +	for_each_set_bit(ch, &enabled_channels, adc->num_channels)
> +		adc->data[ch] =3D readw(adc->base + RZT2H_ADDR_REG(ch));
> +

Is there any particular reason for reading all enabled channels in the IRQ =
when
we kind of just care for one channel? If there's nothing non obvious happen=
ing
It seems that the IRQ could just do complete(...) and reading the result in=
=20
rzt2h_adc_read_single()

- Nuno S=C3=A1


