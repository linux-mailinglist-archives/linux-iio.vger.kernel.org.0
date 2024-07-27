Return-Path: <linux-iio+bounces-7958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF48A93DE59
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 11:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48627B21F93
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 09:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904744653A;
	Sat, 27 Jul 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iibC0LT+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421C7383B2;
	Sat, 27 Jul 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722073890; cv=none; b=r9kYSlfOvib+/MVDixgv2WRbvML4w+lkZFWZOfks4zKOpTfdhI0LlF6Y8f1GrMHKUdZlB1aul9GndLqPtmsPZ+1czFVVL9yDxC651DeiG0/+WEsEvjWHsn3HCy+GiuZqGmbLNTcpMywvXj01isjPp8kyQPYAWrgdrq7RiErkYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722073890; c=relaxed/simple;
	bh=qEb4NWfCNnDOT3pJDMSegBfpZylFDRXJ8vZw2R46gs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHdoB8wbzRZ95uDb04EJckCItGC0VHSVBDTPr0RWTnNsKekJx0xmqJ92Z1FEWoNzjimVOkTC6nCu1EFIRhiltR20L/MkU+GMna9liO88glMX++YPGAEtMlY6TFdUzqgPc0xLnR7Da+zB4N/W+aISSVFK6qRGroHpPcwOPkAOQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iibC0LT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6064C32781;
	Sat, 27 Jul 2024 09:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722073889;
	bh=qEb4NWfCNnDOT3pJDMSegBfpZylFDRXJ8vZw2R46gs4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iibC0LT+SvydpWUp7fkcAL9po8tIf9H5Y2nYkg4UQPL39OURuSgSq9i0BJ3Fkod7N
	 GAcYJYlwZTcznatQS3STv0YKmUUjt21Tjp73m2qNwHJC+2yfoq+3sIDAvDiGVOMEeJ
	 PnfQ2z3uEM+0SBgIDCi36nW30E7zP8IHN8qDt94M8SsiazD6IcdTiy7c4hNyvILwsq
	 4m0fXXGrgnwI+bXYsvRpBZg7RYaD84lUcQniZQ5il7dQmEqEfiLF1QbyX45NC0xHMi
	 Uk/rmZ4dFx8e2+o6pUOvlUHp5ryBur1uj8E4AGHN9sq/dM2FHoQdw3gQnQTRam98ON
	 rWctFkkFf63ag==
Message-ID: <3ef6c902-b004-4aa0-96c9-dabd81a01a6a@kernel.org>
Date: Sat, 27 Jul 2024 11:51:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/2] iio: proximity: aw9610x: Add support for aw9610x
 proximity sensor
To: wangshuaijie@awinic.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 waqar.hameed@axis.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: liweilei@awinic.com, kangjiajun@awinic.com
References: <20240726061312.1371450-1-wangshuaijie@awinic.com>
 <20240726061312.1371450-3-wangshuaijie@awinic.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240726061312.1371450-3-wangshuaijie@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/07/2024 08:13, wangshuaijie@awinic.com wrote:
> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> AW9610X is a low power consumption capacitive touch and proximity controller.
> Each channel can be independently config as sensor input, shield output.
> 
> Channel Information:
>   aw96103: 3-channel
>   aw96105: 5-channel
> 
> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
> ---
>  drivers/iio/proximity/Kconfig   |  11 +
>  drivers/iio/proximity/Makefile  |   1 +
>  drivers/iio/proximity/aw9610x.c | 791 ++++++++++++++++++++++++++++++++
>  drivers/iio/proximity/aw9610x.h | 140 ++++++
>  4 files changed, 943 insertions(+)
>  create mode 100644 drivers/iio/proximity/aw9610x.c
>  create mode 100644 drivers/iio/proximity/aw9610x.h
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 2ca3b0bc5eba..ca1b8bde2def 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -219,4 +219,15 @@ config VL53L0X_I2C
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called vl53l0x-i2c.
>  
> +config AW9610X
> +	tristate "Awinic AW9610X proximity sensor"
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +	  Say Y here to build a driver for Awinic's AW9610X capacitive
> +	  proximity sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called aw9610x.
> +
>  endmenu
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index f36598380446..483f5bf1ac8b 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -21,4 +21,5 @@ obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
>  obj-$(CONFIG_SX9500)		+= sx9500.o
>  obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
>  obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
> +obj-$(CONFIG_AW9610X)		+= aw9610x.o
>  
> diff --git a/drivers/iio/proximity/aw9610x.c b/drivers/iio/proximity/aw9610x.c
> new file mode 100644
> index 000000000000..de5be3918e4f
> --- /dev/null
> +++ b/drivers/iio/proximity/aw9610x.c
> @@ -0,0 +1,791 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AWINIC aw9610x proximity sensor driver
> + *
> + * Author: Wang Shuaijie <wangshuaijie@awinic.com>
> + *
> + * Copyright (c) 2024 awinic Technology CO., LTD
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>

Where do you use it?

> +#include <linux/interrupt.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/of_gpio.h>

Where do you use it?

> +#include <linux/power_supply.h>
> +#include <linux/pinctrl/consumer.h>

Where do you use it?

> +#include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>

Maybe several others are not used...

