Return-Path: <linux-iio+bounces-8695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2B795BF03
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 21:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B131F21F64
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 19:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601CD1D0498;
	Thu, 22 Aug 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hsNgr95A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B0E1474D3
	for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724355602; cv=none; b=tEmh8UN7+CS6+1VGR7lCvaMbPmL4Gsqx/Tga0A0Lunc97Ti90WNyqsXibVLJfNfBeELn6saQAoPKTpAQ4QdYsbaN1vzW3QCCWUek08YgUV55M0QpoTPjJzm8QwLjFl4UuxUzQdcRqN2snEfJ9U7lJWi7YGsZIKjFfteU1unUt+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724355602; c=relaxed/simple;
	bh=oqwtlcrGi1tb2mxP1Ngvoenostrr0CL7pB9E+02Ahyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azQUkRCRolENwRmiT7MA28Gb4S7mCHju+lmR92uK7kF98Isav+F6526rI85lLNwVQtAlQvbFVd0QMGG8jqNg7QTVw7SpxJJQ2gwEkdqcczbFCKySpHLjm9K+KOh34vUPut7oKY8wD18TAkM8Xeb9q36qb/iL8x+nBFn1m60/5PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hsNgr95A; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5de0e47b9so789239eaf.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724355597; x=1724960397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YS/a2XN/koxIPWF1pI8RLRI3ZpyHqhmNdBFZY8wVB4A=;
        b=hsNgr95Amf2/HCE9hM5YWzQY5zjBTwkKGHvZv32AZ+go0J7nlJgYRnDpy6sCEEWtjU
         u0lTrE7uREzbxC/zUljZ+lohE7mzvA2G9QyGngzT1A7ibCJgpe2vHWf99r/OYlojb0Lo
         g7Mt7EqiJV5lWeXKpk078c2T0GQPucCdjr3/TqTCzPijplcapENIGjmp45xkLvkCzVDe
         Tn/kE4tMclwfxpl+YruHhY9xX2+wGp7iXp/LTa30VQjBFOT7fL5ToRFLcRLHjc6or60M
         9ibJ1Q37qIY+gXXIwza5Ij7hh2iJ6hazuzJyDNlUhREt284dZXhR0s5oHMwihJ6h7KRT
         1RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724355597; x=1724960397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YS/a2XN/koxIPWF1pI8RLRI3ZpyHqhmNdBFZY8wVB4A=;
        b=RaPri6DqqOzOrRfOnmI07Ntm/Xtd6WSQgJdeUUpvws5pgKPq874Izmhz/pLH2lYsjJ
         6+Rn3lIKkUiDshJWxpm5TX08TvaTQDe++4Ulr/fhHFd90Qz1i4KYDlHA0qIjiX9f2mwt
         Vuy+Er9O0qXYcp8S9b2OPU1GLUEGpJlhXMwFyAehofBkprVa3K+bAvCn51kbXIV+sXGB
         5cHG/AUWrz1U5MO1nE6GgB+1qMT0j9JWx7DuoZQat2IpAVQtWBvFj5RO40BRNd8FEcUq
         1+upz3C/g5gFDWjQ2ELptM0luhy0ioaPiuoqgNdXFntDixGitKb5CEemWzTvivGGfHa2
         fuhQ==
X-Gm-Message-State: AOJu0Yyvt9tDMTJrzvfDXroYBgA9BoTiMIfjChvXW188E9a+efCGH9Ih
	AxTn0R3p7nv6OE1cDYC5MKIvNVTOv3k+keMrGKGUUheHw+9rdCCYA4mq+8/pxfg=
X-Google-Smtp-Source: AGHT+IEYCX4ZxjNhUv4i/FGCoWEOx56g3TGGQuX9eqvofrKWjGgT28Rhv06u7XPfAfdDxTGoMhraPg==
X-Received: by 2002:a05:6820:220a:b0:5d8:f3f:b1f7 with SMTP id 006d021491bc7-5dca0648d97mr7688979eaf.6.1724355596960;
        Thu, 22 Aug 2024 12:39:56 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5dcb5e6864esm400076eaf.38.2024.08.22.12.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 12:39:56 -0700 (PDT)
Message-ID: <28fa2ba9-9b02-43ac-b070-85a173a5db60@baylibre.com>
Date: Thu, 22 Aug 2024 14:39:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] iio: adc: ad4030: add driver for ad4030-24
To: Esteban Blanc <eblanc@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
 <20240822-eblanc-ad4630_v1-v1-2-5c68f3327fdd@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-2-5c68f3327fdd@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/22/24 7:45 AM, Esteban Blanc wrote:
> This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> 
> The driver implements basic support for the AD4030-24 1 channel
> differential ADC with hardware gain and offset control.
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/iio/adc/Kconfig  |  13 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad4030.c | 854 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 869 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f17c42bea19c..6a5a0e7b7a51 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -420,6 +420,7 @@ R:	Esteban Blanc <eblanc@baylibre.com>
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> +F:	drivers/iio/adc/ad4030.c
>  
>  AD5110 ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
>  M:	Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 88e8ce2e78b3..f4bd05780f6f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -33,6 +33,19 @@ config AD4000
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad4000.
>  
> +config AD4030
> +	tristate "Analog Device AD4630 ADC Driver"
> +	depends on SPI
> +	depends on GPIOLIB
> +	select REGMAP_SPI

It looks like we are just using REGMAP, not REGMAP_SPI.

> +	select IIO_BUFFER

And also select IIO_TRIGGERED_BUFFER?

> +	help
> +	  Say yes here to build support for Analog Devices AD4030 and AD4630 high speed
> +	  SPI analog to digital converters (ADC).
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad4030.
> +
>  config AD4130
>  	tristate "Analog Device AD4130 ADC Driver"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 8b80664c6d6b..0e4f833abf0b 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
>  obj-$(CONFIG_AD4000) += ad4000.o
> +obj-$(CONFIG_AD4030) += ad4030.o
>  obj-$(CONFIG_AD4130) += ad4130.o
>  obj-$(CONFIG_AD4695) += ad4695.o
>  obj-$(CONFIG_AD7091R) += ad7091r-base.o
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> new file mode 100644
> index 000000000000..a981dce988e5
> --- /dev/null
> +++ b/drivers/iio/adc/ad4030.c
> @@ -0,0 +1,854 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD4030 and AD4630 ADC family driver.
> + *
> + * Copyright 2024 Analog Devices, Inc.
> + * Copyright 2024 BayLibre, SAS
> + *
> + * based on code from:
> + *	Analog Devices, Inc.
> + *	  Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> + *	  Nuno Sa <nuno.sa@analog.com>
> + *	  Marcelo Schmitt <marcelo.schmitt@analog.com>
> + *	  Liviu Adace <liviu.adace@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/units.h>

alphabetical order?

> +#include <linux/clk.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define AD4030_REG_INTERFACE_CONFIG_A			0x00
> +#define     AD4030_REG_INTERFACE_CONFIG_A_SW_RESET	(BIT(0) | BIT(7))
> +#define AD4030_REG_INTERFACE_CONFIG_B			0x01
> +#define AD4030_REG_DEVICE_CONFIG			0x02
> +#define AD4030_REG_CHIP_TYPE				0x03
> +#define AD4030_REG_PRODUCT_ID_L				0x04
> +#define AD4030_REG_PRODUCT_ID_H				0x05
> +#define AD4030_REG_CHIP_GRADE				0x06
> +#define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE	0x10
> +#define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
> +#define AD4030_REG_SCRATCH_PAD			0x0A
> +#define AD4030_REG_SPI_REVISION			0x0B
> +#define AD4030_REG_VENDOR_L			0x0C
> +#define AD4030_REG_VENDOR_H			0x0D
> +#define AD4030_REG_STREAM_MODE			0x0E
> +#define AD4030_REG_INTERFACE_CONFIG_C		0x10
> +#define AD4030_REG_INTERFACE_STATUS_A		0x11
> +#define AD4030_REG_EXIT_CFG_MODE		0x14
> +#define     AD4030_REG_EXIT_CFG_MODE_EXIT_MSK	BIT(0)
> +#define AD4030_REG_AVG				0x15
> +#define     AD4030_REG_AVG_MASK_AVG_SYNC	BIT(7)
> +#define     AD4030_REG_AVG_MASK_AVG_VAL		GENMASK(4, 0)
> +#define AD4030_REG_OFFSET_X0_0			0x16
> +#define AD4030_REG_OFFSET_X0_1			0x17
> +#define AD4030_REG_OFFSET_X0_2			0x18
> +#define AD4030_REG_OFFSET_X1_0			0x19
> +#define AD4030_REG_OFFSET_X1_1			0x1A
> +#define AD4030_REG_OFFSET_X1_2			0x1B
> +#define     AD4030_REG_OFFSET_BYTES_NB		3
> +#define     AD4030_REG_OFFSET_CHAN(ch)		(AD4030_REG_OFFSET_X0_2 +	\
> +						(AD4030_REG_OFFSET_BYTES_NB *	\
> +						(ch)))
> +#define AD4030_REG_GAIN_X0_LSB			0x1C
> +#define AD4030_REG_GAIN_X0_MSB			0x1D
> +#define AD4030_REG_GAIN_X1_LSB			0x1E
> +#define AD4030_REG_GAIN_X1_MSB			0x1F
> +#define     AD4030_REG_GAIN_MAX_GAIN		1999970
> +#define     AD4030_REG_GAIN_BYTES_NB		2
> +#define     AD4030_REG_GAIN_CHAN(ch)		(AD4030_REG_GAIN_X0_MSB +	\
> +						(AD4030_REG_GAIN_BYTES_NB *	\
> +						(ch)))
> +#define AD4030_REG_MODES			0x20
> +#define     AD4030_REG_MODES_MASK_OUT_DATA_MODE	GENMASK(2, 0)
> +#define     AD4030_REG_MODES_MASK_LANE_MODE	GENMASK(7, 6)
> +#define AD4030_REG_OSCILATOR			0x21
> +#define AD4030_REG_IO				0x22
> +#define     AD4030_REG_IO_MASK_IO2X		BIT(1)
> +#define AD4030_REG_PAT0				0x23
> +#define AD4030_REG_PAT1				0x24
> +#define AD4030_REG_PAT2				0x25
> +#define AD4030_REG_PAT3				0x26
> +#define AD4030_REG_DIG_DIAG			0x34
> +#define AD4030_REG_DIG_ERR			0x35
> +
> +/* Sequence starting with "1 0 1" to enable reg access */
> +#define AD4030_REG_ACCESS			0xa0

