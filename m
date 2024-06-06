Return-Path: <linux-iio+bounces-5902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2965C8FEF54
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C996B282C7
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 14:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EA719755F;
	Thu,  6 Jun 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORw++nXn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4319645C;
	Thu,  6 Jun 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683832; cv=none; b=KBWWxbtsDAoE9q5AMqXmd8hiWLdLdVyJ2ZgJjxTcJrILRNldRiBC22nwLVSfjg+W8rUBDlotUn6R91DRFrijNjHQdNRq3gyWhiklhRbdiDtJCoemXqz4JFI72Bjq8VVdyAZ7Js8vm/1GGVViDlM/M7zAMitReeur0PgX/8pc+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683832; c=relaxed/simple;
	bh=tyZobNsR9p2yiU7bCwhoZ5UEQhwJNcZhJm5tfJKkpmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZDVUJdSeb/XfMNvmN/+lbQF+m3cENkeWsJkfxZwj1o7fPilPfvW7rZxudggXw4BJg/SwJJoD5QVESuE0ttk3w65sRdtSVDN8CcBH6EFp/l4XQ46Hpv+SjsBzktU7CrjcBJdhv+PoE1PCSqw3nvCR1u4O3VXT7vD132lsp4s0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORw++nXn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so128653966b.2;
        Thu, 06 Jun 2024 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717683828; x=1718288628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKR/L4HU5Z5Z/11JJc83O+MA8Zq4QcFx7fvjKcAKFh8=;
        b=ORw++nXnFQZ37aeSEpWSUskkfRUXZwaXB6fR0Q+TGgZb+YkCnuOlVgQmNSX1bznrWc
         8NRvvPQ0aIIE+LoSOwvWoW87X6tJDgWwsjllsu9ZncoZcCXHwIG44M9mEidHt+zzOJUI
         JgLS3SSvhh7wLJaLMtZdmzhO7V8CofgpAr8DbREdEOM/orRWC9QsYP3yusCV0Nu6GcIv
         lD04ZdudCB2QWQilhvk560cyPcNQ0BFtH8Vd6AKlmAq18hrPCvA7MvMoOJV5CZQNPcLc
         QnTQWzFFhIYAahQXebx2NmcabFH83wwjozeJPdBmP6l1gBIRS+2U2/kFniOXgFLxW3lx
         X7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683828; x=1718288628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKR/L4HU5Z5Z/11JJc83O+MA8Zq4QcFx7fvjKcAKFh8=;
        b=NhABNvdcRTnin+GJkD2iVaqiaFnVZTdAdCZz2uiMDa0udUMKVI1RjO1lX9rJcCUsmb
         5ikqcwXAZIurMUwomgj+FMsv3DDNUSqqb8M7tXFuOXDqxGnxebNoejuaPDVUTTHr6Spj
         Y7wyAhATs4dNrxcXpYzC9aKcSM2gAZEMVeJWKnEpaX3Wo00BH7cy3objUBFkybMQHLfe
         GYuUe+/EfymEQDAgp303AU4gcaK9eMqyYFgFWeP4tMPILA2A25pXiN5IWXiSuiPSB4Sd
         Yu7i6OiPlTb8yLdUuBuqtGjoxNJM4i20SA04K7QZCmVcZH4ObAScA5WJig8flTkAJk1W
         HVPw==
X-Forwarded-Encrypted: i=1; AJvYcCXVdlmqMJrfBAj9sSgX0mrsF7Ketz3ho9NTIWtiXkKXeOXgaHb7aeSfLjwphmBncQCI84vMSaCBTrGmAdzbfYPYSPbK9ewy0N9LN6oB5FpDlFK0b8WMJbZieSrrK0XYAlUQiUUY1/M9ikRt7hE3feJqhVmdS0aDI1EfchdokrJ1dlrqHg==
X-Gm-Message-State: AOJu0YzsnHQNkYoikTSN/AiRgGUkBjN122CJGdshseWFqpDO+ouQXVCY
	tahaHtE3jAHzYBTn2jP1FgDDs6kiIcrGnEc97mhAvIKrkZg4UHHO
