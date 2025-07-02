Return-Path: <linux-iio+bounces-21225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03910AF0D49
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 09:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B621E440AAB
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 07:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF18523026B;
	Wed,  2 Jul 2025 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkEbQmU+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04776211F;
	Wed,  2 Jul 2025 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443015; cv=none; b=kC/HYumFPY30SZzxcZKvmpCnpvaXHN0Kfyu4y9pPIJWDRl8bFDVmepLRVbMHmbmsyq/VNQAd8V8xvOBQR1fd9lfD6cjYLhO35UwH7YUmvOF//bTXK5LuYU3PfRYSPP3k75p5eXbfkf+Z6tmuh3O11Ft36Nt3FrOhGHaD2cB2NmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443015; c=relaxed/simple;
	bh=Q1X6bbdTEe0yaSMMjkEwghrZRhqOzko97t3w24mThPc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCImwZleXOQb7e/SSQkKcl4hhfp6IJy2CRQaeYqr9RnUnTc6uj09eDfBWt2JZqGdmBN/iYpP/6Aq9h73SnCiNR9+adWW5zca9pks0OKmL9LYD6FO482bREOeQAgPEDpRZdf6WrNcQKyBJBlMQq+G2I8Fx8fsbyIl4mrw7Ar635A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkEbQmU+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a582e09144so2990700f8f.1;
        Wed, 02 Jul 2025 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751443012; x=1752047812; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iV/Ph2dG/u7sFBYK4MRj6qlkNVP0kA9qMDQUm1APqRw=;
        b=mkEbQmU+nQlsK22g6e36oNoe6ZzTGFVZHw87FMIS0ON3doEKGaUP1XAuCZGtWrZ0Lq
         8vSVlXHO9Sa0KKcsM3bMgHVboMa36Se+zg8XiZh6xxx8pgS/Bykoul5aMuE+aT/eTiV3
         FGlK/YIMQIFaGOY4dWjCNsPj/JhIJP1K6Aekp3lo9NqdMcFGGrArzMtkjg/q8PIy1jNX
         62LfJqljk5PdVLuPImFOecbPfJ2gudutHQumZxolUGN4Jih+67+rAKcRHqYFmIv6wS10
         lm6Nx/7ZSj9rVtThelgFT3Fh93ih9VPLXK0Q8XFqtyQonuVjlfiz/AFJWZwA9ovyTvCi
         qZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751443012; x=1752047812;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iV/Ph2dG/u7sFBYK4MRj6qlkNVP0kA9qMDQUm1APqRw=;
        b=Pjri87IFlsYmwFhtWJOC9EOduC0Ul2c5oJW72D9mZgHZ1spUHRbYumGmzO8r0IrcS0
         sk7OUzfNMIfq1xxVKqRbBBUEiJq/35srJs3BzLTNwxcUaw87Ivw4uWjKOiL18oB4ucJc
         mu9iaZJfF5Q3pnPzBtILWdXvpu1OaXkwcBuX4Skky1CwxG5ly8Rn5JgI6G30gYqFDDXF
         vC5R1p82Xt4Cz7m6ATL605O4af91Bq3GDnqa4ruCNoSxWdhFqKwDWHJpC2W7tYvgszsy
         +VQb5cNGKiHSeTyHeS48lqk6XyJpRFtdO/KH/xdja/yLPPJfKem8YDD8HGzwexkCrQmz
         etVA==
X-Forwarded-Encrypted: i=1; AJvYcCVD4f5YnSWga3tS1cqKTzqD3p2zGcC8FQUFzpzJh3u4ZRBUS/V5GhfrzxOJIixgFaNYMtkUfceyWpox@vger.kernel.org, AJvYcCXGibaYhJtabClwcLiyEmAHVixXogbuVd3NhvghF4+JqEaFLRprCsp7p0byjBeYpCRT15jGH4PNCNh2@vger.kernel.org, AJvYcCXR9zHXKRCiwP2MGEKIRqx/MuBY+Ab5Y2NC97znD5+BqRkKvZNINCfi/b9Oy4A4bHq/nyqP5GlMFQu7VQDC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy469XOjWD1T7SinwbYwXd8h1AYC8Uw2jN4obMzipS1gJ1yfL+s
	8Ywm1ov6R2em9JqVgtS0vBSVOOIjhPdboAVWzun4Rm12e+auaiPLG3yizRYIXE4W
X-Gm-Gg: ASbGncsMB9SB9g8Zdo8nJ5PclWvPy2gtY+UcCHltfrf30svFhfNZGc+o1JIT9AIWDNG
	kT+rabC6ZhFhzJzVFqrwfsJC6uZwezhIBDS9aoxG0lm+bfIpVetmvt6LVgMQJ5UGZm1eiQNji3p
	kDpag/w/TmyCPIZRzCabZFzwTqSwslKyWv1RBSUuEnrPTAMq+WCrZhKAZ0fKB39zXNypORC5baj
	bolsnsfoEJAm41rNtzUy8/32OlNIBu78CDByU/VjCwFtd+d2yxtzvypxckRcHv3p13DRqhppzJw
	vFg8U8tHdfZgWn2l40pRjTjgYbWHaF/G+9ecSdsshEW7Mnm7oNa+K29IIl6sJjJ6SnY8Ig==
X-Google-Smtp-Source: AGHT+IGZkSowDuNZoXR+Ii7wVfmX3g9XMV/x4oWBOkv9yus3iBnYI5QLGYpYmv9BhmtvRzH01HlHDQ==
X-Received: by 2002:adf:8b04:0:b0:3a4:ec23:dba7 with SMTP id ffacd0b85a97d-3b20095cd2bmr746462f8f.31.1751443012005;
        Wed, 02 Jul 2025 00:56:52 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c4acsm216227585e9.1.2025.07.02.00.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:56:51 -0700 (PDT)
