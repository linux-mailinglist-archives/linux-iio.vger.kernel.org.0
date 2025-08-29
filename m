Return-Path: <linux-iio+bounces-23391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E34B3C1F4
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 19:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260037A44FB
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD60B342CA5;
	Fri, 29 Aug 2025 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KvhqqDbU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB655343213
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489182; cv=none; b=G4av+ed06HG6Ni9SyorepUKfcyEno3QHbmRD0wuRacyO/95broiqO8NtNKUNdT603zejHLW1Ti1hEf7ISTcLhqAfpUKHfjcIaSQCRa5lRFjQ85uuvz/zskpy3a6KkhwDP/PUvC1tVjTJPY5FopHXhn0hZgZg27TRgwG4F+BNT7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489182; c=relaxed/simple;
	bh=grHDVRFEReJoxE/h9NqF92CHGejYoCajq+iv5rfVVj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxzzuSQjFoXsbnsGu/DibnRv8xHYsm0pvHURq4q8/srQcuuHnRIvwut9VE+eD2oVffFPDDxXQ0DykbSAUbuqQIpf5yXrSMfltqrfzUt8RqnOmRZ+rkJzzkTXkU3eriHU7EmqN57IBQxbR1jTD+B6o+22z4qrzATGA5qWTLgTSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KvhqqDbU; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30cceaaecd8so1016944fac.2
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 10:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756489179; x=1757093979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4ygpQXnt2Tly/mlL7LrMOaM+YCr1qLNGpXpeESCXTM=;
        b=KvhqqDbU7e2O5CmEqFciPnNt5lq3sD3dq+aPlca9vmCCIQroR0YeaLLOHQmXnkIhjL
         LlceDOvvkwq3kQcmS7BFkFw9xgSKw6wUJfcznpvoi77w8zVi5RMeyYFobwNcwnAoEzsx
         mkyinw4qGhEhNTfDYp7avm4s0mjMxEvf8IAoxCjQenX5APiyhJtRinT0TKavQnuUu9Hg
         4URrdlKzJpOZkHrhI2flTrHCq9NUplZxm/2ceDvivw2aHfECVht0glpGNaSr+I0b/DqH
         Q+NmKzl6uVKG6x7Fr97Kgf9kb3A2+iBRF7vZZBTme0bI1mZmTXyqRK8idGHMwoBl63uX
         GpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756489179; x=1757093979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4ygpQXnt2Tly/mlL7LrMOaM+YCr1qLNGpXpeESCXTM=;
        b=Od5hHl+HYoU9vvC9dPm7TV5LrfaV6MxCIHwegmR+nH8tlTjWQ+ZkeLkcVFBUIPek6d
         xiTxdbHUoBzCNEtTB+P9QotoGJt8rP5TX8OC6Ozu0PJbNXiFybB/dHPSlImx7zzUZguZ
         8LcHEYYFge8iWKK4cFdK9X8+5HitSKIzEOO7qtnIYRr7T7PPcp2QPLR72W+fQtJhjcFu
         LbTaQGCgGkU2jPJt8GZOj4I63HC+gjWylsr7n+Y4p5uniy9+P5p5ttRLdahoX7Ll8fs6
         br6rKTfpPoT+0NaSpNnSCONYgpLC3kdHUizZMTIK1XRFRDfgc1FjhXGrNWFi6QWWJhFd
         WeBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZGNpN3vg61fGmly5H9eayrimBApRwl76WDhfWNnzdxCxX+V6RUF1v0LNE4xqto0nofOb69dk7WOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP69XH1vQrmZXGP4QojQdtLXiH8KrtzAx6JaB7j8IzVoQnKMFo
	y7oqavljIZuE4aNx9qJtRy5nmlcKSrH+SxOVnVjN3fHNgOEb3MpFeOHdCjLk92Rb4s8=
X-Gm-Gg: ASbGncsse5ve8kbI6ctMI8R/LodZH/S8xHVOuUZAT+cHVwxfS7Vaay436IPs4CfOdOj
	ZnNwIQ+YqyKnzKfVXt+6UXIL8C9JM9luef6wu4Lrzs7NIzHw/oQ3rKObZvTIcrj3raxGztyBM+W
	VNOhuMgUC7/2ergLEn4vuGN9EhffaahuUxm8wh4JrCUsJdjGkhGaJXBxxrQrYE3Cq1DVq6HAyTZ
	ME9im4IMmPAW2T/UdsdWxK4/Cv7gNX2LwCqgmHRXl+cL8Gy2HElFbcuvmNB1YDahzuLzRUuQwaj
	5s1mYEJmZnpoH525lG34X+jjSVPPpPZywitPurhve46oDd8eexn2H4J/dQ/SlmvqPlxeUDr3+Sl
	ACTrzUUmdrSzet0mQy2l3ioCpjB3DPEo6LEKtlXoYaE5WMcJFh6kOouoIWf43ofU9bQ/wU/FHcp
	y2uDVdasR1AA==
