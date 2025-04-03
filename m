Return-Path: <linux-iio+bounces-17592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC54CA7A1E9
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 13:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2373AF6B9
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D67B24BD0C;
	Thu,  3 Apr 2025 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5jvOCUU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC24245037;
	Thu,  3 Apr 2025 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743679880; cv=none; b=C0AORasceANSsokp6mso4VPUR89MmnO0B4JE1S6GsMfhGtHNpcvMD3cic2xA99mWTQceqara1VumB1VKADvvaH2/J+Qz/RxoyLZPtoiuXq7kgeOYaXVNF9w4S0QMm/6qxYLz/qukTAgYZ0h+OHd7QomqgqeyPByrJUTHm6qYXlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743679880; c=relaxed/simple;
	bh=IWZEo3dZZCLrWe4ejhzdcEWNefowF1qQprRke5qovvI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WrXSidGjc24GLlbC06ttORX/RGDz19pQZEY9iONgT2t1knIWh7KBDhoAa+krdxayo4ZKiJfwuPDMg4fOuf4tnwQKGvgeDMxJHFLN5D1zaGYmayCXg9LviiXkn8MH+cNMatlzYisgamVvLiGxqppWrpSUYFJ0IBt/LUrAc1pOkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5jvOCUU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso5165245e9.1;
        Thu, 03 Apr 2025 04:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743679873; x=1744284673; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uEM6j6vU1OGCFDXxCLtGzyuhWBChSMAVnHaV/JJ1PMs=;
        b=E5jvOCUUxhimjDlTcx8A+x9MqUqQJTjy6CrLIXCBPtUbYmbQC2c0oyEEjA3lHaFkpl
         ZVdNelp0SOccaHCELMOa8v+Mz38WA/pTNTVgQScP/vuVfn8jo7pSpB14I5ksKfr5AzpH
         SW58PS1D9RTuAmBrMNV82MZj0o8Kjg545ertnVmfuo8wQMqv1/dsym55J8jiXF17Dusl
         opalCeFmAQZsvcIeOUA8tXl8clDO8TnVI0kqMAdl7uBcKj4zFl8Bip10mYB1QLf/BtWz
         XNDeyHNfvUaSeulmfhZae79JlUICMSdltubNVmHvk9aCJN58WcMYkVjDXYMC2YSkxVnu
         UICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743679873; x=1744284673;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEM6j6vU1OGCFDXxCLtGzyuhWBChSMAVnHaV/JJ1PMs=;
        b=Org33ZYOyQkMwVJe6pSu4iARl3/1smXY2O05dkpTtazc+gu2xodB6uKZO/nOGYl0H3
         VjB1mxhyc75YtiPq2ZQsp5tPyLMY3O7niOePXOU+gcaiUmEUlIz2+PvdhMeNy/AK/2fA
         ylQ36RQeIs3QsuuNggIr2UGj7Mqn5UEDlmVkWRqHclmAvzUkuYxVdMo1fy5Za+EtqBwB
         PC9bYIWVzHlP+rsfoj317Nzso5/FH0Ud1budmYeBgihGFjcCq5qBNZsn6Nn7iNnqE5i2
         DLAhpnMr1b5IVMVw6E1kPYvQ3ByTFPRmax12vTeGq3vb0Se2sS2h2Mo4/O2GMwn36R4L
         khKg==
X-Forwarded-Encrypted: i=1; AJvYcCUjp8WsmgwBwVy7uTlVsOG8sycnJXXBQbiyt3pDfScSzppv44cPwULTI01yJH1sUkWUa1HuHt34ks8c@vger.kernel.org, AJvYcCXQflQYk8lgoonelQQoICMra7w+IVBPmJSttzsVAGmBO7o/Pd8FeGGsPkaBBx6X4nTu2faQ/0lPe08fM5B5@vger.kernel.org
X-Gm-Message-State: AOJu0YxSEJJadI3N+NKdZxwpUi2TAKl/ExIVkfQzw6nxRMio3HzB4Uzl
	8uey6kmOj5qvaHOrBYQbJ9YIWPW54z3Uq4TNTDSyvgSpUpDl/X/L
