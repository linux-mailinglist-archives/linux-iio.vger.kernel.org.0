Return-Path: <linux-iio+bounces-6997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E573391B9EF
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 10:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8A11F243C3
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 08:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23AA14E2D7;
	Fri, 28 Jun 2024 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugej0Z7M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0790D1494A6;
	Fri, 28 Jun 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563482; cv=none; b=FQyPKV5okMR/l5sTFLkj4idNBUZlRdZ2IMgX9fLskwxAO3t4FnVs99poKWNsx8bmLY8Wc1HbZfYKAsjo2R/goViWeizdjuKRe7fsLQzvPLsGG0DOk4XsSJC2AqnstPqwisiGWiEcqSGCi3guqyXzWpk2HDYoMJmK42UIP2b9qnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563482; c=relaxed/simple;
	bh=cHqJK3pKkDx/vmLte9na1kAtEw3Y7QGn0kaLe5oMqko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NWUmy3ZsdkYIQBWXn9jmc/pKznudbT9tASSU0ut2ZpC2ZxB5NOBMw7WrHZwK6g7fNTs9gNCC67M1+tt639VMSOl2r0PQ6fPZYU9g1EO8KbrdO7qRz0noFElM+KRlCg6+X9TK52ydcEdr5n2q8+GpJtv8AAHvtY8jonGK24ZFs5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ugej0Z7M; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso399193a12.2;
        Fri, 28 Jun 2024 01:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719563478; x=1720168278; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XxSxVA5sM6HD112hsMor5SLquD6NlUL0DGqR+Hyc+7k=;
        b=Ugej0Z7M3391sVvBPTXRvty+0ez667SVILtmrSyTAKXUCkECGGt/I2chJvB00CfOyW
         4Vsi4uYosiYXtYFPpnlDjU5Jo0XY+dyqsW+rcmerMCZy9/zV0UEkGByLHnrYX2iLjVzL
         CgAnge3TDwMm8AloD4THNYpoXTodgL8OKyIsmph6ibNBI0CuH9KX7aepx+7v2qJsmSRZ
         6At1rrVujTwWgNlSAePObx8uq9hqFH3DehGnELSWKGYkPTWVtPMcHUj6wHTwH81uRcVt
         WVAOX1yXbvflWdqN6B1SJTeiVTdbQAPCgolWsXFI1SLmnRJR8wrvyZCi4o2XK9l/FV49
         8WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719563478; x=1720168278;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxSxVA5sM6HD112hsMor5SLquD6NlUL0DGqR+Hyc+7k=;
        b=ndNHTe7o3hifwa5gmMBZ9buFpeBxikLEG7pGi4oD8qLSOET2RQ3jHPjEs4sdQOpCxg
         TtwYjRY3k/akbPO7GUu6a4jH9m5siPmei4IZ3OXWYpgMbGxcThJvMmcsBoXw5ksuqRzA
         pyXyGZjtDTbUtxsFOWxK6EOIKq5Bo+RqKVF7rvz1atETC0LNDueZ4Fi/A2os+CtEbS4k
         pr5Rrejsk/8VfwumGd6M0IvQPBW2DIAf9ZqRu2scij/TbZFk97SDzYPszsXEFGU7Or9q
         sQYdchYSpX+eCBaNMXlzdQuP4I/yPycpw16wis9nVHauAPgHteclaGdyfcJRJQpVs/Ze
         o8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnFyKeLV4MxumIVVUp7SFmhZcwejZ74z4rHtZotyVzpNqNuWVXCSSHQHLn5LwOdY60W+jIAK5xCwCP2OGOIMxTmOvRbG9/6e0EQWvSiPNYGCo2dBTd81EwOSTsAB6M13oPlbdvx8u09A==
X-Gm-Message-State: AOJu0YwfT/VbPjWPOq7kgpNG0B+oQIvFHa9s8WvZExswzab5RmRZjlaQ
	cxbdxFmScdihCVPhUssAccAqbzkiWDXZHqrvV8Qnd6UUn/Fa0Aw1
X-Google-Smtp-Source: AGHT+IFTmpUWaT70I6hso8QPh8W/lIaY/6+osH1FSTqcgVFZsvCEMPuixrlTB0q5qNCjom6J/aLL9Q==
X-Received: by 2002:a50:d503:0:b0:57d:3ea:3862 with SMTP id 4fb4d7f45d1cf-57d4bdbe7d0mr13597927a12.27.1719563477966;
        Fri, 28 Jun 2024 01:31:17 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c835b9sm684038a12.3.2024.06.28.01.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:31:17 -0700 (PDT)