> +#include "aw9610x.h"
> +
> +static unsigned int aw9610x_reg_default[] = {

Why this cannot be const?

> +	0x0000, 0x00003f3f, 0x0004, 0x00000064, 0x0008, 0x0017c11e,
> +	0x000c, 0x05000000, 0x0010, 0x00093ffd, 0x0014, 0x19240009,
> +	0x0018, 0xd81c0207, 0x001c, 0xff000000, 0x0020, 0x00241900,
> +	0x0024, 0x00093ff7, 0x0028, 0x58020009, 0x002c, 0xd81c0207,
> +	0x0030, 0xff000000, 0x0034, 0x00025800, 0x0038, 0x00093fdf,
> +	0x003c, 0x7d3b0009, 0x0040, 0xd81c0207,	0x0044, 0xff000000,
> +	0x0048, 0x003b7d00, 0x004c, 0x00093f7f, 0x0050, 0xe9310009,
> +	0x0054, 0xd81c0207, 0x0058, 0xff000000,	0x005c, 0x0031e900,
> +	0x0060, 0x00093dff, 0x0064, 0x1a0c0009,	0x0068, 0xd81c0207,
> +	0x006c, 0xff000000, 0x0070, 0x000c1a00,	0x0074, 0x80093fff,
> +	0x0078, 0x043d0009, 0x007c, 0xd81c0207,	0x0080, 0xff000000,
> +	0x0084, 0x003d0400, 0x00a0, 0xe6400000,	0x00a4, 0x00000000,
> +	0x00a8, 0x010408d2, 0x00ac, 0x00000000,	0x00b0, 0x00000000,
> +	0x00b8, 0x00005fff, 0x00bc, 0x00000000,	0x00c0, 0x00000000,
> +	0x00c4, 0x00000000, 0x00c8, 0x00000000,	0x00cc, 0x00000000,
> +	0x00d0, 0x00000000, 0x00d4, 0x00000000, 0x00d8, 0x00000000,
> +	0x00dc, 0xe6447800, 0x00e0, 0x78000000,	0x00e4, 0x010408d2,
> +	0x00e8, 0x00000000, 0x00ec, 0x00000000,	0x00f4, 0x00005fff,
> +	0x00f8, 0x00000000, 0x00fc, 0x00000000,	0x0100, 0x00000000,
> +	0x0104, 0x00000000, 0x0108, 0x00000000,	0x010c, 0x02000000,
> +	0x0110, 0x00000000, 0x0114, 0x00000000,	0x0118, 0xe6447800,
> +	0x011c, 0x78000000, 0x0120, 0x010408d2,	0x0124, 0x00000000,
> +	0x0128, 0x00000000, 0x0130, 0x00005fff,	0x0134, 0x00000000,
> +	0x0138, 0x00000000, 0x013c, 0x00000000,	0x0140, 0x00000000,
> +	0x0144, 0x00000000, 0x0148, 0x02000000,	0x014c, 0x00000000,
> +	0x0150, 0x00000000, 0x0154, 0xe6447800,	0x0158, 0x78000000,
> +	0x015c, 0x010408d2, 0x0160, 0x00000000,	0x0164, 0x00000000,
> +	0x016c, 0x00005fff, 0x0170, 0x00000000,	0x0174, 0x00000000,
> +	0x0178, 0x00000000, 0x017c, 0x00000000,	0x0180, 0x00000000,
> +	0x0184, 0x02000000, 0x0188, 0x00000000,	0x018c, 0x00000000,
> +	0x0190, 0xe6447800, 0x0194, 0x78000000,	0x0198, 0x010408d2,
> +	0x019c, 0x00000000, 0x01a0, 0x00000000,	0x01a8, 0x00005fff,
> +	0x01ac, 0x00000000, 0x01b0, 0x00000000,	0x01b4, 0x00000000,
> +	0x01b8, 0x00000000, 0x01bc, 0x00000000,	0x01c0, 0x02000000,
> +	0x01c4, 0x00000000, 0x01c8, 0x00000000,	0x01cc, 0xe6407800,
> +	0x01d0, 0x78000000, 0x01d4, 0x010408d2,	0x01d8, 0x00000000,
> +	0x01dc, 0x00000000, 0x01e4, 0x00005fff,	0x01e8, 0x00000000,
> +	0x01ec, 0x00000000, 0x01f0, 0x00000000,	0x01f4, 0x00000000,
> +	0x01f8, 0x00000000, 0x01fc, 0x02000000,	0x0200, 0x00000000,
> +	0x0204, 0x00000000, 0x0208, 0x00000008,	0x020c, 0x0000000d,
> +	0x41fc, 0x00000000, 0x4400, 0x00000000,	0x4410, 0x00000000,
> +	0x4420, 0x00000000, 0x4430, 0x00000000,	0x4440, 0x00000000,
> +	0x4450, 0x00000000, 0x4460, 0x00000000,	0x4470, 0x00000000,
> +	0xf080, 0x00003018, 0xf084, 0x00000fff,	0xf800, 0x00000000,
> +	0xf804, 0x00002e00, 0xf8d0, 0x00000001,	0xf8d4, 0x00000000,
> +	0xff00, 0x00000301, 0xff0c, 0x01000000,	0xffe0, 0x00000000,
> +	0xfff4, 0x00004011, 0x0090, 0x00000000,	0x0094, 0x00000000,
> +	0x0098, 0x00000000, 0x009c, 0x3f3f3f3f,
> +};
> +

...

> +static int aw9610x_read_chipid(struct aw9610x *aw9610x)
> +{
> +	unsigned char cnt = 0;
> +	u32 reg_val;
> +	int ret;
> +
> +	while (cnt < AW_READ_CHIPID_RETRIES) {
> +		ret = aw9610x_i2c_read(aw9610x, REG_CHIPID, &reg_val);
> +		if (ret < 0) {
> +			cnt++;
> +			usleep_range(2000, 3000);
> +		} else {
> +			reg_val = FIELD_GET(AW9610X_CHIPID_MASK, reg_val);
> +			break;
> +		}
> +	}
> +
> +	if (reg_val == AW9610X_CHIP_ID)
> +		return 0;

So devices are detectable? Encode this in the bindings (oneOf and a
fallback compatible) and drop unneeded entry from ID tables.

Best regards,
Krzysztof


