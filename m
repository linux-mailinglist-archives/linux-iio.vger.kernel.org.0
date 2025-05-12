Return-Path: <linux-iio+bounces-19450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E746EAB30F4
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 09:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5E91705F6
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 07:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B24257420;
	Mon, 12 May 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkUa10k6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524E17DA82;
	Mon, 12 May 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036773; cv=none; b=Frdz27KawbXA0R1UuZZGuiCiqAV/mCMKBT18XfX24MNV9ALrzM7NkTHKY4t1s7NhPjNbcEeKVt+n+OQVpBJshz07ZtBPt6sMxYJ96MrbRTbEctHNGT3fwotJquf0JD8U0aZXcFjRT9TgJVoQmytizr8Sm++ATb5VGokC822jklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036773; c=relaxed/simple;
	bh=odysrd4PDuEQ7Bt2ndq1uaqZtOdKBSsUvfqtiQCEQbc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BCoifNG3yyo1UHrq3vJM1dYdEwUoIc6DXCoGY2y2KC4O0MzArCzgCAiwwxf62mDLhtDaMEWgCd5mTsl5g/Yq2OtKwwly72ZsTX/Yyyy/BBNcYzTed99uWy3yigd7sSVCtw6BmB6cO+Hnx8cWbhK3/OeDtTFvT4MjL825crSGWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkUa10k6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so1683393f8f.1;
        Mon, 12 May 2025 00:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747036769; x=1747641569; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIRI4ozadLvw3YnK2+tOjDp2+CFNoSvTWLPZ6x8hk9M=;
        b=TkUa10k6oJOCVse3bYrI9kn/+B8riT5h2ZNpvl3P+e7wZ03TKa5HTXZLpN9vpDzqxI
         tsMP4jZvhCO7T12ZG9Tdt6bElnOPSneNQFgNTX7xdDc3Go1f8nbIEjzHHAyEEPTvSqoD
         cgS4uSCRpuEU+owvrW3MgDr6qrJ0dZ8UioEQN+6NeDkW7BS44KT2VEJdXij4C5kT8pWD
         6N+ht/5oFg9Nsxs44+5uWRj9N4bcrQgAUFgrWQQ6KpJ1u4UlmuRVSo1+SvkKbLma3Abj
         OhYN28nrExp2SEIq/z/04TidIBXmA8PtwJMMRyrPUxrL2z3d+COhHYBnVvc0cM0mf9P8
         9tCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747036769; x=1747641569;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eIRI4ozadLvw3YnK2+tOjDp2+CFNoSvTWLPZ6x8hk9M=;
        b=WdmfgA5OHY2PN6Q0vQOU7H3ZhCGBP/x4iT7j9oGFQzleciTdrx56IJNQH6XSJ9W33+
         NewoAPdMtVOP41a1CRE/+NAEWj/jVifGJZwPeEO843QIRDEdCxhNx5TrM55KP2W+go/3
         +v7AG+0B1taTDC7aoJoV0QwM42t6JRfIjsEws1M9+NK3te1dekkwuRIjQXmWjXnsg+74
         G9rGSpzz3usvoGIBQeC83LLJ8fV5fYWX29gemQ66A7RZvtC4lZ8/YkNbfKuoOUswkWM9
         DI8286tWq6uDRZJm5U4Fd3pKKVfTB/Q71F8LfQZSNOQAsliQDcEB9UhLYg1WL2aPzmoS
         VV9A==