Message-ID: <0036d44542f8cf45c91c867f0ddd7b45d1904d6b.camel@gmail.com>
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Esteban Blanc <eblanc@baylibre.com>, baylibre-upstreaming@groups.io, 
 Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
	 <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Date: Fri, 28 Jun 2024 10:35:08 +0200
In-Reply-To: <20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
	 <20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Esteban,

Main thing that I think we should clear and think about is how to expose th=
e
common mode voltage. I kind if agree with it being a single channel but I s=
till
have some concerns... See below.

On Thu, 2024-06-27 at 13:59 +0200, Esteban Blanc wrote:
> This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
>=20
> The driver implements basic support for the AD4030-24 1 channel
> differential ADC with hardware gain and offset control.
>=20
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 13 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4030.c | 822
> +++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 837 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8ca5b2e09b69..8df171c62d37 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -419,6 +419,7 @@ R:	Esteban Blanc <eblanc@baylibre.com>
> =C2=A0S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad4630.yaml
> +F:	drivers/iio/adc/ad4030.c
> =C2=A0
> =C2=A0AD5110 ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
> =C2=A0M:	Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 3d91015af6ea..e71ac1e49acb 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -21,6 +21,19 @@ config AD_SIGMA_DELTA
> =C2=A0	select IIO_BUFFER
> =C2=A0	select IIO_TRIGGERED_BUFFER
> =C2=A0
> +config AD4030
> +	tristate "Analog Device AD4630 ADC Driver"
> +	depends on SPI
> +	depends on GPIOLIB
> +	select REGMAP_SPI
> +	select IIO_BUFFER
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD4030 and AD46=
30
> high speed
> +	=C2=A0 SPI analog to digital converters (ADC).
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll
> be
> +	=C2=A0 called ad4030.
> +
> =C2=A0config AD4130
> =C2=A0	tristate "Analog Device AD4130 ADC Driver"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 37ac689a0209..7a8945559589 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -6,6 +6,7 @@
> =C2=A0# When adding new entries keep the list in alphabetical order
> =C2=A0obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
> =C2=A0obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> +obj-$(CONFIG_AD4030) +=3D ad4030.o
> =C2=A0obj-$(CONFIG_AD4130) +=3D ad4130.o
> =C2=A0obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
> =C2=A0obj-$(CONFIG_AD7091R5) +=3D ad7091r5.o
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> new file mode 100644
> index 000000000000..6d537e531d6f
> --- /dev/null
> +++ b/drivers/iio/adc/ad4030.c
> @@ -0,0 +1,822 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD4030 and AD4630 ADC family driver.
> + *
> + * Copyright 2024 Analog Devices, Inc.
> + * Copyright 2024 BayLibre, SAS
> + *
> + * based on code from:
> + *	Analog Devices, Inc.
> + *	=C2=A0 Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> + *	=C2=A0 Nuno Sa <nuno.sa@analog.com>
> + *	=C2=A0 Marcelo Schmitt <marcelo.schmitt@analog.com>
> + *	=C2=A0 Liviu Adace <liviu.adace@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/units.h>
> +#include <linux/clk.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define AD4030_REG_INTERFACE_CONFIG_A				0x00
> +#define=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_REG_INTERFACE_CONFIG_A_SW_RESET		=
(BIT(0) |
> BIT(7))
> +#define AD4030_REG_INTERFACE_CONFIG_B				0x01
> +#define AD4030_REG_DEVICE_CONFIG				0x02
> +#define AD4030_REG_CHIP_TYPE					0x03
> +#define AD4030_REG_PRODUCT_ID_L					0x04
> +#define AD4030_REG_PRODUCT_ID_H					0x05
> +#define AD4030_REG_CHIP_GRADE					0x06
> +#define=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_REG_CHIP_GRADE_AD4030_24_GRADE		0=
x10
> +#define=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE		G=
ENMASK(7, 3)
> +#define AD4030_REG_SCRATCH_PAD					0x0A
> +#define AD4030_REG_SPI_REVISION					0x0B
> +#define AD4030_REG_VENDOR_L					0x0C
> +#define AD4030_REG_VENDOR_H					0x0D
> +#define AD4030_REG_STREAM_MODE					0x0E
> +#define AD4030_REG_INTERFACE_CONFIG_C				0x10
> +#define AD4030_REG_INTERFACE_STATUS_A				0x11
> +#define AD4030_REG_EXIT_CFG_MODE				0x14
> +#define=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_REG_EXIT_CFG_MODE_MASK_EXIT_CONFI=
G_MD	BIT(0)
> +#define AD4030_REG_AVG						0x15
> +#define=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_REG_AVG_MASK_AVG_SYNC			BIT(7)
> +#define=C2=A0=C2=A0=C2=A0=C2=A0
> AD4030_REG_AVG_MASK_AVG_VAL				GENMASK(4, 0)
> +#define AD4030_REG_OFFSET_X0_0					0x16
> +#define AD4030_REG_OFFSET_X0_1					0x17
> +#define AD4030_REG_OFFSET_X0_2					0x18
> +#define AD4030_REG_OFFSET_X1_0					0x19
> +#define AD4030_REG_OFFSET_X1_1					0x1A
> +#define AD4030_REG_OFFSET_X1_2					0x1B
> +#define=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_REG_OFFSET_BYTES_NB				3
> +#define=C2=A0=C2=A0=C2=A0=C2=A0
> AD4030_REG_OFFSET_CHAN(ch)				(AD4030_REG_OFFSET_X0_2 +	\
> +								(AD4030_REG_O
> FFSET_BYTES_NB *	\
> +								(ch)))
> +#define AD4030_REG_GAIN_X0_LSB					0x1C
> +#define AD4030_REG_GAIN_X0_MSB					0x1D
> +#define AD4030_REG_GAIN_X1_LSB					0x1E
> +#define AD4030_REG_GAIN_X1_MSB					0x1F
> +#define=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_REG_GAIN_MAX_GAIN				1999970
> +#define=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_REG_GAIN_BYTES_NB				2
> +#define=C2=A0=C2=A0=C2=A0=C2=A0
> AD4030_REG_GAIN_CHAN(ch)				(AD4030_REG_GAIN_X0_MSB +	\
> +								(AD4030_REG_G
> AIN_BYTES_NB *	\
> +								(ch)))
> +#define AD4030_REG_MODES					0x20
> +#define=C2=A0=C2=A0=C2=A0=C2=A0
> AD4030_REG_MODES_MASK_OUT_DATA_MODE			GENMASK(2, 0)
> +#define=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_REG_MODES_MASK_LANE_MODE			GENMAS=
K(7, 6)
> +#define AD4030_REG_OSCILATOR					0x21
> +#define AD4030_REG_IO						0x22
> +#define=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_REG_IO_MASK_IO2X				BIT(1)
> +#define AD4030_REG_PAT0						0x23
> +#define AD4030_REG_PAT1						0x24
> +#define AD4030_REG_PAT2						0x25
> +#define AD4030_REG_PAT3						0x26
> +#define AD4030_REG_DIG_DIAG					0x34
> +#define AD4030_REG_DIG_ERR					0x35
> +
> +/* Sequence starting with "1 0 1" to enable reg access */
> +#define AD4030_REG_ACCESS		0xa0
> +
> +#define AD4030_MAX_DIFF_CHANNEL_NB	2
> +#define AD4030_MAX_COMMON_CHANNEL_NB	AD4030_MAX_DIFF_CHANNEL_NB
> +#define AD4030_MAX_TIMESTAMP_CHANNEL_NB	1
> +#define AD4030_ALL_CHANNELS_NB		(AD4030_MAX_DIFF_CHANNEL_NB +	\
> +					AD4030_MAX_COMMON_CHANNEL_NB +	\
> +					AD4030_MAX_TIMESTAMP_CHANNEL_NB)
> +#define AD4030_VREF_MIN_UV		(4096 * MILLI)
> +#define AD4030_VREF_MAX_UV		(5000 * MILLI)
> +#define AD4030_VIO_THRESHOLD_UV		(1400 * MILLI)
> +
> +#define AD4030_SPI_MAX_XFER_LEN		8
> +#define AD4030_SPI_MAX_REG_XFER_SPEED	(80 * MEGA)
> +#define AD4030_TCNVH_NS			10
> +#define AD4030_TCNVL_NS			20
> +#define AD4030_TCONV_NS			(300 - (AD4030_TCNVH_NS
> +	\
> +					AD4030_TCNVL_NS))
> +#define AD4030_TRESET_PW_NS		50
> +#define AD4030_TRESET_COM_DELAY_MS	750
> +
> +enum ad4030_out_mode {
> +	AD4030_OUT_DATA_MD_16_DIFF =3D 0x00,
> +	AD4030_OUT_DATA_MD_24_DIFF =3D 0x00,
> +	AD4030_OUT_DATA_MD_16_DIFF_8_COM =3D 0x01,
> +	AD4030_OUT_DATA_MD_24_DIFF_8_COM =3D 0x02,
> +	AD4030_OUT_DATA_MD_30_AVERAGED_DIFF =3D 0x03,
> +	AD4030_OUT_DATA_MD_32_PATTERN =3D 0x04
> +};
> +
> +struct ad4030_chip_info {
> +	const char *name;
> +	const unsigned long *available_masks;
> +	unsigned int available_masks_len;
> +	const struct iio_chan_spec channels[AD4030_ALL_CHANNELS_NB];
> +	u8 grade;
> +	u8 precision_bits;
> +	int num_channels;
> +};
> +
> +struct ad4030_state {
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	const struct ad4030_chip_info *chip;
> +	struct gpio_desc *cnv_gpio;
> +	int vref_uv;
> +	int vio_uv;
> +	int min_offset;
> +	int max_offset;
> +	int offset_avail[3];
> +	u32 conversion_speed_hz;
> +	enum ad4030_out_mode mode;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the transfer
> buffers
> +	 * to live in their own cache lines.
> +	 */
> +	u8 tx_data[AD4030_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
> +	struct {
> +		union {
> +			/*
> +			 * Make the buffer large enough for MAX_NUM_CHANNELS
> 32-bit samples and
> +			 * one 64-bit aligned 64-bit timestamp.
> +			 */
> +			u8 raw[ALIGN(AD4030_MAX_DIFF_CHANNEL_NB * sizeof(u32)
> +
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_MAX_COMMON_CHANNEL_NB * s=
izeof(u8),
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(u64)) + sizeof(u64)];

This is not very readable. I would make this simpler.

> +			struct {
> +				s32 val[AD4030_MAX_DIFF_CHANNEL_NB];
> +				u8 common[AD4030_MAX_COMMON_CHANNEL_NB];

Not sure common makes sense as it comes aggregated with the sample. Maybe t=
his
could as simple as:

struct {
	s32 val;
	u64 timestamp __aligned(8);
} rx_data ...

> +			};
> +		};
> +	} rx_data __aligned(IIO_DMA_MINALIGN);
> +};
> +
> +#define AD4030_CHAN_CMO(_idx)=C2=A0 {					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +	.type =3D IIO_VOLTAGE,						\
> +	.indexed =3D 1,							\
> +	.channel =3D _idx,						\
> +	.scan_index =3D _idx,						\
> +	.scan_type =3D {							\
> +		.sign =3D 'u',						\
> +		.storagebits =3D 8,					\
> +		.realbits =3D 8,						\
> +		.endianness =3D IIO_BE,					\
> +	},								\
> +}
> +

