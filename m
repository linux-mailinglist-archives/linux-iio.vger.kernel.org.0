Return-Path: <linux-iio+bounces-19937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 639D7AC3DBF
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 12:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5BB1894137
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 10:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A691F4631;
	Mon, 26 May 2025 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYDJuGRY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02A1E5B7D;
	Mon, 26 May 2025 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748254878; cv=none; b=flfHq5SafFbGZd3rSOaJnDw0GDENmkgv3cwXEMu5HEx+Ka/sAGRWSYph3RorBB4Wc7HePpaVIycfM4kaIDGOItt8BD8zeTYyCqLfxPQtX/Y6DmgAWMah2JmMLmJdNlhGBM0EA0S8sGXkNnEovXCAhiLjJvewnWwsLUvagCSwddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748254878; c=relaxed/simple;
	bh=p2gK8iwaWKY6guqBl2DKOLD8mONcUKHwX183TyfcQG8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gxwonZnzHWCFqqQxsT0kR0c2KREt9k5rnBobX86cuqOXo0QNktPaHc/dFpIw10o7ADGZUICkML5MMuOT0B8hGF/WwjJlv678aevxxTNMoYZo+o8fuK5oFhS6njLIYgTWKuNNOE1Th1RZZ9aYFpQQwlDZIUGexHZKjhgAMeZOAzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYDJuGRY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a36e090102so1138549f8f.2;
        Mon, 26 May 2025 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748254875; x=1748859675; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yDvvEg63RaMwETBjnBaEEie893D+QP16pmtX1cgvqSo=;
        b=PYDJuGRYBdIId1ghEWL9YYBuvRJtCuhWBG7Whkusx8MMe4BYHYCmcNseUTaUjjGqfd
         iTQJ3LVpHusHBeru3ONIOs/kPJuVLRKUZzluHVzw9HV2uswALAJWTpSahv1J3+B99NdI
         by/1AHWDUuyq2pk6xt4Vb7BFhkIB1Z+xARvo7t/Gcg5FnZZR4RHi3BFREABUDxcACCGC
         G35A15F4rYg7flLj5ZcMNw3Id682u3C/8N9ikzyj8hNT+ntmOsi2M0xrX8UApUi5O8bO
         rTBvUClWapHI5uA98O3FTHspoq7TYFH8Nxwp6U9zZxcBOHOyLlAmmVmI9zDcNNkIs4b9
         RCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748254875; x=1748859675;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDvvEg63RaMwETBjnBaEEie893D+QP16pmtX1cgvqSo=;
        b=OIxg6P9NvwcGvGoYbOJnHbobgIVKjy0blo6fICcwNDuoVrFa5sCVhcaiAqASVi0dBG
         ocyOX0dETa/SVtmole+3Sr88SI0df/2Gf1be0NFotsCCdaFgNvci92FESRB02Tj2pg2Y
         77OXzMWcSNCnsExP3AeQNXLPXzFd1f/2vUoS/3X88J8GWE2wNQ0c32IUoKcIHwUalH5f
         li7+gHBCHkXGYfXhbvdISZdwf6JwaU7QUqcb+F1PgJNrRtHcUxVQPF+dUXLxF7JbDUuC
         PeBqGY2otehOL6Fi2nQ57ki27sAFWOiwHw/mfjl5Z+TaZivEaJGfu9CQ3TzWBF14NAut
         3HLw==
X-Forwarded-Encrypted: i=1; AJvYcCUYg2ve/sE+VXQr4OO10INhhcbgxIrziTLVqFwt0W4ymjBQ2Ih5Qtjvm0iPUvyAj1gMuH+aMKKPE6Hw@vger.kernel.org, AJvYcCUfT/1qqkOWgIcjK6C50qoJ0LVxePTPVKCfbw4PN/6+q8QUi9MNonuStoqZOoz02HeXx3qzGGwykzF4RrVB@vger.kernel.org, AJvYcCVMhFwlZ4+P8905FoUaaqUn968QsyUttWmn/50LKaazHouPSz5ADXLGQMYdypWtPGqghb/rGwH4KFaH3w==@vger.kernel.org, AJvYcCVqpW569c5WXYo9Q6igfQiQreOtTSs/7yoMhsIPhKvJL5m/7VDRkKT13Ndzl4RVj1QRkpwviQhKAeM1@vger.kernel.org
X-Gm-Message-State: AOJu0Yydg7pKlR+qY1KZER+p8iqefYb79tjyl6ZcJhpDwHmnCjj16/aN
	2T3EZHan5UgGeGCjpamxsB9mTN+loOII/JJrgPeyMG42Vl7AcwcNmdXjdwkGxa1tSc0=
X-Gm-Gg: ASbGncuYDG2KsEDk9kYhCPGca2VDTRfLwGAjaj4ou+jNukCMuiWIwlTJADDhwFqicf0
	vUsilRZ+WQqGE4U3OtGdEoA5SyoE9PqZy2w6eBMW/O6lhzHEBe80N//FHwM8bTRvIBPs5i1Ih4S
	Z2tWl3dD9GLqKtvJkyByRK+vSm5NJfNZvFw5kpCxkpSIHjqE6uXUcEH4PtY0+3FEpJvy0aIN5vq
	yeRiEUh+yU50eBLmK1wDlhQbzrRqC0p8C8LkMOxnMU4fj2DV2+VGnyNAfKyZGwG41NTtoJREx10
	ej+IwYh2P0yo5A5/1DuaF9//81J6g47PjNjMP2/WGBHEXr/xeWXntjhc