X-Google-Smtp-Source: AGHT+IHkmcNlLoJF1O20UYK06JG3yMQ7dEZ+CSvjhAqoOdHHHKCF7XbJNQ9BPwhS8sbGqd6iA7GB8w==
X-Received: by 2002:a17:907:c85:b0:a61:9c28:f172 with SMTP id a640c23a62f3a-a69a002e7c6mr312002966b.51.1717683828023;
        Thu, 06 Jun 2024 07:23:48 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058172esm104501666b.27.2024.06.06.07.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 07:23:47 -0700 (PDT)
Message-ID: <946b121f-a4a9-4743-8608-c2c07626a94d@gmail.com>
Date: Thu, 6 Jun 2024 16:23:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: light: ROHM BH1745 colour sensor
To: Mudit Sharma <muditsharma.info@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: ivan.orlov0322@gmail.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20240606124539.60757-1-muditsharma.info@gmail.com>
 <20240606124539.60757-4-muditsharma.info@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240606124539.60757-4-muditsharma.info@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2024 14:45, Mudit Sharma wrote:
> Add support for BH1745, which is an I2C colour sensor with red, green,
> blue and clear channels. It has a programmable active low interrupt
> pin. Interrupt occurs when the signal from the selected interrupt
> source channel crosses set interrupt threshold high or low level.
> 
> This driver includes device attributes to configure the following:
> - Interrupt pin latch: The interrupt pin can be configured to
>   be latched (until interrupt register (0x60) is read or initialized)
>   or update after each measurement.
> - Interrupt source: The colour channel that will cause the interrupt
>   when channel will cross the set threshold high or low level.
> 
> This driver also includes device attributes to present valid
> configuration options/values for:
> - Integration time
> - Interrupt colour source
> - Hardware gain
> 
> Add myself as the maintainer for this driver in MAINTAINERS.
> 
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> Reviewed-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Hi Mudit,

a few nitpicks inline.

> ---
> v2->v3:
> - Squash commit for addition to MAINTAINERS
> - Fix code style for consistency:
>   - New line before last 'return'
>   - Use variable name 'value' instead of 'val' in
>     'bh1745_set_trigger_state()'
>   - Align function parameters to match parenthesis
>   - Avoid use of magic number
> - Use named enum instead of anonymous enum
> - Use 'guard(mutex)(&data->lock)' instead of 'mutex_lock()'
>   'mutex_unlock()'
> - Only initialize 'ret' and 'value' when necessary
> - Fix and optimize logic for `in_interrupt_latch_store()` 
> - Fix error handling in irq , trigger handlers and dev attribute for
>   latch
> 
>  MAINTAINERS                |   6 +
>  drivers/iio/light/Kconfig  |  12 +
>  drivers/iio/light/Makefile |   1 +
>  drivers/iio/light/bh1745.c | 866 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 885 insertions(+)
>  create mode 100644 drivers/iio/light/bh1745.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..024c14738dc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19407,6 +19407,12 @@ S:	Supported
>  F:	drivers/power/supply/bd99954-charger.c
>  F:	drivers/power/supply/bd99954-charger.h
>  
> +ROHM BH1745 COLOUR SENSOR
> +M:	Mudit Sharma <muditsharma.info@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/light/bh1745.c
> +
>  ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
>  M:	Tomasz Duszynski <tduszyns@gmail.com>
>  S:	Maintained
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 9a587d403118..6e0bd2addf9e 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -114,6 +114,18 @@ config AS73211
>  	 This driver can also be built as a module.  If so, the module
>  	 will be called as73211.
>  
> +config BH1745
> +	tristate "ROHM BH1745 colour sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here to build support for the ROHM bh1745 colour sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called bh1745.
> +
>  config BH1750
>  	tristate "ROHM BH1750 ambient light sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index a30f906e91ba..939a701a06ac 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_APDS9300)		+= apds9300.o
>  obj-$(CONFIG_APDS9306)		+= apds9306.o
>  obj-$(CONFIG_APDS9960)		+= apds9960.o
>  obj-$(CONFIG_AS73211)		+= as73211.o
> +obj-$(CONFIG_BH1745)		+= bh1745.o
>  obj-$(CONFIG_BH1750)		+= bh1750.o
>  obj-$(CONFIG_BH1780)		+= bh1780.o
>  obj-$(CONFIG_CM32181)		+= cm32181.o
> diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
> new file mode 100644
> index 000000000000..d0b14460e7c4
> --- /dev/null
> +++ b/drivers/iio/light/bh1745.c
> @@ -0,0 +1,866 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ROHM BH1745 digital colour sensor driver
> + *
> + * Copyright (C) Mudit Sharma <muditsharma.info@gmail.com>
> + *
> + * 7-bit I2C slave addresses:
> + *  0x38 (ADDR pin low)
> + *  0x39 (ADDR pin high)
> + *
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/util_macros.h>
> +#include <linux/iio/events.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define BH1745_MOD_NAME "bh1745"
> +
> +/* BH1745 config regs */
> +#define BH1745_SYS_CTRL 0x40
> +
> +#define BH1745_MODE_CTRL_1 0x41
> +#define BH1745_MODE_CTRL_2 0x42
> +#define BH1745_MODE_CTRL_3 0x44
> +
> +#define BH1745_INTR 0x60
> +#define BH1745_INTR_STATUS BIT(7)
> +
> +#define BH1745_PERSISTENCE 0x61
> +