So, from the datasheet, figure 39 we have something like a multiplexer wher=
e we
can have:

- averaged data;
- normal differential;
- test pattern (btw, useful to have it in debugfs - but can come later);
- 8 common mode bits;

While the average, normal and test pattern are really mutual exclusive, the
common mode voltage is different in the way that it's appended to different=
ial
sample. Making it kind of an aggregated thingy. Thus I guess it can make se=
nse
for us to see them as different channels from a SW perspective (even more s=
ince
gain and offset only apply to the differential data). But there are a coupl=
e of
things I don't like (have concerns):

* You're pushing the CM channels into the end. So when we a 2 channel devic=
e
we'll have:

 in_voltage0 - diff
 in_voltage1 - diff
 in_voltage2 - CM associated with chan0
 in_voltage0 - CM associated with chan1

I think we could make it so the CM channel comes right after the channel wh=
ere
it's data belongs too. So for example, odd channels would be CM channels (a=
nd
labels could also make sense).

Other thing that came to mind is if we could somehow use differential =3D t=
rue
here. Having something like:

in_voltage1_in_voltage0_raw - diff data
...
And the only thing for CM would be:

in_voltage1_raw
in_voltage1_scale

(not sure if the above is doable with ext_info - maybe only with device_att=
rs)

The downside of the above is that we don't have a way to separate the scan
elements. Meaning that we don't have a way to specify the scan_type for bot=
h the
common mode and differential voltage. That said, I wonder if it is that use=
ful
to buffer the common mode stuff? Alternatively, we could just have the scan=
_type
for the diff data and apps really wanting the CM voltage could still access=
 the