X-Gm-Gg: ASbGncvvIUvfFqOZhBpYAp8g6MFgSCH692aceN/Rk6SkJKOobZGMs4jAlEwjYXv8/Yq
	YvpW8VHRFg85MDWNQsw0wsQ4mqMp7ecbV+JGg9Yy3v2yphDplfTOHrkjexiH7Iz5fhhmKeLfoec
	Ksw7IWo2iNTh/9OB2W3iDRCr0UUOgdS4q8JZ4McjxjFoteUAmQ9ehRTVqEJbsvcX7pEutQPzKV1
	SxrgdTq27YuByoUGfIMdRkqBFIiZRqER/ka9ryFHZRbys58iQruDNDayzlGp7lq3U3nyz9fxSEO
	8y4nFaVyXn1ADRy3tThSG1xnj19Mx//OtlVuDFylDHIOAsBbv+gWKsDv/UeeVmITsEwxNRotrnm
	0CyDKuHCOgPU8FX4G
X-Google-Smtp-Source: AGHT+IFuaMS8dOtow5Gv9FQ55z1SxFpiddL1Hvul1vcayfklxpFCWD0d7kj7VzjquBZnxBOsEInSeg==
X-Received: by 2002:a05:600c:3d9a:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-43ec14edf46mr20751645e9.22.1743679872706;
        Thu, 03 Apr 2025 04:31:12 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec3669d0fsm15861045e9.36.2025.04.03.04.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 04:31:12 -0700 (PDT)