X-Google-Smtp-Source: AGHT+IHv/cj9QPj0Xaj48+NQlEaqkXohGqTBeFoIfPjGnGZ1QBtJfJPNw7G+QILYdF6U1Sz0Gpz+mA==
X-Received: by 2002:a05:6870:a928:b0:315:ac30:a539 with SMTP id 586e51a60fabf-315ac30a9c8mr2606623fac.36.1756489178478;
        Fri, 29 Aug 2025 10:39:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-315afe62235sm1497011fac.23.2025.08.29.10.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:39:38 -0700 (PDT)
Message-ID: <cc75ef15-91b4-4468-88ae-b71507637f46@baylibre.com>
Date: Fri, 29 Aug 2025 12:39:37 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: temperature: add support for MCP998X
To: victor.duicu@microchip.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: marius.cristea@microchip.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250829143447.18893-1-victor.duicu@microchip.com>
 <20250829143447.18893-3-victor.duicu@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250829143447.18893-3-victor.duicu@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 9:34 AM, victor.duicu@microchip.com wrote:
> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This is the driver for Microchip MCP998X/33 and MCP998XD/33D
> Multichannel Automotive Temperature Monitor Family.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> ---
>  MAINTAINERS                       |   7 +
>  drivers/iio/temperature/Kconfig   |  10 +
>  drivers/iio/temperature/Makefile  |   1 +
>  drivers/iio/temperature/mcp9982.c | 889 ++++++++++++++++++++++++++++++
>  4 files changed, 907 insertions(+)
>  create mode 100644 drivers/iio/temperature/mcp9982.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 76cba707a2c9..6e969f3913f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16622,6 +16622,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
>  F:	drivers/iio/adc/mcp3911.c
>  
> +MICROCHIP MCP9982 TEMPERATURE DRIVER
> +M:	Victor Duicu <victor.duicu@microchip.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
> +F:	drivers/iio/temperature/mcp9982.c
> +
>  MICROCHIP MMC/SD/SDIO MCI DRIVER
>  M:	Aubin Constans <aubin.constans@microchip.com>
>  S:	Maintained
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 1244d8e17d50..e72b49f95f86 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -182,4 +182,14 @@ config MCP9600
>  	  This driver can also be built as a module. If so, the module
>  	  will be called mcp9600.
>  
> +config MCP9982
> +       tristate "Microchip Technology MCP9982 driver"
> +       depends on I2C
> +       help
> +         Say yes here to build support for Microchip Technology's MCP998X/33
> +         and MCP998XD/33D Multichannel Automotive Temperature Monitor Family.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called mcp9982.
> +
>  endmenu
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index 07d6e65709f7..83f5f4bb4ff3 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_MAX30208) += max30208.o
>  obj-$(CONFIG_MAX31856) += max31856.o
>  obj-$(CONFIG_MAX31865) += max31865.o
>  obj-$(CONFIG_MCP9600) += mcp9600.o
> +obj-$(CONFIG_MCP9982) += mcp9982.o
>  obj-$(CONFIG_MLX90614) += mlx90614.o
>  obj-$(CONFIG_MLX90632) += mlx90632.o
>  obj-$(CONFIG_MLX90632) += mlx90635.o
> diff --git a/drivers/iio/temperature/mcp9982.c b/drivers/iio/temperature/mcp9982.c
> new file mode 100644
> index 000000000000..2f0b9c4674fb
> --- /dev/null
> +++ b/drivers/iio/temperature/mcp9982.c
> @@ -0,0 +1,889 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for MCP998X/33 and MCP998XD/33D Multichannel Automotive Temperature Monitor Family
> + *
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Victor Duicu <victor.duicu@microchip.com>
> + *
> + * Datasheet can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device/devres.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/math64.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/string.h>
> +#include <linux/units.h>
> +
> +/* MCP9982 Registers */
> +#define MCP9982_INT_VALUE_ADDR(index)		(2 * (index))
> +#define MCP9982_FRAC_VALUE_ADDR(index)		(2 * (index) + 1)

It looks like these hare high byte and low byte, not intger and
fractional parts. Same applies to other registers below.