raw data. Not pretty, I know...

However, even if we go with the two separate channels there's one thing tha=
t
concerns me. Right now we have diff data with 32 for storage bits and CM da=
ta
with 8 storage bits which means the sample will be 40 bits and in reality w=
e
just have 32. Sure, now we have SW buffering so we can make it work but the
ultimate goal is to support HW buffering where we won't be able to touch th=
e
sample and thus we can't lie about the sample size. Could you run any test =
with
this approach on a HW buffer setup?=20

I did not gave too much thought on it but I'm not sure there's a sane way t=
o
have multiple scan_types associated with the same channel.=20

...

> +#define AD4030_CHAN_IN(_idx, _storage, _real, _shift)
> {			\
>=20
> +
> +static int ad4030_get_chan_gain(struct iio_dev *indio_dev, int ch, int *=
val,
> +				int *val2)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	u16 gain;
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(st->regmap, AD4030_REG_GAIN_CHAN(ch), &gain,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_REG_GAIN_BYTES_NB);

Even though it's just 2 bytes, Jonathan typically has a strict policy regar=
ding
this not being DMA safe.

> +	if (ret)
> +		return ret;
> +
> +	gain =3D be16_to_cpu(gain);
> +
> +	/* From datasheet: multiplied output =3D input =C3=97 gain word/0x8000 =
*/
> +	*val =3D gain / 0x8000;
> +	*val2 =3D mul_u64_u32_div(gain % 0x8000, MICRO, 0x8000);
> +
> +	return 0;
> +}
> +
> +/*
> + * @brief Returns the offset where 1 LSB =3D (VREF/2^precision_bits - 1)=
/gain
> + */
> +static int ad4030_get_chan_offset(struct iio_dev *indio_dev, int ch, int
> *val)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	__be32 offset;