nite: for case-consistency: 0xA0

> +
> +#define AD4030_MAX_IIO_SAMPLE_SIZE_BUFFERED	BITS_TO_BYTES(64)
> +#define AD4030_MAX_HARDWARE_CHANNEL_NB		2
> +#define AD4030_MAX_IIO_CHANNEL_NB		5
> +#define AD4030_COMMON_BYTE_CHANNELS_FILTER	0xA
> +/*
> + * This accounts for for 1 sample per channel plus one u64 for the timestamp,
> + * aligned on a u64 boundary

Technically, soft timestamp is s64.

> + */
> +#define AD4030_MAXIMUM_RX_BUFFER_SIZE			\
> +	ALIGN(AD4030_MAX_IIO_SAMPLE_SIZE_BUFFERED *	\
> +	      AD4030_MAX_HARDWARE_CHANNEL_NB,		\
> +	      sizeof(u64)) + sizeof(u64)
> +
> +#define AD4030_VREF_MIN_UV		(4096 * MILLI)
> +#define AD4030_VREF_MAX_UV		(5000 * MILLI)
> +#define AD4030_VIO_THRESHOLD_UV		(1400 * MILLI)
> +
> +#define AD4030_SPI_MAX_XFER_LEN		8
> +#define AD4030_SPI_MAX_REG_XFER_SPEED	(80 * MEGA)
> +#define AD4030_TCNVH_NS			10
> +#define AD4030_TCNVL_NS			20
> +#define AD4030_TCYC_NS			500
> +#define AD4030_TCYC_ADJUSTED_NS		(AD4030_TCYC_NS - AD4030_TCNVL_NS)
> +#define AD4030_TRESET_PW_NS		50
> +#define AD4030_TRESET_COM_DELAY_MS	750
> +
> +enum ad4030_out_mode {
> +	AD4030_OUT_DATA_MD_16_DIFF = 0x00,
> +	AD4030_OUT_DATA_MD_24_DIFF = 0x00,
> +	AD4030_OUT_DATA_MD_16_DIFF_8_COM = 0x01,
> +	AD4030_OUT_DATA_MD_24_DIFF_8_COM = 0x02,
> +	AD4030_OUT_DATA_MD_30_AVERAGED_DIFF = 0x03,
> +	AD4030_OUT_DATA_MD_32_PATTERN = 0x04
> +};
> +
> +struct ad4030_chip_info {
> +	const char *name;
> +	const unsigned long *available_masks;
> +	unsigned int available_masks_len;
> +	const struct iio_chan_spec channels[AD4030_MAX_IIO_CHANNEL_NB];> +	u8 grade;
> +	u8 precision_bits;
> +	/* Number of hardware channels */
> +	int num_channels;
> +	unsigned int tcyc;

Always nice to have the units in the variable name: tcyc_ns

> +};
> +
> +struct ad4030_state {
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	const struct ad4030_chip_info *chip;
> +	struct gpio_desc *cnv_gpio;
> +	int vref_uv;
> +	int vio_uv;
> +	int offset_avail[3];
> +	u32 conversion_speed_hz;
> +	enum ad4030_out_mode mode;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the transfer buffers
> +	 * to live in their own cache lines.
> +	 */
> +	u8 tx_data[AD4030_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
> +	struct {
> +		union {
> +			u8 raw[AD4030_MAXIMUM_RX_BUFFER_SIZE];
> +			struct {
> +				s32 val;
> +				u32 common;
> +			} __packed buffered[AD4030_MAX_HARDWARE_CHANNEL_NB];

__packed isn't going to make a difference here since everything is 32-bit.

> +		};
> +	} rx_data __aligned(IIO_DMA_MINALIGN);
> +};
> +
> +#define AD4030_CHAN_CMO(_idx)  {					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\

Datasheet says LSB for the 8-bit common mode output value is Vref/256
so we also need IIO_CHAN_INFO_SCALE here.

> +	.type = IIO_VOLTAGE,						\
> +	.indexed = 1,							\
> +	.channel = _idx * 2 + 2,					\
> +	.scan_index = _idx * 2 + 1,					\
> +	.extend_name = "Channel" #_idx " common byte part",		\

Labels are usually one word and reflect the datasheet name.

Suggest `"common-mode" #_idx` or `"CM" #_idx` for this one.

> +	.scan_type = {							\
> +		.sign = 'u',						\
> +		.storagebits = 32,					\

Using SPI offload is going to require different channel info structs
anyway since we will need a samping frequency attribute and there won't
be a soft timestamp.

So I think it would be OK to make storagebits 8 here. And we can make it
whatever it needs to be in the new struct when we actually add SPI
offload support.

> +		.realbits = 8,						\
> +		.endianness = IIO_BE,					\
> +	},								\
> +}
> +
> +#define AD4030_CHAN_IN(_idx, _storage, _real, _shift) {			\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),		\