Message-ID: <52c1fe276d16b68b955a00d0417b40902e2aa56e.camel@gmail.com>
Subject: Re: [PATCH v3 10/12] spi: offload trigger: add ADI Util Sigma-Delta
 SPI driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Date: Wed, 02 Jul 2025 08:57:02 +0100
In-Reply-To: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-10-42abb83e3dac@baylibre.com>
References: 
	<20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
	 <20250701-iio-adc-ad7173-add-spi-offload-support-v3-10-42abb83e3dac@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-01 at 16:37 -0500, David Lechner wrote:
> Add a new driver for the ADI Util Sigma-Delta SPI FPGA IP core.
>=20
> This is used to trigger a SPI offload based on a RDY signal from an ADC
> while masking out other signals on the same line.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/spi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +=
+
> =C2=A0drivers/spi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0.../spi/spi-offload-trigger-adi-util-sigma-delta.c | 62
> ++++++++++++++++++++++
> =C2=A04 files changed, 69 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index
> 60ba572be7f5b48c0ab1d0d9724e19e335e8761b..4ed4977deb6ddc545be39b5c1d5e995=
9e9fe
> 64cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23357,7 +23357,7 @@ F:	include/linux/mtd/spi-nor.h
> =C2=A0
> =C2=A0SPI OFFLOAD
> =C2=A0R:	David Lechner <dlechner@baylibre.com>
> -F:	drivers/spi/spi-offload-trigger-pwm.c
> +F:	drivers/spi/spi-offload-trigger-*.c
> =C2=A0F:	drivers/spi/spi-offload.c
> =C2=A0F:	include/linux/spi/offload/
> =C2=A0K:	spi_offload
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index
> c51da3fc3604977b05388687e5e64a58370186c4..e69f060d3875c168a2dc701a372e47b=
8ffd3
> 3268 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1355,6 +1355,11 @@ if SPI_OFFLOAD
> =C2=A0
> =C2=A0comment "SPI Offload triggers"
> =C2=A0
> +config SPI_OFFLOAD_TRIGGER_ADI_UTIL_SD
> +	tristate "SPI offload trigger using ADI sigma-delta utility"
> +	help
> +	=C2=A0 SPI offload trigger from ADI sigma-delta utility FPGA IP block.
> +
> =C2=A0config SPI_OFFLOAD_TRIGGER_PWM
> =C2=A0	tristate "SPI offload trigger using PWM"
> =C2=A0	depends on PWM
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index
> 4ea89f6fc531625060255ecff237470927e1f041..51f9f16ed734424ff10672a04f2ec16=
6dc63
> 7e0b 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -170,3 +170,4 @@ obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL)	+=3D spi-slave=
-
> system-control.o
> =C2=A0
> =C2=A0# SPI offload triggers
> =C2=A0obj-$(CONFIG_SPI_OFFLOAD_TRIGGER_PWM)	+=3D spi-offload-trigger-pwm.=
o
> +obj-$(CONFIG_SPI_OFFLOAD_TRIGGER_ADI_UTIL_SD) +=3D spi-offload-trigger-a=
di-
> util-sigma-delta.o
> diff --git a/drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c
> b/drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..8468c773713a3d203b2e668f340ee3f=
477b8
> fb6c
> --- /dev/null
> +++ b/drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Analog Devices Inc.
> + * Copyright (C) 2025 BayLibre, SAS
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/spi/offload/provider.h>
> +#include <linux/spi/offload/types.h>
> +#include <linux/types.h>
> +
> +static bool adi_util_sigma_delta_match(struct spi_offload_trigger *trigg=
er,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum spi_offload_trigger_type t=
ype,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 *args, u32 nargs)
> +{
> +	return type =3D=3D SPI_OFFLOAD_TRIGGER_DATA_READY && nargs =3D=3D 0;
> +}
> +
> +static const struct spi_offload_trigger_ops adi_util_sigma_delta_ops =3D=
 {
> +	.match =3D adi_util_sigma_delta_match,
> +};
> +
> +static int adi_util_sigma_delta_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct spi_offload_trigger_info info =3D {
> +		.fwnode =3D dev_fwnode(dev),
> +		.ops =3D &adi_util_sigma_delta_ops,
> +	};
> +	struct clk *clk;
> +
> +	clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get
> clock\n");
> +

Small nit. Did you consider enabling/disabling the clock on the trigger
enable()/disable() callback? I guess the ref clk will be enabled anyways by
someone else but conceptually kind of makes sense to enable the resource on=
ly
when needed.

Not a big deal (at least to me).

- Nuno S=C3=A1

> +	return devm_spi_offload_trigger_register(dev, &info);
> +}
> +
> +static const struct of_device_id adi_util_sigma_delta_of_match_table[] =
=3D {
> +	{ .compatible =3D "adi,util-sigma-delta-spi", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adi_util_sigma_delta_of_match_table);
> +
> +static struct platform_driver adi_util_sigma_delta_driver =3D {
> +	.probe=C2=A0 =3D adi_util_sigma_delta_probe,
> +	.driver =3D {
> +		.name =3D "adi-util-sigma-delta-spi",
> +		.of_match_table =3D adi_util_sigma_delta_of_match_table,
> +	},
> +};
> +module_platform_driver(adi_util_sigma_delta_driver);
> +
> +MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
> +MODULE_DESCRIPTION("ADI Sigma-Delta SPI offload trigger utility driver")=
;
> +MODULE_LICENSE("GPL");