ditto...

> +	int ret;
> +
> +	ret =3D regmap_bulk_read(st->regmap, AD4030_REG_OFFSET_CHAN(ch),
> &offset,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_REG_OFFSET_BYTES_NB);
> +	if (ret)
> +		return ret;
> +
> +	if (st->chip->precision_bits =3D=3D 16)
> +		offset <<=3D 16;
> +	else
> +		offset <<=3D 8;
> +
> +	*val =3D be32_to_cpu(offset);
> +
> +	return 0;
> +}
> +
> +static int ad4030_set_chan_gain(struct iio_dev *indio_dev, int ch, int
> gain_int,
> +				int gain_frac)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	__be16 val;
> +	u64 gain;
> +
> +	gain =3D mul_u32_u32(gain_int, MICRO) + gain_frac;
> +
> +	if (gain > AD4030_REG_GAIN_MAX_GAIN)
> +		return -EINVAL;
> +
> +	val =3D cpu_to_be16(DIV_ROUND_CLOSEST_ULL(gain * 0x8000, MICRO));
> +
> +	return regmap_bulk_write(st->regmap, AD4030_REG_GAIN_CHAN(ch), &val,
> +			=C2=A0 AD4030_REG_GAIN_BYTES_NB);

ditto

> +}
> +
> +static int ad4030_set_chan_offset(struct iio_dev *indio_dev, int ch, int
> offset)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	__be32 val;
> +
> +	if (offset < st->min_offset || offset > st->max_offset)
> +		return -EINVAL;
> +
> +	val =3D cpu_to_be32(offset);
> +	if (st->chip->precision_bits =3D=3D 16)
> +		val >>=3D 16;
> +	else
> +		val >>=3D 8;
> +
> +	return regmap_bulk_write(st->regmap, AD4030_REG_OFFSET_CHAN(ch),
> &val, 3);

...

> +}
> +
> +static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
> +					unsigned int mask)
> +{
> +	return mask & BIT(st->chip->num_channels);
> +}
> +
> +static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask=
)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +
> +	if (ad4030_is_common_byte_asked(st, mask))
> +		st->mode =3D st->chip->precision_bits =3D=3D 24 ?
> +			AD4030_OUT_DATA_MD_24_DIFF_8_COM :
> +			AD4030_OUT_DATA_MD_16_DIFF_8_COM;

At this point you still don't really have AD4030_OUT_DATA_MD_16_DIFF_8_COM
support so I would keep it simple until you need to support it.