> +#define MCP9982_ONE_SHOT_ADDR			0x0A
> +#define MCP9982_INTERNAL_HIGH_LIMIT_ADDR	0x0B
> +#define MCP9982_INTERNAL_LOW_LIMIT_ADDR		0x0C
> +#define MCP9982_EXT1_HIGH_LIMIT_INT_VALUE_ADDR	0x0D
> +#define MCP9982_EXT1_HIGH_LIMIT_FRAC_VALUE_ADDR	0x0E
> +#define MCP9982_EXT1_LOW_LIMIT_INT_VALUE_ADDR	0x0F
> +#define MCP9982_EXT1_LOW_LIMIT_FRAC_VALUE_ADDR	0x10
> +#define MCP9982_INTERNAL_THERM_LIMIT_ADDR	0x1D
> +#define MCP9982_EXT1_THERM_LIMIT_ADDR		0x1E
> +#define MCP9982_CFG_ADDR			0x22
> +#define MCP9982_CONV_ADDR			0x24
> +#define MCP9982_HYS_ADDR			0x25
> +#define MCP9982_CONSEC_ALRT_ADDR		0x26
> +#define MCP9982_ALRT_CFG_ADDR			0x27
> +#define MCP9982_RUNNING_AVG_ADDR		0x28
> +#define MCP9982_HOTTEST_CFG_ADDR		0x29
> +#define MCP9982_STATUS_ADDR			0x2A
> +#define MCP9982_EXT_FAULT_STATUS_ADDR		0x2B
> +#define MCP9982_HIGH_LIMIT_STATUS_ADDR		0x2C
> +#define MCP9982_LOW_LIMIT_STATUS_ADDR		0x2D
> +#define MCP9982_THERM_LIMIT_STATUS_ADDR		0x2E
> +#define MCP9982_HOTTEST_INT_VALUE_ADDR		0x2F
> +#define MCP9982_HOTTEST_FRAC_VALUE_ADDR		0x30
> +#define MCP9982_HOTTEST_STATUS_ADDR		0x31
> +#define MCP9982_THERM_SHTDWN_CFG_ADDR		0x32
> +#define MCP9982_HRDW_THERM_SHTDWN_LIMIT_ADDR	0x33
> +/* 52 is the start address for the beta registers */
> +#define MCP9982_EXT_BETA_CFG_ADDR(index)	((index) + 52)
> +/* 54 is the start address for ideality registers */
> +#define MCP9982_EXT_IDEAL_ADDR(index)		((index) + 54)
> +
> +/* MCP9982 Bits */
> +#define MCP9982_CFG_MSKAL			BIT(7)
> +#define MCP9982_CFG_RS				BIT(6)
> +#define MCP9982_CFG_ATTHM			BIT(5)
> +#define MCP9982_CFG_RECD12			BIT(4)
> +#define MCP9982_CFG_RECD34			BIT(3)
> +#define MCP9982_CFG_RANGE			BIT(2)
> +#define MCP9982_CFG_DA_ENA			BIT(1)
> +#define MCP9982_CFG_APDD			BIT(0)
> +#define MCP9982_STATUS_BUSY			BIT(5)
> +
> +/* The maximum number of channels a member of the family can have */
> +#define MCP9982_MAX_NUM_CHANNELS		5
> +#define MCP9982_BETA_AUTODETECT			16
> +#define MCP9982_OFFSET				-64
> +# define MCP9982_SCALE				3906250
> +
> +#define MCP9982_CHAN(index, si, __address) ({						\
> +	struct iio_chan_spec __chan = {							\
> +		.type = IIO_TEMP,							\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),			\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
> +		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |			\
> +		BIT(IIO_CHAN_INFO_HYSTERESIS) |						\
> +		BIT(IIO_CHAN_INFO_OFFSET) |						\
> +		BIT(IIO_CHAN_INFO_SCALE),						\
> +		.channel = index,							\
> +		.address = __address,							\
> +		.scan_index = si,							\
> +		.scan_type = {								\
> +			.sign = 'u',							\
> +			.realbits = 8,							\
> +			.storagebits = 8,						\
> +		},									\
> +		.indexed = 1,								\
> +	};										\
> +	__chan;										\
> +})
> +
> +/**
> + * struct mcp9982_features - features of a mcp9982 instance
> + * @name:			chip's name
> + * @phys_channels:		number of physical channels supported by the chip
> + * @hw_thermal_shutdown:	presence of hardware thermal shutdown circuitry
> + * @allow_apdd			whether the chip supports enabling APDD
> + */
> +struct mcp9982_features {
> +	const char	*name;
> +	u8		phys_channels;
> +	bool		hw_thermal_shutdown;
> +	bool		allow_apdd;
> +};
> +
> +static const struct mcp9982_features mcp9933_chip_config = {
> +	.name = "mcp9933",
> +	.phys_channels = 3,
> +	.hw_thermal_shutdown = 0,
> +	.allow_apdd = 1,
> +};
> +
> +static const struct mcp9982_features mcp9933d_chip_config = {
> +	.name = "mcp9933d",
> +	.phys_channels = 3,
> +	.hw_thermal_shutdown = 1,
> +	.allow_apdd = 1,
> +};
> +
> +static const struct mcp9982_features mcp9982_chip_config = {
> +	.name = "mcp9982",
> +	.phys_channels = 2,
> +	.hw_thermal_shutdown = 0,
> +	.allow_apdd = 0,
> +};
> +
> +static const struct mcp9982_features mcp9982d_chip_config = {
> +	.name = "mcp9982d",
> +	.phys_channels = 2,
> +	.hw_thermal_shutdown = 1,
> +	.allow_apdd = 0,
> +};
> +
> +static const struct mcp9982_features mcp9983_chip_config = {
> +	.name = "mcp9983",
> +	.phys_channels = 3,
> +	.hw_thermal_shutdown = 0,
> +	.allow_apdd = 0,
> +};
> +
> +static const struct mcp9982_features mcp9983d_chip_config = {
> +	.name = "mcp9983d",
> +	.phys_channels = 3,
> +	.hw_thermal_shutdown = 1,
> +	.allow_apdd = 0,
> +};
> +
> +static const struct mcp9982_features mcp9984_chip_config = {
> +	.name = "mcp9984",
> +	.phys_channels = 4,
> +	.hw_thermal_shutdown = 0,
> +	.allow_apdd = 1,
> +};
> +
> +static const struct mcp9982_features mcp9984d_chip_config = {
> +	.name = "mcp9984d",
> +	.phys_channels = 4,
> +	.hw_thermal_shutdown = 1,
> +	.allow_apdd = 1,
> +};
> +
> +static const struct mcp9982_features mcp9985_chip_config = {
> +	.name = "mcp9985",
> +	.phys_channels = 5,
> +	.hw_thermal_shutdown = 0,
> +	.allow_apdd = 1,
> +};
> +
> +static const struct mcp9982_features mcp9985d_chip_config = {
> +	.name = "mcp9985d",
> +	.phys_channels = 5,
> +	.hw_thermal_shutdown = 1,
> +	.allow_apdd = 1,
> +};
> +
> +static const unsigned int mcp9982_conv_rate[][2] = {
> +	{ 0, 62500 },
> +	{ 0, 125000 },
> +	{ 0, 250000 },
> +	{ 0, 500000 },
> +	{ 1, 0 },
> +	{ 2, 0 },
> +	{ 4, 0 },
> +	{ 8, 0 },
> +	{ 16, 0 },
> +	{ 32, 0 },
> +	{ 64, 0 },
> +};
> +
> +static unsigned int mcp9982_3db_values_map_tbl[11][3][2];