X-Forwarded-Encrypted: i=1; AJvYcCU10wp8+/iyZriqJjkYErxi0Mps4Y1IQAtjOM3rEgq7OryIOh995rI9o9nt2NM94VEQTgIsciqsOMJU@vger.kernel.org, AJvYcCVwpprLQhAK0VfPwlVqgphyEpAqShU9GZmYLE/vh35cqh1jvxKuDnAEmLYFXwUGLcctN74cwDPOhR4M@vger.kernel.org, AJvYcCXGUUvCyNgJJNGR7ndnUd7YTqUpraKrW674HR+yJ2dpqIdfnvr7pb+o8aM6pe7z6uJiiE4cKL94QrIbvnCH@vger.kernel.org
X-Gm-Message-State: AOJu0YxixSx+KfY2sYT1S44A6f+/v9gJNCUHXsgY03OsczQMG580/R5d
	mf2Yg6OjFMG9RFm7Zul17JeiBndetmERmkor22CBaSqWZ31bZwb0
X-Gm-Gg: ASbGncvf9dsw8ZsgX5tWRR/e+2CW91JKs9AOMzDeZ6gZQXVRbnJz9jrg+uqTPtifmLe
	/6wkQEWlqbLUc/eaYJTIdXpuu2g1VK/o/sWDNYSv2MqOtXyIutTujLpWax5j4PWPKhKdNJO/tRX
	iF116WI3vn7sK02fMz5S7EHg/n0ifYlpaElO7HDI3awBg8onAozWTwZySFjK/QddH4+hi6DBdCH
	QOaofN3HjfZKRz4dzTUF2kXEWWsk9ccjDmBUNTfEBlMYGG7ojDzT7AGNzYRX+UVHy3gMQ14zsoL
	E3gDqGkQYQqipfKuBuWbB8+sMes2zNtyhbI5CpXm83ZFjaZhsJ1/KgzQhRLpowSedMo6GoSHMkp
	QCM6E/+j8/EhN0zCHOFu/BvIEcw==
X-Google-Smtp-Source: AGHT+IHCUAawFRwHkW3SX0anhtpKzIMKQtXpUPx/jc1PMp2ao/ounwrvOyffSILFAFGQfMjcPrFT6w==
X-Received: by 2002:a05:6000:4020:b0:391:4ca:490 with SMTP id ffacd0b85a97d-3a1f643d077mr9880147f8f.29.1747036769280;
        Mon, 12 May 2025 00:59:29 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2cf38sm11529218f8f.77.2025.05.12.00.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 00:59:28 -0700 (PDT)
Message-ID: <c881ad8484e9be29db12648d3531b19c822661f6.camel@gmail.com>
Subject: Re: [PATCH v5 09/10] iio: adc: ad4080: add driver support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 12 May 2025 07:59:53 +0100
In-Reply-To: <20250509105019.8887-10-antoniu.miclaus@analog.com>
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
	 <20250509105019.8887-10-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 13:50 +0300, Antoniu Miclaus wrote:
> Add support for AD4080 high-speed, low noise, low distortion,
> 20-bit, Easy Drive, successive approximation register (SAR)
> analog-to-digital converter (ADC).
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v5:
> =C2=A0- rework ad4080_lvds_sync_write using new implementation of data_al=
ign function
> =C2=A0- use dev_err_probe
> =C2=A0- protect both ad4080_set_filter_type and ad4080_set_gec_rate
> =C2=A0- use st->num_lanes > 1
> =C2=A0- validate num_lanes value given by DT.
> =C2=A0- return regmap_update_bits directly.
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 14 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4080.c | 575 ++++++++++++++++++++++++++++++++++++=
+++
> =C2=A04 files changed, 598 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/ad4080.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd04375ab4a2..0038f7a078ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1317,6 +1317,14 @@
> F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> =C2=A0F:	Documentation/iio/ad4030.rst
> =C2=A0F:	drivers/iio/adc/ad4030.c
> =C2=A0
> +ANALOG DEVICES INC AD4080 DRIVER
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml

Hmm, just saw this now... The MAINATINERS files needs to be introduced on t=
he
bindings patch. The above file is not being added now. Fairly sure checkpat=
ch
complains about this in the patch adding the above file.