> +	else
> +		st->mode =3D AD4030_OUT_DATA_MD_24_DIFF;
> +
> +	return regmap_update_bits(st->regmap, AD4030_REG_MODES,
> +				AD4030_REG_MODES_MASK_OUT_DATA_MODE,
> +				st->mode);
> +}
> +
> +static int ad4030_conversion(struct ad4030_state *st, const struct
> iio_chan_spec *chan)
> +{
> +	unsigned int bytes_to_read =3D (BITS_TO_BYTES(chan->scan_type.realbits)
> +
> +			=C2=A0=C2=A0=C2=A0=C2=A0 ((st->mode =3D=3D AD4030_OUT_DATA_MD_24_DIFF=
_8_COM
> ||
> +			=C2=A0=C2=A0=C2=A0=C2=A0 st->mode =3D=3D AD4030_OUT_DATA_MD_16_DIFF_8=
_COM) ?
> 1 : 0)) *
> +			=C2=A0=C2=A0=C2=A0=C2=A0 st->chip->num_channels;
> +	struct spi_transfer xfer =3D {
> +		.rx_buf =3D st->rx_data.raw,
> +		.len =3D bytes_to_read,
> +	};
> +	unsigned char byte_index;
> +	unsigned int i;
> +	int ret;
> +
> +	gpiod_set_value_cansleep(st->cnv_gpio, 1);
> +	ndelay(AD4030_TCNVH_NS);
> +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> +	ndelay(AD4030_TCNVL_NS + AD4030_TCONV_NS);
> +
> +	ret =3D spi_sync_transfer(st->spi, &xfer, 1);
> +	if (ret || (st->mode !=3D AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
> +		=C2=A0=C2=A0=C2=A0 st->mode !=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM))

You should guarantee that st->mode is not invalid...

> +		return ret;
> +
> +	byte_index =3D st->chip->precision_bits =3D=3D 16 ? 3 : 4;
> +	for (i =3D 0; i < st->chip->num_channels; i++)

So even for a single channel conversion we are going through all?

> +		st->rx_data.common[i] =3D ((u8 *)&st-
> >rx_data.val[i])[byte_index];
> +
> +	return 0;
> +}
> +
> +static int ad4030_single_conversion(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan, int
> *val)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D ad4030_set_mode(indio_dev, BIT(chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4030_exit_config_mode(st);
> +	if (ret)
> +		goto out_error;
> +
> +	ret =3D ad4030_conversion(st, chan);
> +	if (ret)
> +		goto out_error;
> +
> +	if (chan->channel < st->chip->num_channels)
> +		*val =3D st->rx_data.val[chan->channel];
> +	else
> +		*val =3D st->rx_data.common[chan->channel - st->chip-
> >num_channels];
> +
> +out_error:
> +	ad4030_enter_config_mode(st);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static irqreturn_t ad4030_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D ad4030_conversion(st, indio_dev->channels);
> +	if (ret)
> +		goto out;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_data.raw,
> +					=C2=A0=C2=A0 pf->timestamp);
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const int *ad4030_get_offset_avail(struct ad4030_state *st)
> +{
> +	return st->offset_avail;
> +}
> +
> +static const int ad4030_gain_avail[3][2] =3D {
> +	{0, 0},
> +	{0, 30},
> +	{1, 999969},
> +};
> +
> +static int ad4030_read_avail(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *channel,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const int **vals, int *type,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int *length, long mask)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*vals =3D ad4030_get_offset_avail(st);
> +		*type =3D IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*vals =3D (void *)ad4030_gain_avail;
> +		*type =3D IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_RANGE;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4030_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *val,
> +			=C2=A0=C2=A0 int *val2, long info)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {

Oh this is not neat :(. I guess there's still no work to make conditional g=
uards
to look more as the typical pattern...


> +		switch (info) {
> +		case IIO_CHAN_INFO_RAW:
> +			return ad4030_single_conversion(indio_dev, chan,
> val);
> +
> +		case IIO_CHAN_INFO_SCALE:
> +			*val =3D (st->vref_uv * 2) / MILLI;
> +			*val2 =3D st->chip->precision_bits;
> +			return IIO_VAL_FRACTIONAL_LOG2;

I don't think this applies to CM?

...

>=20
> +static int ad4030_detect_chip_info(const struct ad4030_state *st)
> +{
> +	unsigned int grade;
> +	int ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4030_REG_CHIP_GRADE, &grade);
> +	if (ret)
> +		return ret;
> +
> +	grade =3D FIELD_GET(AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE, grade);
> +	if (grade !=3D st->chip->grade)
> +		return dev_err_probe(&st->spi->dev, -EINVAL,
> +				"Unknown grade(%u) for %s\n", grade,
> +				st->chip->name);

I think in here we still want to proceed and just print a warning...

- Nuno S=C3=A1