Probably preferable to just hard-code the table so it can be static const.

> +
> +struct division {

Should have mcp9982_ prefix to avoid poential identifier name conflicts.

Or just make it an anonymous struct since it isn't used anywhere else.

> +	u8 integer;
> +	u8 fract;

numerator/denominator would make more sense for division.

> +};
> +
> +static const struct division mcp9982_sampl_fr[11] = {

s/sampl_fr/sample_freq/ 

> +	{ 1, 16 },
> +	{ 1, 8 },
> +	{ 1, 4 },
> +	{ 1, 2 },
> +	{ 1, 1 },
> +	{ 2, 1 },
> +	{ 4, 1 },
> +	{ 8, 1 },
> +	{ 16, 1 },
> +	{ 32, 1 },
> +	{ 64, 1 },
> +};

These value are the same as mcp9982_conv_rate, just in different form. Do
we really need both?

> +
> +/* The delay, in milliseconds, nedded to allow the conversion to end */

s/nedded/needed/

> +static const u64 mcp9982_delay_ms[11] = {
> +	16125,
> +	8125,
> +	4125,
> +	2125,
> +	1125,
> +	625,
> +	375,
> +	255,
> +	190,
> +	160,
> +	145,
> +};
> +
> +static const unsigned int mcp9982_window_size[3] = { 1, 4, 8 };
> +
> +/* (Sampling_Frequency(Hz) * 1000000) / (Window_Size * 2) */
> +static unsigned int mcp9982_calc_all_3db_values(void)

Return value is not checked, so can be void.