With the above:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> +F:	drivers/iio/adc/ad4080.c
> +
> =C2=A0ANALOG DEVICES INC AD4130 DRIVER
> =C2=A0M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> =C2=A0L:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 27413516216c..17df328f5322 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -47,6 +47,20 @@ config AD4030
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le will be
> =C2=A0	=C2=A0 called ad4030.
> =C2=A0
> +config AD4080
> +	tristate "Analog Devices AD4080 high speed ADC"
> +	depends on SPI
> +	select REGMAP_SPI
> +	select IIO_BACKEND
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD4080
> +	=C2=A0 high speed, low noise, low distortion, 20-bit, Easy Drive,
> +	=C2=A0 successive approximation register (SAR) analog-to-digital
> +	=C2=A0 converter (ADC). Supports iio_backended devices for AD4080.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll be
> +	=C2=A0 called ad4080.
> +
> =C2=A0config AD4130
> =C2=A0	tristate "Analog Device AD4130 ADC Driver"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9f26d5eca822..e6efed5b4e7a 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
> =C2=A0obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> =C2=A0obj-$(CONFIG_AD4000) +=3D ad4000.o
> =C2=A0obj-$(CONFIG_AD4030) +=3D ad4030.o
> +obj-$(CONFIG_AD4080) +=3D ad4080.o
> =C2=A0obj-$(CONFIG_AD4130) +=3D ad4130.o
> =C2=A0obj-$(CONFIG_AD4695) +=3D ad4695.o
> =C2=A0obj-$(CONFIG_AD4851) +=3D ad4851.o
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> new file mode 100644
> index 000000000000..9f5302720ddf
> --- /dev/null
> +++ b/drivers/iio/adc/ad4080.c
> @@ -0,0 +1,575 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD4080 SPI ADC driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +

...