X-Google-Smtp-Source: AGHT+IHHLdzyh4ldfuqGdkWQ/KWMg/H/cJzxp87GB8pPL8XIM8U+WILu9uXeT2fI6lvKnnSp6kwH1g==
X-Received: by 2002:a05:6000:238a:b0:3a4:d367:c5aa with SMTP id ffacd0b85a97d-3a4d367c798mr4265259f8f.20.1748254874308;
        Mon, 26 May 2025 03:21:14 -0700 (PDT)
Received: from [100.73.1.233] ([185.128.9.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f23c080asm239676925e9.22.2025.05.26.03.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:21:13 -0700 (PDT)
Message-ID: <a1fc70b489cc6396200cb777795183f42ed31719.camel@gmail.com>
Subject: Re: [PATCH v3 02/10] iio: adc: Add basic support for AD4170
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org, 
	lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	marcelo.schmitt1@gmail.com
Date: Mon, 26 May 2025 11:21:17 +0100
In-Reply-To: <2c308bf8464660079ec6da82a62316e9f2ebd5f7.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
	 <2c308bf8464660079ec6da82a62316e9f2ebd5f7.1747083143.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 09:34 -0300, Marcelo Schmitt wrote:
> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
>=20
> The AD4170 is a multichannel, low noise, 24-bit precision sigma-delta
> analog to digital converter. The AD4170 design offers a flexible data
> aquisition solution with crosspoint multiplexed analog inputs, configurab=
le
> ADC voltage reference inputs, ultra-low noise integrated PGA, digital
> filtering, wide range of configurable output data rates, internal
> oscillator and temperature sensor, four GPIOs, and integrated features fo=
r
> interfacing with load cell weigh scales, RTD, and thermocouple sensors.
>=20
> Add basic support for the AD4170 ADC with the following features:
> - Single-shot read.
> - Analog front end PGA configuration.
> - Differential and pseudo-differential input configuration.
>=20
> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Looks very good. Just some small notes...

> Change log v2 -> v3
> - Updated Copyright year.
> - Separated handling of channel setup cases for better understanding of c=
ode
> flow.
> - Now comparing setups field by field instead of using memcmp().
> - Disable channel on ad4170_read_sample() error path.
> - Reinit completion before entering single conversion mode.
> - Organized ad4170_sinc3_filt_fs_tbl.
> - Used clamp to simplify configuration value checking.
> - Returned earlier whenever possible.
> - Used HZ_PER_KHZ/MHZ.
> - Declared internal voltage reference constant AD4170_INT_REF_2_5V
> - Many other minor code style and readability improvements.
>=20
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 12 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4170.c | 1553 +++++++++++++++++++++++++++++++++++=
+++
> =C2=A04 files changed, 1567 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/ad4170.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a8f2c7a139c..541e37ed304e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1352,6 +1352,7 @@ L:	linux-iio@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> +F:	drivers/iio/adc/ad4170.c
> =C2=A0
> =C2=A0ANALOG DEVICES INC AD4695 DRIVER
> =C2=A0M:	Michael Hennerich <michael.hennerich@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 0fe6601e59ed..594b9f55ec0a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -70,6 +70,18 @@ config AD4130
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le will
> be
> =C2=A0	=C2=A0 called ad4130.
> =C2=A0
> +
> +config AD4170
> +	tristate "Analog Device AD4170 ADC Driver"
> +	depends on SPI
> +	select REGMAP_SPI
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD4170 SPI anal=
og
> +	=C2=A0 to digital converters (ADC).
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll
> be
> +	=C2=A0 called ad4170.
> +
> =C2=A0config AD4695
> =C2=A0	tristate "Analog Device AD4695 ADC Driver"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 07d4b832c42e..d3a1376d1f96 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> =C2=A0obj-$(CONFIG_AD4000) +=3D ad4000.o
> =C2=A0obj-$(CONFIG_AD4030) +=3D ad4030.o
> =C2=A0obj-$(CONFIG_AD4130) +=3D ad4130.o
> +obj-$(CONFIG_AD4170) +=3D ad4170.o
> =C2=A0obj-$(CONFIG_AD4695) +=3D ad4695.o
> =C2=A0obj-$(CONFIG_AD4851) +=3D ad4851.o
> =C2=A0obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> new file mode 100644
> index 000000000000..bf19b31095ee
> --- /dev/null
> +++ b/drivers/iio/adc/ad4170.c
> @@ -0,0 +1,1553 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2025 Analog Devices, Inc.
> + * Author: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> + * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +#include <linux/util_macros.h>
>=20

...

> +
> +static int ad4170_debugfs_reg_access(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg, unsigned int writeval,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *readval)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +	else
> +		return regmap_write(st->regmap, reg, writeval);

redundant else

...

>=20
> +
> +/*
> + * Sets the ADC operating mode. Supported modes are
> + * - Single conversion mode
> + * - Idle mode
> + */
> +static int ad4170_set_mode(struct ad4170_state *st, unsigned int mode)
> +{
> +	return regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
> +				=C2=A0 AD4170_ADC_CTRL_MODE_MSK,
> +				=C2=A0 FIELD_PREP(AD4170_ADC_CTRL_MODE_MSK,
> mode));
> +}

I'm usually not a fan of these wrappers.

...

>=20
> +
> +static int ad4170_parse_firmware(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &st->spi->dev;
> +	int reg_data, ret;
> +	unsigned int i;
> +
> +	st->mclk_hz =3D AD4170_INT_CLOCK_16MHZ;
> +
> +	for (i =3D 0; i < AD4170_NUM_ANALOG_PINS; i++)
> +		st->pins_fn[i] =3D AD4170_PIN_UNASIGNED;

Isn't the above the default already?


- Nuno S=C3=A1