> +{
> +	u32 denominator, remainder;
> +	unsigned int i, j;
> +	u64 numerator;
> +
> +	for (i = 0; i < ARRAY_SIZE(mcp9982_window_size); i++) {
> +		for (j = 0; j <  ARRAY_SIZE(mcp9982_sampl_fr); j++) {
> +			numerator = MICRO * mcp9982_sampl_fr[j].integer;
> +			denominator = 2 * mcp9982_window_size[i] *
> +				      mcp9982_sampl_fr[j].fract;
> +			remainder = do_div(numerator, denominator);

This remainder gets written over immediatly, so this has no effect.

> +			remainder = do_div(numerator, MICRO);
> +			mcp9982_3db_values_map_tbl[j][i][0] = numerator;
> +			mcp9982_3db_values_map_tbl[j][i][1] = remainder;

I'm not sure I understand the math here. [1] says that computing the 3dB point
for a moving average requires at least a square root somewhere. So as suggested
above, a hard-coded table would make more sense.

Also, since one of the options for the filter is disabled, it would technically
have an infinite 3dB point. Not sure what is the best way to handle that.

There is an ongoing discussion in [1] where we have a similar situation.
There, to enable/disable the filter, we are considering to use the filter_type
attribute and only use the 3dB attribute to set the strenght. But there is
still an open question of what the 3dB attribute should do when the filter
is disabled.

[1]: https://lore.kernel.org/linux-iio/20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org/

> +		}
> +	}
> +	return 0;
> +}
> +
> +/* mcp9982 regmap configuration */
> +static const struct regmap_range mcp9982_regmap_wr_ranges[] = {
> +	regmap_reg_range(MCP9982_ONE_SHOT_ADDR,
> +			 MCP9982_EXT1_LOW_LIMIT_FRAC_VALUE_ADDR),
> +	regmap_reg_range(MCP9982_INTERNAL_THERM_LIMIT_ADDR,
> +			 MCP9982_EXT1_THERM_LIMIT_ADDR),
> +	regmap_reg_range(MCP9982_CFG_ADDR, MCP9982_CFG_ADDR),
> +	regmap_reg_range(MCP9982_CONV_ADDR, MCP9982_HOTTEST_CFG_ADDR),
> +	regmap_reg_range(MCP9982_THERM_SHTDWN_CFG_ADDR,
> +			 MCP9982_THERM_SHTDWN_CFG_ADDR),
> +	regmap_reg_range(MCP9982_EXT_BETA_CFG_ADDR(0),
> +			 MCP9982_EXT_IDEAL_ADDR(3)),
> +};
> +
> +static const struct regmap_access_table mcp9982_regmap_wr_table = {
> +	.yes_ranges = mcp9982_regmap_wr_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(mcp9982_regmap_wr_ranges),
> +};
> +
> +static const struct regmap_range mcp9982_regmap_rd_ranges[] = {
> +	regmap_reg_range(MCP9982_INT_VALUE_ADDR(0),
> +			 MCP9982_EXT1_LOW_LIMIT_FRAC_VALUE_ADDR),
> +	regmap_reg_range(MCP9982_INTERNAL_THERM_LIMIT_ADDR,
> +			 MCP9982_EXT1_THERM_LIMIT_ADDR),
> +	regmap_reg_range(MCP9982_CFG_ADDR, MCP9982_CFG_ADDR),
> +	regmap_reg_range(MCP9982_CONV_ADDR, MCP9982_EXT_IDEAL_ADDR(3)),
> +};
> +
> +static const struct regmap_access_table mcp9982_regmap_rd_table = {
> +	.yes_ranges = mcp9982_regmap_rd_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(mcp9982_regmap_rd_ranges),
> +};
> +
> +static bool mcp9982_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MCP9982_ONE_SHOT_ADDR:
> +	case MCP9982_INTERNAL_HIGH_LIMIT_ADDR:
> +	case MCP9982_INTERNAL_LOW_LIMIT_ADDR:
> +	case MCP9982_EXT1_HIGH_LIMIT_INT_VALUE_ADDR:
> +	case MCP9982_EXT1_HIGH_LIMIT_FRAC_VALUE_ADDR:
> +	case MCP9982_EXT1_LOW_LIMIT_INT_VALUE_ADDR:
> +	case MCP9982_EXT1_LOW_LIMIT_FRAC_VALUE_ADDR:
> +	case MCP9982_INTERNAL_THERM_LIMIT_ADDR:
> +	case MCP9982_EXT1_THERM_LIMIT_ADDR:
> +	case MCP9982_CFG_ADDR:
> +	case MCP9982_CONV_ADDR:
> +	case MCP9982_HYS_ADDR:
> +	case MCP9982_CONSEC_ALRT_ADDR:
> +	case MCP9982_ALRT_CFG_ADDR:
> +	case MCP9982_RUNNING_AVG_ADDR:
> +	case MCP9982_HOTTEST_CFG_ADDR:
> +	case MCP9982_THERM_SHTDWN_CFG_ADDR:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static const struct regmap_config mcp9982_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,

	.max_register = ?,