0x instead of 0X as you did with the rest of the addresses?

> +#define BH1745_TH_LSB 0X62
> +#define BH1745_TH_MSB 0X63
> +
> +#define BH1745_TL_LSB 0X64
> +#define BH1745_TL_MSB 0X65
> +
> +#define BH1745_THRESHOLD_MAX 0xFFFF
> +#define BH1745_THRESHOLD_MIN 0x0
> +
> +#define BH1745_MANU_ID 0X92
> +
> +/* BH1745 output regs */
> +#define BH1745_R_LSB 0x50
> +#define BH1745_R_MSB 0x51
> +#define BH1745_G_LSB 0x52
> +#define BH1745_G_MSB 0x53
> +#define BH1745_B_LSB 0x54
> +#define BH1745_B_MSB 0x55
> +#define BH1745_CLR_LSB 0x56
> +#define BH1745_CLR_MSB 0x57
> +
> +#define BH1745_SW_RESET BIT(7)
> +#define BH1745_INT_RESET BIT(6)
> +
> +#define BH1745_MEASUREMENT_TIME_MASK GENMASK(2, 0)
> +
> +#define BH1745_RGBC_EN BIT(4)
> +
> +#define BH1745_ADC_GAIN_MASK GENMASK(1, 0)
> +
> +#define BH1745_INT_ENABLE BIT(0)
> +#define BH1745_INT_SIGNAL_ACTIVE BIT(7)
> +
> +#define BH1745_INT_SIGNAL_LATCHED BIT(4)
> +#define BH1745_INT_SIGNAL_LATCH_OFFSET 4
> +
> +#define BH1745_INT_SOURCE_MASK GENMASK(3, 2)
> +#define BH1745_INT_SOURCE_OFFSET 2
> +
> +#define BH1745_INT_TIME_AVAILABLE "0.16 0.32 0.64 1.28 2.56 5.12"
> +#define BH1745_HARDWAREGAIN_AVAILABLE "1 2 16"
> +#define BH1745_INT_COLOUR_CHANNEL_AVAILABLE \
> +	"0 (Red Channel) 1 (Green Channel) 2 (Blue channel) 3 (Clear channel)"
> +
> +static const int bh1745_int_time[][2] = {
> +	{ 0, 160000 }, /* 160 ms */
> +	{ 0, 320000 }, /* 320 ms */
> +	{ 0, 640000 }, /* 640 ms */
> +	{ 1, 280000 }, /* 1280 ms */
> +	{ 2, 560000 }, /* 2560 ms */
> +	{ 5, 120000 }, /* 5120 ms */
> +};
> +
> +static const u8 bh1745_gain_factor[] = { 1, 2, 16 };
> +
> +enum bh1745_int_source {
> +	BH1745_INT_SOURCE_RED,
> +	BH1745_INT_SOURCE_GREEN,
> +	BH1745_INT_SOURCE_BLUE,
> +	BH1745_INT_SOURCE_CLEAR,
> +};
> +
> +enum bh1745_gain {
> +	BH1745_ADC_GAIN_1X,
> +	BH1745_ADC_GAIN_2X,
> +	BH1745_ADC_GAIN_16X,
> +};
> +
> +enum bh1745_measurement_time {
> +	BH1745_MEASUREMENT_TIME_160MS,
> +	BH1745_MEASUREMENT_TIME_320MS,
> +	BH1745_MEASUREMENT_TIME_640MS,
> +	BH1745_MEASUREMENT_TIME_1280MS,
> +	BH1745_MEASUREMENT_TIME_2560MS,
> +	BH1745_MEASUREMENT_TIME_5120MS,
> +};
> +
> +enum bh1745_presistence_value {
> +	BH1745_PRESISTENCE_UPDATE_TOGGLE,
> +	BH1745_PRESISTENCE_UPDATE_EACH_MEASUREMENT,
> +	BH1745_PRESISTENCE_UPDATE_FOUR_MEASUREMENT,
> +	BH1745_PRESISTENCE_UPDATE_EIGHT_MEASUREMENT,
> +};
> +
> +struct bh1745_data {
> +	struct mutex lock;
> +	struct regmap *regmap;
> +	struct i2c_client *client;
> +	struct iio_trigger *trig;
> +	u8 mode_ctrl1;
> +	u8 mode_ctrl2;
> +	u8 int_src;
> +	u8 int_latch;
> +	u8 interrupt;
> +};
> +
> +static const struct regmap_range bh1745_volatile_ranges[] = {
> +	regmap_reg_range(BH1745_MODE_CTRL_2, BH1745_MODE_CTRL_2), /* VALID */
> +	regmap_reg_range(BH1745_R_LSB, BH1745_CLR_MSB), /* Data */
> +	regmap_reg_range(BH1745_INTR, BH1745_INTR), /* Interrupt */
> +};
> +
> +static const struct regmap_access_table bh1745_volatile_regs = {
> +	.yes_ranges = bh1745_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(bh1745_volatile_ranges),
> +};
> +
> +static const struct regmap_range bh1745_read_ranges[] = {
> +	regmap_reg_range(BH1745_SYS_CTRL, BH1745_MODE_CTRL_2),
> +	regmap_reg_range(BH1745_R_LSB, BH1745_CLR_MSB),
> +	regmap_reg_range(BH1745_INTR, BH1745_INTR),
> +	regmap_reg_range(BH1745_PERSISTENCE, BH1745_TL_MSB),
> +	regmap_reg_range(BH1745_MANU_ID, BH1745_MANU_ID),
> +};
> +
> +static const struct regmap_access_table bh1745_ro_regs = {
> +	.yes_ranges = bh1745_read_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(bh1745_read_ranges),
> +};
> +
> +static const struct regmap_range bh1745_writable_ranges[] = {
> +	regmap_reg_range(BH1745_SYS_CTRL, BH1745_MODE_CTRL_2),
> +	regmap_reg_range(BH1745_PERSISTENCE, BH1745_TL_MSB),
> +};
> +
> +static const struct regmap_access_table bh1745_wr_regs = {
> +	.yes_ranges = bh1745_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(bh1745_writable_ranges),
> +};
> +
> +static const struct regmap_config bh1745_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = BH1745_MANU_ID,
> +	.cache_type = REGCACHE_RBTREE,
> +	.volatile_table = &bh1745_volatile_regs,
> +	.wr_table = &bh1745_wr_regs,
> +	.rd_table = &bh1745_ro_regs,
> +};
> +
> +static const struct iio_event_spec bh1745_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_PERIOD),
> +	},
> +};
> +
> +#define BH1745_CHANNEL(_colour, _si, _addr)                                   \
> +	{                                                                     \
> +		.type = IIO_INTENSITY, .modified = 1,                         \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                 \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN) | \
> +					    BIT(IIO_CHAN_INFO_INT_TIME),      \
> +		.event_spec = bh1745_event_spec,                              \
> +		.num_event_specs = ARRAY_SIZE(bh1745_event_spec),             \
> +		.channel2 = IIO_MOD_LIGHT_##_colour, .address = _addr,        \
> +		.scan_index = _si,                                            \
> +		.scan_type = {                                                \
> +			.sign = 'u',                                          \
> +			.realbits = 16,                                       \
> +			.storagebits = 16,                                    \
> +			.endianness = IIO_CPU,                                \
> +		},                                                            \
> +	}
> +
> +static const struct iio_chan_spec bh1745_channels[] = {
> +	BH1745_CHANNEL(RED, 0, BH1745_R_LSB),
> +	BH1745_CHANNEL(GREEN, 1, BH1745_G_LSB),
> +	BH1745_CHANNEL(BLUE, 2, BH1745_B_LSB),
> +	BH1745_CHANNEL(CLEAR, 3, BH1745_CLR_LSB),
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
> +};
> +
> +static int bh1745_write_value(struct bh1745_data *data, u8 reg, void *value,
> +			      size_t len)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_write(data->regmap, reg, value, len);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"Failed to write to sensor. Reg: 0x%x\n", reg);
> +	}
> +
> +	return ret;
> +}
> +
> +static int bh1745_read_value(struct bh1745_data *data, u8 reg, void *value,
> +			     size_t len)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, reg, value, len);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"Failed to read from sensor. Reg: 0x%x\n", reg);
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t in_interrupt_source_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	int ret;
> +	int value;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	ret = bh1745_read_value(data, BH1745_INTR, &value, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	value &= BH1745_INT_SOURCE_MASK;
> +
> +	return sprintf(buf, "%d\n", value >> 2);
> +}
> +
> +static ssize_t in_interrupt_source_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	int ret;
> +	u16 value;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	ret = kstrtou16(buf, 10, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (value > BH1745_INT_SOURCE_CLEAR) {
> +		dev_err(dev,
> +			"Supplied value: '%d' for interrupt source is invalid\n",
> +			value);
> +		return -EINVAL;
> +	}
> +	guard(mutex)(&data->lock);
> +	data->int_src = value;
> +	value = value << BH1745_INT_SOURCE_OFFSET;
> +	ret = bh1745_read_value(data, BH1745_INTR, &data->interrupt, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->interrupt &= ~BH1745_INT_SOURCE_MASK;
> +	data->interrupt |= value;
> +	ret = bh1745_write_value(data, BH1745_INTR, &data->interrupt, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t in_interrupt_latch_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	int value;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	ret = bh1745_read_value(data, BH1745_INTR, &value, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	value &= BH1745_INT_SIGNAL_LATCHED;
> +	if (value)
> +		return sprintf(buf, "1\n");
> +
> +	return sprintf(buf, "0\n");
> +}
> +
> +static ssize_t in_interrupt_latch_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	int ret;
> +	u16 value;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	ret = kstrtou16(buf, 10, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (value > 1) {
> +		dev_err(dev, "Value out of range for latch setup. Supported values '0' or '1'\n");
> +		return -EINVAL;
> +	}
> +
> +	guard(mutex)(&data->lock);
> +	data->int_latch = value;
> +	ret = bh1745_read_value(data, BH1745_INTR, &data->interrupt, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (value == 0)
> +		data->interrupt &= ~BH1745_INT_SIGNAL_LATCHED;
> +	else
> +		data->interrupt |= BH1745_INT_SIGNAL_LATCHED;
> +
> +	ret = bh1745_write_value(data, BH1745_INTR, &data->interrupt, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t hardwaregain_available_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	return sprintf(buf, "%s\n", BH1745_HARDWAREGAIN_AVAILABLE);
> +}
> +
> +static ssize_t interrupt_source_available_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	return sprintf(buf, "%s\n", BH1745_INT_COLOUR_CHANNEL_AVAILABLE);
> +}
> +
> +static IIO_DEVICE_ATTR_RW(in_interrupt_source, 0);
> +static IIO_DEVICE_ATTR_RW(in_interrupt_latch, 0);
> +static IIO_DEVICE_ATTR_RO(hardwaregain_available, 0);
> +static IIO_DEVICE_ATTR_RO(interrupt_source_available, 0);
> +static IIO_CONST_ATTR_INT_TIME_AVAIL(BH1745_INT_TIME_AVAILABLE);
> +
> +static struct attribute *bh1745_attrs[] = {
> +	&iio_dev_attr_in_interrupt_source.dev_attr.attr,
> +	&iio_dev_attr_in_interrupt_latch.dev_attr.attr,
> +	&iio_dev_attr_hardwaregain_available.dev_attr.attr,
> +	&iio_dev_attr_interrupt_source_available.dev_attr.attr,
> +	&iio_const_attr_integration_time_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group bh1745_attr_group = {
> +	.attrs = bh1745_attrs,
> +};
> +
> +static int bh1745_reset(struct bh1745_data *data)
> +{
> +	int ret;
> +	u8 value;
> +
> +	ret = bh1745_read_value(data, BH1745_SYS_CTRL, &value, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	value |= (BH1745_SW_RESET | BH1745_INT_RESET);
> +
> +	return bh1745_write_value(data, BH1745_SYS_CTRL, &value, 1);
> +}
> +
> +static int bh1745_power_on(struct bh1745_data *data)
> +{
> +	int ret;
> +	u8 value;
> +
> +	ret = bh1745_read_value(data, BH1745_MODE_CTRL_2, &value, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	guard(mutex)(&data->lock);
> +	value |= BH1745_RGBC_EN;
> +	data->mode_ctrl2 = value;
> +	ret = bh1745_write_value(data, BH1745_MODE_CTRL_2, &data->mode_ctrl2, 1);
> +
> +	return ret;
> +}
> +
> +static int bh1745_power_off(struct bh1745_data *data)
> +{
> +	int ret;
> +	int value;
> +
> +	ret = bh1745_read_value(data, BH1745_MODE_CTRL_2, &value, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	guard(mutex)(&data->lock);
> +	value &= ~BH1745_RGBC_EN;
> +	data->mode_ctrl2 = value;
> +	ret = bh1745_write_value(data, BH1745_MODE_CTRL_2, &data->mode_ctrl2, 1);
> +
> +	return ret;
> +}
> +
> +static int bh1745_set_int_time(struct bh1745_data *data, int val, int val2)
> +{
> +	int ret;
> +
> +	for (u8 i = 0; i < ARRAY_SIZE(bh1745_int_time); i++) {
> +		if (val == bh1745_int_time[i][0] &&
> +		    val2 == bh1745_int_time[i][1]) {
> +			guard(mutex)(&data->lock);
> +			data->mode_ctrl1 &= ~BH1745_MEASUREMENT_TIME_MASK;
> +			data->mode_ctrl1 |= i;
> +			ret = bh1745_write_value(data, BH1745_MODE_CTRL_1,
> +						 &data->mode_ctrl1, 1);
> +			return ret;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int bh1745_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u16 value;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		ret = bh1745_read_value(data, chan->address, &value, 2);
> +		if (ret < 0)
> +			return ret;
> +		iio_device_release_direct_mode(indio_dev);
> +		*val = value;
> +		return IIO_VAL_INT;
> +	}
> +
> +	case IIO_CHAN_INFO_HARDWAREGAIN: {
> +		guard(mutex)(&data->lock);
> +		ret = bh1745_read_value(data, BH1745_MODE_CTRL_2,
> +					&data->mode_ctrl2, 1);
> +		if (ret < 0)
> +			return ret;
> +
> +		value = data->mode_ctrl2 & BH1745_ADC_GAIN_MASK;
> +		*val = bh1745_gain_factor[value];
> +		return IIO_VAL_INT;
> +	}
> +
> +	case IIO_CHAN_INFO_INT_TIME: {
> +		guard(mutex)(&data->lock);
> +		ret = bh1745_read_value(data, BH1745_MODE_CTRL_1,
> +					&data->mode_ctrl1, 1);
> +		if (ret < 0)
> +			return ret;
> +
> +		value = data->mode_ctrl1 & BH1745_MEASUREMENT_TIME_MASK;
> +
> +		*val = bh1745_int_time[value][0];
> +		*val2 = bh1745_int_time[value][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bh1745_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN: {
> +		for (u8 i = 0; i < ARRAY_SIZE(bh1745_gain_factor); i++) {
> +			if (bh1745_gain_factor[i] == val) {
> +				guard(mutex)(&data->lock);
> +				data->mode_ctrl2 &= ~BH1745_ADC_GAIN_MASK;
> +				data->mode_ctrl2 |= i;
> +				ret = bh1745_write_value(data,
> +							 BH1745_MODE_CTRL_2,
> +							 &data->mode_ctrl2, 1);
> +				return ret;
> +			}
> +		}
> +		return -EINVAL;
> +	}
> +
> +	case IIO_CHAN_INFO_INT_TIME: {
> +		return bh1745_set_int_time(data, val, val2);
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bh1745_read_thresh(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      enum iio_event_type type,
> +			      enum iio_event_direction dir,
> +			      enum iio_event_info info, int *val, int *val2)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = bh1745_read_value(data, BH1745_TH_LSB, val, 2);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			ret = bh1745_read_value(data, BH1745_TL_LSB, val, 2);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_EV_INFO_PERIOD:
> +		ret = bh1745_read_value(data, BH1745_PERSISTENCE, val, 1);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bh1745_write_thresh(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info, int val, int val2)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (val < BH1745_THRESHOLD_MIN || val > BH1745_THRESHOLD_MAX)
> +			return -EINVAL;
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = bh1745_write_value(data, BH1745_TH_LSB, &val, 2);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			ret = bh1745_write_value(data, BH1745_TL_LSB, &val, 2);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_EV_INFO_PERIOD:
> +		if (val < BH1745_PRESISTENCE_UPDATE_TOGGLE ||
> +		    val > BH1745_PRESISTENCE_UPDATE_EIGHT_MEASUREMENT)
> +			return -EINVAL;
> +		ret = bh1745_write_value(data, BH1745_PERSISTENCE, &val, 1);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info bh1745_info = {
> +	.attrs = &bh1745_attr_group,
> +	.read_raw = bh1745_read_raw,
> +	.write_raw = bh1745_write_raw,
> +	.read_event_value = bh1745_read_thresh,
> +	.write_event_value = bh1745_write_thresh,
> +
> +};
> +
> +static void bh1745_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	if (bh1745_power_off(data) < 0)
> +		dev_err(&data->client->dev, "Failed to turn off device");
> +
> +	dev_info(&data->client->dev, "BH1745 driver removed\n");
> +}
> +
> +static int bh1745_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	int ret;
> +	u8 value = 0;
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	guard(mutex)(&data->lock);
> +	if (state) {
> +		ret = bh1745_read_value(data, BH1745_INTR, &value, 1);
> +		if (ret < 0)
> +			return ret;
> +		value |= (BH1745_INT_ENABLE |
> +			(data->int_latch << BH1745_INT_SIGNAL_LATCH_OFFSET) |
> +			(data->int_src << BH1745_INT_SOURCE_OFFSET));
> +		data->interrupt = value;
> +		ret = bh1745_write_value(data, BH1745_INTR, &data->interrupt,

Suggestion: a few lines go beyond 80 characters (including some other
bh1745_write_value() calls), so you could join those two "1);" with the
rest of the call.

> +					 1);
> +	} else {
> +		data->interrupt = value;
> +		ret = bh1745_write_value(data, BH1745_INTR, &data->interrupt,
> +					 1);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_trigger_ops bh1745_trigger_ops = {
> +	.set_trigger_state = bh1745_set_trigger_state,
> +};
> +
> +static irqreturn_t bh1745_interrupt_handler(int interrupt, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +	int value;
> +
> +	ret = bh1745_read_value(data, BH1745_INTR, &value, 1);
> +	if (ret < 0)
> +		return IRQ_NONE;
> +
> +	if (value & BH1745_INTR_STATUS) {
> +		guard(mutex)(&data->lock);
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
> +						    data->int_src,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns(indio_dev));
> +
> +		iio_trigger_poll_nested(data->trig);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	struct {
> +		u16 chans[4];
> +		s64 timestamp __aligned(8);
> +	} scan;
> +	u16 value;
> +	int ret;
> +

Intended blank line?

> +	int i, j = 0;
> +
> +	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
> +		ret = bh1745_read_value(data, BH1745_R_LSB + 2 * i, &value, 2);
> +		if (ret < 0)
> +			goto err;
> +		scan.chans[j++] = value;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> +					   iio_get_time_ns(indio_dev));
> +
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int bh1745_setup_trigger(struct iio_dev *indio_dev)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	data->trig = devm_iio_trigger_alloc(indio_dev->dev.parent,
> +					    "%sdata-rdy-dev%d", indio_dev->name,
> +					    iio_device_id(indio_dev));
> +	if (!data->trig)
> +		return -ENOMEM;
> +
> +	data->trig->ops = &bh1745_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +	ret = devm_iio_trigger_register(&data->client->dev, data->trig);
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret,
> +				     "Trigger registration failed\n");
> +
> +	ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> +					      NULL, bh1745_trigger_handler,
> +					      NULL);
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret,
> +				     "Triggered buffer setup failed\n");
> +
> +	ret = devm_request_threaded_irq(&data->client->dev, data->client->irq,
> +					NULL, bh1745_interrupt_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					"bh1745_interrupt", indio_dev);
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret,
> +				     "Request for IRQ failed\n");
> +
> +	dev_info(&data->client->dev,
> +		 "Triggered buffer and IRQ setup successfully");
> +
> +	return ret;
> +}
> +
> +static int bh1745_init(struct bh1745_data *data)
> +{
> +	int ret;
> +
> +	mutex_init(&data->lock);
> +	data->mode_ctrl1 = 0;
> +	data->mode_ctrl2 = 0;
> +	data->interrupt = 0;
> +	data->int_src = BH1745_INT_SOURCE_RED;
> +
> +	ret = bh1745_reset(data);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Failed to reset sensor\n");
> +		return ret;
> +	}
> +
> +	ret = bh1745_power_on(data);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Failed to turn on sensor\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bh1745_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	struct bh1745_data *data;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	indio_dev->info = &bh1745_info;
> +	indio_dev->name = "bh1745";
> +	indio_dev->channels = bh1745_channels;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = ARRAY_SIZE(bh1745_channels);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &bh1745_regmap);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
> +				     "Failed to initialize Regmap\n");
> +
> +	ret = bh1745_init(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (client->irq) {
> +		ret = bh1745_setup_trigger(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Failed to register device\n");
> +		return ret;
> +	}
> +
> +	dev_info(&data->client->dev, "BH1745 driver loaded\n");
> +
> +	return ret;
> +}
> +
> +static const struct i2c_device_id bh1745_idtable[] = {
> +	{ "bh1745" },
> +	{},
> +};
> +
> +static const struct of_device_id bh1745_of_match[] = {
> +	{
> +		.compatible = "rohm,bh1745",
> +	},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, bh1745_idtable);
> +
> +static struct i2c_driver bh1745_driver = {
> +	.driver = {
> +		.name = "bh1745",
> +		.of_match_table = bh1745_of_match,
> +	},
> +	.probe = bh1745_probe,
> +	.remove = bh1745_remove,
> +	.id_table = bh1745_idtable,
> +};
> +
> +module_i2c_driver(bh1745_driver);
> +MODULE_AUTHOR("Mudit Sharma <muditsharma.info@gmail.com>");
> +MODULE_DESCRIPTION("BH1745 colour sensor driver");
> +MODULE_LICENSE("GPL");


As far as I am concerned,

Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