As mentioned above scale should be info_mask_separate.

> +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
> +		BIT(IIO_CHAN_INFO_RAW),					\
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBBIAS) |	\
> +		BIT(IIO_CHAN_INFO_CALIBSCALE),				\
> +	.type = IIO_VOLTAGE,						\
> +	.indexed = 1,							\
> +	.channel = _idx * 2,						\
> +	.channel2 = _idx * 2 + 1,					\
> +	.scan_index = _idx * 2,						\
> +	.extend_name = "Channel" #_idx " differential part",		\

As above, suggest `"IN" #_idx` for this.

> +	.differential = true,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.storagebits = _storage,				\
> +		.realbits = _real,					\
> +		.shift = _shift,					\
> +		.endianness = IIO_BE,					\
> +	},								\
> +}
> +
> +static int ad4030_spi_read(void *context, const void *reg, size_t reg_size,
> +			   void *val, size_t val_size)
> +{
> +	struct ad4030_state *st = context;
> +
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_data,
> +		.rx_buf = st->rx_data.raw,
> +		.len = reg_size + val_size,
> +	};
> +	int ret;
> +
> +	memcpy(st->tx_data, reg, reg_size);
> +
> +	/*
> +	 * This should use spi_write_the_read but when doing so, CS never get
> +	 * deasserted.
> +	 */
> +	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(val, &st->rx_data.raw[reg_size], val_size);
> +
> +	return ret;
> +}
> +
> +static int ad4030_spi_write(void *context, const void *data, size_t count)
> +{
> +	const struct ad4030_state *st = context;
> +
> +	return spi_write(st->spi, data, count);
> +}
> +
> +static const struct regmap_bus ad4030_regmap_bus = {
> +	.read = ad4030_spi_read,
> +	.write = ad4030_spi_write,
> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +};
> +
> +static const struct regmap_range ad4030_regmap_rd_range[] = {
> +	regmap_reg_range(AD4030_REG_INTERFACE_CONFIG_A, AD4030_REG_CHIP_GRADE),
> +	regmap_reg_range(AD4030_REG_SCRATCH_PAD, AD4030_REG_STREAM_MODE),
> +	regmap_reg_range(AD4030_REG_INTERFACE_CONFIG_C, AD4030_REG_INTERFACE_STATUS_A),
> +	regmap_reg_range(AD4030_REG_EXIT_CFG_MODE, AD4030_REG_PAT3),
> +	regmap_reg_range(AD4030_REG_DIG_DIAG, AD4030_REG_DIG_ERR),
> +};
> +
> +static const struct regmap_range ad4030_regmap_wr_range[] = {
> +	regmap_reg_range(AD4030_REG_CHIP_TYPE, AD4030_REG_CHIP_GRADE),
> +	regmap_reg_range(AD4030_REG_SPI_REVISION, AD4030_REG_VENDOR_H),
> +};
> +
> +static const struct regmap_access_table ad4030_regmap_rd_table = {
> +	.yes_ranges = ad4030_regmap_rd_range,
> +	.n_yes_ranges = ARRAY_SIZE(ad4030_regmap_rd_range),
> +};
> +
> +static const struct regmap_access_table ad4030_regmap_wr_table = {
> +	.no_ranges = ad4030_regmap_wr_range,
> +	.n_no_ranges = ARRAY_SIZE(ad4030_regmap_wr_range),
> +};
> +
> +static const struct regmap_config ad4030_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.read_flag_mask = 0x80,
> +	.rd_table = &ad4030_regmap_rd_table,
> +	.wr_table = &ad4030_regmap_wr_table,
> +	.max_register = AD4030_REG_DIG_ERR,
> +};
> +
> +static int ad4030_enter_config_mode(struct ad4030_state *st)
> +{
> +	st->rx_data.raw[0] = AD4030_REG_ACCESS;
> +
> +	return spi_write(st->spi, st->rx_data.raw, 1);
> +}
> +
> +static int ad4030_exit_config_mode(struct ad4030_state *st)
> +{
> +	return regmap_write(st->regmap, AD4030_REG_EXIT_CFG_MODE,
> +		     AD4030_REG_EXIT_CFG_MODE_EXIT_MSK);
> +}
> +
> +static int ad4030_get_chan_gain(struct iio_dev *indio_dev, int ch, int *val,
> +				int *val2)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	u16 gain;
> +	int ret;
> +
> +	ret = regmap_bulk_read(st->regmap, AD4030_REG_GAIN_CHAN(ch),
> +			       st->rx_data.raw, AD4030_REG_GAIN_BYTES_NB);
> +	if (ret)
> +		return ret;
> +
> +	gain = be16_to_cpu(*(u16 *)st->rx_data.raw);
> +
> +	/* From datasheet: multiplied output = input × gain word/0x8000 */
> +	*val = gain / 0x8000;
> +	*val2 = mul_u64_u32_div(gain % 0x8000, MICRO, 0x8000);
> +
> +	return 0;
> +}
> +
> +/*
> + * @brief Returns the offset where 1 LSB = (VREF/2^precision_bits - 1)/gain
> + */
> +static int ad4030_get_chan_offset(struct iio_dev *indio_dev, int ch, int *val)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_bulk_read(st->regmap, AD4030_REG_OFFSET_CHAN(ch),
> +			       st->rx_data.raw, AD4030_REG_OFFSET_BYTES_NB);
> +	if (ret)
> +		return ret;
> +
> +	switch (st->chip->precision_bits) {
> +	case 16:
> +		*val = sign_extend32(get_unaligned_be16(st->rx_data.raw), 15);
> +		break;
> +
> +	case 24:
> +		*val = sign_extend32(get_unaligned_be24(st->rx_data.raw), 23);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4030_set_chan_gain(struct iio_dev *indio_dev, int ch, int gain_int,
> +				int gain_frac)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	__be16 *val = (__be16 *)st->rx_data.raw;
> +	u64 gain;

Should check for negative values here (have to check both gain_int and gain_val
due to the way IIO_VAL_INT_PLUS_MICRO works). Otherwise negative numbers will
be turned positive in the unsigned multiply below.

	if (gain_int < 0 || gain_frac < 0)
		return -EINVAL;

> +
> +	gain = mul_u32_u32(gain_int, MICRO) + gain_frac;
> +
> +	if (gain > AD4030_REG_GAIN_MAX_GAIN)
> +		return -EINVAL;
> +
> +	*val = cpu_to_be16(DIV_ROUND_CLOSEST_ULL(gain * 0x8000, MICRO));
> +
> +	return regmap_bulk_write(st->regmap, AD4030_REG_GAIN_CHAN(ch), val,
> +			  AD4030_REG_GAIN_BYTES_NB);
> +}
> +
> +static int ad4030_set_chan_offset(struct iio_dev *indio_dev, int ch, int offset)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	if (offset < st->offset_avail[0] || offset > st->offset_avail[2])
> +		return -EINVAL;
> +
> +	switch (st->chip->precision_bits) {
> +	case 16:
> +		put_unaligned_be16(offset, st->rx_data.raw);
> +		break;
> +
> +	case 24:
> +		put_unaligned_be24(offset, st->rx_data.raw);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_bulk_write(st->regmap, AD4030_REG_OFFSET_CHAN(ch),
> +			  st->rx_data.raw, AD4030_REG_OFFSET_BYTES_NB);
> +}
> +
> +static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
> +					unsigned int mask)
> +{
> +	/* Common byte channel is after the "real" differential sample channel */
> +	return mask & AD4030_COMMON_BYTE_CHANNELS_FILTER;
> +}
> +
> +static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	if (ad4030_is_common_byte_asked(st, mask))
> +		st->mode = AD4030_OUT_DATA_MD_24_DIFF_8_COM;
> +	else
> +		st->mode = AD4030_OUT_DATA_MD_24_DIFF;
> +
> +	return regmap_update_bits(st->regmap, AD4030_REG_MODES,
> +				AD4030_REG_MODES_MASK_OUT_DATA_MODE,
> +				st->mode);
> +}
> +
> +static int ad4030_conversion(struct ad4030_state *st,
> +			     const struct iio_chan_spec *chan)
> +{
> +	unsigned int bytes_to_read;
> +	unsigned char byte_index;
> +	unsigned int i;
> +	int ret;
> +
> +	/* Number of bytes for one differential channel */
> +	bytes_to_read = BITS_TO_BYTES(chan->scan_type.realbits);
> +	/* Add one byte if we are using a differential + common byte mode */
> +	bytes_to_read += (st->mode == AD4030_OUT_DATA_MD_24_DIFF_8_COM ||
> +			st->mode == AD4030_OUT_DATA_MD_16_DIFF_8_COM) ? 1 : 0;
> +	/* Mulitiply by the number of hardware channels */
> +	bytes_to_read *= st->chip->num_channels;
> +
> +	gpiod_set_value_cansleep(st->cnv_gpio, 1);
> +	ndelay(AD4030_TCNVH_NS);
> +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> +	ndelay(st->chip->tcyc);
> +
> +	ret = spi_read(st->spi, st->rx_data.raw, bytes_to_read);
> +	if (ret)
> +		return ret;
> +
> +	if (st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
> +		return 0;
> +
> +	byte_index = BITS_TO_BYTES(chan->scan_type.realbits);
> +	for (i = 0; i < st->chip->num_channels; i++)
> +		st->rx_data.buffered[i].common = ((u8 *)&st->rx_data.buffered[i].val)[byte_index];
> +
> +	return 0;
> +}
> +
> +static int ad4030_single_conversion(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan, int *val)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad4030_set_mode(indio_dev, BIT(chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4030_exit_config_mode(st);
> +	if (ret)
> +		goto out_exit_config_mode_error;

Looks like we could just return ret here.

> +
> +	ret = ad4030_conversion(st, chan);
> +	if (ret)
> +		goto out_error;
> +
> +	if (chan->channel % 2)
> +		*val = st->rx_data.buffered[chan->channel / 2].common;
> +	else
> +		*val = st->rx_data.buffered[chan->channel / 2].val;
> +
> +out_error:
> +	ad4030_enter_config_mode(st);
> +
> +out_exit_config_mode_error:
> +
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;

This can be moved before out_error:, then we can just have
return ret here and leave out the if.

> +}
> +
> +static irqreturn_t ad4030_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad4030_conversion(st, indio_dev->channels);
> +	if (ret)
> +		goto out;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_data.raw,
> +					   pf->timestamp);
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
> +static const int ad4030_gain_avail[3][2] = {
> +	{ 0, 0 },
> +	{ 0, 30 },
> +	{ 1, 999969 },
> +};

Could use IIO_VAL_FRACTIONAL_LOG2 or IIO_VAL_INT_PLUS_NANO here
to get more precise values. Actual range is: [0 1/2^15 U16_MAX/2^15]

To 9 decimal places: [0.000000000 0.000030517 1.999969482]

> +
> +static int ad4030_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *channel,
> +			     const int **vals, int *type,
> +			     int *length, long mask)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*vals = ad4030_get_offset_avail(st);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*vals = (void *)ad4030_gain_avail;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_RANGE;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4030_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		switch (info) {
> +		case IIO_CHAN_INFO_RAW:
> +			return ad4030_single_conversion(indio_dev, chan, val);
> +
> +		case IIO_CHAN_INFO_SCALE:
> +			*val = (st->vref_uv * 2) / MILLI;
> +			*val2 = st->chip->precision_bits;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +
> +		case IIO_CHAN_INFO_CALIBSCALE:
> +			ret = ad4030_get_chan_gain(indio_dev, chan->channel,
> +						   val, val2);
> +			if (ret)
> +				return ret;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +
> +		case IIO_CHAN_INFO_CALIBBIAS:
> +			ret = ad4030_get_chan_offset(indio_dev, chan->channel,
> +						     val);
> +			if (ret)
> +				return ret;
> +			return IIO_VAL_INT;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	unreachable();
> +}
> +
> +static int ad4030_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val,
> +			    int val2, long info)
> +{
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		switch (info) {
> +		case IIO_CHAN_INFO_CALIBSCALE:
> +			return ad4030_set_chan_gain(indio_dev, chan->channel,
> +						    val, val2);
> +
> +		case IIO_CHAN_INFO_CALIBBIAS:
> +			return ad4030_set_chan_offset(indio_dev, chan->channel,
> +						      val);

Need to add .write_raw_get_fmt to struct iio_info below to set
IIO_CHAN_INFO_CALIBBIAS to IIO_VAL_INT. Othwerwise, the defualt
IIO_VAL_INT_PLUS_MICRO is used and val2 would have considered
for handling negative values.

> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	unreachable();
> +}
> +
> +static int ad4030_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval)
> +{
> +	const struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		if (readval)
> +			return regmap_read(st->regmap, reg, readval);
> +
> +		return regmap_write(st->regmap, reg, writeval);
> +	}
> +
> +	unreachable();
> +}
> +
> +static const struct iio_info ad4030_iio_info = {
> +	.read_avail = ad4030_read_avail,
> +	.read_raw = ad4030_read_raw,
> +	.write_raw = ad4030_write_raw,
> +	.debugfs_reg_access = ad4030_reg_access,
> +};
> +
> +static int ad4030_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad4030_set_mode(indio_dev, *indio_dev->active_scan_mask);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4030_exit_config_mode(st);
> +	if (ret)
> +		return ret;
> +
> +	/* Restore SPI max speed for conversion */
> +	st->spi->max_speed_hz = st->conversion_speed_hz;
> +
> +	return 0;
> +}
> +
> +static int ad4030_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	/* Make sure the SPI clock is within range to read register */
> +	st->spi->max_speed_hz = min(st->spi->max_speed_hz,
> +				    AD4030_SPI_MAX_REG_XFER_SPEED);
> +
> +	return ad4030_enter_config_mode(st);
> +}
> +
> +static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
> +	.preenable = ad4030_buffer_preenable,
> +	.postdisable = ad4030_buffer_postdisable,
> +};
> +
> +static int ad4030_regulators_get(struct ad4030_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	static const char * const ids[] = { "vdd-5v", "vdd-1v8" };
> +	int ret;
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ids), ids);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	st->vio_uv = devm_regulator_get_enable_read_voltage(dev, "vio");
> +	if (st->vio_uv < 0)
> +		return dev_err_probe(dev, st->vio_uv,
> +				     "Failed to enable and read vio voltage\n");
> +
> +	st->vref_uv = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (st->vref_uv < 0) {
> +		if (st->vref_uv != -ENODEV)
> +			return dev_err_probe(dev, st->vref_uv,
> +					     "Failed to read vref voltage\n");
> +
> +		/* if not using optional REF, the internal REFIN must be used */
> +		st->vref_uv = devm_regulator_get_enable_read_voltage(dev, "refin");
> +		if (st->vref_uv < 0)
> +			return dev_err_probe(dev, st->vref_uv,
> +					     "Failed to read vrefin voltage\n");
> +	}
> +
> +	if (st->vref_uv < AD4030_VREF_MIN_UV || st->vref_uv > AD4030_VREF_MAX_UV)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "vref(%d) must be in the range [%lu %lu]\n",
> +				     st->vref_uv, AD4030_VREF_MIN_UV,
> +				     AD4030_VREF_MAX_UV);
> +
> +	return 0;
> +}
> +
> +static int ad4030_reset(struct ad4030_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct gpio_desc *reset;
> +	int ret;
> +
> +	/* Use GPIO if available ... */
> +	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(dev, PTR_ERR(reset),
> +				"Failed to get reset GPIO\n");
> +
> +	if (reset) {
> +		ndelay(50);
> +		gpiod_set_value_cansleep(reset, 0);
> +	} else {
> +		/* ... falback to software reset otherwise */
> +		ret = ad4030_enter_config_mode(st);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD4030_REG_INTERFACE_CONFIG_A,
> +				   AD4030_REG_INTERFACE_CONFIG_A_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Wait for reset to complete before communicating to it */
> +	fsleep(AD4030_TRESET_COM_DELAY_MS);

Should be renamed to AD4030_TRESET_COM_DELAY_US since it is microseconds.

> +
> +	/* After reset, conversion mode is enabled. Switch to reg access */
> +	return ad4030_enter_config_mode(st);
> +}
> +
> +static int ad4030_detect_chip_info(const struct ad4030_state *st)
> +{
> +	unsigned int grade;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD4030_REG_CHIP_GRADE, &grade);
> +	if (ret)
> +		return ret;
> +
> +	grade = FIELD_GET(AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE, grade);
> +	if (grade != st->chip->grade)
> +		return dev_err_probe(&st->spi->dev, -EINVAL,
> +					"Unknown grade(0x%x) for %s\n", grade,
> +					st->chip->name);
> +
> +	return 0;
> +}
> +
> +static int ad4030_config(struct ad4030_state *st)
> +{
> +	st->offset_avail[0] = (int)BIT(st->chip->precision_bits - 1) * -1;
> +	st->offset_avail[1] = 1;
> +	st->offset_avail[2] = BIT(st->chip->precision_bits - 1) - 1;
> +
> +	if (st->vio_uv < AD4030_VIO_THRESHOLD_UV)
> +		return regmap_write(st->regmap, AD4030_REG_IO,
> +				AD4030_REG_IO_MASK_IO2X);
> +
> +	return 0;
> +}
> +
> +static int ad4030_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4030_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	/* Make sure the SPI clock is within range to read register */
> +	st->conversion_speed_hz = min(spi->max_speed_hz,
> +				      AD4030_SPI_MAX_REG_XFER_SPEED);
> +
> +	st->regmap = devm_regmap_init(dev, &ad4030_regmap_bus, st,
> +				      &ad4030_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		dev_err_probe(dev, PTR_ERR(st->regmap),
> +			      "Failed to initialize regmap\n");
> +
> +	st->chip = spi_get_device_match_data(spi);
> +	if (!st->chip)
> +		return -EINVAL;
> +
> +	ret = ad4030_regulators_get(st);
> +	if (ret)
> +		return ret;

Datasheet says:

	Perform a reset no sooner than 3 ms after the power
	supplies are valid and stable

So might be a good idea to have mdelay(3) here.

> +
> +	ret = ad4030_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4030_detect_chip_info(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4030_config(st);
> +	if (ret)
> +		return ret;
> +
> +	st->cnv_gpio = devm_gpiod_get(dev, "cnv", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->cnv_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
> +				     "Failed to get cnv gpio\n");
> +
> +	/*
> +	 * One hardware channel is split in two software channels when using
> +	 * common byte mode. Add one more channel for the timestamp.
> +	 */
> +	indio_dev->num_channels = 2 * st->chip->num_channels + 1;

Might make more sense to rename chip->num_channels to num_voltage_inputs
or something like that to avoid confusion.

> +	indio_dev->name = st->chip->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ad4030_iio_info;
> +	indio_dev->channels = st->chip->channels;
> +	indio_dev->available_scan_masks = st->chip->available_masks;
> +	indio_dev->masklength = st->chip->available_masks_len;

indio_dev->masklengh is marked as [INTERN] so should not be set by drivers.

> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      ad4030_trigger_handler,
> +					      &ad4030_buffer_setup_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup triggered buffer\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const unsigned long ad4030_channel_masks[] = {
> +	/* Differential only */
> +	BIT(0),
> +	/* Differential with common byte */

Suggest: /* Differential and common-mode voltage */

> +	GENMASK(1, 0),
> +	0,
> +};
> +
> +static const struct ad4030_chip_info ad4030_24_chip_info = {
> +	.name = "ad4030-24",
> +	.available_masks = ad4030_channel_masks,
> +	.available_masks_len = ARRAY_SIZE(ad4030_channel_masks),
> +	.channels = {
> +		AD4030_CHAN_IN(0, 32, 24, 8),
> +		AD4030_CHAN_CMO(0),
> +		IIO_CHAN_SOFT_TIMESTAMP(2),
> +	},
> +	.grade = AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
> +	.precision_bits = 24,
> +	.num_channels = 1,
> +	.tcyc = AD4030_TCYC_ADJUSTED_NS,
> +};
> +
> +static const struct spi_device_id ad4030_id_table[] = {
> +	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad4030_id_table);
> +
> +static const struct of_device_id ad4030_of_match[] = {
> +	{ .compatible = "adi,ad4030-24", .data = &ad4030_24_chip_info },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ad4030_of_match);
> +
> +static struct spi_driver ad4030_driver = {
> +	.driver = {
> +		.name = "ad4030",
> +		.of_match_table = ad4030_of_match,
> +	},
> +	.probe = ad4030_probe,
> +	.id_table = ad4030_id_table,
> +};
> +module_spi_driver(ad4030_driver);
> +
> +MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
> +MODULE_DESCRIPTION("Analog Devices AD4630 ADC family driver");
> +MODULE_LICENSE("GPL");
> 