> +	.rd_table = &mcp9982_regmap_rd_table,
> +	.wr_table = &mcp9982_regmap_wr_table,
> +	.volatile_reg = mcp9982_is_volatile_reg,
> +};
> +
> +/**
> + * struct mcp9992_priv - information about chip parameters
> + * @regmap:			device register map
> + * @chip			pointer to structure holding chip features
> + * @lock			synchronize access to driver's state members
> + * @iio_chan			specifications of channels
> + * @labels			labels of the channels
> + * @ideality_value		ideality factor value for each external channel
> + * @sampl_idx			index representing the current sampling frequency
> + * @time_limit			time when it is safe to read
> + * @recd34_enable		state of REC on channels 3 and 4
> + * @recd12_enable		state of REC on channels 1 and 2
> + * @apdd_enable			state of anti-parallel diode mode
> + * @run_state			chip is in run state, otherwise is in standby state
> + * @wait_before_read		whether we need to wait a delay before reading a new value
> + * @num_channels		number of active physical channels
> + */
> +struct mcp9982_priv {
> +	struct regmap *regmap;
> +	const struct mcp9982_features *chip;
> +	/*
> +	 * Synchronize access to private members, and ensure atomicity of
> +	 * consecutive regmap operations.
> +	 */
> +	struct mutex lock;
> +	struct iio_chan_spec *iio_chan;
> +	const char *labels[MCP9982_MAX_NUM_CHANNELS];
> +	unsigned int ideality_value[4];
> +	unsigned int sampl_idx;
> +	unsigned long  time_limit;
> +	bool recd34_enable;
> +	bool recd12_enable;
> +	bool apdd_enable;
> +	bool run_state;
> +	bool wait_before_read;
> +	u8 num_channels;
> +};
> +
> +static int mcp9982_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, const int **vals,
> +			      int *type, int *length, long mask)
> +{
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	unsigned int idx = 0;
> +	unsigned int sub = 0;
> +
> +	if (priv->chip->hw_thermal_shutdown) {
> +		idx = 4;
> +		sub = 8;
> +	}
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*vals = mcp9982_conv_rate[idx];
> +		*length = ARRAY_SIZE(mcp9982_conv_rate) * 2 - sub;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*vals = mcp9982_3db_values_map_tbl[priv->sampl_idx][0];
> +		*length = ARRAY_SIZE(mcp9982_3db_values_map_tbl[priv->sampl_idx]) * 2;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp9982_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	unsigned int idx, tmp_reg, reg_status;
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!priv->run_state) {
> +		ret = regmap_write(priv->regmap, MCP9982_ONE_SHOT_ADDR, 1);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * This delay waits for system start-up, as specified by
> +		 * time to first conversion from standby
> +		 */
> +		mdelay(125);
> +		ret = regmap_read_poll_timeout(priv->regmap, MCP9982_STATUS_ADDR,
> +					       reg_status,
> +					       !(reg_status & MCP9982_STATUS_BUSY),
> +					       mcp9982_delay_ms[priv->sampl_idx] * 1000,
> +					       1000 * mcp9982_delay_ms[priv->sampl_idx] * 1000);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/*
> +		 * When working in Run mode, after modifying a parameter (like sampling
> +		 * frequency) we have to wait a delay before reading the new values.
> +		 * We can't determine when the conversion is done based on BUSY bit.
> +		 */
> +		if (priv->wait_before_read) {
> +			if (!time_after(jiffies, priv->time_limit))
> +				mdelay(jiffies_to_msecs(priv->time_limit - jiffies));
> +			priv->wait_before_read = false;
> +		}
> +	}
> +	guard(mutex)(&priv->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(priv->regmap,
> +				  MCP9982_INT_VALUE_ADDR(chan->channel), val);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(priv->regmap,
> +				  MCP9982_FRAC_VALUE_ADDR(chan->channel), val2);
> +		if (ret)
> +			return ret;

Would be better to make new local variables for the register values.

Also, why not using regmap bulk read?

> +
> +		*val = (*val << 8) + (*val2);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = MCP9982_SCALE;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = mcp9982_conv_rate[priv->sampl_idx][0];
> +		*val2 = mcp9982_conv_rate[priv->sampl_idx][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		ret = regmap_read(priv->regmap, MCP9982_RUNNING_AVG_ADDR, &tmp_reg);
> +		if (ret)
> +			return ret;
> +
> +		switch (tmp_reg) {
> +		case 0:
> +		case 1:
> +			idx = tmp_reg;
> +			break;
> +		case 2:
> +			idx = 1;
> +			break;
> +		default:
> +			idx = 2;
> +			break;
> +		}

Could possibly replace this with bitmap_weight().

> +
> +		*val = mcp9982_3db_values_map_tbl[priv->sampl_idx][idx][0];
> +		*val2 = mcp9982_3db_values_map_tbl[priv->sampl_idx][idx][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		ret = regmap_read(priv->regmap, MCP9982_HYS_ADDR, &idx);
> +		if (ret)
> +			return ret;
> +
> +		*val = idx;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = MCP9982_OFFSET;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp9982_read_label(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, char *label)
> +{
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +
> +	if (chan->channel < 0 || chan->channel > 4)
> +		return -EINVAL;
> +
> +	return sysfs_emit(label, "%s\n", priv->labels[chan->channel]);
> +}
> +
> +static int mcp9982_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan, long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		return IIO_VAL_INT_PLUS_MICRO;

Can combine cases:

	case IIO_CHAN_INFO_SAMP_FREQ:
	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
		return IIO_VAL_INT_PLUS_MICRO;

> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp9982_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	unsigned int i, start, previous_sampl_idx;
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +	unsigned long new_time_limit;
> +
> +	start = 0;
> +	guard(mutex)(&priv->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		previous_sampl_idx = priv->sampl_idx;
> +		/*
> +		 * For MCP998XD and MCP9933D sampling frequency can't
> +		 * be set lower than 1.
> +		 */
> +		if (priv->chip->hw_thermal_shutdown)
> +			start = 4;
> +		for (i = start; i < ARRAY_SIZE(mcp9982_conv_rate); i++)
> +			if (val == mcp9982_conv_rate[i][0] &&
> +			    val2 == mcp9982_conv_rate[i][1])
> +				break;
> +
> +		if (i == ARRAY_SIZE(mcp9982_conv_rate))
> +			return -EINVAL;
> +
> +		ret = regmap_write(priv->regmap, MCP9982_CONV_ADDR, i);
> +		if (ret)
> +			return ret;
> +
> +		priv->sampl_idx = i;
> +
> +		/*
> +		 * in Run mode, when changing the frequency, wait a delay based
> +		 * on the previous value to ensure the new value becomes active
> +		 */
> +		if (priv->run_state) {
> +			new_time_limit = jiffies +
> +					   msecs_to_jiffies(mcp9982_delay_ms[previous_sampl_idx]);
> +			if (time_after(new_time_limit, priv->time_limit)) {
> +				priv->time_limit = new_time_limit;
> +				priv->wait_before_read = true;
> +			}
> +			return 0;

This seems redunant with the break path.

> +		}
> +
> +		break;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		for (i = 0; i < ARRAY_SIZE(mcp9982_3db_values_map_tbl[priv->sampl_idx]); i++)
> +			if (val == mcp9982_3db_values_map_tbl[priv->sampl_idx][i][0] &&
> +			    val2 == mcp9982_3db_values_map_tbl[priv->sampl_idx][i][1])
> +				break;
> +
> +		if (i == ARRAY_SIZE(mcp9982_3db_values_map_tbl[priv->sampl_idx]))
> +			return -EINVAL;
> +
> +		/*
> +		 * In mcp9982_3db_values_map_tbl the second index maps:
> +		 * 0 for filter off
> +		 * 1 for filter at level 1
> +		 * 2 for filter at level 2
> +		 */
> +		if (i == 2)
> +			i = 3;
> +		/*
> +		 * If the digital filter is activated for chips without "D", set
> +		 * the power state to Run to ensure the averaging is made on
> +		 * fresh values.
> +		 */
> +		if (!priv->chip->hw_thermal_shutdown) {
> +			if (i == 0) {
> +				ret = regmap_assign_bits(priv->regmap,
> +							 MCP9982_CFG_ADDR,
> +							 MCP9982_CFG_RS, 1);
> +				priv->run_state = 0;
> +			} else {
> +				ret = regmap_assign_bits(priv->regmap,
> +							 MCP9982_CFG_ADDR,
> +							 MCP9982_CFG_RS, 0);
> +				priv->run_state = 1;
> +			}
> +		}
> +
> +		ret = regmap_write(priv->regmap, MCP9982_RUNNING_AVG_ADDR, i);
> +		if (ret)
> +			return ret;
> +		break;
> +	case IIO_CHAN_INFO_HYSTERESIS:

Isn't the hysteresis for the limits, and therefor should be an event
attribute rather than on the main temerature attribute?

> +		if (val < 0 || val > 255)
> +			return -EINVAL;
> +
> +		ret = regmap_write(priv->regmap, MCP9982_HYS_ADDR, val);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (priv->run_state) {
> +		new_time_limit = jiffies +
> +				 msecs_to_jiffies(mcp9982_delay_ms[priv->sampl_idx]);
> +		if (time_after(new_time_limit, priv->time_limit)) {
> +			priv->time_limit = new_time_limit;
> +			priv->wait_before_read = true;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info mcp9982_info = {
> +	.read_raw = mcp9982_read_raw,
> +	.read_label = mcp9982_read_label,
> +	.read_avail = mcp9982_read_avail,
> +	.write_raw_get_fmt = mcp9982_write_raw_get_fmt,
> +	.write_raw = mcp9982_write_raw,
> +};
> +
> +static int mcp9982_init(struct mcp9982_priv *priv)
> +{
> +	int ret;
> +	unsigned int i;
> +	u8 val;
> +
> +	/* Chips 82/83 and 82D/83D do not support anti-parallel diode mode */
> +	if (!priv->chip->allow_apdd)
> +		priv->apdd_enable = 0;

I think we would usually return an error if the firmware requested something
that was not allowed.

> +
> +	/*
> +	 * Chips with "D" work in Run state and those without work
> +	 * in Standby state
> +	 */
> +	if (priv->chip->hw_thermal_shutdown)
> +		priv->run_state = 1;
> +	else
> +		priv->run_state = 0;
> +
> +	/*
> +	 * For chips with "D" in the name set the below parameters to default to
> +	 * ensure that hardware shutdown feature can't be overridden.
> +	 */
> +	if (priv->chip->hw_thermal_shutdown) {
> +		priv->recd12_enable = true;
> +		priv->recd34_enable = true;
> +	}
> +
> +	/*
> +	 * Set default values in registers. APDD, RECD12 and RECD34 are active
> +	 * on 0.
> +	 */
> +	val = FIELD_PREP(MCP9982_CFG_MSKAL, 1) |
> +	      FIELD_PREP(MCP9982_CFG_RS, !priv->run_state) |
> +	      FIELD_PREP(MCP9982_CFG_ATTHM, 1) |
> +	      FIELD_PREP(MCP9982_CFG_RECD12, !priv->recd12_enable) |
> +	      FIELD_PREP(MCP9982_CFG_RECD34, !priv->recd34_enable) |
> +	      FIELD_PREP(MCP9982_CFG_RANGE, 1) | FIELD_PREP(MCP9982_CFG_DA_ENA, 0) |
> +	      FIELD_PREP(MCP9982_CFG_APDD, !priv->apdd_enable);
> +
> +	ret = regmap_write(priv->regmap, MCP9982_CFG_ADDR, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_CONV_ADDR, 6);
> +	if (ret)
> +		return ret;
> +	priv->sampl_idx = 6;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_HYS_ADDR, 10);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_CONSEC_ALRT_ADDR, 112);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_RUNNING_AVG_ADDR, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_HOTTEST_CFG_ADDR, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Set auto-detection beta compensation for channels 1 and 2 */
> +	for (i = 0; i < 2; i++) {
> +		ret = regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(i),
> +				   MCP9982_BETA_AUTODETECT);
> +		if (ret)
> +			return ret;
> +	}
> +	/* Set ideality factor for all external channels */
> +	for (i = 0; i < ARRAY_SIZE(priv->ideality_value); i++) {
> +		ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL_ADDR(i),
> +				   priv->ideality_value[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	priv->wait_before_read = false;
> +	priv->time_limit = jiffies;
> +
> +	return 0;
> +}
> +
> +static int mcp9982_parse_of_config(struct iio_dev *indio_dev, struct device *dev,
> +				   int device_nr_channels)
> +{
> +	unsigned int reg_nr, iio_idx;
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +
> +	priv->apdd_enable = device_property_read_bool(dev,
> +						      "microchip,enable-anti-parallel");
> +
> +	priv->recd12_enable = device_property_read_bool(dev,
> +							"microchip,parasitic-res-on-channel1-2");
> +
> +	priv->recd34_enable = device_property_read_bool(dev,
> +							"microchip,parasitic-res-on-channel3-4");

For cases like the above, we usually just indent one tab instead of
aligning to the "(".

> +
> +	priv->num_channels = device_get_child_node_count(dev) + 1;
> +
> +	if (priv->num_channels > device_nr_channels)
> +		return dev_err_probe(dev, -E2BIG,
> +				     "More channels than the chip supports\n");
> +
> +	priv->iio_chan = devm_kcalloc(dev, priv->num_channels,
> +				      sizeof(*priv->iio_chan), GFP_KERNEL);
> +	if (!priv->iio_chan)
> +		return -ENOMEM;
> +
> +	priv->iio_chan[0] = MCP9982_CHAN(0, 0, MCP9982_INT_VALUE_ADDR(0));
> +
> +	priv->labels[0] = "internal diode";
> +	iio_idx++;
> +	device_for_each_child_node_scoped(dev, child) {
> +		fwnode_property_read_u32(child, "reg", &reg_nr);
> +		if (!reg_nr || reg_nr >= device_nr_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +				     "The index of the channels does not match the chip\n");
> +
> +		priv->ideality_value[reg_nr - 1] = 18;
> +		if (fwnode_property_present(child, "microchip,ideality-factor")) {
> +			fwnode_property_read_u32(child, "microchip,ideality-factor",
> +						 &priv->ideality_value[reg_nr - 1]);

Can just check return value of fwnode_property_read_u32() for -EINVAL instead of
doing separate check for fwnode_property_present().

> +			if (priv->ideality_value[reg_nr - 1] > 63)
> +				return dev_err_probe(dev, -EOVERFLOW,
> +				     "The ideality value is higher than maximum\n");
> +		}
> +
> +		fwnode_property_read_string(child, "label",
> +					    &priv->labels[reg_nr]);
> +
> +		priv->iio_chan[iio_idx++] = MCP9982_CHAN(reg_nr, reg_nr,
> +							 MCP9982_INT_VALUE_ADDR(reg_nr));
> +	}
> +
> +	return 0;
> +}
> +
> +static int mcp9982_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct mcp9982_priv *priv;
> +	struct iio_dev *indio_dev;
> +	const struct mcp9982_features *chip;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	priv->regmap = devm_regmap_init_i2c(client, &mcp9982_regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Cannot initialize register map\n");
> +
> +	ret = devm_mutex_init(dev, &priv->lock);
> +	if (ret)
> +		return ret;
> +
> +	chip = i2c_get_match_data(client);
> +	if (!chip)
> +		return -EINVAL;
> +	priv->chip = chip;
> +
> +	ret = mcp9982_parse_of_config(indio_dev, &client->dev, chip->phys_channels);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Parameter parsing error\n");

mcp9982_parse_of_config() already prints some errors, so doing it again
is a bit reduanant.

> +
> +	mcp9982_calc_all_3db_values();
> +	ret = mcp9982_init(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot initialize device\n");
> +
> +	indio_dev->name = chip->name;
> +	indio_dev->info = &mcp9982_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = priv->iio_chan;
> +	indio_dev->num_channels = priv->num_channels;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot register IIO device\n");
> +
> +	return 0;
> +}