Message-ID: <09c382682676e28c122118cca39c1e67ed842b0b.camel@gmail.com>
Subject: Re: [PATCH v3 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Kim Seer Paller <kimseer.paller@analog.com>, Jonathan Cameron	
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Thu, 03 Apr 2025 12:31:12 +0100
In-Reply-To: <20250403-togreg-v3-3-d4b06a4af5a9@analog.com>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
	 <20250403-togreg-v3-3-d4b06a4af5a9@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-03 at 13:33 +0800, Kim Seer Paller wrote:
> The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls, providing full-scale output spans of 2.5V or
> 5V for reference voltages of 2.5V. These devices operate from a single
> 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> variants include a 2.5V, 5ppm/=C2=B0C internal reference, which is disabl=
ed
> by default.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0 |=C2=A0 11 +
> =C2=A0drivers/iio/dac/Makefile=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/ad3530r.c | 514
> ++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 527 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index
> 9deaf2561ade5b1319cef3cb31b997a4297c0cff..6e64525fadd4ab5fea20279ce6b5cd8=
0ff4c
> 749c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1295,6 +1295,7 @@ L:	linux-iio@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
> +F:	drivers/iio/dac/ad3530r.c
> =C2=A0
> =C2=A0ANALOG DEVICES INC AD3552R DRIVER
> =C2=A0M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index
> 4811ea973125a0dea1f8a9cdee1e0c045bc21981..e0996dc014a3d538ab6b4e0d50ff54e=
de50f
> 1527 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -6,6 +6,17 @@
> =C2=A0
> =C2=A0menu "Digital to analog converters"
> =C2=A0
> +config AD3530R
> +	tristate "Analog Devices AD3530R and Similar DACs driver"
> +	depends on SPI
> +	select REGMAP_SPI
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD3530R, AD3531=
R
> +	=C2=A0 Digital to Analog Converter.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the
> +	=C2=A0 module will be called ad3530r.
> +
> =C2=A0config AD3552R_HS
> =C2=A0	tristate "Analog Devices AD3552R DAC High Speed driver"
> =C2=A0	select AD3552R_LIB
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index
> 8dd6cce81ed1152be4cf0af9ef877b5482ceb347..3684cd52b7fa9bc0ad9f855323dcbb2=
e4965
> c404 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -4,6 +4,7 @@
> =C2=A0#
> =C2=A0
> =C2=A0# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_AD3530R) +=3D ad3530r.o
> =C2=A0obj-$(CONFIG_AD3552R_HS) +=3D ad3552r-hs.o
> =C2=A0obj-$(CONFIG_AD3552R_LIB) +=3D ad3552r-common.o
> =C2=A0obj-$(CONFIG_AD3552R) +=3D ad3552r.o
> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..4b757e19f0c8349999f72e53abb1a4f=
483a4
> 4eb2
> --- /dev/null
> +++ b/drivers/iio/dac/ad3530r.c
> @@ -0,0 +1,514 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD3530R/AD3530 8-channel, 16-bit Voltage Output DAC Driver
> + * AD3531R/AD3531 4-channel, 16-bit Voltage Output DAC Driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#define AD3530R_INTERFACE_CONFIG_A		0x00
> +#define AD3530R_OUTPUT_OPERATING_MODE_0		0x20
> +#define AD3530R_OUTPUT_OPERATING_MODE_1		0x21
> +#define AD3530R_OUTPUT_CONTROL_0		0x2A
> +#define AD3530R_REFERENCE_CONTROL_0		0x3C
> +#define AD3530R_SW_LDAC_TRIG_A			0xE5
> +#define AD3530R_INPUT_CH(c)			(2 * (c) + 0xEB)
> +
> +#define AD3531R_SW_LDAC_TRIG_A			0xDD
> +#define AD3531R_INPUT_CH(c)			(2 * (c) + 0xE3)
> +
> +#define AD3530R_SW_LDAC_TRIG_MASK		BIT(7)
> +#define AD3530R_OUTPUT_CONTROL_MASK		BIT(2)
> +#define AD3530R_REFERENCE_CONTROL_MASK		BIT(0)
> +#define AD3530R_REG_VAL_MASK			GENMASK(15, 0)
> +
> +#define AD3530R_SW_RESET			(BIT(7) | BIT(0))
> +#define AD3530R_MAX_CHANNELS			8
> +#define AD3531R_MAX_CHANNELS			4
> +#define AD3530R_CH(c)				(c)
> +#define AD3530R_32KOHM_POWERDOWN_MODE		3
> +#define AD3530R_INTERNAL_VREF_MV		2500
> +#define AD3530R_LDAC_PULSE_US			100
> +
> +struct ad3530r_chan {
> +	unsigned int powerdown_mode;
> +	bool powerdown;
> +};
> +
> +struct ad3530r_chip_info {
> +	const char *name;
> +	const struct iio_chan_spec *channels;
> +	int (*input_ch_reg)(unsigned int c);
> +	const int iio_chan;
> +	unsigned int num_channels;
> +	unsigned int sw_ldac_trig_reg;
> +	bool internal_ref_support;
> +};
> +
> +struct ad3530r_state {
> +	struct regmap *regmap;
> +	/* lock to protect against multiple access to the device and shared
> data */
> +	struct mutex lock;
> +	struct ad3530r_chan chan[AD3530R_MAX_CHANNELS];
> +	const struct ad3530r_chip_info *chip_info;
> +	struct gpio_desc *ldac_gpio;
> +	int vref_mv;
> +	u8 ldac;
> +	bool range_multiplier;
> +};
> +
> +static int ad3530r_input_ch_reg(unsigned int c)
> +{
> +	return AD3530R_INPUT_CH(c);
> +}
> +
> +static int ad3531r_input_ch_reg(unsigned int c)
> +{
> +	return AD3531R_INPUT_CH(c);
> +}
> +
> +static const char * const ad3530r_powerdown_modes[] =3D {
> +	"1kohm_to_gnd",
> +	"7.7kohm_to_gnd",
> +	"32kohm_to_gnd",
> +};
> +
> +static int ad3530r_get_powerdown_mode(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan)
> +{
> +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +	return st->chan[chan->channel].powerdown_mode - 1;
> +}
> +
> +static int ad3530r_set_powerdown_mode(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mode)
> +{
> +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +	st->chan[chan->channel].powerdown_mode =3D mode + 1;
> +
> +	return 0;
> +}
> +
> +static const struct iio_enum ad3530r_powerdown_mode_enum =3D {
> +	.items =3D ad3530r_powerdown_modes,
> +	.num_items =3D ARRAY_SIZE(ad3530r_powerdown_modes),
> +	.get =3D ad3530r_get_powerdown_mode,
> +	.set =3D ad3530r_set_powerdown_mode,
> +};
> +
> +static ssize_t ad3530r_get_dac_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 char *buf)
> +{
> +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +	return sysfs_emit(buf, "%d\n", st->chan[chan->channel].powerdown);
> +}
> +
> +static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 const char *buf, size_t len)
> +{
> +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +	unsigned int mask, val;
> +	bool powerdown;
> +
> +	ret =3D kstrtobool(buf, &powerdown);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +	switch (chan->channel) {
> +	case AD3530R_CH(0) ... AD3530R_CH(AD3531R_MAX_CHANNELS - 1):
> +		mask =3D GENMASK(chan->channel * 2 + 1, chan->channel * 2);
> +		val =3D (powerdown ? st->chan[chan->channel].powerdown_mode :
> 0)
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 << (chan->channel * 2);
> +
> +		ret =3D regmap_update_bits(st->regmap,
> +					 AD3530R_OUTPUT_OPERATING_MODE_0,
> +					 mask, val);
> +		if (ret)
> +			return ret;
> +
> +		st->chan[chan->channel].powerdown =3D powerdown;
> +		return len;
> +	case AD3530R_CH(AD3531R_MAX_CHANNELS) ...
> +	=C2=A0=C2=A0=C2=A0=C2=A0 AD3530R_CH(AD3530R_MAX_CHANNELS - 1):
> +		mask =3D GENMASK((chan->channel - 4) * 2 + 1,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (chan->channel - 4) * 2);
> +		val =3D (powerdown ? st->chan[chan->channel].powerdown_mode :
> 0)
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 << ((chan->channel - 4) * 2);
> +
> +		ret =3D regmap_update_bits(st->regmap,
> +					 AD3530R_OUTPUT_OPERATING_MODE_1,
> +					 mask, val);
> +		if (ret)
> +			return ret;
> +
> +		st->chan[chan->channel].powerdown =3D powerdown;
> +		return len;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad3530r_trigger_hw_ldac(struct gpio_desc *ldac_gpio)
> +{
> +	gpiod_set_value_cansleep(ldac_gpio, 1);
> +	fsleep(AD3530R_LDAC_PULSE_US);
> +	gpiod_set_value_cansleep(ldac_gpio, 0);
> +
> +	return 0;
> +}
> +
> +static int ad3530r_dac_write(struct ad3530r_state *st, unsigned int chan=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val)
> +{
> +	int ret;
> +	__be16 reg_val;
> +
> +	guard(mutex)(&st->lock);
> +	reg_val =3D cpu_to_be16(val);
> +
> +	ret =3D regmap_bulk_write(st->regmap, st->chip_info-
> >input_ch_reg(chan),
> +				&reg_val, sizeof(reg_val));
> +	if (ret)
> +		return ret;
> +
> +	if (st->ldac_gpio)
> +		return ad3530r_trigger_hw_ldac(st->ldac_gpio);
> +
> +	return regmap_update_bits(st->regmap, st->chip_info-
> >sw_ldac_trig_reg,
> +				=C2=A0 AD3530R_SW_LDAC_TRIG_MASK,
> +				=C2=A0 FIELD_PREP(AD3530R_SW_LDAC_TRIG_MASK, 1));
> +}
> +
> +static int ad3530r_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int *val, int *val2, long info)
> +{
> +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +	__be16 reg_val;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D regmap_bulk_read(st->regmap,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->chip_info->input_ch_reg(cha=
n-
> >channel),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &reg_val, sizeof(reg_val));
> +		if (ret)
> +			return ret;
> +
> +		*val =3D FIELD_GET(AD3530R_REG_VAL_MASK, be16_to_cpu(reg_val));
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D st->vref_mv;
> +		*val2 =3D 16;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad3530r_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2, long info)
> +{
> +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val > U16_MAX)
> +			return -EINVAL;
> +
> +		return ad3530r_dac_write(st, chan->channel, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad3530r_reg_access(struct iio_dev *indio_dev, unsigned int re=
g,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int writeval, unsigned int *r=
eadval)
> +{
> +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +#define AD3530R_CHAN_EXT_INFO(_name, _what, _shared, _read, _write) {	\
> +	.name =3D (_name),						\
> +	.read =3D (_read),						\
> +	.write =3D (_write),						\
> +	.private =3D (_what),						\
> +	.shared =3D (_shared),						\
> +}
> +
> +static const struct iio_chan_spec_ext_info ad3530r_ext_info[] =3D {
> +	AD3530R_CHAN_EXT_INFO("powerdown", 0, IIO_SEPARATE,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad3530r_get_dac_powerdown,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad3530r_set_dac_powerdown),
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE,
> &ad3530r_powerdown_mode_enum),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> +			=C2=A0=C2=A0 &ad3530r_powerdown_mode_enum),
> +	{ },
> +};
> +
> +#define AD3530R_CHAN(_chan) {						\
> +	.type =3D IIO_VOLTAGE,						\
> +	.indexed =3D 1,							\
> +	.channel =3D _chan,						\
> +	.output =3D 1,							\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> BIT(IIO_CHAN_INFO_SCALE),			\
> +	.ext_info =3D ad3530r_ext_info,					\
> +}
> +
> +static const struct iio_chan_spec ad3530r_channels[] =3D {
> +	AD3530R_CHAN(0),
> +	AD3530R_CHAN(1),
> +	AD3530R_CHAN(2),
> +	AD3530R_CHAN(3),
> +	AD3530R_CHAN(4),
> +	AD3530R_CHAN(5),
> +	AD3530R_CHAN(6),
> +	AD3530R_CHAN(7),
> +};
> +
> +static const struct iio_chan_spec ad3531r_channels[] =3D {
> +	AD3530R_CHAN(0),
> +	AD3530R_CHAN(1),
> +	AD3530R_CHAN(2),
> +	AD3530R_CHAN(3),
> +};
> +
> +static const struct ad3530r_chip_info ad3530_chip =3D {
> +	.name =3D "ad3530",
> +	.channels =3D ad3530r_channels,
> +	.num_channels =3D ARRAY_SIZE(ad3530r_channels),
> +	.sw_ldac_trig_reg =3D AD3530R_SW_LDAC_TRIG_A,
> +	.input_ch_reg =3D ad3530r_input_ch_reg,
> +	.internal_ref_support =3D false,
> +};
> +
> +static const struct ad3530r_chip_info ad3530r_chip =3D {
> +	.name =3D "ad3530r",
> +	.channels =3D ad3530r_channels,
> +	.num_channels =3D ARRAY_SIZE(ad3530r_channels),
> +	.sw_ldac_trig_reg =3D AD3530R_SW_LDAC_TRIG_A,
> +	.input_ch_reg =3D ad3530r_input_ch_reg,
> +	.internal_ref_support =3D true,
> +};
> +
> +static const struct ad3530r_chip_info ad3531_chip =3D {
> +	.name =3D "ad3531",
> +	.channels =3D ad3531r_channels,
> +	.num_channels =3D ARRAY_SIZE(ad3531r_channels),
> +	.sw_ldac_trig_reg =3D AD3531R_SW_LDAC_TRIG_A,
> +	.input_ch_reg =3D ad3531r_input_ch_reg,
> +	.internal_ref_support =3D false,
> +};
> +
> +static const struct ad3530r_chip_info ad3531r_chip =3D {
> +	.name =3D "ad3531r",
> +	.channels =3D ad3531r_channels,
> +	.num_channels =3D ARRAY_SIZE(ad3531r_channels),
> +	.sw_ldac_trig_reg =3D AD3531R_SW_LDAC_TRIG_A,
> +	.input_ch_reg =3D ad3531r_input_ch_reg,
> +	.internal_ref_support =3D true,
> +};
> +
> +static int ad3530r_setup(struct ad3530r_state *st)
> +{
> +	const struct ad3530r_chip_info *chip_info =3D st->chip_info;
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct gpio_desc *reset_gpio;
> +	int i, ret;
> +
> +	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(reset_gpio),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get reset GPIO\n");
> +
> +	if (reset_gpio) {
> +		/* Perform hardware reset */
> +		fsleep(1000);
> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +	} else {
> +		/* Perform software reset */
> +		ret =3D regmap_update_bits(st->regmap,
> AD3530R_INTERFACE_CONFIG_A,
> +					 AD3530R_SW_RESET, AD3530R_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	fsleep(10000);
> +
> +	/* Set operating mode to normal operation. */
> +	ret =3D regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_0, 0);
> +	if (ret)
> +		return ret;
> +
> +	if (chip_info->num_channels > AD3531R_MAX_CHANNELS) {
> +		ret =3D regmap_write(st->regmap,
> AD3530R_OUTPUT_OPERATING_MODE_1, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i =3D 0; i < chip_info->num_channels; i++)
> +		st->chan[i].powerdown_mode =3D AD3530R_32KOHM_POWERDOWN_MODE;
> +
> +	st->ldac_gpio =3D devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->ldac_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get ldac GPIO\n");
> +
> +	if (device_property_present(dev, "adi,double-output-range")) {
> +		st->range_multiplier =3D true;
> +
> +		return regmap_update_bits(st->regmap,
> AD3530R_OUTPUT_CONTROL_0,
> +					=C2=A0 AD3530R_OUTPUT_CONTROL_MASK,
> +					=C2=A0
> FIELD_PREP(AD3530R_OUTPUT_CONTROL_MASK, 1));
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config ad3530r_regmap_config =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 8,
> +};
> +
> +static const struct iio_info ad3530r_info =3D {
> +	.read_raw =3D ad3530r_read_raw,
> +	.write_raw =3D ad3530r_write_raw,
> +	.debugfs_reg_access =3D &ad3530r_reg_access,
> +};

I'm not sure if this is what Jonathan had in mind but I think you need to
implement .fwnode_xlate(). Not given too much thought on this but likely yo=
u'll
need more than one argument in your cells since you need to specify the typ=
e of
the channel (voltage, current or temperature).

Moreover, if the consumer is asking for a voltage channel in the muxout pin=
 it
should be straightforward. But if it is temperature or current I would expe=
ct
that to be expressed in your read/write_raw() implementation? But this MUXO=
UT
thing is only about monitoring right? So write_raw() is not allowed...


- Nuno S=C3=A1