> +/* Register Definition */
> +#define AD4080_REG_INTERFACE_CONFIG_A				0x00
> +#define AD4080_REG_INTERFACE_CONFIG_B				0x01
> +#define AD4080_REG_DEVICE_CONFIG				0x02
> +#define AD4080_REG_CHIP_TYPE					0x03
> +#define AD4080_REG_PRODUCT_ID_L					0x04
> +#define AD4080_REG_PRODUCT_ID_H					0x05
> +#define AD4080_REG_CHIP_GRADE					0x06
> +#define AD4080_REG_SCRATCH_PAD					0x0A
> +#define AD4080_REG_SPI_REVISION					0x0B
> +#define AD4080_REG_VENDOR_L					0x0C
> +#define AD4080_REG_VENDOR_H					0x0D
> +#define AD4080_REG_STREAM_MODE					0x0E
> +#define AD4080_REG_TRANSFER_CONFIG				0x0F
> +#define AD4080_REG_INTERFACE_CONFIG_C				0x10
> +#define AD4080_REG_INTERFACE_STATUS_A				0x11
> +#define AD4080_REG_DEVICE_STATUS				0x14
> +#define AD4080_REG_ADC_DATA_INTF_CONFIG_A			0x15
> +#define AD4080_REG_ADC_DATA_INTF_CONFIG_B			0x16
> +#define AD4080_REG_ADC_DATA_INTF_CONFIG_C			0x17
> +#define AD4080_REG_PWR_CTRL					0x18
> +#define AD4080_REG_GPIO_CONFIG_A				0x19
> +#define AD4080_REG_GPIO_CONFIG_B				0x1A
> +#define AD4080_REG_GPIO_CONFIG_C				0x1B
> +#define AD4080_REG_GENERAL_CONFIG				0x1C
> +#define AD4080_REG_FIFO_WATERMARK_LSB				0x1D
> +#define AD4080_REG_FIFO_WATERMARK_MSB				0x1E
> +#define AD4080_REG_EVENT_HYSTERESIS_LSB				0x1F
> +#define AD4080_REG_EVENT_HYSTERESIS_MSB				0x20
> +#define AD4080_REG_EVENT_DETECTION_HI_LSB			0x21
> +#define AD4080_REG_EVENT_DETECTION_HI_MSB			0x22
> +#define AD4080_REG_EVENT_DETECTION_LO_LSB			0x23
> +#define AD4080_REG_EVENT_DETECTION_LO_MSB			0x24
> +#define AD4080_REG_OFFSET_LSB					0x25
> +#define AD4080_REG_OFFSET_MSB					0x26
> +#define AD4080_REG_GAIN_LSB					0x27
> +#define AD4080_REG_GAIN_MSB					0x28
> +#define AD4080_REG_FILTER_CONFIG				0x29
> +
> +/* AD4080_REG_INTERFACE_CONFIG_A Bit Definition */
> +#define AD4080_INTERFACE_CONFIG_A_SW_RESET			(BIT(7) | BIT(0))
> +#define AD4080_INTERFACE_CONFIG_A_ADDR_ASC			BIT(5)
> +#define AD4080_INTERFACE_CONFIG_A_SDO_ENABLE			BIT(4)
> +
> +/* AD4080_REG_INTERFACE_CONFIG_B Bit Definition */
> +#define AD4080_INTERFACE_CONFIG_B_SINGLE_INST			BIT(7)
> +#define AD4080_INTERFACE_CONFIG_B_SHORT_INST			BIT(3)
> +
> +/* AD4080_REG_DEVICE_CONFIG Bit Definition */
> +#define AD4080_DEVICE_CONFIG_OPERATING_MODES_MSK		GENMASK(1, 0)
> +
> +/* AD4080_REG_TRANSFER_CONFIG Bit Definition */
> +#define AD4080_TRANSFER_CONFIG_KEEP_STREAM_LENGTH_VAL		BIT(2)
> +
> +/* AD4080_REG_INTERFACE_CONFIG_C Bit Definition */
> +#define AD4080_INTERFACE_CONFIG_C_STRICT_REG_ACCESS		BIT(5)
> +
> +/* AD4080_REG_ADC_DATA_INTF_CONFIG_A Bit Definition */
> +#define AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A		BIT(6)
> +#define AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN		BIT(4)
> +#define AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES		BIT(2)
> +#define AD4080_ADC_DATA_INTF_CONFIG_A_DATA_INTF_MODE		BIT(0)
> +
> +/* AD4080_REG_ADC_DATA_INTF_CONFIG_B Bit Definition */
> +#define AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK	GENMASK(7, 4)
> +#define AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_SELF_CLK_MODE	BIT(3)
> +#define AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_EN		BIT(0)
> +
> +/* AD4080_REG_ADC_DATA_INTF_CONFIG_C Bit Definition */
> +#define AD4080_ADC_DATA_INTF_CONFIG_C_LVDS_VOD_MSK		GENMASK(6, 4)
> +
> +/* AD4080_REG_PWR_CTRL Bit Definition */
> +#define AD4080_PWR_CTRL_ANA_DIG_LDO_PD				BIT(1)
> +#define AD4080_PWR_CTRL_INTF_LDO_PD				BIT(0)
> +
> +/* AD4080_REG_GPIO_CONFIG_A Bit Definition */
> +#define AD4080_GPIO_CONFIG_A_GPO_1_EN				BIT(1)
> +#define AD4080_GPIO_CONFIG_A_GPO_0_EN				BIT(0)
> +
> +/* AD4080_REG_GPIO_CONFIG_B Bit Definition */
> +#define AD4080_GPIO_CONFIG_B_GPIO_1_SEL_MSK			GENMASK(7, 4)
> +#define AD4080_GPIO_CONFIG_B_GPIO_0_SEL_MSK			GENMASK(3, 0)
> +
> +/* AD4080_REG_FIFO_CONFIG Bit Definition */
> +#define AD4080_FIFO_CONFIG_FIFO_MODE_MSK			GENMASK(1, 0)
> +
> +/* AD4080_REG_FILTER_CONFIG Bit Definition */
> +#define AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK			GENMASK(6, 3)
> +#define AD4080_FILTER_CONFIG_FILTER_SEL_MSK			GENMASK(1, 0)
> +
> +/* Miscellaneous Definitions */
> +#define AD4080_SPI_READ						BIT(7)
> +#define AD4080_CHIP_ID						GENMASK(2, 0)
> +
> +#define AD4080_MAX_SAMP_FREQ					40000000
> +#define AD4080_MIN_SAMP_FREQ					1250000
> +
> +enum ad4080_filter_type {
> +	FILTER_NONE,
> +	SINC_1,
> +	SINC_5,
> +	SINC_5_COMP
> +};
> +
> +static const unsigned int ad4080_scale_table[][2] =3D {
> +	{ 6000, 0 },
> +};
> +
> +static const char *const ad4080_filter_type_iio_enum[] =3D {
> +	[FILTER_NONE]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "none",
> +	[SINC_1]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D "sinc1",
> +	[SINC_5]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D "sinc5",
> +	[SINC_5_COMP]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "sinc5+pf1",
> +};
> +
> +static const int ad4080_dec_rate_iio_enum[] =3D {
> +	2, 4, 8, 16, 32, 64, 128, 256, 512, 1024,
> +};
> +
> +static const char * const ad4080_power_supplies[] =3D {
> +	"vdd33", "vdd11", "vddldo", "iovdd", "vrefin",
> +};
> +
> +struct ad4080_chip_info {
> +	const char *name;
> +	unsigned int product_id;
> +	int num_scales;
> +	const unsigned int (*scale_table)[2];
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +};
> +
> +struct ad4080_state {
> +	struct regmap			*regmap;
> +	struct clk			*clk;
> +	struct iio_backend		*back;
> +	const struct ad4080_chip_info	*info;
> +	/*
> +	 * Synchronize access to members the of driver state, and ensure
> +	 * atomicity of consecutive regmap operations.
> +	 */
> +	struct mutex			lock;
> +	unsigned int			num_lanes;
> +	unsigned int			dec_rate;
> +	unsigned long			clk_rate;
> +	enum ad4080_filter_type		filter_type;
> +	bool				lvds_cnv_en;
> +};
> +
> +static const struct regmap_config ad4080_regmap_config =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 8,
> +	.read_flag_mask =3D BIT(7),
> +	.max_register =3D 0x29,
> +};
> +
> +static int ad4080_reg_access(struct iio_dev *indio_dev, unsigned int reg=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int writeval, unsigned int *readval=
)
> +{
> +	struct ad4080_state *st =3D iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static int ad4080_get_scale(struct ad4080_state *st, int *val, int *val2=
)
> +{
> +	unsigned int tmp;
> +
> +	tmp =3D (st->info->scale_table[0][0] * 1000000ULL) >>
> +		=C2=A0=C2=A0=C2=A0 st->info->channels[0].scan_type.realbits;
> +	*val =3D tmp / 1000000;
> +	*val2 =3D tmp % 1000000;
> +
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
> +static unsigned int ad4080_get_dec_rate(struct iio_dev *dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	struct ad4080_state *st =3D iio_priv(dev);
> +	int ret;
> +	unsigned int data;
> +
> +	ret =3D regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
> +	if (ret)
> +		return ret;
> +
> +	return 1 << (FIELD_GET(AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK, data) + =
1);
> +}
> +
> +static int ad4080_set_dec_rate(struct iio_dev *dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mode)
> +{
> +	struct ad4080_state *st =3D iio_priv(dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	if ((st->filter_type >=3D SINC_5 && mode >=3D 512) || mode < 2)
> +		return -EINVAL;
> +
> +	return regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
> +				=C2=A0 AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
> +				=C2=A0
> FIELD_PREP(AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 (ilog2(mode) - 1)));
> +}
> +
> +static int ad4080_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0 int *val, int *val2, long m)
> +{
> +	struct ad4080_state *st =3D iio_priv(indio_dev);
> +	unsigned int dec_rate;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4080_get_scale(st, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		dec_rate =3D ad4080_get_dec_rate(indio_dev, chan);
> +		if (st->filter_type =3D=3D SINC_5_COMP)
> +			dec_rate *=3D 2;
> +		if (st->filter_type)
> +			*val =3D DIV_ROUND_CLOSEST(st->clk_rate, dec_rate);
> +		else
> +			*val =3D st->clk_rate;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val =3D ad4080_get_dec_rate(indio_dev, chan);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4080_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad4080_set_dec_rate(indio_dev, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4080_lvds_sync_write(struct ad4080_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	int ret;
> +
> +	ret =3D regmap_set_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK=
_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_backend_interface_data_align(st->back, 10000);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Data alignment process failed\n");
> +
> +	dev_dbg(dev, "Success: Pattern correct and Locked!\n");
> +	return regmap_clear_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				 AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN);
> +}
> +
> +static ssize_t ad4080_get_filter_type(struct iio_dev *dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan)
> +{
> +	struct ad4080_state *st =3D iio_priv(dev);
> +	unsigned int data;
> +	int ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
> +	if (ret)
> +		return ret;
> +
> +	return FIELD_GET(AD4080_FILTER_CONFIG_FILTER_SEL_MSK, data);
> +}
> +
> +static int ad4080_set_filter_type(struct iio_dev *dev,
> +				=C2=A0 const struct iio_chan_spec *chan,
> +				=C2=A0 unsigned int mode)
> +{
> +	struct ad4080_state *st =3D iio_priv(dev);
> +	unsigned int dec_rate;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	dec_rate =3D ad4080_get_dec_rate(dev, chan);
> +
> +	if (mode >=3D SINC_5 && dec_rate >=3D 512)
> +		return -EINVAL;
> +
> +	ret =3D iio_backend_filter_type_set(st->back, mode);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
> +				 AD4080_FILTER_CONFIG_FILTER_SEL_MSK,
> +				 FIELD_PREP(AD4080_FILTER_CONFIG_FILTER_SEL_MSK,
> +					=C2=A0=C2=A0=C2=A0 mode));
> +	if (ret)
> +		return ret;
> +
> +	st->filter_type =3D mode;
> +
> +	return 0;
> +}
> +
> +static int ad4080_read_avail(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const int **vals, int *type, int *length,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals =3D ad4080_dec_rate_iio_enum;
> +		*length =3D ARRAY_SIZE(ad4080_dec_rate_iio_enum);
> +		*type =3D IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ad4080_iio_info =3D {
> +	.debugfs_reg_access =3D ad4080_reg_access,
> +	.read_raw =3D ad4080_read_raw,
> +	.write_raw =3D ad4080_write_raw,
> +	.read_avail =3D ad4080_read_avail,
> +};
> +
> +static const struct iio_enum ad4080_filter_type_enum =3D {
> +	.items =3D ad4080_filter_type_iio_enum,
> +	.num_items =3D ARRAY_SIZE(ad4080_filter_type_iio_enum),
> +	.set =3D ad4080_set_filter_type,
> +	.get =3D ad4080_get_filter_type,
> +};
> +
> +static struct iio_chan_spec_ext_info ad4080_ext_info[] =3D {
> +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad4080_filter_type_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
> +			=C2=A0=C2=A0 &ad4080_filter_type_enum),
> +	{ }
> +};
> +
> +static const struct iio_chan_spec ad4080_channel =3D {
> +	.type =3D IIO_VOLTAGE,
> +	.indexed =3D 1,
> +	.channel =3D 0,
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE),
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	.info_mask_shared_by_all_available =3D
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	.ext_info =3D ad4080_ext_info,
> +	.scan_index =3D 0,
> +	.scan_type =3D {
> +		.sign =3D 's',
> +		.realbits =3D 20,
> +		.storagebits =3D 32,
> +	},
> +};
> +
> +static const struct ad4080_chip_info ad4080_chip_info =3D {
> +	.name =3D "AD4080",
> +	.product_id =3D AD4080_CHIP_ID,
> +	.scale_table =3D ad4080_scale_table,
> +	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> +	.num_channels =3D 1,
> +	.channels =3D &ad4080_channel,
> +};
> +
> +static int ad4080_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4080_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	unsigned int id;
> +	int ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +			=C2=A0=C2=A0 AD4080_INTERFACE_CONFIG_A_SW_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +			=C2=A0=C2=A0 AD4080_INTERFACE_CONFIG_A_SDO_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (id !=3D AD4080_CHIP_ID)
> +		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
> +
> +	ret =3D regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_GPIO_CONFIG_A_GPO_1_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4080_REG_GPIO_CONFIG_B,
> +			=C2=A0=C2=A0 FIELD_PREP(AD4080_GPIO_CONFIG_B_GPIO_1_SEL_MSK, 3));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_backend_num_lanes_set(st->back, st->num_lanes);
> +	if (ret)
> +		return ret;
> +
> +	if (!st->lvds_cnv_en)
> +		return 0;
> +
> +	ret =3D regmap_update_bits(st->regmap,
> +				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +			=09
> AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
> +			=09
> FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK, 7));
> +	if (ret)
> +		return ret;
> +
> +	if (st->num_lanes > 1) {
> +		ret =3D regmap_set_bits(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D regmap_set_bits(st->regmap,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV=
_EN);
> +	if (ret)
> +		return ret;
> +
> +	return ad4080_lvds_sync_write(st);
> +}
> +
> +static int ad4080_properties_parse(struct ad4080_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +
> +	st->lvds_cnv_en =3D device_property_read_bool(dev, "adi,lvds-cnv-enable=
");
> +
> +	st->num_lanes =3D 1;
> +	device_property_read_u32(dev, "adi,num-lanes", &st->num_lanes);
> +	if (!st->num_lanes)
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid 'adi,num-lanes' value: %u",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 st->num_lanes);
> +
> +	return 0;
> +}
> +
> +static int ad4080_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct device *dev =3D &spi->dev;
> +	struct ad4080_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	ret =3D devm_regulator_bulk_get_enable(dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(ad4080_power_supplies),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 ad4080_power_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get and enable supplies\n");
> +
> +	st->regmap =3D devm_regmap_init_spi(spi, &ad4080_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	st->info =3D spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +
> +	ret =3D devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name =3D st->info->name;
> +	indio_dev->channels =3D st->info->channels;
> +	indio_dev->num_channels =3D st->info->num_channels;
> +	indio_dev->info =3D &ad4080_iio_info;
> +
> +	ret =3D ad4080_properties_parse(st);
> +	if (ret)
> +		return ret;
> +
> +	st->clk =3D devm_clk_get_enabled(&spi->dev, "cnv");
> +	if (IS_ERR(st->clk))
> +		return PTR_ERR(st->clk);
> +
> +	st->clk_rate =3D clk_get_rate(st->clk);
> +
> +	st->back =3D devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);
> +
> +	ret =3D devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4080_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ad4080_id[] =3D {
> +	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad4080_id);
> +
> +static const struct of_device_id ad4080_of_match[] =3D {
> +	{ .compatible =3D "adi,ad4080", &ad4080_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad4080_of_match);
> +
> +static struct spi_driver ad4080_driver =3D {
> +	.driver =3D {
> +		.name =3D "ad4080",
> +		.of_match_table =3D ad4080_of_match,
> +	},
> +	.probe =3D ad4080_probe,
> +	.id_table =3D ad4080_id,
> +};
> +module_spi_driver(ad4080_driver);
> +
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
> +MODULE_DESCRIPTION("Analog Devices AD4080");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BACKEND");


